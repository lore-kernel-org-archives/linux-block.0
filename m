Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09598675D2
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWwQBBwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E73C433C8;
	Tue,  5 Dec 2023 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701794270;
	bh=WT3Lgl/3mNHVUcvzikUtksIrWGED6a0ZRp6/fXuqUHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWwQBBwu+4zMtI6bx2B8CqWMqvRcaEU+lPAqrEhV55NcEOAgOxnUusdl9OtFLu14x
	 jz6+msDNUkjliHQTg265+N/cRDV31QeGH5Mqqri/QjAORU1YqkvC43gh2It9YanWkx
	 BL7uQ/gv0rdgPRAC9wGGvDEGiN7Ta1NjHsTcXJ+eqh4cT9ce3iCrheVeXVR+Vk/7K1
	 ppG1/vFGQkO9PudLjer3wPB5pcU3nMGqS9cn4RYmyY6ww9Qgn0CSu9FE2TgYMzbKE9
	 P3Xskt3xSeESxRMLHbuGKa7HcUer2/RWH/WiwWQh8QKzzPPuA9TmXmGe358amwPsvS
	 2X74PIIFJ6rPQ==
Date: Tue, 5 Dec 2023 09:37:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: support adding less than len in
 bio_add_hw_page
Message-ID: <ZW9R29OUl3j8BH43@kbusch-mbp>
References: <20231204173419.782378-1-hch@lst.de>
 <20231204173419.782378-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204173419.782378-3-hch@lst.de>

On Mon, Dec 04, 2023 at 06:34:19PM +0100, Christoph Hellwig wrote:
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index cef830adbc06e0..335d81398991b3 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -966,10 +966,13 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>  		struct page *page, unsigned int len, unsigned int offset,
>  		unsigned int max_sectors, bool *same_page)
>  {
> +	unsigned int max_size = max_sectors << SECTOR_SHIFT;
> +
>  	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>  		return 0;
>  
> -	if (((bio->bi_iter.bi_size + len) >> SECTOR_SHIFT) > max_sectors)
> +	len = min3(len, max_size, queue_max_segment_size(q));
> +	if (len > max_size - bio->bi_iter.bi_size)
>  		return 0;
>  
>  	if (bio->bi_vcnt > 0) {

Not related to your patch, but noticed while reviewing: would it not be
beneficial to truncate 'len' down to what can fit in the current-segment
instead of assuming the max segment size?
