Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F762DEA94;
	Thu, 13 Nov 2025 23:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763077560; cv=none; b=H8llvSLtM7nF6drnkcaTsfa8QlrGUm9DSRAsNdKSiepO/iJrLcGxV3henWrsGu//XktD6z57ajQXThvqrW74Fkpgm5I8VjpRnD5CRoZQFNsRl+aBlBk2uiEnJhKII/tdJlVr9Tt4oC17r+KNjXCy1chnzCQ4ndVa14hhkLZJV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763077560; c=relaxed/simple;
	bh=YZmw0SFpUrytgIGZJsXG6pQNJXy/A33lKK7OMVHiIxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA4ZwaPmvuIFkQ0cgKJlT7HZWubLM4Ozm7I9sspF0ZYaly73yth+eh/ugZv1v9las8PoiGHLZokAYo8dlght3FJX7Hz+f6mnsjhCSGJdDxUILgJ/KUJ6scJTWklPCQV3KvUJ1WEvW+UtSKbPUA9gmClxpVcMhFVndbS4vbMpbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJZPnEtb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJZPnEtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FABC4CEF8;
	Thu, 13 Nov 2025 23:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763077560;
	bh=YZmw0SFpUrytgIGZJsXG6pQNJXy/A33lKK7OMVHiIxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJZPnEtbYXJ04UEiC5Vh6amfnoEKz+3gXQP2KfrZ78Rj8FxjZu4hP2wqV+uGjtbyd
	 sLTzNlSw2pdexAM6SBriuo7y+UZ+iu0BqHLQ8h1AkH8WHaqkfZsVdDY8Y8NAJxqZXI
	 rrc4wMgIUI0+QnIvDBPPeqh6v3p91pfVT6m2ABVaXBsjydTAP4bD4GxGTj2O7hV+3H
	 DaIv8/7oxqN8FYGVPP8ARMwxac2luBLSi2YrfqfK4dhPM624OZPgZahXI0hSMist+K
	 Se1O2FPx6Mg7k4g0WBLHDYLhizj11n1uXWfrAWOw+ryRbD6bivJuiic239RMQ1fGrH
	 N7rWbnBnX8zGQ==
Date: Thu, 13 Nov 2025 15:45:57 -0800
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>,
	Brian Geffon <bgeffon@google.com>, Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2 1/4] zram: introduce writeback bio batching support
Message-ID: <aRZttTsRG1cZoovl@google.com>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
 <20251113085402.1811522-2-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113085402.1811522-2-senozhatsky@chromium.org>

On Thu, Nov 13, 2025 at 05:53:59PM +0900, Sergey Senozhatsky wrote:
> From: Yuwen Chen <ywen.chen@foxmail.com>
> 
> Currently, zram writeback supports only a single bio writeback
> operation, waiting for bio completion before post-processing
> next pp-slot.  This works, in general, but has certain throughput
> limitations.  Implement batched (multiple) bio writeback support
> to take advantage of parallel requests processing and better
> requests scheduling.
> 
> For the time being the writeback batch size (maximum number of
> in-flight bio requests) is set to 1, so the behaviors is the
> same as the previous single-bio writeback.  This is addressed
> in a follow up patch, which adds a writeback_batch_size device
> attribute.
> 
> Please refer to [1] and [2] for benchmarks.
> 
> [1] https://lore.kernel.org/linux-block/tencent_B2DC37E3A2AED0E7F179365FCB5D82455B08@qq.com
> [2] https://lore.kernel.org/linux-block/tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com
> 
> [senozhatsky: significantly reworked the initial patch so that the
> approach and implementation resemble current zram post-processing
> code]

This version is much clear than previous series.
Most below are nits.

> 
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Co-developed-by: Richard Chang <richardycc@google.com>
> Suggested-by: Minchan Kim <minchan@google.com>
> ---
>  drivers/block/zram/zram_drv.c | 343 +++++++++++++++++++++++++++-------
>  1 file changed, 278 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a43074657531..a0a939fd9d31 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -734,20 +734,226 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
>  	submit_bio(bio);
>  }
>  
> -static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
> -{
> -	unsigned long blk_idx = 0;
> -	struct page *page = NULL;
> +struct zram_wb_ctl {
> +	struct list_head idle_reqs;
> +	struct list_head inflight_reqs;
> +
> +	atomic_t num_inflight;
> +	struct completion done;
> +	struct blk_plug plug;
> +};
> +
> +struct zram_wb_req {
> +	unsigned long blk_idx;
> +	struct page *page;
>  	struct zram_pp_slot *pps;
>  	struct bio_vec bio_vec;
>  	struct bio bio;
> -	int ret = 0, err;
> +
> +	struct list_head entry;
> +};

How about moving structure definition to the upper part of the C file?
Not only readability to put together data types but also better diff
for reviewer to know what we changed in this patch.

> +
> +static void release_wb_req(struct zram_wb_req *req)
> +{
> +	__free_page(req->page);
> +	kfree(req);
> +}
> +
> +static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
> +{
> +	/* We should never have inflight requests at this point */
> +	WARN_ON(!list_empty(&wb_ctl->inflight_reqs));
> +
> +	while (!list_empty(&wb_ctl->idle_reqs)) {
> +		struct zram_wb_req *req;
> +
> +		req = list_first_entry(&wb_ctl->idle_reqs,
> +				       struct zram_wb_req, entry);
> +		list_del(&req->entry);
> +		release_wb_req(req);
> +	}
> +
> +	kfree(wb_ctl);
> +}
> +
> +/* XXX: should be a per-device sysfs attr */
> +#define ZRAM_WB_REQ_CNT 1

Understand you will create the knob for the tune but at least,
let's introduce default number for that here.

How about 32 since it's general queue depth for modern storage?

> +
> +static struct zram_wb_ctl *init_wb_ctl(void)
> +{
> +	struct zram_wb_ctl *wb_ctl;
> +	int i;
> +
> +	wb_ctl = kmalloc(sizeof(*wb_ctl), GFP_KERNEL);
> +	if (!wb_ctl)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&wb_ctl->idle_reqs);
> +	INIT_LIST_HEAD(&wb_ctl->inflight_reqs);
> +	atomic_set(&wb_ctl->num_inflight, 0);
> +	init_completion(&wb_ctl->done);
> +
> +	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
> +		struct zram_wb_req *req;
> +
> +		/*
> +		 * This is fatal condition only if we couldn't allocate
> +		 * any requests at all.  Otherwise we just work with the
> +		 * requests that we have successfully allocated, so that
> +		 * writeback can still proceed, even if there is only one
> +		 * request on the idle list.
> +		 */
> +		req = kzalloc(sizeof(*req), GFP_NOIO | __GFP_NOWARN);

Why GFP_NOIO?

> +		if (!req)
> +			break;
> +
> +		req->page = alloc_page(GFP_NOIO | __GFP_NOWARN);

Ditto

> +		if (!req->page) {
> +			kfree(req);
> +			break;
> +		}
> +
> +		INIT_LIST_HEAD(&req->entry);

Do we need this reset?

> +		list_add(&req->entry, &wb_ctl->idle_reqs);
> +	}
> +
> +	/* We couldn't allocate any requests, so writeabck is not possible */
> +	if (list_empty(&wb_ctl->idle_reqs))
> +		goto release_wb_ctl;
> +
> +	return wb_ctl;
> +
> +release_wb_ctl:
> +	release_wb_ctl(wb_ctl);
> +	return NULL;
> +}
> +
> +static void zram_account_writeback_rollback(struct zram *zram)
> +{
> +	spin_lock(&zram->wb_limit_lock);
> +	if (zram->wb_limit_enable)
> +		zram->bd_wb_limit +=  1UL << (PAGE_SHIFT - 12);
> +	spin_unlock(&zram->wb_limit_lock);
> +}
> +
> +static void zram_account_writeback_submit(struct zram *zram)
> +{
> +	spin_lock(&zram->wb_limit_lock);
> +	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> +		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
> +	spin_unlock(&zram->wb_limit_lock);
> +}

I didn't think about much about this that we really need to be
accurate like this. Maybe, next time after coffee.

> +
> +static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
> +{
>  	u32 index;
> +	int err;
>  
> -	page = alloc_page(GFP_KERNEL);
> -	if (!page)
> -		return -ENOMEM;
> +	index = req->pps->index;
> +	release_pp_slot(zram, req->pps);
> +	req->pps = NULL;
> +
> +	err = blk_status_to_errno(req->bio.bi_status);
> +	if (err) {
> +		/*
> +		 * Failed wb requests should not be accounted in wb_limit
> +		 * (if enabled).
> +		 */
> +		zram_account_writeback_rollback(zram);
> +		return err;
> +	}
>  
> +	atomic64_inc(&zram->stats.bd_writes);
> +	zram_slot_lock(zram, index);
> +	/*
> +	 * We release slot lock during writeback so slot can change under us:
> +	 * slot_free() or slot_free() and zram_write_page(). In both cases
> +	 * slot loses ZRAM_PP_SLOT flag. No concurrent post-processing can
> +	 * set ZRAM_PP_SLOT on such slots until current post-processing
> +	 * finishes.
> +	 */
> +	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> +		goto out;
> +
> +	zram_free_page(zram, index);
> +	zram_set_flag(zram, index, ZRAM_WB);
> +	zram_set_handle(zram, index, req->blk_idx);
> +	atomic64_inc(&zram->stats.pages_stored);
> +
> +out:
> +	zram_slot_unlock(zram, index);
> +	return 0;
> +}
> +
> +static void zram_writeback_endio(struct bio *bio)
> +{
> +	struct zram_wb_ctl *wb_ctl = bio->bi_private;
> +
> +	if (atomic_dec_return(&wb_ctl->num_inflight) == 0)
> +		complete(&wb_ctl->done);
> +}
> +
> +static void zram_submit_wb_request(struct zram *zram,
> +				   struct zram_wb_ctl *wb_ctl,
> +				   struct zram_wb_req *req)
> +{
> +	/*
> +	 * wb_limit (if enabled) should be adjusted before submission,
> +	 * so that we don't over-submit.
> +	 */
> +	zram_account_writeback_submit(zram);
> +	atomic_inc(&wb_ctl->num_inflight);
> +	list_add_tail(&req->entry, &wb_ctl->inflight_reqs);
> +	submit_bio(&req->bio);
> +}
> +
> +static struct zram_wb_req *select_idle_req(struct zram_wb_ctl *wb_ctl)
> +{
> +	struct zram_wb_req *req;
> +
> +	req = list_first_entry_or_null(&wb_ctl->idle_reqs,
> +				       struct zram_wb_req, entry);
> +	if (req)
> +		list_del(&req->entry);
> +	return req;
> +}
> +
> +static int zram_wb_wait_for_completion(struct zram *zram,
> +				       struct zram_wb_ctl *wb_ctl)
> +{
> +	int ret = 0;
> +
> +	if (atomic_read(&wb_ctl->num_inflight))
> +		wait_for_completion_io(&wb_ctl->done);
> +
> +	reinit_completion(&wb_ctl->done);
> +	while (!list_empty(&wb_ctl->inflight_reqs)) {
> +		struct zram_wb_req *req;
> +		int err;
> +
> +		req = list_first_entry(&wb_ctl->inflight_reqs,
> +				       struct zram_wb_req, entry);
> +		list_move(&req->entry, &wb_ctl->idle_reqs);
> +
> +		err = zram_writeback_complete(zram, req);
> +		if (err)
> +			ret = err;
> +	}
> +
> +	return ret;
> +}
> +
> +static int zram_writeback_slots(struct zram *zram,
> +				struct zram_pp_ctl *ctl,
> +				struct zram_wb_ctl *wb_ctl)
> +{
> +	struct zram_wb_req *req = NULL;
> +	unsigned long blk_idx = 0;
> +	struct zram_pp_slot *pps;
> +	int ret = 0, err;
> +	u32 index = 0;
> +
> +	blk_start_plug(&wb_ctl->plug);

Why is the plug part of wb_ctl?

The scope of plug is in this function and the purpose is for
this writeback batch in this function so the plug can be local
variable in this function.

>  	while ((pps = select_pp_slot(ctl))) {
>  		spin_lock(&zram->wb_limit_lock);
>  		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
> @@ -757,6 +963,26 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  		}
>  		spin_unlock(&zram->wb_limit_lock);
>  
> +		while (!req) {
> +			req = select_idle_req(wb_ctl);
> +			if (req)
> +				break;
> +
> +			blk_finish_plug(&wb_ctl->plug);
> +			err = zram_wb_wait_for_completion(zram, wb_ctl);
> +			blk_start_plug(&wb_ctl->plug);
> +			/*
> +			 * BIO errors are not fatal, we continue and simply
> +			 * attempt to writeback the remaining objects (pages).
> +			 * At the same time we need to signal user-space that
> +			 * some writes (at least one, but also could be all of
> +			 * them) were not successful and we do so by returning
> +			 * the most recent BIO error.
> +			 */
> +			if (err)
> +				ret = err;
> +		}
> +
>  		if (!blk_idx) {
>  			blk_idx = alloc_block_bdev(zram);
>  			if (!blk_idx) {
> @@ -765,7 +991,6 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  			}
>  		}
>  
> -		index = pps->index;
>  		zram_slot_lock(zram, index);
>  		/*
>  		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
> @@ -775,67 +1000,47 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  		 */
>  		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
>  			goto next;
> -		if (zram_read_from_zspool(zram, page, index))
> +		if (zram_read_from_zspool(zram, req->page, index))
>  			goto next;
>  		zram_slot_unlock(zram, index);
>  
> -		bio_init(&bio, zram->bdev, &bio_vec, 1,
> -			 REQ_OP_WRITE | REQ_SYNC);
> -		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
> -		__bio_add_page(&bio, page, PAGE_SIZE, 0);
> -
>  		/*
> -		 * XXX: A single page IO would be inefficient for write
> -		 * but it would be not bad as starter.
> +		 * From now on pp-slot is owned by the req, remove it from
> +		 * its pps bucket.
>  		 */
> -		err = submit_bio_wait(&bio);

Yay, finally we remove this submit_bio_wait.

> -		if (err) {
> -			release_pp_slot(zram, pps);
> -			/*
> -			 * BIO errors are not fatal, we continue and simply
> -			 * attempt to writeback the remaining objects (pages).
> -			 * At the same time we need to signal user-space that
> -			 * some writes (at least one, but also could be all of
> -			 * them) were not successful and we do so by returning
> -			 * the most recent BIO error.
> -			 */
> -			ret = err;
> -			continue;
> -		}
> +		list_del_init(&pps->entry);
>  
> -		atomic64_inc(&zram->stats.bd_writes);
> -		zram_slot_lock(zram, index);
> -		/*
> -		 * Same as above, we release slot lock during writeback so
> -		 * slot can change under us: slot_free() or slot_free() and
> -		 * reallocation (zram_write_page()). In both cases slot loses
> -		 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
> -		 * ZRAM_PP_SLOT on such slots until current post-processing
> -		 * finishes.
> -		 */
> -		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> -			goto next;
> +		req->blk_idx = blk_idx;
> +		req->pps = pps;
> +		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1,
> +			 REQ_OP_WRITE | REQ_SYNC);

Can't we drop the REQ_SYNC now?
