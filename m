Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF5C433E3
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD456191A
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 11:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhCVLXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:23:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCVLXV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 07:23:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6B00AD4A;
        Mon, 22 Mar 2021 11:23:19 +0000 (UTC)
Subject: Re: [PATCH 1/2] blk-mq: add a blk_mq_submit_bio_direct API
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <df54545f-0f2c-9bc1-e448-d8595088b7f5@suse.de>
Date:   Mon, 22 Mar 2021 12:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322073726.788347-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/21 8:37 AM, Christoph Hellwig wrote:
> This adds (back) and API for simple stacking drivers to submit a bio to
> blk-mq queue.  The prime aim is to avoid blocking on the queue freeze
> percpu ref, as a multipath driver really does not want to get blocked
> on that when an underlying device is undergoing error recovery.  It also
> happens to optimize away the small overhead of the curren->bio_list based
> recursion avoidance.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       |  2 +-
>  block/blk-mq.c         | 37 +++++++++++++++++++++++++++++++++++++
>  block/blk.h            |  1 +
>  include/linux/blk-mq.h |  1 +
>  4 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff20849738..4344f3c9058282 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -792,7 +792,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  	return BLK_STS_OK;
>  }
>  
> -static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> +noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  {
>  	struct block_device *bdev = bio->bi_bdev;
>  	struct request_queue *q = bdev->bd_disk->queue;
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d4d7c1caa43966..4ff85692843b49 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2286,6 +2286,43 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  	return BLK_QC_T_NONE;
>  }
>  
> +/**
> + * blk_mq_submit_bio_direct - hand a bio directly to the driver for I/O
> + * @bio:  The bio describing the location in memory and on the device.
> + *
> + * This function behaves similar to submit_bio_noacct(), but does never waits
> + * for the queue to be unfreozen, instead it return false and lets the caller
> + * deal with the fallout.  It also does not protect against recursion and thus
> + * must only be used if the called driver is known to be blk-mq based.
> + */
> +bool blk_mq_submit_bio_direct(struct bio *bio, blk_qc_t *qc)
> +{
> +	struct gendisk *disk = bio->bi_bdev->bd_disk;
> +	struct request_queue *q = disk->queue;
> +
> +	if (WARN_ON_ONCE(!current->bio_list) ||
> +	    WARN_ON_ONCE(disk->fops->submit_bio)) {
> +		bio_io_error(bio);
> +		goto fail;
> +	}
> +	if (!submit_bio_checks(bio))
> +		goto fail;
> +
> +	if (unlikely(blk_queue_enter(q, BLK_MQ_REQ_NOWAIT)))
> +		return false;
> +	if (!blk_crypto_bio_prep(&bio))
> +		goto fail_queue_exit;
> +	*qc = blk_mq_submit_bio(bio);
> +	return true;
> +
> +fail_queue_exit:
> +	blk_queue_exit(disk->queue);
> +fail:
> +	*qc = BLK_QC_T_NONE;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_submit_bio_direct);
> +
>  void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  		     unsigned int hctx_idx)
>  {
> diff --git a/block/blk.h b/block/blk.h
> index 3b53e44b967e4e..c4c66b2a9ffb19 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -221,6 +221,7 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
>  ssize_t part_timeout_store(struct device *, struct device_attribute *,
>  				const char *, size_t);
>  
> +bool submit_bio_checks(struct bio *bio);
>  void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
>  int ll_back_merge_fn(struct request *req, struct bio *bio,
>  		unsigned int nr_segs);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2c473c9b899089..6804f397106ada 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -615,6 +615,7 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
>  }
>  
>  blk_qc_t blk_mq_submit_bio(struct bio *bio);
> +bool blk_mq_submit_bio_direct(struct bio *bio, blk_qc_t *qc);
>  void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
>  		struct lock_class_key *key);
>  
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
