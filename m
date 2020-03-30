Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F59C43331
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 11:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AB72072E
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 11:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgC3LPw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:15:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:53442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgC3LPv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 07:15:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F4052AD08;
        Mon, 30 Mar 2020 11:15:49 +0000 (UTC)
Subject: Re: [PATCH 3/5] bcache: pass the make_request methods to
 blk_queue_make_request
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200327083012.1618778-1-hch@lst.de>
 <20200327083012.1618778-4-hch@lst.de>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <f0214b2f-5472-4c55-1b06-fa2b2afd3948@suse.de>
Date:   Mon, 30 Mar 2020 19:15:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327083012.1618778-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/3/27 4:30 下午, Christoph Hellwig wrote:
> bcache is the only driver not actually passing its make_request
> methods to blk_queue_make_request, but instead just sets them up
> manually a little later.  Make bcache follow the common way of
> setting up make_request based queues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For the bcache part, it is fine for me.

Reviewed-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/request.c |  7 ++-----
>  drivers/md/bcache/request.h |  3 +++
>  drivers/md/bcache/super.c   | 10 ++++++----
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 820d8402a1dc..71a90fbec314 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1161,8 +1161,7 @@ static void quit_max_writeback_rate(struct cache_set *c,
>  
>  /* Cached devices - read & write stuff */
>  
> -static blk_qc_t cached_dev_make_request(struct request_queue *q,
> -					struct bio *bio)
> +blk_qc_t cached_dev_make_request(struct request_queue *q, struct bio *bio)
>  {
>  	struct search *s;
>  	struct bcache_device *d = bio->bi_disk->private_data;
> @@ -1266,7 +1265,6 @@ void bch_cached_dev_request_init(struct cached_dev *dc)
>  {
>  	struct gendisk *g = dc->disk.disk;
>  
> -	g->queue->make_request_fn		= cached_dev_make_request;
>  	g->queue->backing_dev_info->congested_fn = cached_dev_congested;
>  	dc->disk.cache_miss			= cached_dev_cache_miss;
>  	dc->disk.ioctl				= cached_dev_ioctl;
> @@ -1301,8 +1299,7 @@ static void flash_dev_nodata(struct closure *cl)
>  	continue_at(cl, search_free, NULL);
>  }
>  
> -static blk_qc_t flash_dev_make_request(struct request_queue *q,
> -					     struct bio *bio)
> +blk_qc_t flash_dev_make_request(struct request_queue *q, struct bio *bio)
>  {
>  	struct search *s;
>  	struct closure *cl;
> diff --git a/drivers/md/bcache/request.h b/drivers/md/bcache/request.h
> index c64dbd7a91aa..bb005c93dd72 100644
> --- a/drivers/md/bcache/request.h
> +++ b/drivers/md/bcache/request.h
> @@ -37,7 +37,10 @@ unsigned int bch_get_congested(const struct cache_set *c);
>  void bch_data_insert(struct closure *cl);
>  
>  void bch_cached_dev_request_init(struct cached_dev *dc);
> +blk_qc_t cached_dev_make_request(struct request_queue *q, struct bio *bio);
> +
>  void bch_flash_dev_request_init(struct bcache_device *d);
> +blk_qc_t flash_dev_make_request(struct request_queue *q, struct bio *bio);
>  
>  extern struct kmem_cache *bch_search_cache;
>  
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 0c3c5419c52b..5e38a167c85e 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -816,7 +816,7 @@ static void bcache_device_free(struct bcache_device *d)
>  }
>  
>  static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
> -			      sector_t sectors)
> +			      sector_t sectors, make_request_fn make_request_fn)
>  {
>  	struct request_queue *q;
>  	const size_t max_stripes = min_t(size_t, INT_MAX,
> @@ -870,7 +870,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  	if (!q)
>  		return -ENOMEM;
>  
> -	blk_queue_make_request(q, NULL);
> +	blk_queue_make_request(q, make_request_fn);
>  	d->disk->queue			= q;
>  	q->queuedata			= d;
>  	q->backing_dev_info->congested_data = d;
> @@ -1339,7 +1339,8 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
>  			q->limits.raid_partial_stripes_expensive;
>  
>  	ret = bcache_device_init(&dc->disk, block_size,
> -			 dc->bdev->bd_part->nr_sects - dc->sb.data_offset);
> +			 dc->bdev->bd_part->nr_sects - dc->sb.data_offset,
> +			 cached_dev_make_request);
>  	if (ret)
>  		return ret;
>  
> @@ -1451,7 +1452,8 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
>  
>  	kobject_init(&d->kobj, &bch_flash_dev_ktype);
>  
> -	if (bcache_device_init(d, block_bytes(c), u->sectors))
> +	if (bcache_device_init(d, block_bytes(c), u->sectors,
> +			flash_dev_make_request))
>  		goto err;
>  
>  	bcache_device_attach(d, c, u - c->uuids);
> 
