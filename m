Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16931717B
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383045; cv=none; b=XB6V2INLYHcdeI16Iw7lD6Tn/dAcCWX2udonWh2edMY968jil1v7MirR0LhCb4nYyOSdpixF7yVX+LOJ69Fcy5G7XnjaI+tbzJ3TePa1cVays4q27odK8lR/6aKxMsjF24NnQfcLs7Im0T83mAKfrS3XYb3FDxQUzWKnPlBIil8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383045; c=relaxed/simple;
	bh=JHOdDhFljM1k1sSBmX7I3426qAR4wbcnLHzu7CPur0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mhx6yE7upya6Yuis/Pfet2eq+B2M+FODO/HVjGIPAjlkOf8rHa7k7wHRhLBvQAg8SVyCzaC6lWUqqSFs/RZ83V2r66+WpIUV6+eb3S1Mi0daAp7LtW8L8M6vILX7snIuXu3FAYrM4sFLkK1vRO3PKpisxRiaU7Sh+5h3z7siS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcXGLGLW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcXGLGLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F6AC19424;
	Tue, 24 Mar 2026 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774383045;
	bh=JHOdDhFljM1k1sSBmX7I3426qAR4wbcnLHzu7CPur0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rcXGLGLWxfCR2P3tnjW1IsvwaHkQA8OmS/I/I3BfhVfIp+PRa9js7D6J/ubgF+9sf
	 0JBRleEO2Vz+TZdqJJcehVyzqBmER3QWSQmqWYxJs/iEMaarIUr/Xp3k9favQ2fkWS
	 GiemVpoIaTSlkFAkpxrXjVW+xhglGGQLeNvgUwu+K+sKoB7ojAtRKgP7N6rdporl8E
	 s1vghnee1AGjy3AGuPyKcbG+T6//RWJANGeuZSx85G9sTb2bBi9eerg0sWh/Q8X9fW
	 JqCaLB7pJX0WsQg0NmbB3SW8NRqe58zXNDGtCytA0ho12zGYpDBqoy6hbVMzORKYHj
	 6zVSJDdVO3uYA==
Message-ID: <5cadb7e4-fce7-4a26-aa85-d968fb368e58@kernel.org>
Date: Tue, 24 Mar 2026 13:10:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] null_blk: Support configuring the maximum segment
 size
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hans Holmberg <hans.holmberg@wdc.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Nilay Shroff <nilay@linux.ibm.com>, Kees Cook <kees@kernel.org>,
 Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260323202904.1248169-1-bvanassche@acm.org>
 <20260323202904.1248169-3-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260323202904.1248169-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/03/23 13:29, Bart Van Assche wrote:
> Add support for configuring the maximum segment size. The maximum segment
> size may be set to a value smaller than the virtual memory page size.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/null_blk/main.c     | 13 +++++++++++++
>  drivers/block/null_blk/null_blk.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 677ac829ef80..bf63431f6820 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -169,6 +169,10 @@ static int g_max_sectors;
>  module_param_named(max_sectors, g_max_sectors, int, 0444);
>  MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>  
> +static unsigned int g_max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +module_param_named(max_segment_size, g_max_segment_size, int, 0444);
> +MODULE_PARM_DESC(max_segment_size, "Maximum size of a segment in bytes");

Maximum size of a DMA segment in bytes ?

(to be consistent with the code comment describing this. "segment" alone is not
clear...)

> +
>  static unsigned int nr_devices = 1;
>  module_param(nr_devices, uint, 0444);
>  MODULE_PARM_DESC(nr_devices, "Number of devices to register");
> @@ -450,6 +454,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
>  NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
>  NULLB_DEVICE_ATTR(blocksize, uint, NULL);
>  NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
> +NULLB_DEVICE_ATTR(max_segment_size, uint, NULL);
>  NULLB_DEVICE_ATTR(irqmode, uint, NULL);
>  NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
>  NULLB_DEVICE_ATTR(index, uint, NULL);
> @@ -608,6 +613,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>  	&nullb_device_attr_index,
>  	&nullb_device_attr_irqmode,
>  	&nullb_device_attr_max_sectors,
> +	&nullb_device_attr_max_segment_size,
>  	&nullb_device_attr_mbps,
>  	&nullb_device_attr_memory_backed,
>  	&nullb_device_attr_no_sched,
> @@ -805,6 +811,7 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->queue_mode = g_queue_mode;
>  	dev->blocksize = g_bs;
>  	dev->max_sectors = g_max_sectors;
> +	dev->max_segment_size = g_max_segment_size;
>  	dev->irqmode = g_irqmode;
>  	dev->hw_queue_depth = g_hw_queue_depth;
>  	dev->blocking = g_blocking;
> @@ -1251,6 +1258,9 @@ static blk_status_t null_transfer(struct nullb *nullb, struct page *page,
>  	unsigned int valid_len = len;
>  	void *p;
>  
> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
> +		  dev->max_segment_size);
> +
>  	p = kmap_local_page(page) + off;
>  	if (!is_write) {
>  		if (dev->zoned) {
> @@ -1298,6 +1308,8 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
>  		len = bvec.bv_len;
> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
> +		bvec.bv_len = len;
>  		if (transferred_bytes + len > max_bytes)
>  			len = max_bytes - transferred_bytes;
>  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
> @@ -1961,6 +1973,7 @@ static int null_add_dev(struct nullb_device *dev)
>  		.logical_block_size	= dev->blocksize,
>  		.physical_block_size	= dev->blocksize,
>  		.max_hw_sectors		= dev->max_sectors,
> +		.max_segment_size	= dev->max_segment_size,
>  		.dma_alignment		= 1,
>  	};
>  
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 6c4c4bbe7dad..43dc47789718 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -93,6 +93,7 @@ struct nullb_device {
>  	unsigned int queue_mode; /* block interface */
>  	unsigned int blocksize; /* block size */
>  	unsigned int max_sectors; /* Max sectors per command */
> +	unsigned int max_segment_size; /* Max size of a single DMA segment. */
>  	unsigned int irqmode; /* IRQ completion handler */
>  	unsigned int hw_queue_depth; /* queue depth */
>  	unsigned int index; /* index of the disk, only valid with a disk */


-- 
Damien Le Moal
Western Digital Research
