Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:44442 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeJaA42 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Oct 2018 20:56:28 -0400
Date: Tue, 30 Oct 2018 12:02:23 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests -v2] Fix build failure for discontiguous-io on
 32-bit platforms
Message-ID: <20181030160223.GA6236@thunk.org>
References: <20181030143649.28246-1-tytso@mit.edu>
 <1540911775.196084.110.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1540911775.196084.110.camel@acm.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Oct 30, 2018 at 08:02:55AM -0700, Bart Van Assche wrote:
> Details about how the build fails on 32-bit systems would have been welcome
> in the commit message. Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

For the record, here's the failure.  It's the usual incomprehensible
C++ error reporting.  :-)

% schroot -c stretch-i386 -- ./build-all --blktests-only
----------------- 2018-10-30 16:00:18: Starting build of blktests
make -C src all
make[1]: Entering directory '/usr/projects/xfstests-bld/build-32/blktests/src'
g++  -O2 -std=c++11 -Wall -Wextra -Wno-sign-compare -Werror -o discontiguous-io discontiguous-io.cpp
discontiguous-io.cpp: In function 'int main(int, char**)':
discontiguous-io.cpp:294:34: error: no matching function for call to 'min(long unsigned int, size_t)'
         std::min(4ul, len - i * 4));
                                  ^
In file included from /usr/include/c++/6/bits/char_traits.h:39:0,
                 from /usr/include/c++/6/string:40,
                 from /usr/include/c++/6/bits/locale_classes.h:40,
                 from /usr/include/c++/6/bits/ios_base.h:41,
                 from /usr/include/c++/6/iomanip:40,
                 from discontiguous-io.cpp:8:
/usr/include/c++/6/bits/stl_algobase.h:195:5: note: candidate: template<class _Tp> const _Tp& std::min(const _Tp&, const _Tp&)
     min(const _Tp& __a, const _Tp& __b)
     ^~~
/usr/include/c++/6/bits/stl_algobase.h:195:5: note:   template argument deduction/substitution failed:
discontiguous-io.cpp:294:34: note:   deduced conflicting types for parameter 'const _Tp' ('long unsigned int' and 'size_t {aka unsigned int}')
         std::min(4ul, len - i * 4));
                                  ^
In file included from /usr/include/c++/6/bits/char_traits.h:39:0,
                 from /usr/include/c++/6/string:40,
                 from /usr/include/c++/6/bits/locale_classes.h:40,
                 from /usr/include/c++/6/bits/ios_base.h:41,
                 from /usr/include/c++/6/iomanip:40,
                 from discontiguous-io.cpp:8:
/usr/include/c++/6/bits/stl_algobase.h:243:5: note: candidate: template<class _Tp, class _Compare> const _Tp& std::min(const _Tp&, const _Tp&, _Compare)
     min(const _Tp& __a, const _Tp& __b, _Compare __comp)
     ^~~
/usr/include/c++/6/bits/stl_algobase.h:243:5: note:   template argument deduction/substitution failed:
discontiguous-io.cpp:294:34: note:   deduced conflicting types for parameter 'const _Tp' ('long unsigned int' and 'size_t {aka unsigned int}')
         std::min(4ul, len - i * 4));
                                  ^
Makefile:27: recipe for target 'discontiguous-io' failed
make[1]: *** [discontiguous-io] Error 1
make[1]: Leaving directory '/usr/projects/xfstests-bld/build-32/blktests/src'
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 2
