Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821343D4FD
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896019; cv=none; b=gM+jVjBHZJ/v62iKozdiN17vI7ap7LrSGcVvgg+Ox+lY4TM1ClsfIx4SYeLkM/5sso3xNRa8TR//WxpqVXa4YE7gJLLjyXZ75wT51kEKn9H8EfPQ4uUqI26gp0XlcJ8whyNC1sxcMShnLfHvoEvbP/ZYnroIvGor1m136o02+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896019; c=relaxed/simple;
	bh=LSU9AOBYibeX1Uha/DrgzV0O6LXNJ7DhrmIED8Sgd2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOHWkSG3JDmbejFBZy9fMGUwT10HdUatuaB2lw9NHY7xY9IAwFkIS1rRa8fwXxApo0f1rFXGfV6QVN3Cn3i9/noEpXC05avbV4vVriw8ypZ+9uvox2ZzsAb7/J1b+NZ7Vr7vHyyvcBmZaDsNRAr90yxHVw5s4i3gLbYhJ4ZAq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nbxzU7/C; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nbxzU7/C"
Message-ID: <c09acca3-d674-4671-8e8a-28c80e948266@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779896008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DizPhBJ5zejUTzmM2OZ+0qtFU+KsFivOKnHTh7xE2NQ=;
	b=nbxzU7/Cm3lnsrc0v/NwF0rGlAyyXYMP9xU96sKkc6ikvRhGBX+Fn1a3LMvgNKV76zoXjk
	V/+wuO1deAvrFuPmiNKFF+H3ZS6jlR+CkR/0WKeJ/E4feJJn9/eXrhz1KKbLTlbjqwfMVj
	8Xs1d3rVGCAxZR/upruDlxsHjQ44B9g=
Date: Wed, 27 May 2026 17:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: add a bio_endio_status helper
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260527151247.2352145-1-hch@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260527151247.2352145-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/27/26 17:12, Christoph Hellwig wrote:
> Add a helper that sets bi_status and call bio_endio() as that is a very
> common pattern and convert the core block code over to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good:

Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>

Do you plan to convert similar call patterns in other drivers like drbd, 
zram, dm, etc, too?

> ---
>   block/blk-core.c            | 11 ++++-------
>   block/blk-crypto-fallback.c |  9 +++------
>   block/blk-crypto.c          |  3 +--
>   block/blk-merge.c           |  6 ++----
>   block/blk-mq.c              |  6 ++----
>   block/fops.c                |  3 +--
>   include/linux/bio.h         | 19 +++++++++++++++----
>   7 files changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 22af5dec112b..b0f0a304ea0b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -636,12 +636,10 @@ static void __submit_bio(struct bio *bio)
>   		struct gendisk *disk = bio->bi_bdev->bd_disk;
>   	
>   		if ((bio->bi_opf & REQ_POLLED) &&
> -		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
> -			bio->bi_status = BLK_STS_NOTSUPP;
> -			bio_endio(bio);
> -		} else {
> +		    !(disk->queue->limits.features & BLK_FEAT_POLL))
> +			bio_endio_status(bio, BLK_STS_NOTSUPP);
> +		else
>   			disk->fops->submit_bio(bio);
> -		}
>   		blk_queue_exit(disk->queue);
>   	}
>   
> @@ -886,8 +884,7 @@ void submit_bio_noacct(struct bio *bio)
>   not_supported:
>   	status = BLK_STS_NOTSUPP;
>   end_io:
> -	bio->bi_status = status;
> -	bio_endio(bio);
> +	bio_endio_status(bio, status);
>   }
>   EXPORT_SYMBOL(submit_bio_noacct);
>   
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 61f595410832..8b04d9205b8d 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -361,8 +361,7 @@ static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
>   	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
>   					bc->bc_key, &slot);
>   	if (status != BLK_STS_OK) {
> -		src_bio->bi_status = status;
> -		bio_endio(src_bio);
> +		bio_endio_status(src_bio, status);
>   		return;
>   	}
>   	__blk_crypto_fallback_encrypt_bio(src_bio,
> @@ -437,8 +436,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
>   	}
>   	mempool_free(f_ctx, bio_fallback_crypt_ctx_pool);
>   
> -	bio->bi_status = status;
> -	bio_endio(bio);
> +	bio_endio_status(bio, status);
>   }
>   
>   /**
> @@ -499,8 +497,7 @@ bool blk_crypto_fallback_bio_prep(struct bio *bio)
>   
>   	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
>   					&bc->bc_key->crypto_cfg)) {
> -		bio->bi_status = BLK_STS_NOTSUPP;
> -		bio_endio(bio);
> +		bio_endio_status(bio, BLK_STS_NOTSUPP);
>   		return false;
>   	}
>   
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 856d3c5b1fa0..165c9d2cce07 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -267,8 +267,7 @@ bool __blk_crypto_submit_bio(struct bio *bio)
>   		if (!IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)) {
>   			pr_warn_once("%pg: crypto API fallback disabled; failing request.\n",
>   				bdev);
> -			bio->bi_status = BLK_STS_NOTSUPP;
> -			bio_endio(bio);
> +			bio_endio_status(bio, BLK_STS_NOTSUPP);
>   			return false;
>   		}
>   		return blk_crypto_fallback_bio_prep(bio);
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index fcf09325b22e..7cc82a7a6f4e 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -122,8 +122,7 @@ struct bio *bio_submit_split_bioset(struct bio *bio, unsigned int split_sectors,
>   	struct bio *split = bio_split(bio, split_sectors, GFP_NOIO, bs);
>   
>   	if (IS_ERR(split)) {
> -		bio->bi_status = errno_to_blk_status(PTR_ERR(split));
> -		bio_endio(bio);
> +		bio_endio_status(bio, errno_to_blk_status(PTR_ERR(split)));
>   		return NULL;
>   	}
>   
> @@ -143,8 +142,7 @@ EXPORT_SYMBOL_GPL(bio_submit_split_bioset);
>   static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
>   {
>   	if (unlikely(split_sectors < 0)) {
> -		bio->bi_status = errno_to_blk_status(split_sectors);
> -		bio_endio(bio);
> +		bio_endio_status(bio, errno_to_blk_status(split_sectors));
>   		return NULL;
>   	}
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4c5c16cce4f8..ade9d3a89743 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3187,8 +3187,7 @@ void blk_mq_submit_bio(struct bio *bio)
>   	}
>   
>   	if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
> -		bio->bi_status = BLK_STS_NOTSUPP;
> -		bio_endio(bio);
> +		bio_endio_status(bio, BLK_STS_NOTSUPP);
>   		goto queue_exit;
>   	}
>   
> @@ -3229,8 +3228,7 @@ void blk_mq_submit_bio(struct bio *bio)
>   
>   	ret = blk_crypto_rq_get_keyslot(rq);
>   	if (ret != BLK_STS_OK) {
> -		bio->bi_status = ret;
> -		bio_endio(bio);
> +		bio_endio_status(bio, ret);
>   		blk_mq_free_request(rq);
>   		return;
>   	}
> diff --git a/block/fops.c b/block/fops.c
> index ffe7b2042f4e..15783a6180de 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -218,8 +218,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>   
>   		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
>   		if (unlikely(ret)) {
> -			bio->bi_status = BLK_STS_IOERR;
> -			bio_endio(bio);
> +			bio_endio_status(bio, BLK_STS_IOERR);
>   			break;
>   		}
>   		if (iocb->ki_flags & IOCB_NOWAIT) {
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 7597ae4dc52b..d778e65fdacd 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -371,16 +371,27 @@ void submit_bio(struct bio *bio);
>   
>   extern void bio_endio(struct bio *);
>   
> -static inline void bio_io_error(struct bio *bio)
> +/**
> + * bio_endio - end I/O on a bio with a specific status
> + * @bio:	bio
> + * @status:	status to set
> + *
> + * Set @bio->bi_status to @status and call bio_endio().
> + **/
> +static inline void bio_endio_status(struct bio *bio, blk_status_t status)
>   {
> -	bio->bi_status = BLK_STS_IOERR;
> +	bio->bi_status = status;
>   	bio_endio(bio);
>   }
>   
> +static inline void bio_io_error(struct bio *bio)
> +{
> +	bio_endio_status(bio, BLK_STS_IOERR);
> +}
> +
>   static inline void bio_wouldblock_error(struct bio *bio)
>   {
> -	bio->bi_status = BLK_STS_AGAIN;
> -	bio_endio(bio);
> +	bio_endio_status(bio, BLK_STS_AGAIN);
>   }
>   
>   /*

