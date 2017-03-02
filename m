Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34989 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbdCBSHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2017 13:07:07 -0500
Received: by mail-wr0-f179.google.com with SMTP id g10so58318824wrg.2
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2017 10:06:26 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <80de4554-a14b-4ce6-7c6e-ec66f70b14b1@fb.com>
Date: Thu, 2 Mar 2017 17:07:15 +0100
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Message-Id: <6C03BF2A-0902-431A-A545-933F56D3E134@linaro.org>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com> <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org> <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com> <9fe1b3a9-2a80-8891-1044-f83558e28d15@fb.com> <1720FEB5-FBBA-4EAA-8292-E820AA15389D@linaro.org> <dc4dc011-7038-2c05-b1c0-f6f7a07fa9ae@fb.com> <80de4554-a14b-4ce6-7c6e-ec66f70b14b1@fb.com>
To: Jens Axboe <axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 02 mar 2017, alle ore 16:13, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> On 03/02/2017 08:00 AM, Jens Axboe wrote:
>> On 03/02/2017 03:28 AM, Paolo Valente wrote:
>>>=20
>>>> Il giorno 15 feb 2017, alle ore 19:04, Jens Axboe <axboe@fb.com> ha =
scritto:
>>>>=20
>>>> On 02/15/2017 10:58 AM, Jens Axboe wrote:
>>>>> On 02/15/2017 10:24 AM, Paolo Valente wrote:
>>>>>>=20
>>>>>>> Il giorno 10 feb 2017, alle ore 19:32, Omar Sandoval =
<osandov@osandov.com> ha scritto:
>>>>>>>=20
>>>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>>>=20
>>>>>>> None of the other blk-mq elevator hooks are called with this =
lock held.
>>>>>>> Additionally, it can lead to circular locking dependencies =
between
>>>>>>> queue_lock and the private scheduler lock.
>>>>>>>=20
>>>>>>=20
>>>>>> Hi Omar,
>>>>>> I'm sorry but it seems that a new potential deadlock has showed =
up.
>>>>>> See lockdep splat below.
>>>>>>=20
>>>>>> I've tried to think about different solutions than turning back =
to
>>>>>> deferring the body of exit_icq, but at no avail.
>>>>>=20
>>>>> Looks like a interaction between bfqd->lock and q->queue_lock. =
Since the
>>>>> core has no notion of you bfqd->lock, the naturally dependency =
here
>>>>> would be to nest bfqd->lock inside q->queue_lock. Is that possible =
for
>>>>> you?
>>>>>=20
>>>>> Looking at the code a bit, maybe it'd just be simpler to get rid =
of
>>>>> holding the queue lock for that spot. For the mq scheduler, we =
really
>>>>> don't want places where we invoke with that held already. Does the =
below
>>>>> work for you?
>>>>=20
>>>> Would need to remove one more lockdep assert. And only test this =
for
>>>> the mq parts, we'd need to spread a bit of love on the classic
>>>> scheduling icq exit path for this to work on that side.
>>>>=20
>>>=20
>>>=20
>>> Jens,
>>> here is the reply I anticipated in my previous email: after rebasing
>>> against master, I'm getting again the deadlock that this patch of
>>> yours solved (together with some changes in bfq-mq).  I thought you =
added a
>>> sort of equivalent commit (now) to the mainline branch.  Am I wrong?
>>=20
>> The patch I posted was never pulled to completion, it wasn't clear
>> to me if it fixed your issue or not. Maybe I missed a reply on
>> that?
>>=20
>> Let me take another stab at it today, I'll send you a version to test
>> on top of my for-linus branch.
>=20
> I took at look at my last posting, and I think it was only missing a
> lock grab in cfq, since we don't hold that for icq exit anymore.  =
Paolo,
> it'd be great if you could verify that this works. Not for bfq-mq (we
> already know it does), but for CFQ.

No luck, sorry :(

It looks like to have just not to take q->queue_lock in cfq_exit_icq.

[    9.329501] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

[    9.336132] [ INFO: possible recursive locking detected ]
[    9.343801] 4.10.0-bfq-mq+ #56 Not tainted
[    9.353359] ---------------------------------------------
[    9.354101] ata_id/160 is trying to acquire lock:
[    9.354750]  (&(&q->__queue_lock)->rlock){..-...}, at: =
[<ffffffffaf48501a>] cfq_exit_icq+0x2a/0x80
[    9.355986]=20
[    9.355986] but task is already holding lock:
[    9.364221]  (&(&q->__queue_lock)->rlock){..-...}, at: =
[<ffffffffaf45a686>] put_io_context_active+0x86/0xe0
[    9.382980]=20
[    9.382980] other info that might help us debug this:
[    9.386460]  Possible unsafe locking scenario:
[    9.386460]=20
[    9.397070]        CPU0
[    9.397468]        ----
[    9.397811]   lock(&(&q->__queue_lock)->rlock);
[    9.398440]   lock(&(&q->__queue_lock)->rlock);
[    9.406265]=20
[    9.406265]  *** DEADLOCK ***
[    9.406265]=20
[    9.409589]  May be due to missing lock nesting notation
[    9.409589]=20
[    9.413040] 2 locks held by ata_id/160:
[    9.413576]  #0:  (&(&ioc->lock)->rlock/1){......}, at: =
[<ffffffffaf45a638>] put_io_context_active+0x38/0xe0
[    9.418069]  #1:  (&(&q->__queue_lock)->rlock){..-...}, at: =
[<ffffffffaf45a686>] put_io_context_active+0x86/0xe0
[    9.441118]=20
[    9.441118] stack backtrace:
[    9.445113] CPU: 0 PID: 160 Comm: ata_id Not tainted 4.10.0-bfq-mq+ =
#56
[    9.446210] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS =
VirtualBox 12/01/2006
[    9.457223] Call Trace:
[    9.457636]  dump_stack+0x85/0xc2
[    9.458183]  __lock_acquire+0x1834/0x1890
[    9.458839]  ? __lock_acquire+0x4af/0x1890
[    9.464206]  lock_acquire+0x11b/0x220
[    9.471703]  ? cfq_exit_icq+0x2a/0x80
[    9.472225]  _raw_spin_lock+0x3d/0x80
[    9.472784]  ? cfq_exit_icq+0x2a/0x80
[    9.476336]  cfq_exit_icq+0x2a/0x80
[    9.486750]  ioc_exit_icq+0x38/0x50
[    9.487245]  put_io_context_active+0x92/0xe0
[    9.488049]  exit_io_context+0x48/0x50
[    9.488423]  do_exit+0x7a8/0xc80
[    9.488797]  do_group_exit+0x50/0xd0
[    9.496655]  SyS_exit_group+0x14/0x20
[    9.497170]  entry_SYSCALL_64_fastpath+0x23/0xc6
[    9.497808] RIP: 0033:0x7f224d1c1b98
[    9.498302] RSP: 002b:00007ffd342666f8 EFLAGS: 00000246 ORIG_RAX: =
00000000000000e7
[    9.499360] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: =
00007f224d1c1b98
[    9.511706] RDX: 0000000000000000 RSI: 000000000000003c RDI: =
0000000000000000
[    9.516390] RBP: 00007f224db02690 R08: 00000000000000e7 R09: =
ffffffffffffff90
[    9.523044] R10: 00007f224d6d7250 R11: 0000000000000246 R12: =
0000000000000016
[    9.524015] R13: 0000000000000001 R14: 000055938a1c3010 R15: =
00007ffd34266170

Thanks,
Paolo

>  Run with lockdep enabled and see if
> it spits out anything. We'll hit this exit path very quickly, so the
> test doesn't need to be anything exhaustive.
>=20
>=20
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index b12f9c87b4c3..546ff8f81ede 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -54,7 +54,7 @@ static void ioc_exit_icq(struct io_cq *icq)
> 	icq->flags |=3D ICQ_EXITED;
> }
>=20
> -/* Release an icq.  Called with both ioc and q locked. */
> +/* Release an icq.  Called with ioc locked. */
> static void ioc_destroy_icq(struct io_cq *icq)
> {
> 	struct io_context *ioc =3D icq->ioc;
> @@ -62,7 +62,6 @@ static void ioc_destroy_icq(struct io_cq *icq)
> 	struct elevator_type *et =3D q->elevator->type;
>=20
> 	lockdep_assert_held(&ioc->lock);
> -	lockdep_assert_held(q->queue_lock);
>=20
> 	radix_tree_delete(&ioc->icq_tree, icq->q->id);
> 	hlist_del_init(&icq->ioc_node);
> @@ -222,25 +221,34 @@ void exit_io_context(struct task_struct *task)
> 	put_io_context_active(ioc);
> }
>=20
> +static void __ioc_clear_queue(struct list_head *icq_list)
> +{
> +	while (!list_empty(icq_list)) {
> +		struct io_cq *icq =3D list_entry(icq_list->next,
> +					       struct io_cq, q_node);
> +		struct io_context *ioc =3D icq->ioc;
> +
> +		spin_lock_irq(&ioc->lock);
> +		ioc_destroy_icq(icq);
> +		spin_unlock_irq(&ioc->lock);
> +	}
> +}
> +
> /**
>  * ioc_clear_queue - break any ioc association with the specified =
queue
>  * @q: request_queue being cleared
>  *
> - * Walk @q->icq_list and exit all io_cq's.  Must be called with @q =
locked.
> + * Walk @q->icq_list and exit all io_cq's.
>  */
> void ioc_clear_queue(struct request_queue *q)
> {
> -	lockdep_assert_held(q->queue_lock);
> +	LIST_HEAD(icq_list);
>=20
> -	while (!list_empty(&q->icq_list)) {
> -		struct io_cq *icq =3D list_entry(q->icq_list.next,
> -					       struct io_cq, q_node);
> -		struct io_context *ioc =3D icq->ioc;
> +	spin_lock_irq(q->queue_lock);
> +	list_splice_init(&q->icq_list, &icq_list);
> +	spin_unlock_irq(q->queue_lock);
>=20
> -		spin_lock(&ioc->lock);
> -		ioc_destroy_icq(icq);
> -		spin_unlock(&ioc->lock);
> -	}
> +	__ioc_clear_queue(&icq_list);
> }
>=20
> int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, =
int node)
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 002af836aa87..c44b321335f3 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -815,9 +815,7 @@ static void blk_release_queue(struct kobject =
*kobj)
> 	blkcg_exit_queue(q);
>=20
> 	if (q->elevator) {
> -		spin_lock_irq(q->queue_lock);
> 		ioc_clear_queue(q);
> -		spin_unlock_irq(q->queue_lock);
> 		elevator_exit(q->elevator);
> 	}
>=20
> diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> index 137944777859..4a71c79de037 100644
> --- a/block/cfq-iosched.c
> +++ b/block/cfq-iosched.c
> @@ -3658,6 +3658,8 @@ static void cfq_exit_icq(struct io_cq *icq)
> 	struct cfq_io_cq *cic =3D icq_to_cic(icq);
> 	struct cfq_data *cfqd =3D cic_to_cfqd(cic);
>=20
> +	spin_lock(cfqd->queue->queue_lock);
> +
> 	if (cic_to_cfqq(cic, false)) {
> 		cfq_exit_cfqq(cfqd, cic_to_cfqq(cic, false));
> 		cic_set_cfqq(cic, NULL, false);
> @@ -3667,6 +3669,8 @@ static void cfq_exit_icq(struct io_cq *icq)
> 		cfq_exit_cfqq(cfqd, cic_to_cfqq(cic, true));
> 		cic_set_cfqq(cic, NULL, true);
> 	}
> +
> +	spin_unlock(cfqd->queue->queue_lock);
> }
>=20
> static void cfq_init_prio_data(struct cfq_queue *cfqq, struct =
cfq_io_cq *cic)
> diff --git a/block/elevator.c b/block/elevator.c
> index ac1c9f481a98..01139f549b5b 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -983,9 +983,7 @@ static int elevator_switch(struct request_queue =
*q, struct elevator_type *new_e)
> 		if (old_registered)
> 			elv_unregister_queue(q);
>=20
> -		spin_lock_irq(q->queue_lock);
> 		ioc_clear_queue(q);
> -		spin_unlock_irq(q->queue_lock);
> 	}
>=20
> 	/* allocate, init and register new elevator */
>=20
> --=20
> Jens Axboe
