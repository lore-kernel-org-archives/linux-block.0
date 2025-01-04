Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19364A3E
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735963474; cv=none; b=CLzdsfYKytFVYLyWj7voi1u5ktdDDVQtS7GfqsUTEzzHN++a67xpogYEWztaYtXBWQhoXVp4NtQqF86mPfjrgSnt0hnY+FpykPVikz/V9YZ39tcYin+4Cqje+dP94uZtLGeZLmjsS4Yuq+rBUZXoBj1KvjPiOSK6auo/1ilQWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735963474; c=relaxed/simple;
	bh=SkakfseJVYyoadFTDc55xyFfLzZq9gsHUiWANfMzH5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqNNza6V7iqkUBTUNXjmtE8vEbVqaBTjA932XDemkh38q7QOdqtIOAvN2fUf8/Yz2TDRezeeC95C1oD4vLfSi2Bdq041cBsjn/fV6rqBI+byrbwaYmbujVK/QSViU5kF0U4+7qFbT2ZiCmylbsPVwqgG42BQOKvMz5L54FxmBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKcgQSzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKcgQSzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01083C4CED1;
	Sat,  4 Jan 2025 04:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735963474;
	bh=SkakfseJVYyoadFTDc55xyFfLzZq9gsHUiWANfMzH5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKcgQSzFTOy9eg3DD9OW1PHkqZxObrKOjvNF6xKl4TPERnfnCvmWYji+RlsBO1vjs
	 n1LH9z/SJ4AIXXBdpRd1ZIGBQaVuM2phkWsire8S0U3MMjes5HRM30DgSLD2ll1mHW
	 pXiTZRN63N//GewmAYrxgfvSx4LGbEXgcMl2XxhmS3BWEvPSIqkfT7fI9bYKfWIfen
	 H3GLaDOucD9MF0azrljtJhUruGADCpk6UDaW0SKNkHA3StsFStBPi43Nz3T/o81EM2
	 RlOdQci1+wYpWO//u/FPZEuyPhfqdHY1wq55r2b+0XAdV4y+YHlBxfojCy/FtxUA6C
	 ucJ47AydNCW6Q==
Date: Fri, 3 Jan 2025 20:04:32 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
Message-ID: <Z3izUEIPTdvRg5Xe@bombadil.infradead.org>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org>
 <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
 <Z3dFBQIiik6FWLut@fedora>
 <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
 <Z3iTFSBxKY4Z8xZg@bombadil.infradead.org>
 <386a5388-1b1b-4e5a-ad9c-0da1840f12ee@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386a5388-1b1b-4e5a-ad9c-0da1840f12ee@acm.org>

On Fri, Jan 03, 2025 at 06:15:55PM -0800, Bart Van Assche wrote:
> On 1/3/25 5:47 PM, Luis Chamberlain wrote:
> > While that addresses a smaller segment then page size this still leaves
> > open the question of if a dma segment can be larger than page size,
> Hmm ... aren't max_segment_size values that are larger than the page
> size supported since day one of the Linux kernel? Or are you perhaps
> referring to Ming's multi-page bvec patch series that was merged about
> six years ago?

Try aiming high for a single 2 MiB for a single IO on x86_64 on NVMe, that is
currently not possible. At the max 128 NVMe number of DMA segments, and we have
4 KiB per DMA segment, for a 512 KiB IO limit. Should multi-page bvec
enable to lift this?

  Luis
