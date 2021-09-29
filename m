Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0359BC433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 08:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6695613A6
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 08:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbhI2ITD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 04:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244479AbhI2ITC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 04:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632903441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fl7qehZ5HowIPBtRwXGbJDgC5zsN8jworvefKfKsvBw=;
        b=W664fB+0PeGvfLYghRNWD9M3c623QSa/hPwxvjHWxqcmC+KNTVqsP9741IDDZrKrFq1Rqm
        M+llTPWiS9kGnCUWHeuH8Ns6EcPdHu8oUjFYYoUtxxBApgo8DgT4BaoWUb5xKUxavrjGAm
        H6JxnEi9EW3SS3XbGEWeRrmuT4ZEmJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-ABuqekptN1Wrd4hlRPZ4Wg-1; Wed, 29 Sep 2021 04:17:11 -0400
X-MC-Unique: ABuqekptN1Wrd4hlRPZ4Wg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0BD01006AA4;
        Wed, 29 Sep 2021 08:17:09 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B168160CC9;
        Wed, 29 Sep 2021 08:17:05 +0000 (UTC)
Date:   Wed, 29 Sep 2021 16:17:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 4/5] block: drain file system I/O on del_gendisk
Message-ID: <YVQg/a6GnELfPV1S@T590>
References: <20210929071241.934472-1-hch@lst.de>
 <20210929071241.934472-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929071241.934472-5-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29, 2021 at 09:12:40AM +0200, Christoph Hellwig wrote:
> Instead of delaying draining of file system I/O related items like the
> blk-qos queues, the integrity read workqueue and timeouts only when the
> request_queue is removed, do that when del_gendisk is called.  This is
> important for SCSI where the upper level drivers that control the gendisk
> are separate entities, and the disk can be freed much earlier than the
> request_queue, or can even be unbound without tearing down the queue.
> 
> Fixes: edb0872f44ec ("block: move the bdi from the request_queue to the gendisk")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  block/blk-core.c      | 27 ++++++++++++---------------
>  block/blk.h           |  1 +
>  block/genhd.c         | 21 +++++++++++++++++++++
>  include/linux/genhd.h |  1 +
>  4 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 43f5da707d8e3..4d8f5fe915887 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -49,7 +49,6 @@
>  #include "blk-mq.h"
>  #include "blk-mq-sched.h"
>  #include "blk-pm.h"
> -#include "blk-rq-qos.h"
>  
>  struct dentry *blk_debugfs_root;
>  
> @@ -337,23 +336,25 @@ void blk_put_queue(struct request_queue *q)
>  }
>  EXPORT_SYMBOL(blk_put_queue);
>  
> -void blk_set_queue_dying(struct request_queue *q)
> +void blk_queue_start_drain(struct request_queue *q)
>  {
> -	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> -
>  	/*
>  	 * When queue DYING flag is set, we need to block new req
>  	 * entering queue, so we call blk_freeze_queue_start() to
>  	 * prevent I/O from crossing blk_queue_enter().
>  	 */
>  	blk_freeze_queue_start(q);
> -
>  	if (queue_is_mq(q))
>  		blk_mq_wake_waiters(q);
> -
>  	/* Make blk_queue_enter() reexamine the DYING flag. */
>  	wake_up_all(&q->mq_freeze_wq);
>  }
> +
> +void blk_set_queue_dying(struct request_queue *q)
> +{
> +	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> +	blk_queue_start_drain(q);
> +}
>  EXPORT_SYMBOL_GPL(blk_set_queue_dying);
>  
>  /**
> @@ -385,13 +386,8 @@ void blk_cleanup_queue(struct request_queue *q)
>  	 */
>  	blk_freeze_queue(q);
>  
> -	rq_qos_exit(q);
> -
>  	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>  
> -	/* for synchronous bio-based driver finish in-flight integrity i/o */
> -	blk_flush_integrity();
> -
>  	blk_sync_queue(q);
>  	if (queue_is_mq(q))
>  		blk_mq_exit_queue(q);
> @@ -474,11 +470,12 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  
>  static inline int bio_queue_enter(struct bio *bio)
>  {
> -	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +	struct gendisk *disk = bio->bi_bdev->bd_disk;
> +	struct request_queue *q = disk->queue;
>  
>  	while (!blk_try_enter_queue(q, false)) {
>  		if (bio->bi_opf & REQ_NOWAIT) {
> -			if (blk_queue_dying(q))
> +			if (test_bit(GD_DEAD, &disk->state))
>  				goto dead;
>  			bio_wouldblock_error(bio);
>  			return -EBUSY;
> @@ -495,8 +492,8 @@ static inline int bio_queue_enter(struct bio *bio)
>  		wait_event(q->mq_freeze_wq,
>  			   (!q->mq_freeze_depth &&
>  			    blk_pm_resume_queue(false, q)) ||
> -			   blk_queue_dying(q));
> -		if (blk_queue_dying(q))
> +			   test_bit(GD_DEAD, &disk->state));
> +		if (test_bit(GD_DEAD, &disk->state))
>  			goto dead;
>  	}
>  
> diff --git a/block/blk.h b/block/blk.h
> index 7d2a0ba7ed21d..e2ed2257709ae 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -51,6 +51,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
>  void blk_free_flush_queue(struct blk_flush_queue *q);
>  
>  void blk_freeze_queue(struct request_queue *q);
> +void blk_queue_start_drain(struct request_queue *q);
>  
>  #define BIO_INLINE_VECS 4
>  struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
> diff --git a/block/genhd.c b/block/genhd.c
> index 7b6e5e1cf9564..b3c33495d7208 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -26,6 +26,7 @@
>  #include <linux/badblocks.h>
>  
>  #include "blk.h"
> +#include "blk-rq-qos.h"
>  
>  static struct kobject *block_depr;
>  
> @@ -559,6 +560,8 @@ EXPORT_SYMBOL(device_add_disk);
>   */
>  void del_gendisk(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
> +
>  	might_sleep();
>  
>  	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
> @@ -575,8 +578,26 @@ void del_gendisk(struct gendisk *disk)
>  	fsync_bdev(disk->part0);
>  	__invalidate_device(disk->part0, true);
>  
> +	/*
> +	 * Fail any new I/O.
> +	 */
> +	set_bit(GD_DEAD, &disk->state);
>  	set_capacity(disk, 0);
>  
> +	/*
> +	 * Prevent new I/O from crossing bio_queue_enter().
> +	 */
> +	blk_queue_start_drain(q);
> +	blk_mq_freeze_queue_wait(q);

Draining request won't fix the problem completely:

1) blk-mq dispatch code may still be in-progress after q_usage_counter
becomes zero, see the story in 662156641bc4 ("block: don't drain in-progress dispatch in
blk_cleanup_queue()")

2) elevator code / blkcg code may still be called after blk_cleanup_queue(), such
as kyber, trace_kyber_latency()(q->disk is referred) is called in kyber's timer
handler, and the timer is deleted via del_timer_sync() via kyber_exit_sched()
from blk_release_queue().

> +
> +	rq_qos_exit(q);
> +	blk_sync_queue(q);
> +	blk_flush_integrity();
> +	/*
> +	 * Allow using passthrough request again after the queue is torn down.
> +	 */
> +	blk_mq_unfreeze_queue(q);

Again, one FS bio is still possible to enter queue now: submit_bio_checks()
is done before set_capacity(0), and submitted after blk_mq_unfreeze_queue()
returns.


Thanks,
Ming

