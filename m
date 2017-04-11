Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V2 00/16] Introduce the BFQ I/O scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1491843362.4199.14.camel@sandisk.com>
Date: Tue, 11 Apr 2017 10:43:07 +0200
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Message-Id: <D1691D90-1F99-440B-841D-E0327E4FE7D7@linaro.org>
References: <20170331124743.3530-1-paolo.valente@linaro.org> <1491843362.4199.14.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 10 apr 2017, alle ore 18:56, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Fri, 2017-03-31 at 14:47 +0200, Paolo Valente wrote:
>> [ ... ]
>=20
> Hello Paolo,
>=20
> Is the git tree that is available at =
https://github.com/Algodev-github/bfq-mq
> appropriate for testing BFQ? If I merge that tree with v4.11-rc6 and =
if I run
> the srp-test software against that tree as follows:
>=20
>    ./run_tests -e bfq-mq -t 02-mq
>=20
> then the following appears on the console:
>=20
> [ 2748.650352] BUG: unable to handle kernel NULL pointer dereference =
at 00000000000000d0
> [ 2748.650442] IP: __bfq_insert_request+0x26/0x650 [bfq_mq_iosched]
> [ 2748.650509] PGD 0=20
> [ 2748.650511]=20
> [ 2748.650585] Oops: 0000 [#1] SMP
> [ 2748.651107] CPU: 9 PID: 10772 Comm: kworker/9:2H Tainted: G         =
 I     4.11.0-rc6-dbg+ #1
> [ 2748.651191] Workqueue: kblockd blk_mq_requeue_work
> [ 2748.651228] task: ffff88037c808040 task.stack: ffffc90003b4c000
> [ 2748.651268] RIP: 0010:__bfq_insert_request+0x26/0x650 =
[bfq_mq_iosched]
> [ 2748.651307] RSP: 0018:ffffc90003b4f9d8 EFLAGS: 00010002
> [ 2748.651345] RAX: 0000000000000001 RBX: 0000000000000000 RCX: =
0000000000000001
> [ 2748.651383] RDX: 0000000000000001 RSI: ffff880377f52e80 RDI: =
ffff880401f774e8
> [ 2748.651423] RBP: ffffc90003b4fa80 R08: 9093955f00000000 R09: =
0000000000000001
> [ 2748.651464] R10: ffffc90003b4fa00 R11: ffffffffa06d0d53 R12: =
ffff880401f77840
> [ 2748.651506] R13: ffff880401f774e8 R14: ffff880378a451e0 R15: =
0000000000000000
> [ 2748.651547] FS:  0000000000000000(0000) GS:ffff88046f040000(0000) =
knlGS:0000000000000000
> [ 2748.651588] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2748.651626] CR2: 00000000000000d0 CR3: 0000000001c0f000 CR4: =
00000000001406e0
> [ 2748.651664] Call Trace:
> [ 2748.651778]  bfq_insert_request+0x83/0x280 [bfq_mq_iosched]
> [ 2748.651934]  bfq_insert_requests+0x50/0x70 [bfq_mq_iosched]
> [ 2748.651975]  blk_mq_sched_insert_request+0x11e/0x170
> [ 2748.652015]  blk_insert_cloned_request+0xb6/0x1f0
> [ 2748.652361]  map_request+0x13c/0x290 [dm_mod]
> [ 2748.652403]  dm_mq_queue_rq+0x90/0x160 [dm_mod]
> [ 2748.652441]  blk_mq_dispatch_rq_list+0x1f2/0x3e0
> [ 2748.652479]  blk_mq_sched_dispatch_requests+0xf1/0x190
> [ 2748.652516]  __blk_mq_run_hw_queue+0x12d/0x1c0
> [ 2748.652553]  __blk_mq_delay_run_hw_queue+0xe3/0xf0
> [ 2748.652593]  blk_mq_run_hw_queues+0x5c/0x80
> [ 2748.652632]  blk_mq_requeue_work+0x132/0x150
> [ 2748.652671]  process_one_work+0x206/0x6a0
> [ 2748.652709]  worker_thread+0x49/0x4a0
> [ 2748.652745]  kthread+0x107/0x140
> [ 2748.652854]  ret_from_fork+0x2e/0x40
> [ 2748.652891] Code: ff 0f 1f 40 00 55 48 89 e5 41 57 41 56 41 55 41 =
54 53 48 83 c4 80 8b 87 58 03 00 00 48 8b 9e b0 00 00 00 85 c0 0f 84 8b =
04 00 00 <48> 8b 83 d0 00 00 00 48 85 c0 0f 84 63 04 00 00
> 48 83 e8 10 48=20
> [ 2748.653049] RIP: __bfq_insert_request+0x26/0x650 [bfq_mq_iosched] =
RSP: ffffc90003b4f9d8
> [ 2748.653090] CR2: 00000000000000d0
>=20
> The crash address corresponds to the following source code according =
to gdb:
>=20
> (gdb) list *(__bfq_insert_request+0x26)
> 0xd6f6 is in __bfq_insert_request (block/bfq-mq-iosched.c:4430).
> 4425
> 4426    static void __bfq_insert_request(struct bfq_data *bfqd, struct =
request *rq)
> 4427    {
> 4428            struct bfq_queue *bfqq =3D RQ_BFQQ(rq), *new_bfqq;
> 4429
> 4430            assert_spin_locked(&bfqd->lock);
> 4431
> 4432            bfq_log_bfqq(bfqd, bfqq, "__insert_req: rq %p bfqq =
%p", rq, bfqq);
> 4433
> 4434            /*
>=20

Hi Bart,
I've tried to figure out how to deal with this crash, but I didn't
find any sensible way to go, for the following two reasons.

First, if I'm not missing anything, then I don't yet have the hardware
required to run the srp-test.  So, I cannot easily reproduce this
failure.  Actually, BFQ is not yet suitable, and maybe will never be
in its current design, for very high-speed hardware as InfiniBand and
NVMe devices.

Second, a NULL-pointer fault at the line you report is rather weird.
In fact, the sequence of C-code instructions executed up to that line
is:

struct bfq_data *bfqd =3D q->elevator->elevator_data;
...
spin_lock_irq(&bfqd->lock);
__bfq_insert_request(bfqd, rq);
	/* inside the __bfq_insert_request function: */
	struct bfq_queue *bfqq =3D RQ_BFQQ(rq), ...;
	assert_spin_locked(&bfqd->lock);

So, how can the last line cause a NULL-pointer-dereference exception
on the same address, &bfqd->lock, on which spin_lock_irq(&bfqd->lock);
was happy to work to get a spin lock?

Any idea on how to proceed?  If this strage bug remains hard to spot,
then, if you agree, I will go on in the meanwhile with submitting a
new version of the patch series, which addresses your other issues.

Thanks,
Paolo

> Bart.
