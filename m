Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D992907
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003782; cv=none; b=DO7vsXokyJuRbKyrX6NHhpKRUQNjjiLGlHY8hupu1IYwPIQt6dBm5Up1kr8U3EFJJPuBWLgRQFLhDPf68AYvlG+2Vn0CAgRMaoGycLVXowow2IcYnB5jlIpYAKYgJdojtLjY0PdEJVqIkigLtVZ1wXBXKH0+zYgSz4wU41pFk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003782; c=relaxed/simple;
	bh=qE2ql7jnHxxLxdU4iU2G1L81ggU4Z4r9ctLaKOLBjs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WunG10MSl305iod32vd4rnoEp8Fs3r7sEg3qMqV8x4b8ufkMMBRSF13rK4pVGR56ghYtuqSD7U1aI/q23Rjn+yAuMCG68wi9LUCL5Ff0ZX/9kCUUjPe1DQ89zQVYT9SbXnJoa86vzo8zm7FRxca+iBVxG61xY1zaute4kTtB+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atXYb89r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atXYb89r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412D7C4CEEF;
	Thu, 31 Jul 2025 23:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754003781;
	bh=qE2ql7jnHxxLxdU4iU2G1L81ggU4Z4r9ctLaKOLBjs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=atXYb89raZ2PCUQZ7zqoovKN3s+dtARHDAdh6mZuFBNvb+m8AZbrsbxs8mjPGfEYx
	 f9M2WfBglclkycKSYeL4anO0QjZKfius+ld3QlsuMIeaYr83Gb7hdJ5WvQa5vuqDuC
	 Y/vwi3a/hpoOToBd9XvI/4lGYXRNGh6sWLuvlcGFTIrUbnqVfiB4VEa6domO4vxo/5
	 gNT6aqONVerNF03AoeHaR9gPqeAlDqxiyUOQvrpOLWDTKLZ+oBluNZOFUq7Hf1H0n8
	 2wbXJkudNOCkHDK5LySWPcK0WjM2dAhGoAu0FI9XIQaaxgLptQa67Z+JvBATpo2epT
	 VDVWuztgaEOWw==
Message-ID: <933aca3c-3a68-46dc-9b01-7bfa0bee06aa@kernel.org>
Date: Fri, 1 Aug 2025 08:16:19 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: fix KASAN use-after-free of tag set
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20250731110745.165751-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250731110745.165751-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/25 20:07, Shin'ichiro Kawasaki wrote:
> When a zoned loop device, or zloop device, is removed, KASAN enabled
> kernel reports "BUG KASAN use-after-free" in blk_mq_free_tag_set(). The
> BUG happens because zloop_ctl_remove() calls put_disk(), which invokes
> zloop_free_disk(). The zloop_free_disk() frees the memory allocated for
> the zlo pointer. However, after the memory is freed, zloop_ctl_remove()
> calls blk_mq_free_tag_set(&zlo->tag_set), which accesses the freed zlo.
> Hence the KASAN use-after-free.
> 
>  zloop_ctl_remove()
>   put_disk(zlo->disk)
>    put_device()
>     kobject_put()
>      ...
>       zloop_free_disk()
>         kvfree(zlo)
>   blk_mq_free_tag_set(&zlo->tag_set)
> 
> To avoid the BUG, move the call to blk_mq_free_tag_set(&zlo->tag_set)
> from zloop_ctl_remove() into zloop_free_disk(). This ensures that
> the tag_set is freed before the call to kvfree(zlo).
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> CC: stable@vger.kernel.org
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
