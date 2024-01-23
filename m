Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D07E6;
	Tue, 23 Jan 2024 04:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705984869; cv=none; b=udxcPxlcAJg5UJwhFecpD/8oTaq3z5pgIl9MqglCb3c4WKabRgD0+QHHo4jWIHyZT6Iu+A28O1jsnYmKHKkrbRd1eUhbDTAcuJrh/hVeNm6EOytKqYsbnG/6qGMz3LePDd7SBDN4l015d7gLa8a0TuQX0R2MVDf4gezhYddx+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705984869; c=relaxed/simple;
	bh=ydiaEKqGk/zYwexK6yzv2Z6sXqMYYQwc2PODQ/3cRT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayjRWz5XIUp521jnqbVg6AgWOeGB1CFyWe1xJZC5P/Rag7mk+UNX0JUX2ASOaAMRiK8M3iCW8YCZzaGqWpGJZhcOijRtmINEFLduwhwLNsYx2o2oTqH0hav/QQGZu+DIAmYY8o59j7qBzcrzgDymbr21WZ3NcMvhwXR0keTW0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLqrVb+9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLqrVb+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E062AC433F1;
	Tue, 23 Jan 2024 04:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705984868;
	bh=ydiaEKqGk/zYwexK6yzv2Z6sXqMYYQwc2PODQ/3cRT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eLqrVb+9U+loA7Exrh1sMeqofdgr3FTefrzp9Ur7YpMWuAY7BVaSth6Awf5CgvIGe
	 tFu/z70wDR03btfPn6ZM4ATGRaEcUW8PIVMzPw3HLpj5/rfMX4gQZ7HIlbVYtCGYUU
	 Z75d9VNpDR2WjSYuqulqz78htBcsHA1m34DRJawlAULEYGxNRhzRJRpjkHmRdizAi1
	 cZY86Z//2ifd/dM26MA/vOyInP68HoJUDL0dxvpmJVQifKtWgD2xKyn65rR0MWRaNR
	 34QL1I/DUy+xxmCFlAutaX7YQKVE0HUMGuONPobg/ejXxKmQPtftXY50lrDqIRmysg
	 MF67DWUz9yxdg==
Message-ID: <96007133-162c-4fff-9343-dd88ca520aa7@kernel.org>
Date: Tue, 23 Jan 2024 13:41:05 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] block: refactor disk_update_readahead
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
 <20240122173645.1686078-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Factor out a blk_apply_bdi_limits limits helper that can be used with
> an explicit queue_limits argument, which will be useful later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 06ea91e51b8b2e..e872b0e168525e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -85,6 +85,17 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> +static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
> +		struct queue_limits *lim)
> +{
> +	/*
> +	 * For read-ahead of large files to be effective, we need to read ahead
> +	 * at least twice the optimal I/O size.
> +	 */
> +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);

Nit: while at it, you could replace that division by PAGE_SIZE with a right
shift by PAGE_SHIFT.

Other than that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
> +}
> +
>  /**
>   * blk_queue_bounce_limit - set bounce buffer limit for queue
>   * @q: the request queue for the device
> @@ -393,15 +404,7 @@ EXPORT_SYMBOL(blk_queue_alignment_offset);
>  
>  void disk_update_readahead(struct gendisk *disk)
>  {
> -	struct request_queue *q = disk->queue;
> -
> -	/*
> -	 * For read-ahead of large files to be effective, we need to read ahead
> -	 * at least twice the optimal I/O size.
> -	 */
> -	disk->bdi->ra_pages =
> -		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> -	disk->bdi->io_pages = queue_max_sectors(q) >> (PAGE_SHIFT - 9);
> +	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
>  }
>  EXPORT_SYMBOL_GPL(disk_update_readahead);
>  

-- 
Damien Le Moal
Western Digital Research

