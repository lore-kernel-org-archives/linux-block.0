Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA11FA5;
	Tue, 23 Jan 2024 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986970; cv=none; b=XtRGSX9lfYyWMHtFX0TcrnheK2TYyHWvOfI77akp+TOYMzIuhyibTHzhIsdISF1pwckM26e60XzR5E1BKqKbVyIsF8zWHirB0+PGTIV5Mcy0e7vl79/JsaVv8jz67vZ3MhwQ3A/pVn6NFu+nN9bLCqIQKhhy3BQsP4QT0GmDffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986970; c=relaxed/simple;
	bh=3gjd11VNRFKEeXE8qGU7uHiRry2OiA7AdrPwpMjQSaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn2oqMu5+m1VaMXjNigUsPfnlTEY5h9y8w9hDpyDsZAmubDZSV/RpvmC47sBmY+DwydM+Av3ZsAfJ2onVn7LXbPC/Jd85yuUgdoytylpJdUA5AR0GiHBUKecXAH49Lz6t7LioIpatnop8kPXB0GDUe3m9cpR24pJHGMMMj0l9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnnyu1kY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnnyu1kY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0D5C433F1;
	Tue, 23 Jan 2024 05:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986969;
	bh=3gjd11VNRFKEeXE8qGU7uHiRry2OiA7AdrPwpMjQSaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hnnyu1kYPQ7J9dya0/IJbWJZmtOgaWI2HIp+its6MYc0Mrh6nXBhoTCFpRBUQ1QvK
	 VD0P6frLT2Up9BpJTn9Nf7CgaUr6aZqnYyhfrd0+6L2Z25JdMLc/fykFkZTcJ7wpYk
	 Ayg75jeU3CADE1pqu4APT+MeRSaCcdYaHPfOJ4bkgBqxidfclAkFxRRyiotqXR4By6
	 F0CHU61kA62ver0vQcZivinyKeo7tI0e55gYxG6Y4YQ2xRBtKEilFPx7iifW54cSqk
	 Kuf9gma/KJRvljDMpCO7vKxSwGLR14lg+/IgBHLgMMM/oTMa2m5KQe5hauehEfX8T4
	 ED9A2ZRr8Q5IQ==
Message-ID: <ec80947b-fe0f-46a2-b7bb-76bf8fb8b510@kernel.org>
Date: Tue, 23 Jan 2024 14:16:07 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] block: use queue_limits_commit_update in
 queue_discard_max_store
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-8-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Convert queue_discard_max_store to use queue_limits_commit_update to
> check and updated the max_sectors limit and freeze the queue before

s/updated/update
s/max_sectors/max_discard_sectors

> doing so to ensure we don't have request in flight while changing

s/request/requests

> the limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With the typos fixed, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk-sysfs.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 54e10604ddb1dd..8c8f69d8ba48ee 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -175,7 +175,9 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
>  				       const char *page, size_t count)
>  {
>  	unsigned long max_discard_bytes;
> +	struct queue_limits lim;
>  	ssize_t ret;
> +	int err;
>  
>  	ret = queue_var_store(&max_discard_bytes, page, count);
>  	if (ret < 0)
> @@ -187,10 +189,14 @@ static ssize_t queue_discard_max_store(struct request_queue *q,
>  	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
>  		return -EINVAL;
>  
> -	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> -	q->limits.max_discard_sectors =
> -		min_not_zero(q->limits.max_hw_discard_sectors,
> -			     q->limits.max_user_discard_sectors);
> +	blk_mq_freeze_queue(q);
> +	lim = queue_limits_start_update(q);
> +	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> +	err = queue_limits_commit_update(q, &lim);
> +	blk_mq_unfreeze_queue(q);
> +
> +	if (err)
> +		return err;
>  	return ret;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

