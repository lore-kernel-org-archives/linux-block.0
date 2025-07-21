Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660E2D8DD3
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103101; cv=none; b=IYz3WiKf9Z0b3Y2gB21Vp0CjgS+OvbUA35jvhj6+JYc5Zwul1pgc4Vvu9Fwlx9CwYMtfNkMfPWuD8Xfmq+qQ2ZCZN7RFzeVivuDB+ZvW+9xwIPlbT/GTD2qE672z2rL5szUXXGG41DSJonEQ+W+WGWGMBzbxCE2IVE5G3+SAh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103101; c=relaxed/simple;
	bh=EBjBrH5NTb+hOZNndQiFZRDePDIlXgoHaYNN0WBbGgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+WJTf15ADNqZwGjQ8quhfORkVCLD2B0Iq5QbHnRbVcQPelxXsx8KJsjsDs7kf9azM1cx0fMce+Cu5mKYj68s0wZlVaRwrHYy4useWSsOXOJNFC2l3wJkC42AX8wSrhBZp+lz7poGxwGSaJAdFHTbMmpfBbwewlkz49Zi22HaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye795BXf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye795BXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D445C4CEED;
	Mon, 21 Jul 2025 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753103100;
	bh=EBjBrH5NTb+hOZNndQiFZRDePDIlXgoHaYNN0WBbGgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ye795BXfHl7ShFXlDNa1XAwLEqKLlIV7VJQ/nJppy6X2hPslhIJXj0UQxnYy27jiz
	 3gJ5qwJy9ojJUKrC7jtiq6UHznVD2dF1CjxTi+V2uTis0Rx5nc51o7eQxYPDU18W4t
	 cVFbWyjXDYcrm8hn8ZVx1mppwl+revx/eN6mSPlRv182gNHjKuz3X8zg2B4WUrd6ND
	 0OHu6HRKlElZZKZYHYUFAfJVCUlV4ThaVXHjwUuBQBm6Erfn+vC5ozt6cp6N0FpKCW
	 UC7/Gr3pkkkQzWxTty9/yCVq+/2/Zoax3Q6DjOrc+igMoP6bUDaOfl9YYJfTCzpHm3
	 5WT9+SKsc+nHQ==
Message-ID: <4b30df72-72e0-484e-99d5-820af02619d9@kernel.org>
Date: Mon, 21 Jul 2025 22:04:57 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250720113553.913034-1-nilay@linux.ibm.com>
 <20250720113553.913034-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250720113553.913034-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/07/20 20:35, Nilay Shroff wrote:
> When setting up a null block device, we initialize a tagset that
> includes a driver_data field—typically used by block drivers to
> store a pointer to driver-specific data. In the case of null_blk,
> this should point to the struct nullb instance.
> 
> However, due to recent tagset refactoring in the null_blk driver, we
> missed initializing driver_data when creating a shared tagset. As a
> result, software queues (ctx) fail to map correctly to new hardware
> queues (hctx). For example, increasing the number of submit queues
> triggers an nr_hw_queues update, which invokes null_map_queues() to
> remap queues. Since set->driver_data is unset, null_map_queues()
> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
> effectively making the hardware queues unusable for I/O.
> 
> This patch fixes the issue by ensuring that set->driver_data is properly
> initialized to point to the struct nullb during tagset setup.
> 
> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/block/null_blk/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index aa163ae9b2aa..9e1c4ce6fc42 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1854,13 +1854,14 @@ static int null_init_global_tag_set(void)
>  
>  static int null_setup_tagset(struct nullb *nullb)
>  {
> +	nullb->tag_set->driver_data = nullb;
> +

How can this be correct since the tag_set pointer is initialized below ?

>  	if (nullb->dev->shared_tags) {
>  		nullb->tag_set = &tag_set;

Shouldn't you add:

		nullb->tag_set->driver_data = nullb;

here instead ?

>  		return null_init_global_tag_set();
>  	}
>  
>  	nullb->tag_set = &nullb->__tag_set;
> -	nullb->tag_set->driver_data = nullb;
>  	nullb->tag_set->nr_hw_queues = nullb->dev->submit_queues;
>  	nullb->tag_set->queue_depth = nullb->dev->hw_queue_depth;
>  	nullb->tag_set->numa_node = nullb->dev->home_node;


-- 
Damien Le Moal
Western Digital Research
