Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53962747B
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044408; cv=none; b=buJnCZoyB+neeZfd2hJiT3r7+aNKeYPlIMAclVVj03PmWpJnuMl3CDgY5xBBuPrfgLGPgeDdwNPImOBgG/eETZ38zk3C+3dRzuUmgfOEJoHJ71YnxON5GK2y4L3eCCtNeq2Z0OoKJesSeFT8R/HlfQPicMMxEmo5x+6WOofQEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044408; c=relaxed/simple;
	bh=xQjjxcqg1vzdGEnR2jqG3yihsrYr7sfJtUC2Vcq3Sz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfXEegmAc21p4PsMziGCNbdz1jHnMrqDraifOuq2pnIgCE9I+y7qvyc+O9UUTb0pVndlb3FVdiFL4vl7ju/Xmd4mKO0OWCPIzZtoBtO9qOewEQM9U4bFYFibu/eSgaSvoPGnjB7H0ieR6eaFc27Z3PfapDfIzpZSoV6XIJfoc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fSFkmcon; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fSFkmcon"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MV+7km5COX/2ohGeQYg8HVsb3e1EVCJ4eRLjMMEbaDA=; b=fSFkmconyPr+OM+fiWO+nPLB74
	QN8ZdIc3NsxWVDd+LHNXQ7K9qhgb/LFkVjhcMDggMx4lHP3I0QbAxRBeAv5znekDHAHO8+NKWlx2B
	t1A9rWY8FlafCTssG6w5tQJ2e22DFCdecsSZcerUWhUv5h2RbTccvoCW1fYFAVRbayXvXtGgwWePP
	EssG2X6hrE6e/HMHWrRQyHK5KtJe20RxuWpHXTOd1zK0kTTjATEVhJiXKBlMI3p4QcIeFUEItQQrX
	nmLBlIj/quRXqAWk8N9rFrAehJyASp234w1hnlBjBCN6LoV3a8GoupPdzaEDKhQhNTdjUKDdfkvC3
	Aw5YEU0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swhHy-0000000CHTc-0OeK;
	Fri, 04 Oct 2024 12:20:06 +0000
Date: Fri, 4 Oct 2024 05:20:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <Zv_ddkAZhjC9OQyo@infradead.org>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
 <20241004042127.GO11458@google.com>
 <Zv-O9tldIzPfD8ju@infradead.org>
 <20241004074818.GP11458@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004074818.GP11458@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 04, 2024 at 04:48:18PM +0900, Sergey Senozhatsky wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bc5e8c5eaac9..ccd36cb5ada7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -292,6 +292,16 @@ void blk_queue_start_drain(struct request_queue *q)
>  	wake_up_all(&q->mq_freeze_wq);
>  }
>  
> +void blk_queue_disk_dead(struct request_queue *q)
> +{
> +	struct gendisk *disk = q->disk;
> +
> +	if (WARN_ON_ONCE(!test_bit(GD_DEAD, &disk->state)))
> +		return;
> +	/* Make blk_queue_enter() reexamine the GD_DEAD flag. */
> +	wake_up_all(&q->mq_freeze_wq);
> +}

Why is this a separate helper vs just doing the wake_up_all in the
only caller that sets (with the suggested fixup anyway) GD_DEAD?

> +			   blk_queue_dying(q) ||
> +			   test_bit(GD_DEAD, &disk->state));

This needs to check for a NULL disk.  And now that I'm looking at the
code a bit more this makes me worried that checking for q->disk here
sounds like a good way to hit a race with clearing it.  So I fear we
need the other hack variant that sets QUEUE_FLAG_DYING unconditionally
in __blk_mark_disk_dead and then clears it again (for GD_OWNS_QUEUE
only) toward the end of del_gendisk.

