Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38116 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbdBQKaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 05:30:39 -0500
Received: by mail-wm0-f53.google.com with SMTP id r141so6934222wmg.1
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2017 02:30:38 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <7F6BB427-828D-4609-8A89-6CFB87D57B85@linaro.org>
Date: Fri, 17 Feb 2017 11:30:34 +0100
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Message-Id: <F598CD85-0340-4189-AF45-D30C40DA4A07@linaro.org>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com> <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org> <a3e62a57-d401-99e0-6487-fc8277204e71@fb.com> <9fe1b3a9-2a80-8891-1044-f83558e28d15@fb.com> <7F6BB427-828D-4609-8A89-6CFB87D57B85@linaro.org>
To: Jens Axboe <axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 16 feb 2017, alle ore 11:31, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>>=20
>> Il giorno 15 feb 2017, alle ore 19:04, Jens Axboe <axboe@fb.com> ha =
scritto:
>>=20
>> On 02/15/2017 10:58 AM, Jens Axboe wrote:
>>> On 02/15/2017 10:24 AM, Paolo Valente wrote:
>>>>=20
>>>>> Il giorno 10 feb 2017, alle ore 19:32, Omar Sandoval =
<osandov@osandov.com> ha scritto:
>>>>>=20
>>>>> From: Omar Sandoval <osandov@fb.com>
>>>>>=20
>>>>> None of the other blk-mq elevator hooks are called with this lock =
held.
>>>>> Additionally, it can lead to circular locking dependencies between
>>>>> queue_lock and the private scheduler lock.
>>>>>=20
>>>>=20
>>>> Hi Omar,
>>>> I'm sorry but it seems that a new potential deadlock has showed up.
>>>> See lockdep splat below.
>>>>=20
>>>> I've tried to think about different solutions than turning back to
>>>> deferring the body of exit_icq, but at no avail.
>>>=20
>>> Looks like a interaction between bfqd->lock and q->queue_lock. Since =
the
>>> core has no notion of you bfqd->lock, the naturally dependency here
>>> would be to nest bfqd->lock inside q->queue_lock. Is that possible =
for
>>> you?
>>>=20
>>> Looking at the code a bit, maybe it'd just be simpler to get rid of
>>> holding the queue lock for that spot. For the mq scheduler, we =
really
>>> don't want places where we invoke with that held already. Does the =
below
>>> work for you?
>>=20
>> Would need to remove one more lockdep assert. And only test this for
>> the mq parts, we'd need to spread a bit of love on the classic
>> scheduling icq exit path for this to work on that side.
>>=20
>=20
> Sorry Jens, same splat.  What confuses me is the second column
> in the possible scenario:
>=20
> [  139.368477]        CPU0                    	CPU1
> [  139.369129]        ----                    	----
> [  139.369774]   lock(&(&ioc->lock)->rlock);
> [  139.370339]                                		=
lock(&(&q->__queue_lock)->rlock);
> [  139.390579]                                		=
lock(&(&ioc->lock)->rlock);
> [  139.391522]   lock(&(&bfqd->lock)->rlock);
>=20
> I could not find any code path, related to the reported call traces,
> and taking first q->queue_lock and then ioc->lock.
>=20
> Any suggestion on how to go on, and hopefully help with this problem =
is
> welcome.
>=20

Jens,
this is just to tell you that I have found the link that still causes
the circular dependency: an ioc->lock nested into a queue_lock in
ioc_create_icq.  I'll try to come back with a solution proposal.

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>> index b12f9c87b4c3..546ff8f81ede 100644
>> --- a/block/blk-ioc.c
>> +++ b/block/blk-ioc.c
>> @@ -54,7 +54,7 @@ static void ioc_exit_icq(struct io_cq *icq)
>> 	icq->flags |=3D ICQ_EXITED;
>> }
>>=20
>> -/* Release an icq.  Called with both ioc and q locked. */
>> +/* Release an icq.  Called with ioc locked. */
>> static void ioc_destroy_icq(struct io_cq *icq)
>> {
>> 	struct io_context *ioc =3D icq->ioc;
>> @@ -62,7 +62,6 @@ static void ioc_destroy_icq(struct io_cq *icq)
>> 	struct elevator_type *et =3D q->elevator->type;
>>=20
>> 	lockdep_assert_held(&ioc->lock);
>> -	lockdep_assert_held(q->queue_lock);
>>=20
>> 	radix_tree_delete(&ioc->icq_tree, icq->q->id);
>> 	hlist_del_init(&icq->ioc_node);
>> @@ -222,25 +221,34 @@ void exit_io_context(struct task_struct *task)
>> 	put_io_context_active(ioc);
>> }
>>=20
>> +static void __ioc_clear_queue(struct list_head *icq_list)
>> +{
>> +	while (!list_empty(icq_list)) {
>> +		struct io_cq *icq =3D list_entry(icq_list->next,
>> +					       struct io_cq, q_node);
>> +		struct io_context *ioc =3D icq->ioc;
>> +
>> +		spin_lock_irq(&ioc->lock);
>> +		ioc_destroy_icq(icq);
>> +		spin_unlock_irq(&ioc->lock);
>> +	}
>> +}
>> +
>> /**
>> * ioc_clear_queue - break any ioc association with the specified =
queue
>> * @q: request_queue being cleared
>> *
>> - * Walk @q->icq_list and exit all io_cq's.  Must be called with @q =
locked.
>> + * Walk @q->icq_list and exit all io_cq's.
>> */
>> void ioc_clear_queue(struct request_queue *q)
>> {
>> -	lockdep_assert_held(q->queue_lock);
>> +	LIST_HEAD(icq_list);
>>=20
>> -	while (!list_empty(&q->icq_list)) {
>> -		struct io_cq *icq =3D list_entry(q->icq_list.next,
>> -					       struct io_cq, q_node);
>> -		struct io_context *ioc =3D icq->ioc;
>> +	spin_lock_irq(q->queue_lock);
>> +	list_splice_init(&q->icq_list, &icq_list);
>> +	spin_unlock_irq(q->queue_lock);
>>=20
>> -		spin_lock(&ioc->lock);
>> -		ioc_destroy_icq(icq);
>> -		spin_unlock(&ioc->lock);
>> -	}
>> +	__ioc_clear_queue(&icq_list);
>> }
>>=20
>> int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, =
int node)
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 070d81bae1d5..1944aa1cb899 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -815,9 +815,7 @@ static void blk_release_queue(struct kobject =
*kobj)
>> 	blkcg_exit_queue(q);
>>=20
>> 	if (q->elevator) {
>> -		spin_lock_irq(q->queue_lock);
>> 		ioc_clear_queue(q);
>> -		spin_unlock_irq(q->queue_lock);
>> 		elevator_exit(q->elevator);
>> 	}
>>=20
>> diff --git a/block/elevator.c b/block/elevator.c
>> index a25bdd90b270..aaa1e9836512 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -985,9 +985,7 @@ static int elevator_switch(struct request_queue =
*q, struct elevator_type *new_e)
>> 		if (old_registered)
>> 			elv_unregister_queue(q);
>>=20
>> -		spin_lock_irq(q->queue_lock);
>> 		ioc_clear_queue(q);
>> -		spin_unlock_irq(q->queue_lock);
>> 	}
>>=20
>> 	/* allocate, init and register new elevator */
>>=20
>> --=20
>> Jens Axboe
