Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C834DCC8
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261768; cv=none; b=KEfp6MYTh+uoV1o/CE0Nyi96GWhxWhmdbLNUlDRxXia9YvjqR+TCJ8nXXjKMu283qAIBLoqM8azQJYlV5WlkZTLKPIsCDGKsLbBqldeFtce365xoND4AIpvZFSEkBbAVK61hfqbzBt00XNEY/NsRIYsU6Z5MTYGr0XA162Fnglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261768; c=relaxed/simple;
	bh=OEzlS1jd5QMmP53SZ5T4g08EAu977qlP6bBWWrvK7dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCuTfMe51hGdI0fib+crN5iMaS/SVAr6DtkpYoKmpHghnu/NsfDFm34Z3Blz3CxpJVvG3WYLA5MoIyChWP+SOa8SyZ7CSgAIZEj44ECMX6UVLjY83ytMrZ8jDWfQQNgb+URmiBqPWD2Rj6fdSkQFQC/7ccD6eFyC3pAeaR6fdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD+gw0k4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD+gw0k4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD90B1F00893;
	Wed, 20 May 2026 07:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779261766;
	bh=iTGTHmjgP5M+bWV7oIfWCuPYiD48ND/hiGO4ejfqww4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CD+gw0k4sBVGEj9UXGl0hcM6RvTigNbVgQyLxLsAyWofDgJU3J9vIFyYAGe/1XY27
	 S9Hb7stujoA2zIroOnvqh2NDpdaZ+5xhHMQbta6YpdvCEZ0V1AETyy9EkCFF/1c9hc
	 8frC58RlI0ODxB7xHhOmQ+IYxt6/hbPvv5Qb1JrycJgTlWpaY3G3iN1gPaFFm5qAyK
	 os45CkLzRhH6qNoN6uPTLybpcWd7bcAI2mIEu0sEze6lX5q8qyj2oitRolcGo3P8sI
	 oTnx+06xfEnQ4GNqJA70k4eRgHOQlvAhV2Kw4DLnb4MX65+z4TcnnmOG6clF1AgD6z
	 x4fXggdpqvd/A==
Message-ID: <03564da7-661e-40ea-9a11-8b96972f1048@kernel.org>
Date: Wed, 20 May 2026 09:22:42 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered
 context
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-4-kbusch@meta.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260519172326.3462354-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/19 19:23, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> bio_check_eod() in submit_bio_noacct() validates that a bio does not
> extend beyond the partition's available sectors. This check runs before
> bio_queue_enter(), so it is not serialized against queue limit updates.
> A driver that freezes the queue, updates limits, changes the capacity,
> and unfreezes can race with a bio that passed the early check under the
> old capacity.
> 
> Remove bio_check_eod() and replace it with a bounds check in
> __bio_split_to_limits(), which runs after the queue usage reference has
> been acquired. The check uses partition-aware arithmetic to validate
> both partition bounds and disk capacity in a single comparison that
> works correctly on the post-remap sector values.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

[...]

> @@ -423,6 +423,17 @@ static inline bool bio_may_need_split(struct bio *bio,
>  static inline struct bio *__bio_split_to_limits(struct bio *bio,
>  		const struct queue_limits *lim, unsigned int *nr_segs)
>  {
> +	if (unlikely(bio_end_sector(bio) > bdev_nr_sectors(bio->bi_bdev) +
> +					   bio->bi_bdev->bd_start_sect)) {
> +		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
> +				    "%pg: rw=%d, sector=%llu, nr_sectors = %u limit=%llu\n",
> +				    current->comm, bio->bi_bdev, bio->bi_opf,
> +				    bio->bi_iter.bi_sector, bio_sectors(bio),
> +				    bdev_nr_sectors(bio->bi_bdev) +
> +					bio->bi_bdev->bd_start_sect);

Should this be a pr_err_ratelimited() ?

Also, putting this check here means that we are going to redo the check for all
the fragment of the large BIO being split, no ? It would be nice to be able to
do this check only once when the large BIO is submitted.

Moving this check to a helper and calling this new helper higher in the
submission path could avoid that. But I am not 100% sure if a higher placed call
can be a problem.
> +		goto ioerr;
> +	}
> +
>  	switch (bio_op(bio)) {
>  	case REQ_OP_READ:
>  	case REQ_OP_WRITE:
> @@ -442,6 +453,9 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
>  		*nr_segs = 0;
>  		return bio;
>  	}
> +ioerr:
> +	bio_io_error(bio);
> +	return NULL;
>  }
>  
>  /**


-- 
Damien Le Moal
Western Digital Research
