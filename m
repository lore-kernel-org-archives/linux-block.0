Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1145220;
	Tue, 23 Jan 2024 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986896; cv=none; b=StZMY3CSwEYu6V4YqVco7dIZhor7M8TjL7WO4Qok7ZuS0f6Ex6F81Fl4x2aTJWMy6RnKYjv09j9vDT1it2qLsL1HskF6VhH4eZVU8MLmhIjCM+AlL5tbPUvKZroPf8L38+p/k+zrzIkmNaejYXhVbsbc6fQyeZ8zg+eLl6RDOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986896; c=relaxed/simple;
	bh=SeDxthAOTwIFhmRZDIowt7SyrKBsfhtYcYm8P7eDFOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHZ9cP7C7s2qVItmkBLbfutNHgVUdMiFBU1auhmNAThjrSJvOAxay+APgC4wmAaXtSrc5gazWNoj5yvG4nFUOL+QeJoPMR8aWhybJ/4nJ3+zP8t5GkDmF39wdkIsN2AUMYns0faj9uGmh/eyDHOAlg94frtVfsPNR27BmgY1hIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ0y6vCD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ0y6vCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D38C433C7;
	Tue, 23 Jan 2024 05:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986896;
	bh=SeDxthAOTwIFhmRZDIowt7SyrKBsfhtYcYm8P7eDFOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EZ0y6vCD6HFvuRmSM7s/RT9DEP3p7gRhTKVYy4+fidZ2Hu/56vVZ1in80rhT1IPde
	 Mz/BDuGECMXYB+VnSD3hQnnr5vzj20uZKGoU6NEauXc0UUSa3LmEKumv7jEBgZoN+n
	 FtPDuN37BqeZOMSEBYio35lkhWbDilu9k7xj93vMz5OKSnwjCgulvtyd5LDsPnr+ed
	 yy5+DhSTlQoBeyYzghqCEWZyYJQs6uZQsSwq4ZtfP1C4LbgMftQ/rLUSFZ/+MGlPCr
	 Ztqvp/ZCUrPr/6Ytzn2pcb2FPj5rkvozgjgc5x6uQe7EQqNQyQm/CfIgTKrME5cSCs
	 i5jF2UPHmzNtQ==
Message-ID: <c0738ba9-2eb8-4997-b357-af481da0a457@kernel.org>
Date: Tue, 23 Jan 2024 14:12:37 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] nvme: remove the hack to not update the discard
 limits in nvme_config_discard
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
 <20240122173645.1686078-7-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Now that the block layer tracks a separate user max discard limit, there
> is no need to prevent nvme from updating it on controller capability
> changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 85ab0fcf9e8864..ef70268dccbc5a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1754,16 +1754,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
>  	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
>  			NVME_DSM_MAX_RANGES);
>  
> -	/*
> -	 * If discard is already enabled, don't reset queue limits.
> -	 *
> -	 * This works around the fact that the block layer can't cope well with
> -	 * updating the hardware limits when overridden through sysfs.  This is
> -	 * harmless because discard limits in NVMe are purely advisory.
> -	 */
> -	if (queue->limits.max_discard_sectors)
> -		return;
> -
>  	blk_queue_max_discard_sectors(queue, max_discard_sectors);

This function references max_user_discard_sectors but that access is done
without holding the queue limits mutex. Is that safe ?

>  	if (ctrl->dmrl)
>  		blk_queue_max_discard_segments(queue, ctrl->dmrl);

-- 
Damien Le Moal
Western Digital Research

