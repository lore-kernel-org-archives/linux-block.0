Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1A6FCA;
	Mon, 12 Feb 2024 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722683; cv=none; b=FiiKQBlmLYgy0DeJuU/oQcatv7y7nvYepv2GamWnBrxZ6re2+Jlw2+iBG4ZO91dzSLvL8D+ohgXANwbpY/RELVtaOkLtmR3GRAsCLBVxplDfl8ItziUU7Oq/Ltmct5Ee7eAZWlcWtCKXIJMm1u5+zDaS2ow4yO8i+DY01n76fuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722683; c=relaxed/simple;
	bh=+Gv/VC5NcWqqN18JSwFFw7Fat9gAWSXTSwmPjBcFj+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozFf9rVDzDGdvC00I1HYjkZfFaD0lle0dxGUMRrKbZYOrhV+BFRYN+ZduYYN40jWzJ6yjl3XsC539x71qzm7fuVlPdIYQmSz7cgzDvSXHuXInpmr/vmQpQ9O7IXsi/cDGPanSYu17eeaLam2dRsUyB6lkKmYWHnvdDAtsxuOAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOzqJq7M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOzqJq7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDDEC433C7;
	Mon, 12 Feb 2024 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707722683;
	bh=+Gv/VC5NcWqqN18JSwFFw7Fat9gAWSXTSwmPjBcFj+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YOzqJq7MEx89Uid+NYxhbdV1hR2XUZyL1Eu2D+0iew02XLCVIrBFKA48KU7p/2Xq7
	 LfJDC8aB5S/gqjyI5SOyyjBZxqWxYascqCl8IeXn6OtKUTaKYCBGORy3OxSP2NxiGm
	 i/Pesv0hmYvVy+viEmNoi1pPtvyeWcF49iVYc4EZKm4Bvf+T9td4H0yQPcT3HIlCNU
	 /4vd6yiqDGQ+JPTLnRafemp9y8GPein7GNeYRCRi15yUDAcbZQlSBbYefQO4ObZKRV
	 rQtwsK7SID+p/05V1tKvAXC9F542GXMecBO9T9IZSAtL6Ixl/wRxKb56WdWuFNhBqT
	 HDeCfqi+NLWkg==
Message-ID: <e1061d81-ca74-4b56-b87d-4f6660340093@kernel.org>
Date: Mon, 12 Feb 2024 16:24:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue limits
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
 <20240212064609.1327143-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240212064609.1327143-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/24 15:45, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.  Also use the low-level
> validation helper to implement blk_set_default_limits instead of
> duplicating the initialization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       |   1 +
>  block/blk-settings.c   | 228 ++++++++++++++++++++++++++++++++++-------
>  block/blk.h            |   4 +-
>  include/linux/blkdev.h |  23 +++++
>  4 files changed, 218 insertions(+), 38 deletions(-)

[...]

> +	/*
> +	 * Random default for the maximum number of sectors.  Driver should not

s/sectors/segments ?

> +	 * rely on this and set their own.
> +	 */
> +	if (!lim->max_segments)
> +		lim->max_segments = BLK_MAX_SEGMENTS;

Other than the above, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

