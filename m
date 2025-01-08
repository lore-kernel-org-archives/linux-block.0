Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928021AA1D9
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364731; cv=none; b=BsqCpHBK/7FxjN/KNlEM9iL+g9RSgL24hObXkLpOvUzhzHrZi/Tz9RBpT75Q4M3afAaaBvMTAj4N2450qqCg/UhdHoAyV/nWtED9bWUk4MP9OIMD3AkEBYCwl0hP1dTrv8jEEGyl4jvGpMNy7taW5mmt2/uV/OfN6kXvwfnareo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364731; c=relaxed/simple;
	bh=YZ4Q/E/sQ2Q/z0h2gsvkxQYHC4Nb4GdyFW5EKSiERTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ircRZSZLVAJw4zeK7+wEFUutX9ycFffT7uMYg0sko8RypDxQamuilmWtqKNNCrLV2iWJzC3Ih0pehhWS3JA03XuuMk+dSyjcFgAkpdNSxmRH4figDW7klr39pcwtT5jsyvrjsy9PP5d+ajCwHfmHh3MrEK58MYrDdQ3hwuxQkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On3BdI2w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On3BdI2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4837EC4CED3;
	Wed,  8 Jan 2025 19:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364731;
	bh=YZ4Q/E/sQ2Q/z0h2gsvkxQYHC4Nb4GdyFW5EKSiERTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On3BdI2wqc0DmSOUcdpMX2jNi50drumNNKb7bDi3z6dX/fdgfrHEx44cfCkEiJS3F
	 1X1TuuAANZXjQ4UKWLq3fr4TbCphkED5bmFM744ghWOUeASSRsCtlmRlf54m6fM3V3
	 idllElY7fWFIHFzp5DduJjqPDbRxGfhJEwAbDerqKZIBUJ3/HlyCxm1YFAW7cyh59s
	 mQxTGYC7CIbofg0q4HU7i5MnFi7CwbVNXXXU3Cree9NJi8x6pybeBKIQY0yfGOzC0V
	 4S+d9LAd9nU6ajGzEljZ4xN0WfVA4pvkNlLRTP/4DE6fDbnuH4luojKkc6MrnFFmCm
	 rSOpS3Iv8RfAw==
Date: Wed, 8 Jan 2025 11:32:09 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
Message-ID: <Z37SuaXaw9pBqON0@bombadil.infradead.org>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org>
 <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
 <Z3dFBQIiik6FWLut@fedora>
 <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
 <Z3iTFSBxKY4Z8xZg@bombadil.infradead.org>
 <386a5388-1b1b-4e5a-ad9c-0da1840f12ee@acm.org>
 <Z3izUEIPTdvRg5Xe@bombadil.infradead.org>
 <cbda6cc0-9781-4214-a6fd-e9852141bd64@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbda6cc0-9781-4214-a6fd-e9852141bd64@acm.org>

On Sat, Jan 04, 2025 at 02:30:42PM -0800, Bart Van Assche wrote:
> On 1/3/25 8:04 PM, Luis Chamberlain wrote:
> > Try aiming high for a single 2 MiB for a single IO on x86_64 on NVMe, that is
> > currently not possible. At the max 128 NVMe number of DMA segments, and we have
> > 4 KiB per DMA segment, for a 512 KiB IO limit. Should multi-page bvec
> > enable to lift this?
> 
> 4 KiB per DMA segment for NVMe? I think that the DMA segment size limit for
> PRP and SGL modes is much larger than 4 KiB.

Of course in terms of device capability, I was referring to what we
support in software.

> See also the
> description of the CC.MPS parameter and PRP Lists in the NVMe base
> specification. From a system with an NVMe controller:
> 
> $ cat /sys/block/nvme0n1/queue/max_segment_size
> 4294967295

To enable such things you need either huge pages or large folios, and
for a deterministic large dma segment you can use min-order, my
experimentation shows we have a bit of work to lever really large dma
segments above 64k.

 Luis
