Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170207172446.4528-1-paolo.valente@linaro.org>
Date: Mon, 13 Feb 2017 22:09:45 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 linus.walleij@linaro.org,
 broonie@kernel.org
Message-Id: <478A4EBE-9218-4527-9F8A-42AAEBDC9470@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
To: Paolo Valente <paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 07 feb 2017, alle ore 18:24, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
>=20
> I have finally pushed here [1] the current WIP branch of bfq for
> blk-mq, which I have tentatively named bfq-mq.
>=20
> This branch *IS NOT* meant for merging into mainline and contain code
> that mau easily violate code style, and not only, in many
> places. Commits implement the following main steps:
> 1) Add the last version of bfq for blk
> 2) Clone bfq source files into identical bfq-mq source files
> 3) Modify bfq-mq files to get a working version of bfq for blk-mq
> (cgroups support not yet functional)
>=20
> In my intentions, the main goals of this branch are:
>=20
> 1) Show, as soon as I could, the changes I made to let bfq-mq comply
> with blk-mq-sched framework. I though this could be particularly
> useful for Jens, being BFQ identical to CFQ in terms of hook
> interfaces and io-context handling, and almost identical in terms
> request-merging.
>=20
> 2) Enable people to test this first version bfq-mq. Code is purposely
> overfull of log messages and invariant checks that halt the system on
> failure (lock assertions, BUG_ONs, ...).
>=20
> To make it easier to revise commits, I'm sending the patches that
> transform bfq into bfq-mq (last four patches in the branch [1]). They
> work on two files, bfq-mq-iosched.c and bfq-mq.h, which, at the
> beginning, are just copies of bfq-iosched.c and bfq.h.
>=20

Hi,
this is just to inform that, as I just wrote to Bart, I have rebase
the branch [1] against the current content of for-4.11/next.

Jens, Omar, did you find the time to have a look at the main commits
or to run some test?

Thanks,
Paolo

[1] https://github.com/Algodev-github/bfq-mq

> Thanks,
> Paolo
>=20
> [1] https://github.com/Algodev-github/bfq-mq
>=20
> Paolo Valente (4):
>  blk-mq: pass bio to blk_mq_sched_get_rq_priv
>  Move thinktime from bic to bfqq
>  Embed bfq-ioc.c and add locking on request queue
>  Modify interface and operation to comply with blk-mq-sched
>=20
> block/bfq-cgroup.c       |   4 -
> block/bfq-mq-iosched.c   | 852 =
+++++++++++++++++++++++++++++------------------
> block/bfq-mq.h           |  65 ++--
> block/blk-mq-sched.c     |   8 +-
> block/blk-mq-sched.h     |   5 +-
> include/linux/elevator.h |   2 +-
> 6 files changed, 567 insertions(+), 369 deletions(-)
>=20
> --
> 2.10.0
