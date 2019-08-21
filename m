Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED94C3A589
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 03:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7DD22DA7
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 03:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfHUDBI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 23:01:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfHUDBI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 23:01:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90E3C58569;
        Wed, 21 Aug 2019 03:01:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91D5A3D8F;
        Wed, 21 Aug 2019 03:00:58 +0000 (UTC)
Date:   Wed, 21 Aug 2019 11:00:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
Message-ID: <20190821030052.GD24167@ming.t460p>
References: <20190816135506.29253-1-ming.lei@redhat.com>
 <09092247-1623-57ff-6297-1abd9a8cc8a2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09092247-1623-57ff-6297-1abd9a8cc8a2@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 21 Aug 2019 03:01:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 20, 2019 at 02:21:10PM -0700, Bart Van Assche wrote:
> On 8/16/19 6:55 AM, Ming Lei wrote:
> > @@ -567,8 +568,17 @@ int elevator_switch_mq(struct request_queue *q,
> >   	lockdep_assert_held(&q->sysfs_lock);
> >   	if (q->elevator) {
> > -		if (q->elevator->registered)
> > +		if (q->elevator->registered) {
> > +			/*
> > +			 * sysfs write is exclusively, release
> > +			 * sysfs_lock for avoiding deadlock with
> > +			 * sysfs built-in lock which is required
> > +			 * in either .show or .store path.
> > +			 */
> > +			mutex_unlock(&q->sysfs_lock);
> >   			elv_unregister_queue(q);
> > +			mutex_lock(&q->sysfs_lock);
> > +		}
> >   		ioc_clear_queue(q);
> >   		elevator_exit(q, q->elevator);
> >   	}
> 
> Hi Ming,
> 
> I don't like this part of the patch. Consider the following call chain:
> 
> queue_attr_store() -> elv_iosched_store() -> __elevator_change() ->
> elevator_switch() -> elevator_switch_mq().
> 
> queue_attr_store() locks sysfs_lock to serialize sysfs attribute show
> and store callbacks. So the above changes unlocks sysfs_lock from inside
> such a callback function and hence breaks that serialization.

I guess we have to break the serialization, because we can't hold
q->sysfs_lock when deleting iosched kobjects. And we may re-check
QUEUE_FLAG_REGISTERED after grabbing .sysfs_lock again, and stop
to switch to new scheduler if queue is un-registered.

> Can you
> have a look at the alternative patch below?

Sure.

> 
> Thanks,
> 
> Bart.
> 
> 
> Subject: [PATCH] block: Fix lock inversion triggered during request queue removal
> 
> Call blk_mq_unregister_dev() after having deleted q->kobj. Move
> the kobject_uevent(q->mq_kobj, KOBJ_REMOVE) call from inside
> blk_mq_unregister_dev() to its caller.
> 
> ---
>  block/blk-mq-sysfs.c |  5 ++---
>  block/blk-sysfs.c    | 19 +++----------------
>  block/elevator.c     |  2 --
>  3 files changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index d6e1a9bd7131..0ec968009791 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -270,16 +270,15 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
>  	struct blk_mq_hw_ctx *hctx;
>  	int i;
> 
> -	lockdep_assert_held(&q->sysfs_lock);
> -
>  	queue_for_each_hw_ctx(q, hctx, i)
>  		blk_mq_unregister_hctx(hctx);
> 
> -	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>  	kobject_del(q->mq_kobj);
>  	kobject_put(&dev->kobj);
> 
> +	mutex_lock(&q->sysfs_lock);
>  	q->mq_sysfs_init_done = false;
> +	mutex_unlock(&q->sysfs_lock);
>  }
> 
>  void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 977c659dcd18..e6f8cd99aded 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -1029,31 +1029,18 @@ void blk_unregister_queue(struct gendisk *disk)
>  	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
>  		return;
> 
> -	/*
> -	 * Since sysfs_remove_dir() prevents adding new directory entries
> -	 * before removal of existing entries starts, protect against
> -	 * concurrent elv_iosched_store() calls.
> -	 */
> -	mutex_lock(&q->sysfs_lock);
> -
>  	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);

.sysfs_lock has to be held for clearing 'REGISTERED', we have to wait
for concurrent store to 'queue/scheduler' before un-registering queue.

> 
> -	/*
> -	 * Remove the sysfs attributes before unregistering the queue data
> -	 * structures that can be modified through sysfs.
> -	 */
>  	if (queue_is_mq(q))
> -		blk_mq_unregister_dev(disk_to_dev(disk), q);
> -	mutex_unlock(&q->sysfs_lock);
> -
> +		kobject_uevent(q->mq_kobj, KOBJ_REMOVE);

Could you explain why you move the above line here?

>  	kobject_uevent(&q->kobj, KOBJ_REMOVE);
>  	kobject_del(&q->kobj);
>  	blk_trace_remove_sysfs(disk_to_dev(disk));
> 
> -	mutex_lock(&q->sysfs_lock);
> +	if (queue_is_mq(q))
> +		blk_mq_unregister_dev(disk_to_dev(disk), q);
>  	if (q->elevator)
>  		elv_unregister_queue(q);
> -	mutex_unlock(&q->sysfs_lock);
> 
>  	kobject_put(&disk_to_dev(disk)->kobj);
>  }
> diff --git a/block/elevator.c b/block/elevator.c
> index 2f17d66d0e61..128e7cf032e1 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -495,8 +495,6 @@ int elv_register_queue(struct request_queue *q)
> 
>  void elv_unregister_queue(struct request_queue *q)
>  {
> -	lockdep_assert_held(&q->sysfs_lock);
> -
>  	if (q) {
>  		struct elevator_queue *e = q->elevator;

elv_unregister_queue() is still called in elevator_switch_mq() with
.sysfs_lock held, then potential AB-BA lock still exists.

The same issue exists on blk_mq_sysfs_unregister() too.


Thanks,
Ming
