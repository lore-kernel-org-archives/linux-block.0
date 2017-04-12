Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/16] Introduce the BFQ I/O scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1491935512.2654.16.camel@sandisk.com>
Date: Wed, 12 Apr 2017 08:01:44 +0200
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Message-Id: <17416A05-8401-4B03-B46C-78A8976C5B8E@linaro.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org> <1491921434.2540.1.camel@sandisk.com> <17A56264-D096-4F6E-8E66-50030A10B331@linaro.org> <1491935512.2654.16.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 11 apr 2017, alle ore 20:31, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Tue, 2017-04-11 at 19:37 +0200, Paolo Valente wrote:
>> Just pushed:
>> https://github.com/Algodev-github/bfq-mq/tree/add-bfq-mq-logical
>=20
> Thanks!
>=20
> But are you aware that the code on that branch doesn't build?
>=20
> $ make all
> [ ... ]
> ERROR: "bfq_mark_bfqq_busy" [block/bfq-wf2q.ko] undefined!
> ERROR: "bfqg_stats_update_dequeue" [block/bfq-wf2q.ko] undefined!
> [ ... ]
>=20
> $ PAGER=3D git grep bfq_mark_bfqq_busy
> block/bfq-wf2q.c:       bfq_mark_bfqq_busy(bfqq);
>=20

That's exactly the complain of the kbuild test robot.  As I wrote,
build completes with no problem in my test system (Ubuntu 16.04, gcc
5.4.0), even with the exact offending tree and .config that the robot
reports.

I didn't understand what is going on.  In your case, as well as for
the test robot, the compilation of the file block/bfq-wf2q.c as a
module component fails, because that file does not contain the
definition of the reported functions.  But that definition is
(uniquely) in the file block/bfq-iosched.c, which is to be compiled
with the former file, according to the following rule in
block/Makefile:
obj-$(CONFIG_IOSCHED_BFQ)       +=3D bfq-iosched.o bfq-wf2q.o =
bfq-cgroup.o

I have tried all combinations of configurations for bfq (builti-in or
module, with or without cgrousp support), always successfully.  If it
makes any sense to share this information, these are the exact
commands I used to test al combinations (in addition to make full
builds in some cases, and try make all as in your case):

make O=3Dbuilddir M=3Dblock

and

make O=3Dbuilddir M=3Dblock modules

Where is my mistake?

Thanks,
Paolo

> Bart.
