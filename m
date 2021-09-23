Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B34C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 06:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB52B61019
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 06:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhIWGXH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:23:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48416 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhIWGXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 02:23:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 907CC22349;
        Thu, 23 Sep 2021 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632378095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xudr1hmsjlR9Appu9UnJK0IG58xGnnb42IvddLEWsoA=;
        b=DIIcGuXXuZeSGwEdOE4uXXcjbHYMgXUrpoEtnElqL6weqG6jgUNr+bs+uVhIz/g63FzvZi
        QODImJhXPoDn70HTfyKQSPTZ/XD89U9DuR7zKjQsChpcXSAsPHPyoB8X+3szrV80RH4hq4
        MIjPisgS1zojPe5sU0A2adEs7UwtUD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632378095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xudr1hmsjlR9Appu9UnJK0IG58xGnnb42IvddLEWsoA=;
        b=9BSnBoc6xBSCCKUBR4YZ/QarT7xSnDWKZjLrMa9CB5giH27QGIqYMZW4MBKgOm/K0dxpLH
        Eraca5kTFFSwR2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61D6A13DB5;
        Thu, 23 Sep 2021 06:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hVOEFu8cTGE6WwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 23 Sep 2021 06:21:35 +0000
Subject: Re: [PATCH 3/4] block: drain file system I/O on del_gendisk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20210922172222.2453343-1-hch@lst.de>
 <20210922172222.2453343-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ce23ed6e-fc5c-b209-0b6c-70163572fb67@suse.de>
Date:   Thu, 23 Sep 2021 08:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210922172222.2453343-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/21 7:22 PM, Christoph Hellwig wrote:
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
>   block/blk-core.c      | 27 ++++++++++++---------------
>   block/blk.h           |  1 +
>   block/genhd.c         | 21 +++++++++++++++++++++
>   include/linux/genhd.h |  1 +
>   4 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index e951378855a02..d150d829a53c4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -49,7 +49,6 @@
>   #include "blk-mq.h"
>   #include "blk-mq-sched.h"
>   #include "blk-pm.h"
> -#include "blk-rq-qos.h"
>   
>   struct dentry *blk_debugfs_root;
>   
> @@ -337,23 +336,25 @@ void blk_put_queue(struct request_queue *q)
>   }
>   EXPORT_SYMBOL(blk_put_queue);
>   
> -void blk_set_queue_dying(struct request_queue *q)
> +void blk_queue_start_drain(struct request_queue *q)
>   {
> -	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> -
>   	/*
>   	 * When queue DYING flag is set, we need to block new req
>   	 * entering queue, so we call blk_freeze_queue_start() to
>   	 * prevent I/O from crossing blk_queue_enter().
>   	 */
>   	blk_freeze_queue_start(q);
> -
>   	if (queue_is_mq(q))
>   		blk_mq_wake_waiters(q);
> -
>   	/* Make blk_queue_enter() reexamine the DYING flag. */
>   	wake_up_all(&q->mq_freeze_wq);
>   }
> +
> +void blk_set_queue_dying(struct request_queue *q)
> +{
> +	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> +	blk_queue_start_drain(q);
> +}
>   EXPORT_SYMBOL_GPL(blk_set_queue_dying);
>   
>   /**
> @@ -385,13 +386,8 @@ void blk_cleanup_queue(struct request_queue *q)
>   	 */
>   	blk_freeze_queue(q);
>   
> -	rq_qos_exit(q);
> -
>   	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>   
> -	/* for synchronous bio-based driver finish in-flight integrity i/o */
> -	blk_flush_integrity();
> -
>   	blk_sync_queue(q);
>   	if (queue_is_mq(q))
>   		blk_mq_exit_queue(q);
> @@ -474,11 +470,12 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>   
>   static inline int bio_queue_enter(struct bio *bio)
>   {
> -	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +	struct gendisk *disk = bio->bi_bdev->bd_disk;
> +	struct request_queue *q = disk->queue;
>   
>   	while (!blk_try_enter_queue(q, false)) {
>   		if (bio->bi_opf & REQ_NOWAIT) {
> -			if (blk_queue_dying(q))
> +			if (test_bit(GD_DEAD, &disk->state))
>   				goto dead;
>   			bio_wouldblock_error(bio);
>   			return -EBUSY;
> @@ -495,8 +492,8 @@ static inline int bio_queue_enter(struct bio *bio)
>   		wait_event(q->mq_freeze_wq,
>   			   (!q->mq_freeze_depth &&
>   			    blk_pm_resume_queue(false, q)) ||
> -			   blk_queue_dying(q));
> -		if (blk_queue_dying(q))
> +			   test_bit(GD_DEAD, &disk->state));
> +		if (test_bit(GD_DEAD, &disk->state))
>   			goto dead;
>   	}
>   
> diff --git a/block/blk.h b/block/blk.h
> index 7d2a0ba7ed21d..e2ed2257709ae 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -51,6 +51,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
>   void blk_free_flush_queue(struct blk_flush_queue *q);
>   
>   void blk_freeze_queue(struct request_queue *q);
> +void blk_queue_start_drain(struct request_queue *q);
>   
>   #define BIO_INLINE_VECS 4
>   struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
> diff --git a/block/genhd.c b/block/genhd.c
> index 7b6e5e1cf9564..b3c33495d7208 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -26,6 +26,7 @@
>   #include <linux/badblocks.h>
>   
>   #include "blk.h"
> +#include "blk-rq-qos.h"
>   
>   static struct kobject *block_depr;
>   
> @@ -559,6 +560,8 @@ EXPORT_SYMBOL(device_add_disk);
>    */
>   void del_gendisk(struct gendisk *disk)
>   {
> +	struct request_queue *q = disk->queue;
> +
>   	might_sleep();
>   
>   	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
> @@ -575,8 +578,26 @@ void del_gendisk(struct gendisk *disk)
>   	fsync_bdev(disk->part0);
>   	__invalidate_device(disk->part0, true);
>   
> +	/*
> +	 * Fail any new I/O.
> +	 */
> +	set_bit(GD_DEAD, &disk->state);
>   	set_capacity(disk, 0);
>   

I always tend to become a bit nervous about simple 'set_bit' statements.
On the one side, it _might_ be already set (unlikely, I know).
But more importantly, 'set_bit' implies no memory barrier, so we have an 
inherent race condition.
So don't you need a barrier here to synchronize the 'state' variable 
update to all CPUs?
Or can't we just make it a

if (test_and_set_bit(GD_DEAD, &disk->state))
	WARN()

Hmm?

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
> +
>   	if (!(disk->flags & GENHD_FL_HIDDEN)) {
>   		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
>   
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index c68d83c87f83f..0f5315c2b5a34 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -149,6 +149,7 @@ struct gendisk {
>   	unsigned long state;
>   #define GD_NEED_PART_SCAN		0
>   #define GD_READ_ONLY			1
> +#define GD_DEAD				2
>   
>   	struct mutex open_mutex;	/* open/close mutex */
>   	unsigned open_partitions;	/* number of open partitions */
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
