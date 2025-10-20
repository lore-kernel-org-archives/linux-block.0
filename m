Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E6354AEA;
	Mon, 20 Oct 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946792; cv=none; b=bSrK1dY5Ug//HOnQKsDEGSdlx7C0nkZMM2xsTjYXE9sI0p+i53Sfl6d3POVw07LU8087J6y677tDQuPjS22OE9q1aD5ekPMNExSlCZwkOm+sVlvu8PIgaXsjW1OOEalwBkisjRxuD3cTWx9qehq8ORqSBiwizCpf0N+sZ4mXeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946792; c=relaxed/simple;
	bh=S1V3jsImf5h8yqSk61EYpNQyrAvY2nfUa59BmY7SvuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7ODVf7/0Npmr3s2ruFCEFLuHEck4ilkhO1bZJsu+tQ2mH7vJRWl0BbbXV8HCfgGVSHG1aD63n/wvZtWeo43K6hj2LE33D+JDEHfRSR23xOyrFUYNmtUcPh/lZkib/3bo7zOqiIC1xgraSLyNi++0RscFUn5ONHJqAq1zQEyvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWOAPF4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWOAPF4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647EBC4CEF9;
	Mon, 20 Oct 2025 07:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760946792;
	bh=S1V3jsImf5h8yqSk61EYpNQyrAvY2nfUa59BmY7SvuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWOAPF4w2M5bFzPRH91Jscb0ku1Tp+vIsX2LezRP1KXfSDXDiF0i/t717XDy0r9wG
	 PlYgmnfThQWc9FJXU5zaOCHro4tA2EzTNUrh2GF+29ECi2CUvMWQrRFRASfeSZg/AH
	 PGpu5flxWg+6eMfBveDm4qdsJ4wtbOvEsXI8rkCJIsJbhfVaz2UkYLQ4H6G6CB+LSb
	 xM+DdDI4YwK6avFSvGr+Rbhi8bOLG9ooEPpIiAYzFe0Y0EiZCE3ag4D07jn1xG9MZj
	 zJQmo60urfKRv5f7p6j0ByJJ8z/OPO8YplY3pK+xtacxk9cNIWwxwsPvegH2hjOjt4
	 G3MZH55D/h8Zw==
Date: Mon, 20 Oct 2025 10:53:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-pci: unmap MMIO pages with appropriate interface
Message-ID: <20251020075305.GL6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-2-3f486904db5e@nvidia.com>
 <20251017062008.GB402@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017062008.GB402@lst.de>

On Fri, Oct 17, 2025 at 08:20:08AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:31:59AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Block layer maps MMIO memory through dma_map_phys() interface
> > with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> > that memory with the appropriate unmap function, something which
> > wasn't possible before adding new REQ attribute to block layer in
> > previous patch.
> 
> DMA_ATTR_MMIO only gets set in the following patch as far as I can
> tell.
> 
> The more logical way would be to simply convert to dma_unmap_phys
> here and then add the flag in one go as suggested last round.

Done, thanks
