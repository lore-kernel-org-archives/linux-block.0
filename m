Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8A1E515
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363560; cv=none; b=uMbFt2dFXA09NHEkI/qNUl2xus7gQ15+buKSFp3xEs8hdOpkc9qb2VFhaWA7wbcGsD1M9/ohsuDmTcOj84oYNkVkF9bl/i78X9f9E0c4NAY78Cdm51ES4sZyhkmgC7oMInb7+VxomBwecZqILV+4NiuZICLpSXQe9NB6uTLWK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363560; c=relaxed/simple;
	bh=49/FqZ2wJzPsEP2SrZYqtKJSXDQny/PrPSPleDh0Ufw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQiZUUO33RN/iRKlqSPPRXmC7d6wsfotYbT47hpPazbto0yDWhzE5eZlYbb7hMoSqqA715npOkE9Yl1ASilz1BSy/Wai0T7rIPCZpl0hribDN1qFGMWYIcZP4qVADfUGdf5dILgSBHQwlRwBHqFgSGIq35ODvWbw0SEmtsoS+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbLzWvGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbLzWvGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83079C4CED3;
	Wed,  8 Jan 2025 19:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736363559;
	bh=49/FqZ2wJzPsEP2SrZYqtKJSXDQny/PrPSPleDh0Ufw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbLzWvGurWhFMXZd/3TSAXxoiAklcDLp4Ush8UsoW6p7Ut36rIrCvSbt9rnGXSdcT
	 U3mQzKzZ8rEjha5amjiHTjz3sIlour93tGad35T6N+ak9en8xSoxi9ItVvQZY8/G9v
	 k1J2vxGj7GDByaa5HyXmq2kV7rvR4WykX7vUN8/vK/k8gTkQAYU84GXNJ7rCvGkLpY
	 a+a1JxfA0mJ5rfy7+IxPQC+RFwCzuE/NpdOYSzMc1HHJyyPOGjTzBVOO3SjbeUvPP+
	 qSR9usTUh5rPdiXmEtGxxXwbR/pjNiR9MDecgrQiSPqbWMJfdRx+EQ5xVp5Y/CkMv9
	 Rw8bSLJIUW+xw==
Date: Wed, 8 Jan 2025 11:12:38 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
Message-ID: <Z37OJnjv6FRyyBJC@bombadil.infradead.org>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org>
 <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
 <Z3dFBQIiik6FWLut@fedora>
 <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
 <Z3iTFSBxKY4Z8xZg@bombadil.infradead.org>
 <386a5388-1b1b-4e5a-ad9c-0da1840f12ee@acm.org>
 <Z3izUEIPTdvRg5Xe@bombadil.infradead.org>
 <Z3nZe3nRS5KyaLzr@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3nZe3nRS5KyaLzr@kbusch-mbp>

On Sat, Jan 04, 2025 at 04:59:39PM -0800, Keith Busch wrote:
> On Fri, Jan 03, 2025 at 08:04:32PM -0800, Luis Chamberlain wrote:
> > On Fri, Jan 03, 2025 at 06:15:55PM -0800, Bart Van Assche wrote:
> > > On 1/3/25 5:47 PM, Luis Chamberlain wrote:
> > > > While that addresses a smaller segment then page size this still leaves
> > > > open the question of if a dma segment can be larger than page size,
> > > Hmm ... aren't max_segment_size values that are larger than the page
> > > size supported since day one of the Linux kernel? Or are you perhaps
> > > referring to Ming's multi-page bvec patch series that was merged about
> > > six years ago?
> > 
> > Try aiming high for a single 2 MiB for a single IO on x86_64 on NVMe, that is
> > currently not possible. At the max 128 NVMe number of DMA segments, and we have
> > 4 KiB per DMA segment, for a 512 KiB IO limit. Should multi-page bvec
> > enable to lift this?
> 
> You need huge pages to guarantee you can reach those transfer sizes in a
> single command. Otherwise you need to get lucky with larger contiguous
> folios, which can certainly happen but it's just not as desterministic.

Now with min-order support, it is deterministic.

  Luis
