// Std Lib
#include <iostream>
#include <stdlib.h>

// MechSys
#include <mechsys/lbm/Domain.h>

using std::cout;
using std::endl;

struct UserData
{
    Vec3_t             g;
    Array<Cell *> Top;
    Array<Cell *> Bottom;
    double rho;
    double Tf;
    double vmax;
};

void Setup(LBM::Domain & dom, void * UD)
{
    UserData & dat = (*static_cast<UserData *>(UD));
    for (size_t j=0;j<dom.Lat.Size();j++)
    for (size_t i=0;i<dom.Lat[j].Ncells;i++)
    {
        Cell * c = dom.Lat[j].Cells[i];
        c->BForcef = c->Density()*dat.g;
    }
    // Assign boundary condition
    //double vel = std::min(10.0*dat.vmax*dom.Time/dat.Tf,dat.vmax);
//    double vel =dat.vmax;
//    #ifdef USE_OMP
//        #pragma omp parallel for schedule(static) num_threads(dom.Nproc)
//    #endif
        //for (size_t i=0; i<dat.Top.Size();i++)
    	//{
    		//Cell * c = dat.Top[i];
    		//if (c->IsSolid) continue;
    		//double rho = (c->F[0]+c->F[1]+c->F[3] + 2.0*(c->F[6]+c->F[2]+c->F[5]))/(1.0-vel); // set input by pressure
    		//c->F[4] = c->F[2] + (2.0/3.0)*rho*vel;
    		//c->F[8] = c->F[6] + (1.0/6.0)*rho*vel - 0.5*(c->F[1]-c->F[3]);
    		//c->F[7] = c->F[5] + (1.0/6.0)*rho*vel + 0.5*(c->F[1]-c->F[3]);
            //c->Rho = c->VelDen(c->Vel);
    	//}
//#ifdef USE_OMP
//    #pragma omp parallel for schedule(static) num_threads(dom.Nproc)
//#endif
//    for (size_t i=0; i<dat.Top.Size();i++)
//	{
//		Cell * c = dat.Top[i];
//		if (c->IsSolid) continue;
//		double rho = (c->F[0]+c->F[1]+c->F[3] + 2.0*(c->F[6]+c->F[2]+c->F[5]))/(1.0-vel); // set input by pressure
//		c->F[4] = c->F[2] + (2.0/3.0)*rho*vel;
//		c->F[8] = c->F[6] + (1.0/6.0)*rho*vel - 0.5*(c->F[1]-c->F[3]);
//		c->F[7] = c->F[5] + (1.0/6.0)*rho*vel + 0.5*(c->F[1]-c->F[3]);
//        c->Rho = c->VelDen(c->Vel);
//	}
//#ifdef USE_OMP
//    #pragma omp parallel for schedule(static) num_threads(dom.Nproc)
//#endif
//    for (size_t i=0; i<dat.Bottom.Size();i++)
//	{
//		Cell * c = dat.Bottom[i];
//		if (c->IsSolid) continue;
//		double vx = -1.0 + (c->F[0]+c->F[1]+c->F[3] + 2.0*(c->F[6]+c->F[2]+c->F[5]))/c->RhoBC; // set output by velocity
//		c->F[2] = c->F[4] - (2.0/3.0)*c->RhoBC*vx;
//		c->F[6] = c->F[8] - (1.0/6.0)*c->RhoBC*vx + 0.5*(c->F[1]-c->F[3]);
//		c->F[5] = c->F[7] - (1.0/6.0)*c->RhoBC*vx - 0.5*(c->F[1]-c->F[3]);
//        c->Rho = c->VelDen(c->Vel);
//	}
}
void placehook2d(LBM::Domain & dom, iVec3_t position, int size, int thick, bool flip )
{
//	UserData & dat = (*static_cast<UserData *>(UD)); // Catch global parameters
	iVec3_t transform = iVec3_t(1,1,1);
	if (flip)
	{
		transform = iVec3_t(-1,1,1);
	}
	iVec3_t post = position;
	iVec3_t post2;
	iVec3_t mid;
	for (size_t i=0; i<size;i++)
	{
		post2 = post + iVec3_t(i,0,0)*transform;
		dom.Lat[0].GetCell(post2)->IsSolid = true;
	}
	for (size_t i=0; i<thick;i++)
	{
		post2= post +iVec3_t(0,i,0)*transform;
		dom.Lat[0].GetCell(post2)->IsSolid = true;
	}
	post=position+iVec3_t(0,thick,0)*transform;
	for (size_t i=0; i<size-thick;i++)
	{
		post2 = post + iVec3_t(i,0,0)*transform;
		dom.Lat[0].GetCell(post2)->IsSolid = true;
	}
	post = position +iVec3_t(size,0,0)*transform;
	for (size_t i=0; i<(size/5); i++)
	{
		post2 = post+iVec3_t(0,i,0)*transform;
		dom.Lat[0].GetCell(post2)->IsSolid = true;
	}
	post = position +iVec3_t(size-thick,thick,0)*transform;
	for (size_t i=0; i<(size/5-thick); i++)
	{
		post2 = post+ iVec3_t(0,i,0)*transform;
		dom.Lat[0].GetCell(post2)->IsSolid = true;
	}
	post = position + iVec3_t(size-thick,int(size/5),0)*transform;
	for (size_t i=0; i<thick+1; i++)
	{
		post2 = post+iVec3_t(i,0,0)*transform;
		dom.Lat[0].GetCell(post2)->IsSolid = true;
	}
}
int main(int argc, char **argv) try
{
	size_t nproc = 6;					// number of processors
    if (argc==2) nproc=atoi(argv[1]);
    double  nu = 0.15;

    size_t nx = 400, ny = 400;
    double vmax=0.2;
    LBM::Domain dom(D2Q9, nu, iVec3_t(nx,ny,1), 1.0, 1.0);
    UserData dat;
    dom.UserData = &dat;
    dat.g           = 0.0,-1.0e-5,0.0;
    dat.Tf=5000;
    dat.vmax=vmax;
    // Domain does not have rigrid boundary

    //set liquid
	for (size_t i=0; i<nx; ++i)
	for (size_t j=0; j<ny; ++j)
    {
		// set density
            dom.Lat[0].GetCell(iVec3_t(i,j,0))->Initialize(1.0,OrthoSys::O);
    }
	// Set hooks
	cout << "Placing hook \n";
	for (size_t i=0; i<2; i++)
	{
		placehook2d(dom,iVec3_t(0,100+i*200,0),250,10,false );
		placehook2d(dom,iVec3_t(nx-1,i*200,0),250,10,true);
	}
	// set boundary condition
	// Set rigrid boundaries from Left and Right
//	cout << "Set rigrid boundary \n";
//	for (size_t i=0;i<ny;i++)
//	{
//		dom.Lat[0].GetCell(iVec3_t(0,i,0))->IsSolid = true;
//		dom.Lat[0].GetCell(iVec3_t(nx-1,i,0))->IsSolid = true;
//	}

	//Assigning the top and bottom cells
	cout << "Assign top and bottom boundaries \n";
	for (size_t i=0;i<nx;i++)
	{
		dat.Top.Push(dom.Lat[0].GetCell(iVec3_t(i,ny-1,0)));
	    dat.Bottom.Push(dom.Lat[0].GetCell(iVec3_t(i,0,0)));

//	    // set parabolic profile
//	    dat.Vel.Push(vmax);
//	    dat.Top [i]->RhoBC = 1.0;
//	    //dat.Right[i]->VelBC = 0.08,0.0,0.0;
//	    dat.Bottom[i]->RhoBC = 1.0;
	}
	dat.rho  = 1.0;

    // Set parameters
	cout << "Set parameters \n";
    //dom.Lat[0].G  = -200.0;
    //dom.Lat[0].Gs = -200.0;
    //dom.Gmix      =  0.001;
    cout << "Solving domain \n";
    dom.Solve(dat.Tf,dat.Tf/100.0,Setup,NULL,"fish_ladder",true,nproc);
}
MECHSYS_CATCH
