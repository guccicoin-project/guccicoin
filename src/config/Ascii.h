// Copyright (c) 2018, The TurtleCoin Developers
//
// Please see the included LICENSE file for more information

#pragma once

const std::string windowsAsciiArt =
        "\n   _____                _           _       \n"
        "  / ____|              (_)         (_)      \n"
        " | |  __ _   _  ___ ___ _  ___ ___  _ _ __  \n"
        " | | |_ | | | |/ __/ __| |/ __/ _ \\| | '_ \\ \n"
        " | |__| | |_| | (_| (__| | (_| (_) | | | | |\n"
        "  \\_____|\\__,_|\\___\\___|_|\\___\\___/|_|_| |_|\n";

const std::string nonWindowsAsciiArt = 
        "\n ██████╗ ██╗   ██╗ ██████╗ ██████╗██╗ ██████╗ ██████╗ ██╗███╗   ██╗\n"
        "██╔════╝ ██║   ██║██╔════╝██╔════╝██║██╔════╝██╔═══██╗██║████╗  ██║\n"
        "██║  ███╗██║   ██║██║     ██║     ██║██║     ██║   ██║██║██╔██╗ ██║\n"
        "██║   ██║██║   ██║██║     ██║     ██║██║     ██║   ██║██║██║╚██╗██║\n"
        "╚██████╔╝╚██████╔╝╚██████╗╚██████╗██║╚██████╗╚██████╔╝██║██║ ╚████║\n"
        " ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝╚═╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝\n";

/* Windows has some characters it won't display in a terminal. If your ascii
   art works fine on Windows and Linux terminals, just replace 'asciiArt' with
   the art itself, and remove these two #ifdefs and above ascii arts */
#ifdef _WIN32
const std::string asciiArt = windowsAsciiArt;
#else
const std::string asciiArt = nonWindowsAsciiArt;
#endif
