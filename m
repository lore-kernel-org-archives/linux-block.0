Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582217A5BE;
	Fri, 20 Sep 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840455; cv=none; b=OanzZkUHgbfxVmGfn6V+FbFNBno/yFSvnC3QbK7mQMSTnkT4BTB4WXiXu140VEfVnXznk69rEU8W689Ral00Ce4qjVujf3/6PcInbdQi3AuhkM4H5y56VB1Q1R2vQ4BiJclQn3dFo9H2+NHMLChPWcnfmSoE2e3yaQS7J/GsKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840455; c=relaxed/simple;
	bh=fJQ2/NRHqbnYLN76hZ0RNK+p7U/YMxGNz0ur/MmzG9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV5PvvBMNFQcXef+oHTUKzlEbkowW09WDujNO/fZ/zUAbLq7md4KN6cP4GVtTr1vOOmcI2hUk0xzKg9WIGxufXm/jooOjmBK3Nos63g1hNvBNATIebcFuhj/hIa5rZqu/BhjtkvWlcm5DxbEIRviW3YwZqN1Dd+LYd1tDaS/erw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B034A227AA8; Fri, 20 Sep 2024 15:54:07 +0200 (CEST)
Date: Fri, 20 Sep 2024 15:54:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux@treblig.org
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Remove unused blk_limits_io_{min,opt}
Message-ID: <20240920135406.GA1552@lst.de>
References: <20240920004817.676216-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920004817.676216-1-linux@treblig.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 20, 2024 at 01:48:17AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> blk_limits_io_min and blk_limits_io_opt are unused since the
> recent commit
>   0a94a469a4f0 ("dm: stop using blk_limits_io_{min,opt}")

Yeah, this should have been removed once both the dm and block tree
that had changes in the area got merged, but I forgot about it.

Thanks!

