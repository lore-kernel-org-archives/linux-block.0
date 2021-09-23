Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDEC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D0E61130
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhIWBff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238177AbhIWBfe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632360843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5sTNH0DMEHxc/UUCqYBpOnuxfKb0wrbF1Aoxgn49gQc=;
        b=LuUNeo8pMHCO7EmobpLQLeuJI95TBtYVDT0Fjh0I+192IcUgzws/v76aCZ551hIKAP+APJ
        RgYErfItf2D4cNyLXUwb/u3aVtpnjkVWnNOlREzv6X6NqAeWMJWV/mALc9eXcpEd4GQ5dV
        RznGnvLT6VFUa9N7LAHdytCujA5xk0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-V1NTVZFsNxWpa-X38BGbQw-1; Wed, 22 Sep 2021 21:34:02 -0400
X-MC-Unique: V1NTVZFsNxWpa-X38BGbQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04BAB1005E4D;
        Thu, 23 Sep 2021 01:34:01 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9147C5D9DC;
        Thu, 23 Sep 2021 01:33:53 +0000 (UTC)
Date:   Thu, 23 Sep 2021 09:34:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: drain file system I/O on del_gendisk
Message-ID: <YUvZi2a0KjxEkiHo@T590>
References: <20210922172222.2453343-1-hch@lst.de>
 <20210922172222.2453343-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922172222.2453343-4-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 22, 2021 at 07:22:21PM +0200, Christoph Hellwig wrote:
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
> ---
>  block/blk-core.c      | 27 ++++++++++++---------------
>  block/blk.h           |  1 +
>  block/genhd.c         | 21 +++++++++++++++++++++
>  include/linux/genhd.h |  1 +
>  4 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index e951378855a02..d150d829a53c4 100644
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
> +
> +	rq_qos_exit(q);
> +	blk_sync_queue(q);
> +	blk_flush_integrity();
> +	/*
> +	 * Allow using passthrough request again after the queue is torn down.
> +	 */
> +	blk_mq_unfreeze_queue(q);

After blk_mq_unfreeze_queue() returns, blk_try_enter_queue() will return
true, so new FS I/O from opened bdev still won't be blocked, right?


Thanks,
Ming

