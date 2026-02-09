Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558D280A5B
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649115; cv=none; b=bbW2wqB8ZZUaKFpCgQoxQ4vJr+5y54lHBQOtvaKG9tUc7OTlZfRWC9ePajYztMBBhDxc3CQKOInm7BkhwXuGBjloNJPuhH4HMq451rTfKY/sMvYykaHgwfPNDBb928c80r5u5ijMTQ3/KhvhQZW3gutQO2lyF54k1Bz0zHp34XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649115; c=relaxed/simple;
	bh=6pH1rYW2NW7b8RF5xRzWg628t2ZAdUKRYAxLe2BJzrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiZ8QeQtxtDUit5GR3YGnBMsWhedSWG7cnwyxKc4dQSBhOZXy/tvvTfasJuNQhzW262vYGtMb+hCkefTRXuPPtBMSuxzmvzkHklaRokhrblfBMu1E2bijLbi43/uQzpyr9je62d8n1sOjqesLsCDNHxlVp8A5cASTbNm64DSpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43BDD68CFE; Mon,  9 Feb 2026 15:58:33 +0100 (CET)
Date: Mon, 9 Feb 2026 15:58:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <20260209145832.GC18315@lst.de>
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-4-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209082953.3053721-4-yukuai@fnnas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 09, 2026 at 04:29:52PM +0800, Yu Kuai wrote:
> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
> When the queue is already frozen before this call (from nvme_start_freeze
> in apple_nvme_disable), the freeze depth becomes 2. The internal unfreeze
> only decrements it to 1, leaving the queue still frozen when
> debugfs_create_files() is called.
> 
> This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
> debugfs_create_files() and risks deadlock.
> 
> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
> so the queue is unfrozen before the call, allowing the internal
> freeze/unfreeze to work correctly.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  drivers/nvme/host/apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 15b3d07f8ccd..1835753ad91a 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1202,8 +1202,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
>  
>  	nvme_unquiesce_io_queues(&anv->ctrl);
>  	nvme_wait_freeze(&anv->ctrl);
> -	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>  	nvme_unfreeze(&anv->ctrl);
> +	blk_mq_update_nr_hw_queues(&anv->tagset, 1);

Looks good on it's own, but it would also good to align the
apple driver with the PCI one here more.

Reviewed-by: Christoph Hellwig <hch@lst.de>
