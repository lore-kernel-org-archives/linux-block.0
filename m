Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4F1BC2A
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644636; cv=none; b=nt8QXzje1R113DXkysk7RBo66TixB2CUgMZgnEHxpUV3xddCZPoWRESkgWqTBV6JvKUMWD7tD+Cyk2Hf3DU5hEpA9TgnAI1ILqhqTcxXo/Kf3mO1yOEwPizGcvBoP4l+9VyvDheHdpnOjui9aNC8GmkbtIz3evAR9nTLGWOSMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644636; c=relaxed/simple;
	bh=9qibEFW/evOMzfhyLCyvZehu9vzNcz0uu6BXH2Sn4/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3s6YhHRmq7ukADeUUSWO8Pjp3ErSWgITQQaAl1e2Cz95n+u/5mii6QjRFY8apK0NcuOs+VegsZmx0rgdHvf7BgO40nSkDUOTo6ImCXkwZ9C172llCzNtBGTGcrZPKw0PpKhl0BtG5Tz5xunv3oesht+X8Yay/0I9kHf4YjcacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AhXIlqVT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhXIlqVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729644632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCIPWAYsWQe3LnjMcaSzI757XbaKVycxBmIthwX6+qY=;
	b=AhXIlqVTHwxw8+KwGtgBGJU4XG2NJGnkicO2tFvfI548rABriMh9FHmIdEvf1u1c5MORvn
	iBWzDfPBjj3ScUNUXG7qQiCEuQ7i05T307VgkLojhczwh8Hr8UzkY3Kr+Z4NuiYmsDciW6
	3RS18geYB0ywcov2IY9H2O+xooGbAAg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-JCF2p18YNg6MvGwTPszn8A-1; Tue,
 22 Oct 2024 20:50:29 -0400
X-MC-Unique: JCF2p18YNg6MvGwTPszn8A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6EFE195608F;
	Wed, 23 Oct 2024 00:50:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2D7119560AE;
	Wed, 23 Oct 2024 00:50:22 +0000 (UTC)
Date: Wed, 23 Oct 2024 08:50:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <ZxhISRqy8q2Cp8f8@fedora>
References: <Zw6a7SlNGMlsHJ19@fedora>
 <20241016080419.GA30713@lst.de>
 <Zw958YtMExrNhUxy@fedora>
 <Zxd9XyqqA604F1Rn@arm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxd9XyqqA604F1Rn@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Oct 22, 2024 at 11:24:31AM +0100, Catalin Marinas wrote:
> On Wed, Oct 16, 2024 at 04:31:45PM +0800, Ming Lei wrote:
> > On Wed, Oct 16, 2024 at 10:04:19AM +0200, Christoph Hellwig wrote:
> > > On Wed, Oct 16, 2024 at 12:40:13AM +0800, Ming Lei wrote:
> > > > Turns out host controller's DMA alignment is often too relax, so two DMA
> > > > buffers may cross same cache line easily, and trigger the warning of
> > > > "cacheline tracking EEXIST, overlapping mappings aren't supported".
> > > > 
> > > > The attached test code can trigger the warning immediately with CONFIG_DMA_API_DEBUG
> > > > enabled when reading from one scsi disk which queue DMA alignment is 3.
> > > 
> > > We should not allow smaller than cache line alignment on architectures
> > > that are not cache coherent indeed.
> 
> Even on architectures that are not fully coherent, the coherency is a
> property of the device. You may need to somehow pass this information in
> struct queue_limits if you want it to be optimal.

Yeah, looks the issue has to be fixed from driver side, only driver has
'struct device' info.

> 
> > Yes, something like the following change:
> > 
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index a446654ddee5..26bd0e72c68e 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -348,7 +348,9 @@ static int blk_validate_limits(struct queue_limits *lim)
> >  	 */
> >  	if (!lim->dma_alignment)
> >  		lim->dma_alignment = SECTOR_SIZE - 1;
> > -	if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
> > +	else if (lim->dma_alignment < L1_CACHE_BYTES - 1)
> > +		lim->dma_alignment = L1_CACHE_BYTES - 1;
> > +	else if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
> >  		return -EINVAL;
> 
> L1_CACHE_BYTES is not the right check here since a level 2/3 cache may
> have a larger cache line than level 1 (and we have such configurations
> on arm64 where ARCH_DMA_MINALIGN is 128 and L1_CACHE_BYTES is 64). Use
> dma_get_cache_alignment() instead. On fully coherent architectures like
> x86 it should return 1.
> 
> That said, the DMA debug code also uses the static L1_CACHE_SHIFT and it
> will trigger the warning anyway. Some discussion around the DMA API
> debug came up during the small ARCH_KMALLOC_MINALIGN changes (don't
> remember it was in private with Robin or on the list). Now kmalloc() can
> return a small buffer (less than a cache line) that won't be bounced if
> the device is coherent (see dma_kmalloc_safe()) but the DMA API debug
> code only checks for direction == DMA_TO_DEVICE, not
> dev_is_dma_coherent(). For arm64 I did not want to disable small
> ARCH_KMALLOC_MINALIGN if CONFIG_DMA_API_DEBUG is enabled as this would
> skew the testing by forcing all allocations to be ARCH_DMA_MINALIGN
> aligned.
> 
> Maybe I'm missing something in those checks but I'm surprised that the
> DMA API debug code doesn't complain about small kmalloc() buffers on x86
> (which never had any bouncing for this specific case since it's fully
> coherent). I suspect people just don't enable DMA debugging on x86 for
> such devices (typically USB drivers have this issue).

I did see report on warning of "cacheline tracking EEXIST, overlapping mappings
aren't supported" on USB several times, since it is often treated as same with
this one.

> 
> So maybe the DMA API debug should have two modes: a generic one that
> catches alignments irrespective of the coherency of the device and
> another that's specific to the device/architecture coherency properties.
> The former, if enabled, should also force a higher minimum kmalloc()
> alignment and a dma_get_cache_alignment() > 1.

Or dma debug log needs to be improved by showing the warning is just a
hint.


Thanks,
Ming

