#include <boost/filesystem.hpp>
#include <boost/filesystem/directory.hpp>
#include <boost/filesystem/file_status.hpp>
#include <boost/filesystem/operations.hpp>
#include <boost/filesystem/path.hpp>
#include <cstdio>
#include <cstdlib>
#include <stdio.h>
#include <string>
#include <sys/file.h>

#define TEMPLATE_FOLDER ".mkproject/templates/"

using namespace boost::filesystem;
using namespace std;

int main(int argc, char *argv[]) {
  if (argc != 3) {
    printf("usage: mkproject <name> <language>\n");
    return 1;
  }

  path projectDir(argv[1]);
  if (exists(projectDir)) {
    printf("error: project '%s' seems to already exist, aborting\n", argv[1]);
    return 2;
  }

  create_directories(projectDir);

  path templateFile = path(getenv("HOME")) / path(TEMPLATE_FOLDER) /
                      path(string(argv[2]) + ".tar.gz");
  printf("info: template '%s'\n", templateFile.c_str());
  if (!exists(templateFile)) {
    printf("error: unknown template '%s', aborting\n", argv[2]);
    return 3;
  }

  printf("info: creating project '%s'\n", argv[1]);
  std::string command("tar -xf ");
  command += templateFile.c_str();
  command += " -C ";
  command += projectDir.c_str();

  system(command.c_str());

  return 0;
}