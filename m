Return-Path: <Golden_Miller83@protonmail.ch>
Date: Sat, 10 Nov 2018 14:15:34 +0000
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>, Kees Cook <keescook@chromium.org>, Daniel Micay <danielmicay@gmail.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: "kyber: add tracepoints" causes write beyond size of object
Message-ID: <DLM1_HbVqIgDqe7g8efFag9FGTUn_GGAPNdzoZltene_ba7lQ7_WUPLeR55uE-ufyn0HcMtfeGGQX8PlekpAayPCf0UVont1YWqHWEU2Tms=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hello,

Commit 6c3b7af1c975b87b86dcb2af233d1ae21eb05107 ("kyber: add tracepoints")[=
1] causes write beyond size of object. This was detected by "FORTIFY_SOURCE=
 intra-object overflow checking"[2] feature which is part of linux-hardened=
 out-of-tree patchset designed to catch such errors.

The specific error is:

In file included from ./include/linux/bitmap.h:9,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:21,
                 from ./arch/x86/include/asm/cpufeature.h:8,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:81,
                 from ./include/linux/rcupdate.h:40,
                 from ./include/linux/rculist.h:11,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from ./include/linux/blkdev.h:5,
                 from block/kyber-iosched.c:21:
In function =E2=80=98strlcpy=E2=80=99,
    inlined from =E2=80=98perf_trace_kyber_latency=E2=80=99 at ./include/tr=
ace/events/kyber.h:14:1:
./include/linux/string.h:310:4: error: call to =E2=80=98__write_overflow=
=E2=80=99 declared with attribute error: detected write beyond size of obje=
ct passed as 1st parameter
    __write_overflow();
    ^~~~~~~~~~~~~~~~~~
In function =E2=80=98strlcpy=E2=80=99,
    inlined from =E2=80=98trace_event_raw_event_kyber_latency=E2=80=99 at .=
/include/trace/events/kyber.h:14:1:
./include/linux/string.h:310:4: error: call to =E2=80=98__write_overflow=
=E2=80=99 declared with attribute error: detected write beyond size of obje=
ct passed as 1st parameter
    __write_overflow();
    ^~~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:293: block/kyber-iosched.o] Error 1
make: *** [Makefile:1063: block] Error 2
make: *** Waiting for unfinished jobs....

Using 'strlcpy' function is generally not recommended[3][4].

Jordan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv4.20-rc1&id=3D6c3b7af1c975b87b86dcb2af233d1ae21eb05107

[2] https://github.com/anthraxx/linux-hardened/commit/9460692de8eb53fd62d59=
f564eba215e7c03a34b

[3] https://lwn.net/Articles/763641/

[4] https://outflux.net/slides/2018/lss/danger.pdf
