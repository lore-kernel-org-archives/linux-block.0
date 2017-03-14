Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <7654009c-f38b-20f8-7536-2982338a8228@kernel.dk>
Date: Tue, 14 Mar 2017 12:28:26 +0100
Cc: Tejun Heo <tj@kernel.org>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <82C709A3-7D94-4C67-9FBC-0B247353DC9F@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <20170304160131.57366-2-paolo.valente@linaro.org> <91b856e8-2c14-00b6-fdd8-b9879b1b9952@kernel.dk> <060CBCB3-AB73-4F88-9CDC-828F502A8FF7@linaro.org> <7654009c-f38b-20f8-7536-2982338a8228@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 06 mar 2017, alle ore 21:46, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 03/05/2017 09:02 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 05 mar 2017, alle ore 16:16, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>>=20
>>> On 03/04/2017 09:01 AM, Paolo Valente wrote:
>>>> We tag as v0 the version of BFQ containing only BFQ's engine plus
>>>> hierarchical support. BFQ's engine is introduced by this commit, =
while
>>>> hierarchical support is added by next commit. We use the v0 tag to
>>>> distinguish this minimal version of BFQ from the versions =
containing
>>>> also the features and the improvements added by next commits. =
BFQ-v0
>>>> coincides with the version of BFQ submitted a few years ago [1], =
apart
>>>> from the introduction of preemption, described below.
>>>>=20
>>>> BFQ is a proportional-share I/O scheduler, whose general structure,
>>>> plus a lot of code, are borrowed from CFQ.
>>>=20
>>> I'll take a closer look at this in the coming week.
>>=20
>> ok
>>=20
>>> But one quick
>>> comment - don't default to BFQ. Both because it might not be fully
>>> stable yet, and also because the performance limitation of it is
>>> quite severe. Whereas deadline doesn't really hurt single queue
>>> flash at all, BFQ will.
>>>=20
>>=20
>> Ok, sorry.  I was doubtful on what to do, but, to not bother you on
>> every details, I went for setting it as default, because I thought
>> people would have preferred to test it, even from boot, in this
>> preliminary stage.  I reset elevator.c in the submission, unless you
>> want me to do it even before receiving your and others' reviews.
>=20
> I don't think it's stable enough for that yet, it's seen very little
> testing outside of your own testing.

Hi Jens.

Yes, sorry, in general people of course use a kernel for a little bit
more than just testing bfq ...

> Given that, it's much better that
> people opt in to testing BFQ, so they at least know they can expect
> crashes.
>=20
> Speaking of testing, I ran into this bug:
>=20
> [ 9469.621413] general protection fault: 0000 [#1] PREEMPT SMP
> [ 9469.627872] Modules linked in: loop dm_mod xfs libcrc32c =
bfq_iosched x86_pkg_temp_thermal btrfe
> [ 9469.648196] CPU: 0 PID: 2114 Comm: kworker/0:1H Tainted: G        W =
      4.11.0-rc1+ #249
> [ 9469.657873] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS =
2.3.4 11/09/2016
> [ 9469.666742] Workqueue: xfs-log/nvme4n1p1 xfs_buf_ioend_work [xfs]
> [ 9469.674213] task: ffff881fe97646c0 task.stack: ffff881ff13d0000
> [ 9469.681053] RIP: 0010:__bfq_bfqq_expire+0xb3/0x110 [bfq_iosched]
> [ 9469.687991] RSP: 0018:ffff881fff603dd8 EFLAGS: 00010082
> [ 9469.694052] RAX: 6b6b6b6b6b6b6b6b RBX: ffff883fe8e0eb58 RCX: =
0000000000010004
> [ 9469.702251] RDX: 0000000000010004 RSI: 0000000000000000 RDI: =
00000000ffffffff
> [ 9469.710456] RBP: ffff881fff603de8 R08: 0000000000000000 R09: =
0000000000000001
> [ 9469.718659] R10: 0000000000000001 R11: 0000000000000000 R12: =
ffff883fe8dbf4e8
> [ 9469.726863] R13: 0000000000000000 R14: 0000000000000001 R15: =
0000000000007904
> [ 9469.735063] FS:  0000000000000000(0000) GS:ffff881fff600000(0000) =
knlGS:0000000000000000
> [ 9469.744539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9469.751189] CR2: 00000000020c0018 CR3: 0000001fec1db000 CR4: =
00000000003406f0
> [ 9469.759392] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [ 9469.767596] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [ 9469.775794] Call Trace:
> [ 9469.778748]  <IRQ>
> [ 9469.781222]  bfq_bfqq_expire+0x104/0x2f0 [bfq_iosched]
> [ 9469.787193]  ? bfq_idle_slice_timer+0x2a/0xc0 [bfq_iosched]
> [ 9469.793650]  bfq_idle_slice_timer+0x7c/0xc0 [bfq_iosched]
> [ 9469.799914]  __hrtimer_run_queues+0xd9/0x500
> [ 9469.804911]  ? bfq_rq_enqueued+0x340/0x340 [bfq_iosched]
> [ 9469.811072]  hrtimer_interrupt+0xb0/0x200
> [ 9469.815781]  local_apic_timer_interrupt+0x31/0x50
> [ 9469.821264]  smp_apic_timer_interrupt+0x33/0x50
> [ 9469.826555]  apic_timer_interrupt+0x90/0xa0
>=20
> just running the xfstest suite. It's test generic/299. Have you done
> full runs of xfstest? I'd greatly recommend that for shaking out bugs.
> Run a full loop with xfs, one with btrfs, and one with ext4 for better
> confidence in the stability of the code.
>=20

Thanks for this information and suggestions.  I'm running xfstests
right now, to reproduce at least the failure you spotted.

Thanks,
Paolo

> (gdb) l *__bfq_bfqq_expire+0xb3
> 0x5983 is in __bfq_bfqq_expire (block/bfq-iosched.c:2664).
> 2659		 * been properly deactivated or requeued, so we can =
safely
> 2660		 * execute the final step: reset in_service_entity along =
the
> 2661		 * path from entity to the root.
> 2662		 */
> 2663		for_each_entity(entity)
> 2664			entity->sched_data->in_service_entity =3D NULL;
> 2665	}
> 2666=09
> 2667	static void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct =
bfq_queue *bfqq,
> 2668					bo
