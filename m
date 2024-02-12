Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F22B9C5;
	Mon, 12 Feb 2024 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722092; cv=none; b=Xwk+AHGsh+n8SMTZUTj0fgIp490rTx18M2Z6L2eH96R234lSbQj9c6WopaHoZ30WryvdSFKZabOvUyEz+JNWtJNes/Qjxt1NX4muBGzxQzpKnMIfF37YKBavucMorHIfCiNCet3WLoRBdH9oKIqQerwxfvn4Ykb1ujKFlCemqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722092; c=relaxed/simple;
	bh=Ruyp/aqRGVYf/y+pWuf+666gtKrZkHSIarRGzQGsj/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdgTf3/KNH/V+PSLNX7gZiDU9Qn4ZsVcDoNRsEgyDRqR4DjN2ggPm4M3q3JeflTPBG7yXLSBi2caIhHxLMAtbRG1CqU3sIoE+N0lDysazdOX1jmR5nKPjZdl7HC0mFEsEKWdqu3d2N90qAZcsG9mR9/fuN8LImX5UyJJ5U3Cunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=py7dt9Et; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="py7dt9Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AD4C433C7;
	Mon, 12 Feb 2024 07:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722091;
	bh=Ruyp/aqRGVYf/y+pWuf+666gtKrZkHSIarRGzQGsj/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=py7dt9Et5yXvGNkxG1iq0OW3q95ZGtQaQb+zaXDEgLf0RUUSS0NBywYfAVFuZY2WD
	 AkqG0aOxRv24zvBQ0AxHUE4QcA1l6c4zwVRhOG9Q+G8tZbkS3oo5zZoqT31iGtJYC0
	 w7xjdc5EWzT4j3ingzLRUsf38DQFK6PTPQEoD9sMafQ1vNna1ZAH9pFe81rrnFQX/2
	 838JWWqlnYmvfGuKMN0rEG+naPZW/Azp0ob5JMcdTYKxDuAm/yzFoyhn1irzFydu8Y
	 VH/oYaryQitAD7NZKLHHoqQmbo49mlkMnkH3K9L1Vomb3HjwYawBhL6+vz+PQQzFO1
	 K0V4SLwdmN1fA==
Message-ID: <74b1ddcc-4249-4b5f-89ef-6ebca70100a2@kernel.org>
Date: Mon, 12 Feb 2024 16:14:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] block: decouple blk_set_stacking_limits from
 blk_set_default_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240212064609.1327143-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/24 15:45, Christoph Hellwig wrote:
> blk_set_stacking_limits uses very little from blk_set_default_limits.
> Open code these initializations in preparation for rewriting
> blk_set_default_limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-settings.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index f16d3fec6658e5..1cae2db41490d2 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -65,13 +65,16 @@ void blk_set_default_limits(struct queue_limits *lim)
>   * blk_set_stacking_limits - set default limits for stacking devices
>   * @lim:  the queue_limits structure to reset
>   *
> - * Description:
> - *   Returns a queue_limit struct to its default state. Should be used
> - *   by stacking drivers like DM that have no internal limits.
> + * Prepare queue limits for applying limits from underlying devices using
> + * blk_stack_limits().
>   */
>  void blk_set_stacking_limits(struct queue_limits *lim)
>  {
> -	blk_set_default_limits(lim);
> +	memset(lim, 0, sizeof(*lim));
> +	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
> +	lim->discard_granularity = 512;

Super minor nit: SECTOR_SIZE would be nice here.

> +	lim->dma_alignment = 511;
> +	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
>  
>  	/* Inherit limits from component devices */
>  	lim->max_segments = USHRT_MAX;

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

