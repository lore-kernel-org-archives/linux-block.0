Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307C136665
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058796; cv=none; b=Z+3asrEzb+R0ywVcmrbN5jVPY7u9OadGGBR1ewWZeTinsWnhe9aIeUVlYtLNcXgUSA/hzNa9uKIwoZglA0Cvbbxxa//8uRDM2fz51AWalALJjnCba2sdmOUnIwW73AlyHFikCh6bvV7pcLevmQ7KCa7uxlwWzy2+g74Jmg/C6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058796; c=relaxed/simple;
	bh=KfpF+a6+4mm3/s4tVOICTjq4PLP2bKJ15yhSQaDB4JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPW3uZe5l4Mk/dPsgivU1hYEfG94VtcU9pkYxzLiPMh0LSeP3UDNTB3OeDjMDcKH/u0uFsSWTiDrAFsEcbcmvEA4iIWWxYfE9BGpdv1St1AauVOgbENpw1yobqivlPczqLKyahY3cC/tPa7NcglUGbdjqasmwW1sMqW86ri0Pnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lh129NPY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lh129NPY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tA2PrzgLK4+8KTgRQ8IZhbM+gZkF2hVK0c+GgUhcVOA=; b=Lh129NPYPR3eULKDE+6U0xzf7T
	r8meDyW5cRMRaLzUWQHO/HMc+KAoUTUsj3vxYSlVMrK8VskSRp+taa8fhArCqdwC6r/a3JQkAOXiE
	pcxXFgIjUykYNHoGARpMouKc7DjkHIjwnwHYDr95pobYphnCEiWO3swuA56nSPx2HhDvt8oN9dBJ8
	iOTc4GY/oPylPd6zljNQLjNvpFoMDTd6esVX8tGokBMieFQhSNkFTlrbltKcuWpm0eze8ZS/017K4
	r7GWr+x82W13u4a30nAaDHo6lbLRASv70leFVDm2Jnd+9yzyjGAN1nurgAsQNjWevo7zlHR/dKMaw
	x7cENDjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnQYV-00000004pcM-0KRu;
	Thu, 21 Mar 2024 22:06:35 +0000
Date: Thu, 21 Mar 2024 15:06:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <Zfyva1pnrDEE5c6D@infradead.org>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321131634.1009972-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 21, 2024 at 09:16:34PM +0800, Ming Lei wrote:
> For any bio with data, its start sector and size have to be aligned with
> the queue's logical block size.
> 
> This rule is obvious, but there is still user which may send unaligned
> bio to block layer, and it is observed that dm-integrity can do that,
> and cause double free of driver's dma meta buffer.
> 
> So failfast unaligned bio from submit_bio_noacct() for avoiding more
> troubles.

I've been wanting to do that for the next merge window, as the lack of
this check is kinda stunning.  Note that we have open coded versions
of it in __blkdev_issue_dicard and blkdev_issue_zeroout that can go
away now.

> +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> +{
> +	unsigned int bs = q->limits.logical_block_size;
> +	unsigned int size = bio->bi_iter.bi_size;

This should just use bdev_logical_block_size() on bio->bi_bdev.
