Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CBF1E47A8
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492941; cv=none; b=jjFwM9oHZRp4zor8GWXSpG+iYuK78IpL8oVgP6/5PSALAq0kSO11munaNd1UuxG/dAAy85kDYVH3S5xD1yhdQV4yVulXRkZbMpfhdUsEntoNcX+HPm02aPn/NHU/gBHWLs4XfrtVNT5T+U//Pg9s6AuuvnmEnXQR7r273GyTQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492941; c=relaxed/simple;
	bh=hN5Oh7g37se9bCrh+/d/7sRxh5EUl4pJcygR3ZZdmUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erS/GlIKSTYwiMcqOIX4xknEIXY2yv+S2pOOVcJYN851vJUf2cgqrGLJgompYi636YDQdmr7ZIVRbL5LWHR9S9YawyNjvd2ofXwrf1QWdpY5ihq4DHIDAydA03nKDazIXTJeWJr+MJHZ5sMI66Ez0Jhn+onr/evjN+mVXWftzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2873227A87; Mon, 14 Jul 2025 13:35:34 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:35:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/2] Fix bio splitting in the crypto fallback code
Message-ID: <20250714113534.GA1471@lst.de>
References: <20250711171853.68596-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711171853.68596-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 11, 2025 at 10:18:50AM -0700, Bart Van Assche wrote:
> Hi Jens,
> 
> When using the crypto fallback code, large bios are split twice. A first
> time by bio_split_to_limits() and a second time by the crypto fallback
> code. This causes bios not to be submitted in LBA error and hence triggers
> write errors for zoned block devices. This patch series fixes this by
> splitting bios once. Please consider this patch series for the next merge
> window.

I can't get patch 2 to apply.  What tree is this against?

