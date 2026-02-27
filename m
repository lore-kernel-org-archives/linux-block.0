Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F62923E34C
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198897; cv=none; b=cU+DnFqBs0g3I8KBMV9FR8dq5HHcPYx3rS9GQVrq2bRkiidZ8PJu9csp8RPHMj8OUp0lOghRtAcBBcqoS0RMmhNEIlLUfVrbEHYq7r/+01Tj1t+wi4xv6jfxWq68v5Oo1T9AmQ79AgvzAc0S6RXdy6bSp2rPzDwluSArCmFZcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198897; c=relaxed/simple;
	bh=CssOadRfP1nI/lX56pRax/5xGOn5KgJs2w+Wn1EdsY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jp1/DOkOTfC/Q84QjXT0hLx/Ij/IbHW8rgGMlBJhY2b7lAY3TrIB4OjHSDmEyZYclwHpI6pZOFO896+GD+3ECqPXLKWe1hnWTGz3QbfEJbTMjsEzMcTQ4dXQP4A7hgpWdbHt7cBhhSoYFE/FbjZVudvezDhrHYUDC0rweiyS+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIJ/FXTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIJ/FXTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15367C116C6;
	Fri, 27 Feb 2026 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198896;
	bh=CssOadRfP1nI/lX56pRax/5xGOn5KgJs2w+Wn1EdsY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aIJ/FXTcNawCbTxg2+H1vxJAgbFxP7ERu6iZkx66zjBI817mYrTeGSd98peMLMbRn
	 J1icVSNRzVjRQgx/A5iiexGaEh/tUceds/KK+k2miwPHQRvx7mhNm4mFJ56M8R6abO
	 YNDrM+rQzJdeMBtmGpyQ8zyhg2bUEBGrTZPcMrxmpTqchki71khYIVGAQOVVnyvPHk
	 TnxZ5ytLAL/Xo7zBZku3+xBBnakQ5tygTKCOoohYHWs9XMSLb+m60Y2MEOOaXWUp01
	 iGwlZS28LuqwgL6d2d/agGl9/5OOobqCuZCOmjs7vEzp1V97uOSbTMd51Nzb01rrB3
	 gwtUhXxHVNnVA==
Message-ID: <38c949c4-9903-49d8-8992-899d90580a0c@kernel.org>
Date: Fri, 27 Feb 2026 22:28:14 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Correct comments on bio_alloc_clone() and
 bio_init_clone()
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20260227104438.1646405-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260227104438.1646405-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 19:44, John Garry wrote:
> Correct the comments that the cloned bio must be freed before the memory
> pointed to by @bio_Src->bi_io_vecs (is freed).
> 
> Christoph Hellwig contributed most the of the update wording.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note: Not sure if it matters, but your patch is missing the "---" separator
between your SoB and the beginning of the diff.

> 
> diff --git a/block/bio.c b/block/bio.c
> index 8203bb7455a9f..156bb75f55298 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -897,10 +897,11 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
>   * @gfp: allocation priority
>   * @bs: bio_set to allocate from
>   *
> - * Allocate a new bio that is a clone of @bio_src. The caller owns the returned
> - * bio, but not the actual data it points to.
> - *
> - * The caller must ensure that the return bio is not freed before @bio_src.
> + * Allocate a new bio that is a clone of @bio_src. This reuses the bio_vecs
> + * pointed to by @bio_src->bi_io_vec, and clones the iterator pointing to
> + * the current position in it.  The caller owns the returned bio, but not
> + * the bio_vecs, and must ensure the bio is freed before the memory
> + * pointed to by @bio_Src->bi_io_vecs.
>   */
>  struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
>  		gfp_t gfp, struct bio_set *bs)
> @@ -929,9 +930,7 @@ EXPORT_SYMBOL(bio_alloc_clone);
>   * @gfp: allocation priority
>   *
>   * Initialize a new bio in caller provided memory that is a clone of @bio_src.
> - * The caller owns the returned bio, but not the actual data it points to.
> - *
> - * The caller must ensure that @bio_src is not freed before @bio.
> + * The same bio_vecs reuse and bio lifetime rules as bio_alloc_clone() apply.
>   */
>  int bio_init_clone(struct block_device *bdev, struct bio *bio,
>  		struct bio *bio_src, gfp_t gfp)


-- 
Damien Le Moal
Western Digital Research
