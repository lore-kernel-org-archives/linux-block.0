Return-Path: <SRS0=A22s=WX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25924C3A5A3
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B58204EC
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 10:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfH0KiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfH0KiA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 06:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4F458B5FF0;
        Tue, 27 Aug 2019 10:37:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 796EC5D9CD;
        Tue, 27 Aug 2019 10:37:50 +0000 (UTC)
Date:   Tue, 27 Aug 2019 18:37:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V3 5/5] block: split .sysfs_lock into two locks
Message-ID: <20190827103744.GD30871@ming.t460p>
References: <20190826025146.31158-1-ming.lei@redhat.com>
 <20190826025146.31158-6-ming.lei@redhat.com>
 <6499b212-fa8c-7d19-8149-43c8ad1e950d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6499b212-fa8c-7d19-8149-43c8ad1e950d@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 27 Aug 2019 10:37:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 26, 2019 at 09:24:03AM -0700, Bart Van Assche wrote:
> On 8/25/19 7:51 PM, Ming Lei wrote:
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index 5b0b5224cfd4..5941a0176f87 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -938,6 +938,7 @@ int blk_register_queue(struct gendisk *disk)
> >   	int ret;
> >   	struct device *dev = disk_to_dev(disk);
> >   	struct request_queue *q = disk->queue;
> > +	bool has_elevator = false;
> >   	if (WARN_ON(!q))
> >   		return -ENXIO;
> > @@ -945,7 +946,6 @@ int blk_register_queue(struct gendisk *disk)
> >   	WARN_ONCE(blk_queue_registered(q),
> >   		  "%s is registering an already registered queue\n",
> >   		  kobject_name(&dev->kobj));
> > -	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
> >   	/*
> >   	 * SCSI probing may synchronously create and destroy a lot of
> > @@ -966,7 +966,7 @@ int blk_register_queue(struct gendisk *disk)
> >   		return ret;
> >   	/* Prevent changes through sysfs until registration is completed. */
> > -	mutex_lock(&q->sysfs_lock);
> > +	mutex_lock(&q->sysfs_dir_lock);
> 
> Does mutex_lock(&q->sysfs_dir_lock) really protect against changes of the
> I/O scheduler through sysfs or does it only protect against concurrent sysfs
> object creation and removal?

It is only for protecting against concurrent sysfs object creation and removal.

> In other words, should the comment above this
> mutex lock call be updated?

Yeah, it should be removed.

> 
> > @@ -987,26 +987,37 @@ int blk_register_queue(struct gendisk *disk)
> >   		blk_mq_debugfs_register(q);
> >   	}
> > -	kobject_uevent(&q->kobj, KOBJ_ADD);
> > -
> > -	wbt_enable_default(q);
> > -
> > -	blk_throtl_register_queue(q);
> > -
> > +	/*
> > +	 * The queue's kobject ADD uevent isn't sent out, also the
> > +	 * flag of QUEUE_FLAG_REGISTERED isn't set yet, so elevator
> > +	 * switch won't happen at all.
> > +	 */
> >   	if (q->elevator) {
> > -		ret = elv_register_queue(q);
> > +		ret = elv_register_queue(q, false);
> >   		if (ret) {
> > -			mutex_unlock(&q->sysfs_lock);
> > -			kobject_uevent(&q->kobj, KOBJ_REMOVE);
> > +			mutex_unlock(&q->sysfs_dir_lock);
> >   			kobject_del(&q->kobj);
> >   			blk_trace_remove_sysfs(dev);
> >   			kobject_put(&dev->kobj);
> >   			return ret;
> >   		}
> > +		has_elevator = true;
> >   	}
> 
> I think the reference to the kobject ADD event in the comment is misleading.
> If e.g. a request queue is registered, unregistered and reregistered
> quickly, can it happen that a udev rule for the ADD event triggered by the
> first registration is executed in the middle of the second registration? Is

It should happen, but this patch doesn't change anything about this
behavior.

> setting the REGISTERED flag later sufficient to fix the race against
> scheduler changes through sysfs?

Yes, it is enough. 

> If so, how about leaving out the reference
> to the kobject ADD event from the above comment?

OK.

> 
> > +	mutex_lock(&q->sysfs_lock);
> > +	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
> > +	wbt_enable_default(q);
> > +	blk_throtl_register_queue(q);
> > +	mutex_unlock(&q->sysfs_lock);
> > +
> > +	/* Now everything is ready and send out KOBJ_ADD uevent */
> > +	kobject_uevent(&q->kobj, KOBJ_ADD);
> > +	if (has_elevator)
> > +		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
> 
> Can it happen that immediately after mutex_unlock(&q->sysfs_lock) a script
> removes the I/O scheduler and hence makes the value of the 'has_elevator'
> variable stale? In other words, should emitting KOBJ_ADD also be protected
> by sysfs_lock?

Good catch, it could be fine to hold syfs_lock for emitting KOBJ_ADD.

> 
> > @@ -1021,6 +1032,7 @@ EXPORT_SYMBOL_GPL(blk_register_queue);
> >   void blk_unregister_queue(struct gendisk *disk)
> >   {
> >   	struct request_queue *q = disk->queue;
> > +	bool has_elevator;
> >   	if (WARN_ON(!q))
> >   		return;
> > @@ -1035,25 +1047,25 @@ void blk_unregister_queue(struct gendisk *disk)
> >   	 * concurrent elv_iosched_store() calls.
> >   	 */
> >   	mutex_lock(&q->sysfs_lock);
> > -
> >   	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
> > +	has_elevator = !!q->elevator;
> > +	mutex_unlock(&q->sysfs_lock);
> > +	mutex_lock(&q->sysfs_dir_lock);
> >   	/*
> >   	 * Remove the sysfs attributes before unregistering the queue data
> >   	 * structures that can be modified through sysfs.
> >   	 */
> >   	if (queue_is_mq(q))
> >   		blk_mq_unregister_dev(disk_to_dev(disk), q);
> > -	mutex_unlock(&q->sysfs_lock);
> >   	kobject_uevent(&q->kobj, KOBJ_REMOVE);
> >   	kobject_del(&q->kobj);
> >   	blk_trace_remove_sysfs(disk_to_dev(disk));
> > -	mutex_lock(&q->sysfs_lock);
> > -	if (q->elevator)
> > +	if (has_elevator)
> >   		elv_unregister_queue(q);
> > -	mutex_unlock(&q->sysfs_lock);
> > +	mutex_unlock(&q->sysfs_dir_lock);
> 
> Is it safe to call elv_unregister_queue() if no I/O scheduler is associated
> with a request queue?

No, q->elevator has to be valid for elv_unregister_queue().

>If so, have you considered to leave out the
> 'has_elevator' variable from this function?
> 
> > @@ -567,10 +580,23 @@ int elevator_switch_mq(struct request_queue *q,
> >   	lockdep_assert_held(&q->sysfs_lock);
> >   	if (q->elevator) {
> > -		if (q->elevator->registered)
> > +		if (q->elevator->registered) {
> > +			mutex_unlock(&q->sysfs_lock);
> > +
> >   			elv_unregister_queue(q);
> > +
> > +			mutex_lock(&q->sysfs_lock);
> > +		}
> >   		ioc_clear_queue(q);
> >   		elevator_exit(q, q->elevator);
> > +
> > +		/*
> > +		 * sysfs_lock may be dropped, so re-check if queue is
> > +		 * unregistered. If yes, don't switch to new elevator
> > +		 * any more
> > +		 */
> > +		if (!blk_queue_registered(q))
> > +			return 0;
> >   	}
> 
> So elevator_switch_mq() is called with sysfs_lock held and releases and
> reacquires that mutex?

Yes.

> What will happen if e.g. syzbot writes into
> /sys/block/*/queue/scheduler from multiple threads concurrently? Can that

It can't happen, sysfs's write on same file is always exclusively protected
by one mutex, see kernfs_fop_write(), and should be same for normal fs too.

> lead to multiple concurrent calls of elv_register_queue() and
> elv_unregister_queue()? Can that e.g. cause concurrent calls of the
> following code from elv_register_queue(): kobject_add(&e->kobj, &q->kobj,
> "%s", "iosched")?

No, it won't happen.

> 
> Is it even possible to fix this lock inversion by introducing only one new
> mutex? I think the sysfs directories and attributes referenced by this patch
> are as follows:
> 
> /sys/block/<q>/queue
> /sys/block/<q>/queue/attr
> /sys/block/<q>/queue/iosched/attr
> /sys/block/<q>/mq
> /sys/block/<q>/mq/<n>
> /sys/block/<q>/mq/<n>/attr
> 
> Isn't the traditional approach to protect such a hierarchy to use one mutex
> per level? E.g. one mutex to serialize "queue" and "mq" manipulations
> (sysfs_dir_lock?), one mutex to protect the queue/attr attributes
> (sysfs_lock?), one mutex to serialize kobj creation in the mq directory, one
> mutex to protect the mq/<n>/attr attributes and one mutex to protect the I/O
> scheduler attributes?

This patch keeps to use sysfs_lock for protecting attributes show/write,
meantime don't use it for serializing kobj creation & removal, so far
looks good.

I will address your above comments and post V4 for further review.

Thanks,
Ming
