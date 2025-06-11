Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791605695
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749602899; cv=none; b=RCQUa2o1g+roPUvNJsL/6KRx38PwQr1kwfsBaMVcdwUi92yjbitATdBxuTcPK868ed0XXGCYhewttaSGeVcxvJkT2Rv96f/BDgDL+OqtauaGrC9Eh4tw4okzA+Mp51ECxqtQkHixoP+oYElTqWxKGqIhEs/LgOcrqfzoef0EbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749602899; c=relaxed/simple;
	bh=V8TM2DFZqtKgTpP/AibNphXjUQr21YjmrizCDn7s5vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3+LtgurJrf1HuYlDInIWNv7G+MbsfjO22UTNw6SCvtNcolyRSdmUrdoEpPVjfMu8uF3sJjhuQGqvef8DXaL9PUpSYjj8RXd44AIwc8LOYEyaIdXTkCmlUg66RjE0jvlghMRVAfGNJVtzQmjAStkULI1//jJDomqPxiKn/R1VHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obsSpbwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obsSpbwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69024C4CEED;
	Wed, 11 Jun 2025 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749602899;
	bh=V8TM2DFZqtKgTpP/AibNphXjUQr21YjmrizCDn7s5vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=obsSpbwHwOmTtSyrVhzWteo3GD9YQv6+/1VIM4qJSpwA+aIGB74ZWqRccvUBaD8I7
	 9sad7HM8a0K2MS1J7jON8CUXhRoIMEv1x54NeMCpCUE5JRXSfJOfN4Oj48tflH6myk
	 zkLJG1W6ZodH3jLZlAJo3bw7Ina/9pR3EJhe8zQpvkHDzt62ZhwSQ7KfHShIy1PEN4
	 +Q/ule8IUa9Fk4YPuxvobUNOk+vVf8Tlv+m4BGkl80hSBBS0vz+t811GxwuqttgK3H
	 RhwkMwGPzD2QvU9X+irMYYGtWFAxqxS2XGkzj4x1V+2mPnXlfVbz1e8jyGRgKipTaJ
	 FsTdYyjF7LQhw==
Message-ID: <c98e6252-c0af-4d25-8995-5b808b0c6da5@kernel.org>
Date: Wed, 11 Jun 2025 09:46:31 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Eric Biggers <ebiggers@google.com>
References: <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org> <aEi9KxqQr-pWNJHs@kbusch-mbp>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aEi9KxqQr-pWNJHs@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 8:18 AM, Keith Busch wrote:
> On Tue, Jun 10, 2025 at 10:23:26AM -0700, Bart Van Assche wrote:
>> On 6/8/25 8:55 PM, Christoph Hellwig wrote:
>>> The problem here is that blk_crypto_fallback_split_bio_if_needed does
>>> sneaky splits behind the back of the main splitting code.
>>>
>>> The fix is to include the limit imposed by it in __bio_split_to_limits
>>> as well if the crypto fallback is used.
>>
>> (+Eric)
>>
>> Hmm ... my understanding is that when the inline encryption fallback
>> code is used that the bio must be split before
>> blk_crypto_fallback_encrypt_bio() encrypts the bio. Making
>> __bio_split_to_limits() take the inline encryption limit into account
>> would require to encrypt the data much later. How to perform encryption
>> later for bio-based drivers? Would moving the blk_crypto_bio_prep() call
>> from submit_bio() to just before __bio_split_to_limits() perhaps require
>> modifying all bio-based drivers that do not call
>> __bio_split_to_limits()?
> 
> I think you could just prep the encryption at the point the bio is split
> to its queue's limits, and then all you need to do after that is ensure
> the limits don't exceed what the fallback requires (which appears to
> just be a simple segment limitation). It looks like most of the bio
> based drivers split to limits already.

Nope, at least not DM, and by that, I mean not in the sense of splitting BIOs
using bio_split_to_limits(). The only BIOs being split are "abnormal" ones,
such as discard.

That said, DM does split the BIOs through cloning and also has the "accept
partial" thing, which is used in many places and allows DM target drivers to
split BIOs as they are received, but not necessarilly based on the device queue
limits (e.g. dm-crypt splits reads and writes using an internal
max_read|write_size limit).

So inline crypto on top of a DM/bio-based device may need some explicit
splitting added in dm.c (__max_io_len() maybe ?).

> And if that's all okay, it simplifies quite a lot of things in this path
> because the crypto fallback doesn't need to concern itself with
> splitting anymore. Here's a quick shot a it, but compile tested only:
> 
> ---
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f25..157f4515eea7d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -39,7 +39,6 @@
>  #include <linux/bpf.h>
>  #include <linux/part_stat.h>
>  #include <linux/sched/sysctl.h>
> -#include <linux/blk-crypto.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/block.h>
> @@ -626,9 +625,6 @@ static void __submit_bio(struct bio *bio)
>  	/* If plug is not used, add new plug here to cache nsecs time. */
>  	struct blk_plug plug;
>  
> -	if (unlikely(!blk_crypto_bio_prep(&bio)))
> -		return;
> -
>  	blk_start_plug(&plug);
>  
>  	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 005c9157ffb3d..794400382e85b 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -209,36 +209,6 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_crypto_keyslot *slot,
>  	return true;
>  }
>  
> -static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
> -{
> -	struct bio *bio = *bio_ptr;
> -	unsigned int i = 0;
> -	unsigned int num_sectors = 0;
> -	struct bio_vec bv;
> -	struct bvec_iter iter;
> -
> -	bio_for_each_segment(bv, bio, iter) {
> -		num_sectors += bv.bv_len >> SECTOR_SHIFT;
> -		if (++i == BIO_MAX_VECS)
> -			break;
> -	}
> -	if (num_sectors < bio_sectors(bio)) {
> -		struct bio *split_bio;
> -
> -		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
> -				      &crypto_bio_split);
> -		if (IS_ERR(split_bio)) {
> -			bio->bi_status = BLK_STS_RESOURCE;
> -			return false;
> -		}
> -		bio_chain(split_bio, bio);
> -		submit_bio_noacct(bio);
> -		*bio_ptr = split_bio;
> -	}
> -
> -	return true;
> -}
> -
>  union blk_crypto_iv {
>  	__le64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
>  	u8 bytes[BLK_CRYPTO_MAX_IV_SIZE];
> @@ -275,10 +245,6 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
>  	bool ret = false;
>  	blk_status_t blk_st;
>  
> -	/* Split the bio if it's too big for single page bvec */
> -	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
> -		return false;
> -
>  	src_bio = *bio_ptr;
>  	bc = src_bio->bi_crypt_context;
>  	data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
> diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
> index 94a155912bf1c..2804843310cc4 100644
> --- a/block/blk-crypto-profile.c
> +++ b/block/blk-crypto-profile.c
> @@ -459,6 +459,16 @@ bool blk_crypto_register(struct blk_crypto_profile *profile,
>  		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
>  		return false;
>  	}
> +
> +	if (queue_max_segments(q) > BIO_MAX_VECS) {
> +		struct queue_limits lim;
> +
> +		lim = queue_limits_start_update(q);
> +		lim.max_segments = BIO_MAX_VECS;
> +		if (queue_limits_commit_update(q, &lim))
> +			return false;
> +	}
> +
>  	q->crypto_profile = profile;
>  	return true;
>  }
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3af1d284add50..d6d6f5b214c82 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -124,9 +124,10 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
>  		trace_block_split(split, bio->bi_iter.bi_sector);
>  		WARN_ON_ONCE(bio_zone_write_plugging(bio));
>  		submit_bio_noacct(bio);
> -		return split;
> +		bio = split;
>  	}
>  
> +	blk_crypto_bio_prep(&bio);
>  	return bio;
>  error:
>  	bio->bi_status = errno_to_blk_status(split_sectors);
> --


-- 
Damien Le Moal
Western Digital Research
