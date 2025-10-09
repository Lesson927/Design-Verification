#include "stdio.h"
#ifdef __cplusplus
extern "C" {
#endif
extern char at_least_one_object_file;
extern void *kernel_scs_file_ht_new(const void *, int);
extern int kernel_scs_file_ht_get(void *, const char *, int *);
extern int  strcmp(const char*, const char*);
  typedef struct {
    char* dFileName;
  } lPkgFileInfoStruct;

  typedef struct {
    char* dFileName;
    char* dRealFileName;
    long dFileOffset;
    unsigned long dFileSize;
    int dFileModTime;
    unsigned int simFlag;
  } lFileInfoStruct;

static int lNumOfScsFiles;
  static lFileInfoStruct lFInfoArr[] = {
  {"synopsys_sim.setup_0", "/opt/Synopsys/vcs_202003/Q-2020.03-SP2-7/bin/synopsys_sim.setup", 75558, 3536, 1627361595, 0},
  {"linux64/packages/synopsys/lib/64/NOVAS__.sim", "", 0, 75558, 0, 0},
  {"linux64/packages/synopsys/lib/64/NOVAS.sim", "", 79094, 49785, 0, 0},
