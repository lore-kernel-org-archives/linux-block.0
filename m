Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC015624D
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671293; cv=none; b=lKDSddircwoVaLnv9RjQaFBs7nL1Z4FBgyKPJhDZQTCUXc2AsLIqTpT1sE+H94nk5C+2A3wALYDWL+qaerhSXwpCCAn7URGShSc9xWRdG/CBngY6zTRrtC3O5DrKnxR7dA7vv3Gvr6vJAE5uSPaQ3ovtO1K7twwO7biJ6Ct3pK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671293; c=relaxed/simple;
	bh=ntLWO+iE+1gwrTbfuiL5/pgnoEjVIuVBISOtCd1ajMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9RivzBeCda9H8mDIuIZ1pT3yJSt9yMd3eh2x9khyo3GNv4xMw9jwb0KYUxPJo/dwitg53DpIlb1u2rGNmYvyxLEPVgh4Mf3LkYWyX+5euAU19FIX/eDqCIADD5nIOd5AYEMOujN65LymBXc6fkV5/S0nvacIusbrn5jhpyv6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3i5x3qm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3i5x3qm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729671291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3GXfkHhVEGQSWTQWS/QZ/6RvPfNerfsebO3yq7ox3o=;
	b=G3i5x3qmHGY8VhyATiW1XdJNmtA2icLJMu3L8dLk/2rDbxmydH96CQc/Xo43lGOgVCgu3+
	ZZnFt/aAXCUhbreK2IC7Z9qBox5tvZvc94ZZYlIFRyZDC3CiIm2UHJKZdoe7isRBCezy8k
	n8mn654RVoDafViyztWfhGFvNxDvfBI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-N7DNoR73O8aoXheucPKUwQ-1; Wed,
 23 Oct 2024 04:14:47 -0400
X-MC-Unique: N7DNoR73O8aoXheucPKUwQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0417F1956058;
	Wed, 23 Oct 2024 08:14:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.171])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C0341956088;
	Wed, 23 Oct 2024 08:14:39 +0000 (UTC)
Date: Wed, 23 Oct 2024 16:14:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <ZxiwaupwAkf1u8VE@fedora>
References: <Zw6a7SlNGMlsHJ19@fedora>
 <20241016080419.GA30713@lst.de>
 <Zw958YtMExrNhUxy@fedora>
 <Zxd9XyqqA604F1Rn@arm.com>
 <20241023061233.GA2612@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023061233.GA2612@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Oct 23, 2024 at 08:12:33AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 11:24:31AM +0100, Catalin Marinas wrote:
> > > > We should not allow smaller than cache line alignment on architectures
> > > > that are not cache coherent indeed.
> > 
> > Even on architectures that are not fully coherent, the coherency is a
> > property of the device. You may need to somehow pass this information in
> > struct queue_limits if you want it to be optimal.
> 
> Well, devices set the queue limits.  So this would be a fix in the
> drivers that set the queue limits.  SCSI already does this in the
> midlayer code,

I guess it isn't true:

[linux]# cat /sys/block/sda/queue/dma_alignment
3

> so the main places to fix are nvme und ublk.
> 
> I cant take care of nvme by copying the scsi pattern.
> 
> > That said, the DMA debug code also uses the static L1_CACHE_SHIFT and it
> > will trigger the warning anyway. Some discussion around the DMA API
> > debug came up during the small ARCH_KMALLOC_MINALIGN changes (don't
> > remember it was in private with Robin or on the list). Now kmalloc() can
> > return a small buffer (less than a cache line) that won't be bounced if
> > the device is coherent (see dma_kmalloc_safe()) but the DMA API debug
> > code only checks for direction == DMA_TO_DEVICE, not
> > dev_is_dma_coherent(). For arm64 I did not want to disable small
> > ARCH_KMALLOC_MINALIGN if CONFIG_DMA_API_DEBUG is enabled as this would
> > skew the testing by forcing all allocations to be ARCH_DMA_MINALIGN
> > aligned.
> > 
> > Maybe I'm missing something in those checks but I'm surprised that the
> > DMA API debug code doesn't complain about small kmalloc() buffers on x86
> > (which never had any bouncing for this specific case since it's fully
> > coherent). I suspect people just don't enable DMA debugging on x86 for
> > such devices (typically USB drivers have this issue).
> 
> I don't think there's too many of these indeed.

Usually it is assumed that it is safe to DMA over kmalloc() buffer...

thanks,
Ming

