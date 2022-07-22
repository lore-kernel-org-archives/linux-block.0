Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA7C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 05:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiGVF4V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVF4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 01:56:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086451A36
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658469377; x=1690005377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UX5wN+XKQlQUx3XhgnlQhSFEy5aRrim0q/A6Wl1aeVI=;
  b=laDOo4J3Sc3kPfcnMS8tadJL1p2/NPw+jMA3UKLdEaQCHsVCu2zBVI+w
   JKEHhSrBzDkAUsIKOt2acgHX0LYYMrTVbDHSFveAkJn4iuLWwxKTe2z/z
   Wa3b6iL+ISWL/LYqYohObDoE000AQDMkL9kDCsRwnYZHZ7TC5QQoRdncE
   dtDT85my1dy6qRmlLs34hCfrv7/6wUzYJtUch47sTrZdKJcg9/0k9nwBs
   HSsPvngyQSNpCzh2xoKeR4GZK/0RHEPyCtVICjt2cAnuxKCwx1/rm6Sxk
   FiPPzp62hPbHs9agZWNKjunqwvFfp4gTa++0KPiAilsKTdbfyiMpDce9R
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654531200"; 
   d="scan'208";a="310948400"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 13:56:17 +0800
IronPort-SDR: Cs9tStMJjkDSEcz8TQ+bzA/maQaJetZoUxDRbAljxQJsNXXZ9jIxxA5iOE1Tbb7CvCP8ZfSc7n
 8Gwpdxr+dTLihVq3W2vn1uLSCBPRR+73s0KQWO+c5K7+d9RufLnPzQciMDq6lpLrT9lu5Zs2K+
 AviutNs6HGhbDfFtMjW4UBI8iT9pEbNufYhZ8KhPrEDc3r6SXRkaarHnw4ZVFNhknpIYc4ngD3
 9MJOouc+Wl6bFy4/0Z8T22TdfH3Owbpp6YtDqsuLjjZ84+G16A3XF3DoAFOjk3Tvh7pQsQYTkE
 o3Q/RbC0atpj+mQTXtfi/H8L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 22:17:35 -0700
IronPort-SDR: p13lcsY5dUu5zm1rRNAlUmowHFXXrCCkMtENyWTU5dqjQ9TAzCcCDquHe0XbEgcPTTzjNpCAWl
 lN5GuqzetV8dXUqUeBjjW3+vC2cIOQrgVUyy5BLzaK7sL8VR9pxE2a+OdURNBu+DceZQ8dkVC1
 +g1EAFANtUP0Uz4klgs97fiol7GI194nwesdHlrUWQKK3IUS6Udk95FepnTEhe1dKUPrkcDvfD
 npd6UB0GBCm7FU+g3k2hJ14iHs07lQ0vmKx84cZA3lkUFpTmHWihzP1vm6dZ0T6tbt8G3/mMAz
 mVE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 22:56:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LpzFr5MFnz1Rwnl
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:56:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658469375; x=1661061376; bh=UX5wN+XKQlQUx3XhgnlQhSFEy5aRrim0q/A
        6Wl1aeVI=; b=c7dnKzoS43AjIDg26vf5ZLtyGnsnX/LWxjTAxhEAAlKB7/eCJXT
        mJBOwkAfuI/p0ipfhX/JhMY+jODrrZ/vZ1WXRA4c4+Z3nQ6CroGMSiZpYhG4B6Cv
        1Yq3dvAd1OazFCq2RweJtMtAXA2Y0m4mjKZuJI5WSK4v3M+7djLvhnQea+73f3G5
        iVTXY5o6nQYCd9IF8KEJYWmgtXLfF4WkwLNW86z9qJuv58f6qwg9+1KVEgyRxzSv
        sEh3x2Q/4TZQo90AlqALuxL2YaXi+H/BFSQwYE0Js9zIYYHueAdztlZf/34YnUNJ
        smC6TkUuy9EpVyoSIs/aQmByokAvYn732dA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id exWQRL70mY4I for <linux-block@vger.kernel.org>;
        Thu, 21 Jul 2022 22:56:15 -0700 (PDT)
Received: from [10.225.163.125] (unknown [10.225.163.125])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LpzFq0TJQz1RtVk;
        Thu, 21 Jul 2022 22:56:14 -0700 (PDT)
Message-ID: <05f5c887-df0c-7960-7497-3f2e39f98e5d@opensource.wdc.com>
Date:   Fri, 22 Jul 2022 14:56:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] block: move ->bio_split to the gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220720142456.1414262-1-hch@lst.de>
 <20220720142456.1414262-2-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220720142456.1414262-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/22 23:24, Christoph Hellwig wrote:
> Only non-passthrough requests are split by the block layer and use the
> ->bio_split bio_set.  Move it from the request_queue to the gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       |  9 +--------
>  block/blk-merge.c      | 20 ++++++++++----------
>  block/blk-sysfs.c      |  2 --
>  block/genhd.c          |  9 ++++++++-
>  drivers/md/dm.c        |  2 +-
>  include/linux/blkdev.h |  3 ++-
>  6 files changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 123468b9d2e43..59f13d011949d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -377,7 +377,6 @@ static void blk_timeout_work(struct work_struct *work)
>  struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>  {
>  	struct request_queue *q;
> -	int ret;
>  
>  	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
>  			GFP_KERNEL | __GFP_ZERO, node_id);
> @@ -396,13 +395,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>  	if (q->id < 0)
>  		goto fail_srcu;
>  
> -	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
> -	if (ret)
> -		goto fail_id;
> -
>  	q->stats = blk_alloc_queue_stats();
>  	if (!q->stats)
> -		goto fail_split;
> +		goto fail_id;
>  
>  	q->node = node_id;
>  
> @@ -439,8 +434,6 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>  
>  fail_stats:
>  	blk_free_queue_stats(q->stats);
> -fail_split:
> -	bioset_exit(&q->bio_split);
>  fail_id:
>  	ida_free(&blk_queue_ida, q->id);
>  fail_srcu:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3c3f785f558af..e657f1dc824cb 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -328,26 +328,26 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>   * Split a bio into two bios, chain the two bios, submit the second half and
>   * store a pointer to the first half in *@bio. If the second bio is still too
>   * big it will be split by a recursive call to this function. Since this
> - * function may allocate a new bio from q->bio_split, it is the responsibility
> - * of the caller to ensure that q->bio_split is only released after processing
> - * of the split bio has finished.
> + * function may allocate a new bio from disk->bio_split, it is the
> + * responsibility of the caller to ensure that disk->bio_split is only released
> + * after processing of the split bio has finished.
>   */
>  void __blk_queue_split(struct request_queue *q, struct bio **bio,
>  		       unsigned int *nr_segs)
>  {
> +	struct bio_set *bs = &(*bio)->bi_bdev->bd_disk->bio_split;
>  	struct bio *split = NULL;
>  
>  	switch (bio_op(*bio)) {
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
> -		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
> +		split = blk_bio_discard_split(q, *bio, bs, nr_segs);
>  		break;
>  	case REQ_OP_WRITE_ZEROES:
> -		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
> -				nr_segs);
> +		split = blk_bio_write_zeroes_split(q, *bio, bs, nr_segs);
>  		break;
>  	default:
> -		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
> +		split = blk_bio_segment_split(q, *bio, bs, nr_segs);
>  		break;
>  	}

Suggestion for a follow-up patch: we could save the *bio pointer in a
local variable instead of constantly de-referencing bio.

>  
> @@ -368,9 +368,9 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>   *
>   * Split a bio into two bios, chains the two bios, submit the second half and
>   * store a pointer to the first half in *@bio. Since this function may allocate
> - * a new bio from q->bio_split, it is the responsibility of the caller to ensure
> - * that q->bio_split is only released after processing of the split bio has
> - * finished.
> + * a new bio from disk->bio_split, it is the responsibility of the caller to
> + * ensure that disk->bio_split is only released after processing of the split
> + * bio has finished.
>   */
>  void blk_queue_split(struct bio **bio)
>  {
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index c0303026752d5..e1f009aba6fd2 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -779,8 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
>  	if (queue_is_mq(q))
>  		blk_mq_release(q);
>  
> -	bioset_exit(&q->bio_split);
> -
>  	if (blk_queue_has_srcu(q))
>  		cleanup_srcu_struct(q->srcu);
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index 44dfcf67ed96a..150494e8742b0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1138,6 +1138,8 @@ static void disk_release(struct device *dev)
>  	might_sleep();
>  	WARN_ON_ONCE(disk_live(disk));
>  
> +	bioset_exit(&disk->bio_split);
> +
>  	blkcg_exit_queue(disk->queue);
>  
>  	disk_release_events(disk);
> @@ -1330,9 +1332,12 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  	if (!disk)
>  		goto out_put_queue;
>  
> +	if (bioset_init(&disk->bio_split, BIO_POOL_SIZE, 0, 0))
> +		goto out_free_disk;
> +
>  	disk->bdi = bdi_alloc(node_id);
>  	if (!disk->bdi)
> -		goto out_free_disk;
> +		goto out_free_bioset;
>  
>  	/* bdev_alloc() might need the queue, set before the first call */
>  	disk->queue = q;
> @@ -1370,6 +1375,8 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  	iput(disk->part0->bd_inode);
>  out_free_bdi:
>  	bdi_put(disk->bdi);
> +out_free_bioset:
> +	bioset_exit(&disk->bio_split);
>  out_free_disk:
>  	kfree(disk);
>  out_put_queue:
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 54c2a23f4e55c..b163de50f3c6b 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1693,7 +1693,7 @@ static void dm_split_and_process_bio(struct mapped_device *md,
>  	 */
>  	WARN_ON_ONCE(!dm_io_flagged(io, DM_IO_WAS_SPLIT));
>  	io->split_bio = bio_split(bio, io->sectors, GFP_NOIO,
> -				  &md->queue->bio_split);
> +				  &md->disk->bio_split);
>  	bio_chain(io->split_bio, bio);
>  	trace_block_split(io->split_bio, bio->bi_iter.bi_sector);
>  	submit_bio_noacct(bio);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d04bdf549efa9..97d3ef8f3f416 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -140,6 +140,8 @@ struct gendisk {
>  	struct request_queue *queue;
>  	void *private_data;
>  
> +	struct bio_set bio_split;
> +
>  	int flags;
>  	unsigned long state;
>  #define GD_NEED_PART_SCAN		0
> @@ -531,7 +533,6 @@ struct request_queue {
>  
>  	struct blk_mq_tag_set	*tag_set;
>  	struct list_head	tag_set_list;
> -	struct bio_set		bio_split;
>  
>  	struct dentry		*debugfs_dir;
>  	struct dentry		*sched_debugfs_dir;

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
