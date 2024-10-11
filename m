Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7A20B1EE;
	Fri, 11 Oct 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635057; cv=none; b=mazoCJoPXggGQnuoROO+mbGmniaa31Ogcev4K5+7Z+DC/mPMJWlRh0xM8mQHXoQB1TZzcRhpsmLvz2y+JcNjTjgSDnVSr8EaJIVL6+ot3FNaMH/OzifdmuJ+SXEVPMBDbu9KtSbDomcfkLwV47oVgy8y+PiQKqCfPWEAFeN3Yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635057; c=relaxed/simple;
	bh=0k0uuJXxZO1a9p593HtZs9eeYyFF+LZ8Uf+1O9EeATY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHWUteafyvVBanWNImlDbRyle8TQJb4GY5wh5/m1k1iCkfiE53aAqHeBLSypwWmOEPy5XBpRwOnH4PO625elAuU+ora4Cu0pqJ/XUbF2LbzrrV1tYzOY9D/zLfZqWI5qLPQiiHKtpXWAPbQyMQWsBFvAaiOwMdMkXpkJU+UPADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sCU5mGLO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCU5mGLO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=evMOHtTT+WW9a5O0KLtbjpuy1+vqj7vLADFr4AFS7zE=; b=sCU5mGLOm+fIYEzSA7IAca//A4
	+i1MZnFchZH+YvqrOW9WFGS54N374Mi2jqQNGZVumyxEcr2Pnwpb1TeK1xEHaFJd66rp4yDa9Khgo
	d2hEWXH5dSptCII791m3+JhuYRJogSaY0bGe8q6miS5MiOzNj72pjT2mGlTCBO0ne6PKCqqiteJoJ
	RrvWGYykAArDRQWCpbwdiNmohyIOB6SnCWcibQmpqFsvV4AC3J3O6u0C2/ADU83liFKfGXxo/YTLw
	ABGkRshf3i+bgg1+2gz8YrphxIBEKPZTC7q/xL2fUtRMo3mLWwufbkIv900lrDYKcN7pkT5bp6nE+
	WL3SapQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szAwZ-0000000FgHG-13LA;
	Fri, 11 Oct 2024 08:24:15 +0000
Date: Fri, 11 Oct 2024 01:24:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, kernel-team@meta.com,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] elevator: do not request_module if elevator exists
Message-ID: <ZwjgrwSw2vUVP2cp@infradead.org>
References: <20241010141509.4028059-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010141509.4028059-1-leitao@debian.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 10, 2024 at 07:15:08AM -0700, Breno Leitao wrote:
> Whenever an I/O elevator is changed, the system attempts to load a
> module for the new elevator. This occurs regardless of whether the
> elevator is already loaded or built directly into the kernel. This
> behavior introduces unnecessary overhead and potential issues.
> 
> This makes the operation slower, and more error-prone. For instance,
> making the problem fixed by [1] visible for users that doesn't even rely
> on modules being available through modules.
> 
> Do not try to load the ioscheduler if it is already visible.
> 
> This change brings two main benefits: it improves the performance of
> elevator changes, and it reduces the likelihood of errors occurring
> during this process.
> 
> [1] Commit e3accac1a976 ("block: Fix elv_iosched_local_module handling of "none" scheduler")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  block/elevator.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 4122026b11f1..1904e217505a 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -709,13 +709,16 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
>  			    size_t count)
>  {
>  	char elevator_name[ELV_NAME_MAX];
> +	const char *name;
>  
>  	if (!elv_support_iosched(disk->queue))
>  		return -EOPNOTSUPP;
>  
>  	strscpy(elevator_name, buf, sizeof(elevator_name));
> +	name = strstrip(elevator_name);
>  
> -	request_module("%s-iosched", strstrip(elevator_name));
> +	if (!__elevator_find(name))

__elevator_find needs to be called with elv_list_lock.

