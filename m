Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8911C92;
	Mon, 12 Aug 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470708; cv=none; b=l4nL4u7gERYmc8BZi0la6CRhlXowSaFASqvLXbui+h8MfIkq4zIlqFbS2At6dy5m/zOWQdVPXlNSwcxgjRuYsGT0n6QRoBWT1RZ298H5reom4ZzMGG80dIO5SV9AANojN8lnkNrbIuo0AMP1Tg2PL6F/xYomOmKITAi3ZJM+H6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470708; c=relaxed/simple;
	bh=NC4tazcis1jSVDgkpJprpwF0eRbJkaFqXwFdKxjDB4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpX45rv8aZnZDP5+YDotH+JEFccbFUvzCyFen/mYPqh3FWyDANCulScDGelZvFAQ7U5Lxx5GZtQavJ+Et4zti8S3YpVQDdRWYe6UV1fFlCAIbE0jmCDHkAEfISWtUW3L7cVAkTzJ5IVakTY5U2DaZN4nxchnYaCGtPAwHBo1Sag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cphgbrVt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cphgbrVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AB3C32782;
	Mon, 12 Aug 2024 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470708;
	bh=NC4tazcis1jSVDgkpJprpwF0eRbJkaFqXwFdKxjDB4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cphgbrVt1l435qTXWYs/HLQ/IuQzjPeAU0azb8Ce/+u9Hz8WjxpZDBgZVivdaN6J7
	 EJu4bLeWqlTmeA72RgUSX+hHU9cKPD9T7c8wo0fwMauxf4bhBEzg1XxvMzNOqUTEwD
	 sJcO1qIenQNuu/JnA0Wzd9BCGqgxsXNF6XOgck+D0YGvyu7Et7Y93LN4t0plCdCKYu
	 PGuU2EchBmNtJpOEbcQt0OKqXJ5IoIarlqfudjDDwfeUIlU1Cp9qFM5GJjaOrU5pHx
	 0/tkl1ACm9+Tauzbwn8rBB20pna6wRCN3tihEvRsmjWTluVsKmTIWZX6GlhogEVcva
	 c7HPPK5Hj1XcQ==
Message-ID: <7f38f5bc-6bd2-4e3a-92e6-c232761fafc6@kernel.org>
Date: Mon, 12 Aug 2024 15:51:12 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH AUTOSEL 6.10 13/16] block: change rq_integrity_vec to
 respect the iterator
Content-Language: en-GB
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, kbusch@kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240728004739.1698541-1-sashal@kernel.org>
 <20240728004739.1698541-13-sashal@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240728004739.1698541-13-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha, Greg,

On 28/07/2024 02:47, Sasha Levin wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> [ Upstream commit cf546dd289e0f6d2594c25e2fb4e19ee67c6d988 ]
> 
> If we allocate a bio that is larger than NVMe maximum request size,
> attach integrity metadata to it and send it to the NVMe subsystem, the
> integrity metadata will be corrupted.

(...)

> diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
> index 7428cb43952da..d16dd24719841 100644
> --- a/include/linux/blk-integrity.h
> +++ b/include/linux/blk-integrity.h
> @@ -100,14 +100,13 @@ static inline bool blk_integrity_rq(struct request *rq)
>  }
>  
>  /*
> - * Return the first bvec that contains integrity data.  Only drivers that are
> - * limited to a single integrity segment should use this helper.
> + * Return the current bvec that contains the integrity data. bip_iter may be
> + * advanced to iterate over the integrity data.
>   */
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> -		return NULL;
> -	return rq->bio->bi_integrity->bip_vec;
> +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +				 rq->bio->bi_integrity->bip_iter);
>  }
>  #else /* CONFIG_BLK_DEV_INTEGRITY */
>  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
> @@ -169,7 +168,8 @@ static inline int blk_integrity_rq(struct request *rq)
>  
>  static inline struct bio_vec *rq_integrity_vec(struct request *rq)
>  {
> -	return NULL;
> +	/* the optimizer will remove all calls to this function */
> +	return (struct bio_vec){ };

If CONFIG_BLK_DEV_INTEGRITY is not defined, there is a compilation error
here in v6.10 with the recently queued patches because the signature has
not been updated:

> In file included from block/bdev.c:15:                                                                                                                                             
> include/linux/blk-integrity.h: In function 'rq_integrity_vec':
> include/linux/blk-integrity.h:172:16: error: incompatible types when returning type 'struct bio_vec' but 'struct bio_vec *' was expected
>   172 |         return (struct bio_vec){ };                 
>       |                ^

Could it be possible to backport the following fix to v6.10 as well please?

  69b6517687a4 ("block: use the right type for stub rq_integrity_vec()")

It is also needed for v6.6 and v6.1.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

