Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDDC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 08:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiG1IHR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiG1IHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 04:07:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBD04BD07
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 01:07:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F154D33E51;
        Thu, 28 Jul 2022 08:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658995634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/cKRyY4fDP8Iz+xa3QHvIiZFY56RDsZZFEQL8Sxloo=;
        b=WFAfHjoqCNd2pviAEu6pyBsx8EPYSAmSkRXUKaksGZajhqMpFLVfemzGoQ5KCAu8wNkqkf
        IGnmWoZoEzLNWqiIMixXj6+iRQqhnBkmlRzu2k28c6X/4nelUkiur/sXOiQg6gymo+1AkA
        8Iqe5vKNp3YLvK/r1cBUtzUkCBbnreQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658995634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/cKRyY4fDP8Iz+xa3QHvIiZFY56RDsZZFEQL8Sxloo=;
        b=pHdnMdqsP9yxaVz2b2sOGqmT7EX3m8fbVhRYBxNDQyVh32tSyt3W78gaPVguVwokuJxA9C
        CZYtDnnpxXdTv6DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C34C913A7E;
        Thu, 28 Jul 2022 08:07:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EEJ2LrJD4mJWJgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 28 Jul 2022 08:07:14 +0000
Message-ID: <5323f3a1-14ac-eafb-3b5a-493fea2e86f5@suse.de>
Date:   Thu, 28 Jul 2022 10:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220727162300.3089193-1-hch@lst.de>
 <20220727162300.3089193-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/6] block: move ->bio_split to the gendisk
In-Reply-To: <20220727162300.3089193-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/22 18:22, Christoph Hellwig wrote:
> Only non-passthrough requests are split by the block layer and use the
> ->bio_split bio_set.  Move it from the request_queue to the gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-core.c       | 9 +--------
>   block/blk-merge.c      | 7 ++++---
>   block/blk-sysfs.c      | 2 --
>   block/genhd.c          | 8 +++++++-
>   drivers/md/dm.c        | 2 +-
>   include/linux/blkdev.h | 3 ++-
>   6 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 123468b9d2e43..59f13d011949d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -377,7 +377,6 @@ static void blk_timeout_work(struct work_struct *work)
>   struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   {
>   	struct request_queue *q;
> -	int ret;
>   
>   	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
>   			GFP_KERNEL | __GFP_ZERO, node_id);
> @@ -396,13 +395,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   	if (q->id < 0)
>   		goto fail_srcu;
>   
> -	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
> -	if (ret)
> -		goto fail_id;
> -
>   	q->stats = blk_alloc_queue_stats();
>   	if (!q->stats)
> -		goto fail_split;
> +		goto fail_id;
>   
>   	q->node = node_id;
>   
> @@ -439,8 +434,6 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   
>   fail_stats:
>   	blk_free_queue_stats(q->stats);
> -fail_split:
> -	bioset_exit(&q->bio_split);
>   fail_id:
>   	ida_free(&blk_queue_ida, q->id);
>   fail_srcu:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 6e29fb28584ef..30872a3537648 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -331,18 +331,19 @@ static struct bio *bio_split_rw(struct bio *bio, struct request_queue *q,
>   struct bio *__bio_split_to_limits(struct bio *bio, struct request_queue *q,
>   		       unsigned int *nr_segs)
>   {
> +	struct bio_set *bs = &bio->bi_bdev->bd_disk->bio_split;
>   	struct bio *split;
>   

What happens for nvme-multipath?
While I know that we shouldn't split on a path, experience shows that we 
_will_ do it eventually.
Hence, shouldn't we take precaution for hidden disks with no gendisk 
attached here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
