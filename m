Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B8EAC5
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663960; cv=none; b=mnQobTVfMFDZVuQeX72cKk8Kr08mlTjSloIddZrHxdN+tPbiVy4POaL9ENEUe71gtDHLzNWVmD9SeoE9Hs+9gisOVvUtbiwfkhUJhPhndAXaLSVDPyKVci4f9gh5WEkFhhgL2CAaJ+fUscgaAtijRrofiZv1mGVAEaULEwmQ/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663960; c=relaxed/simple;
	bh=zYIkbutsUddWS7tXXaoDBuFmdqRB7cN1i62zBK7ktgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX8gHDCYBGRO/ZL2DH/wYDlXU0s72q7qCgR1PXIM8ndry91VXfwD+/owrpISp/qy9BtqGNZBhHJC4sIwraQ3p9TeII3Smk7HyvaZf/19RKAq7PHgkyVjgiD9PE1Tlborxjzah3lLxx4p8CE5T5za8TWASlnl26omSK6z89TzY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C71FB227A87; Wed, 23 Oct 2024 08:12:33 +0200 (CEST)
Date: Wed, 23 Oct 2024 08:12:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <20241023061233.GA2612@lst.de>
References: <Zw6a7SlNGMlsHJ19@fedora> <20241016080419.GA30713@lst.de> <Zw958YtMExrNhUxy@fedora> <Zxd9XyqqA604F1Rn@arm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxd9XyqqA604F1Rn@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 22, 2024 at 11:24:31AM +0100, Catalin Marinas wrote:
> > > We should not allow smaller than cache line alignment on architectures
> > > that are not cache coherent indeed.
> 
> Even on architectures that are not fully coherent, the coherency is a
> property of the device. You may need to somehow pass this information in
> struct queue_limits if you want it to be optimal.

Well, devices set the queue limits.  So this would be a fix in the
drivers that set the queue limits.  SCSI already does this in the
midlayer code, so the main places to fix are nvme und ublk.

I cant take care of nvme by copying the scsi pattern.

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

I don't think there's too many of these indeed.

> So maybe the DMA API debug should have two modes: a generic one that
> catches alignments irrespective of the coherency of the device and
> another that's specific to the device/architecture coherency properties.
> The former, if enabled, should also force a higher minimum kmalloc()
> alignment and a dma_get_cache_alignment() > 1.

Sounds reasonable.

