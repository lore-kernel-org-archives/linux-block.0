Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595538;
	b=lGmAEyLPNXtVMiFF4konQfqI/G47yu1rj7p/cjQFfMeX5f5ENgoKHwCfNAAnBGKNv4YK
	 rfju7aBWSrMY1b/VHv3KWQWkMN51nj9sr0fjeXBQK6n9i6ROMots3gIN6xw2VJ+GHNOam
	 +wh6kOjkGdQOFHjw1I2ldbYU31d3VPpidkamvjdxEwW3e4KoQgXRoCPy1U3B1vb0ux3uj
	 V6l9wuodGUeYxFgBwaMyacSQ6UE/VKDSek15bX0NJ5npxe3mnuj+oJ8R4b7wLDC/aCYXn
	 uDQRcgelAnFgyjZY01mH94Vz3FH8SnihaQsLe4YJBQnOETZy2YHviwNviNsyqF77vjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FsHH6aozeXPThpXvJUYVLtQrnQwbfOChlZ8cfIqdctg=;
	b=Pk8IXOD692pqVotBcPrBDYQAiq2hzvQULbJ65HC2zusdkdg1gw3UH5wNirypNir2ImY1
	 3QkOSzmkqOElRG2i34q+0TGOfSMv08Gkq9FLsYy7vm+4vqhX8qqsPg0wbeDxIR9Tkw+bK
	 UTHmM3ABKRxTskWISdc7QETJgkUX0lPBo/pNtV4Gu7ecAtifpZ1KrjHIUT/E2BTXanv3d
	 mRVpExeO7hPr3t0I3QWdq5+TFedlE5k25rvFD1ylQGt3vhgsrn5dKJpTyt8/irNuG2ulC
	 NPNd590JId/OVIh+0ATzIeG3eXH0BlsK945vIFR+1fM1MrawM4X059GzQJo35cZQ/og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fRtNArbA;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CD606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 15:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D8CD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fRtNArbA
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dc202a60eso423534f8f.3
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792595536; x=1793200336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FsHH6aozeXPThpXvJUYVLtQrnQwbfOChlZ8cfIqdctg=;
        b=fRtNArbAsjB87bQ7Egtqi1qkoryq/3OpgC+NpIKVcrOe3+zlMXYMwOlAI8wBFiWNqz
         /vwIrs8UcevppcI4bM3g8DBDAAPymD3sBjBVJZkceWgpJVAoP88Fri5Aq/xfZc77SNg3
         heAxZ+4juOcdoVkAt/XGapWWe7ioX6XUStxAlzmwxpDhGFXB3ERcql5/GqsTfS0H/qYU
         GbXxFn405gpDNlr5sBH6IWrq7iarI3go7WnfA0KVbRX/9NmUYIhzyNwuyUkllOfxIm1f
         VKxKclYr9bO065thJe8DJ9E9Vckk3PDMFluqv9yYpZUIrjYUjQXqMqXt92ZWv6Np+iS9
         u+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595536; x=1793200336;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsHH6aozeXPThpXvJUYVLtQrnQwbfOChlZ8cfIqdctg=;
        b=JTs83Q9ZC8OCyBrzHRDU+GzFDslMcmTk0wwRZek+Sx0KE5UaJmsZJj4u+L9p+DTOxg
         BqoHP/tvKod5nhwsqXGA4igEnrNDvNPlwDQpvOLwENcFiPa0XjWNYcsMmrUwsxFMoNxm
         tMdtV35irG9AiLj3MwraCS2tp39hc5jToylBt5L0vRcTABm0jNKpKvmGh87shsaNAcKR
         LLR5LKFDSAyhDiOnV1KakBpNu1ZYsbsqIHOe/p15JLQ57R2xQliJIMFIf2M/FRD0xO3t
         pwtIbcUh4EcwU0U2hEYagL9Hy0hgdrP4YTyipx5SpwccvexZq3xED3F9QQSewY8aqZim
         rfRQ==
X-Gm-Message-State: AFq9FYI8piBFU0Hrmt2LlrxwmINXmc0X6Aq75WAHxwQVmY2Y8ecDDm7+
	cNvn3qyUbChzqSGxKYEskoxqmwo3dx4zTiuC2KaDPEo1XSf3Ua9KARr/
X-Gm-Gg: AYBFou2mD5ywbJ6ge4Sb/BCMsz9DBTBx39GY9F/jmphMX5KOpAkJGUjMDxMSMCEVMwy
	MJ65yuQ1hT0N2FhDFLm+iSFftJCsmkZ9eykA/6mZom1DlGG7WdmgOVNTWNcfBAau0RwVAog2mNZ
	MLUU0ugJGI0it+pUR40PCTmhFhzZ3EGt/VF/p7Y2Jqrrz3PfRRB4Jzaxh2T+hdrPj1TxZ7Kc5Lp
	Q4z0pqSZWSSZlwpQFUozNw5muRW6VeGjrAZC3jY1GOwGl6fhPznUSWvPQEcs3MCJmoWPt4wWiO8
	2+/g96S0HzvQKGl2EeJJKIdTUzaiAdpbvWKYfBdeZ3IDSDfeFLy7Qp9wvnQbI5CxSDzFFXqj2y6
	kEBuDsCfjufZU3JihOMMyHPA69MNuJT43sxaGqlulRYn+l9xy7j5p9AFRRR9vm6y/I8fnEllmDZ
	kU0llHTY/9XF5OeG5r/hxRJ6bkzNJIjaIlIWDGIL8xo2pGpkigw5nAbkWfAN6IGHWWpoHN+lfk7
	T2QCa3g7y38zLtSCZ6878V42MA4aGBZcGWOnVSSaci9tf9HVaXKcSX6R95Whu/vRaD/11QRaTKe
	4rXMVdXHV57wGLq7Jw5J1mFIGjkdtE4QIqVZvVEe0auk7csP1HNgoYpLzAZvkHfVaJpOiVroIri
	bKiuVb60=
X-Received: by 2002:a05:6000:46d6:b0:48d:f831:2681 with SMTP id ffacd0b85a97d-48e264ce32cmr3497388f8f.38.1792595536092;
        Wed, 21 Oct 2026 08:12:16 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-19.dab.02.net. [82.132.213.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f02f1sm6396517f8f.3.2026.10.21.08.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:12:15 -0700 (PDT)
Message-ID: <5f542a8d-c6c1-4c5d-b0c6-f761af2e126a@gmail.com>
Date: Wed, 21 Oct 2026 16:12:15 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] block: refuse a dma-buf bio for a disk the buffer was
 not registered on
To: Anuj Gupta <anuj1072538@gmail.com>, hch@lst.de, djwong@kernel.org,
 cem@kernel.org, brauner@kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, anuj20.g@samsung.com,
 nj.shetty@samsung.com
References: <20261016091919.971295-1-anuj1072538@gmail.com>
 <20261016091919.971295-3-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261016091919.971295-3-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 10:19, Anuj Gupta wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
...> +static bool bio_dmabuf_map_valid(const struct bio *bio,
> +				 const struct iov_iter *iter)
> +{
> +	return iter->dmabuf_map->ctx->registered_devt ==
> +		disk_devt(bio->bi_bdev->bd_disk);
> +}
> +
>   /**
>    * bio_iov_iter_get_pages - add user or kernel pages to a bio
>    * @bio: bio to add pages to
> @@ -1300,6 +1312,9 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>   	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>   		return -EIO;
>   
> +	if (iov_iter_is_dmabuf_map(iter) && !bio_dmabuf_map_valid(bio, iter))
> +		return -EXDEV;
> +
>   	if (bio_iov_iter_set(bio, iter)) {
>   		if (iov_iter_is_bvec(iter) &&
>   		    !bio_iov_bvec_aligned(bio, mem_align_mask))
> diff --git a/block/fops.c b/block/fops.c
> index 18a755f6e0b0..b36dde10a4ac 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -19,6 +19,7 @@
>   #include <linux/iomap.h>
>   #include <linux/module.h>
>   #include <linux/io_uring/cmd.h>
> +#include <linux/dma-buf-io.h>
>   #include "blk.h"
>   
>   static inline struct inode *bdev_file_inode(struct file *file)
> @@ -938,6 +939,7 @@ int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
>   			     struct dma_buf_io_ctx *ctx)
>   {
>   	struct gendisk *disk = bdev->bd_disk;
> +	int ret;
>   
>   	if (!(file->f_flags & O_DIRECT))
>   		return -EINVAL;
> @@ -945,7 +947,10 @@ int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
>   		return -EOPNOTSUPP;
>   	if (bdev_has_integrity_csum(bdev))
>   		return -EOPNOTSUPP;
> -	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
> +	ret = disk->fops->init_dma_buf_io_ctx(bdev, ctx);
> +	if (!ret)
> +		ctx->registered_devt = disk_devt(disk);
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(bdev_init_dma_buf_io_ctx);
>   
> diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
> index b9bbeca1744f..d42a79f2ac9b 100644
> --- a/include/linux/dma-buf-io.h
> +++ b/include/linux/dma-buf-io.h
> @@ -50,6 +50,8 @@ struct dma_buf_io_ctx {
>   
>   	void					*dev_priv;
>   	const struct dma_buf_io_ops		*dev_ops;
> +
> +	dev_t					registered_devt;

That wouldn't work well with multiple devices. Maybe reject it in
xfs / iomap for now?

FWIW, a generic solution is for xfs to own the ctx passed on
registration instead of forwarding it to block, allocate an array
of new ctxs for each device and register them separately. This
should even be able to support dynamic device registration.

-- 
Pavel Begunkov

