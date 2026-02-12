Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DEF2E03E4
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891435; cv=none; b=p/AESGQf+JfrU2BmLXAMT87s5sNw3WM7d7VfP6SXeraTSCR3PyksuHBDSeF05boIWjQfsaF45Y3ys1iQpk1rIcjxCDNFwEA3OuuNp3bprQ+nGKbKre1iZtCEPWK+fLeA6W7qOa97bVdASRUj9kk1P2nujg72Wf9NhLFaRpsgGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891435; c=relaxed/simple;
	bh=jqWGrykKjpNLQqZ/erZ8Az5tb+gJHnULAEbIa3nXIVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiyi+2KKayDdPG0G64gEMniKFCnsNau8KtzKXbzjiXA4y0TcPnK4dwSfPY1rYYFzAuCvw3avcvFDajiTcSRZytRwpLSLhYy9Du5yzeF0+FUB2iRipiFesGm6Gh6kVfjNiO6D3k3Fj/2Uy5B7D0gQs4OaRdiGFpok5nQ5D1gDkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2CA868D09; Thu, 12 Feb 2026 11:17:11 +0100 (CET)
Date: Thu, 12 Feb 2026 11:17:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, leon@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix partial IOVA mapping cleanup in
 blk_rq_dma_map_iova
Message-ID: <20260212101711.GA8869@lst.de>
References: <20260211204944.23380-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211204944.23380-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 11, 2026 at 12:49:44PM -0800, Chaitanya Kulkarni wrote:
> When dma_iova_link() fails partway through mapping a request's bvec
> list, the function breaks out of the loop without cleaning up
> already mapped segments. Similarly, if dma_iova_sync() fails after
> linking all segments, no cleanup is performed.
> 
> This leaves partial IOVA mappings in place. The completion path
> attempts to unmap the full expected size via dma_iova_destroy() or
> nvme_unmap_data(), but only a partial size was actually mapped,
> leading to incorrect unmap operations.

Do you have a reproducer for this?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

