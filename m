Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1620ED;
	Mon,  3 Jun 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444040; cv=none; b=AkL8mfQGad28RddTdqpCal5kHA7hkfz0IoZZbr2DK4LKa1ZtdNSWQoBUExJxSh95ea/Y3O1f/bLNxKBJRW5TrRS/SOTzjZOOUDmXa9uFtTsttJp57cFM8aJ/S+n1Vwj5wetRpYzC/qpnBjIXuAIXscHDAaSWWXqm+sywWUGALig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444040; c=relaxed/simple;
	bh=v+0RbsfKdGgk/6XvGRknMDTc2wiUcVUl6dcouRw8NJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsZz++ekOgyEsZFwTkJi7ONr/YQ0PYJEeUSb70SPUgiZoTo4s5Vs3o7ZjLqW/iCCJGrZ5RY5VUkr3Vf/ekSq4VuWE1o6gpO2wUHaX20/JjlRhs1PJEu4qrfonZ0CVpFKHvzheTfEvXjsrm0GvCSVm8b/XVSl859VBjJFxumVMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPmyw51K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPmyw51K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F955C2BD10;
	Mon,  3 Jun 2024 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717444039;
	bh=v+0RbsfKdGgk/6XvGRknMDTc2wiUcVUl6dcouRw8NJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPmyw51KfG4g3+7Ei/p0tAOrX7io955hQRR8FthZq/gWvI/n9Z4SxaNt68zwa9g2O
	 6POAii0RDLzdMk6TOEGtP6JwF5VGbu8HblqBBvmbEsCBnq5G9jnhtcvfR9FbQt5J9y
	 ZzilGkhi05j99m90Sc7r6s825ay12VRbAlQT0PBMtVssCYPiCXhQcNhfeAJ1Z0h73D
	 Jj1MTDr0pITf2p+a8k0YPApfPUETkikOq2zpjH++zD/cm2JJxJiRZaQa2+Uuv2tzks
	 wmQnrmI67Ev7VkJhZmKyW1y6pLrq45fYlTzCEDAdFHPdvpqzkjt+Vi3tvASCycWAPE
	 GrirwzVbQAuKQ==
Date: Mon, 3 Jun 2024 13:47:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] null_blk: fix validation of block size
Message-ID: <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
References: <20240603192645.977968-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603192645.977968-1-nmi@metaspace.dk>

On Mon, Jun 03, 2024 at 09:26:45PM +0200, Andreas Hindborg wrote:
> -	dev->blocksize = round_down(dev->blocksize, 512);
> -	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
> +	if (blk_validate_block_size(dev->blocksize) != 0) {
> +		return -EINVAL;
> +	}

No need for the { } brackets for a one-line if.

It also looks like a good idea if this check was just done in
blk_validate_limits() so that each driver doesn't have to do their own
checks. That block function is kind of recent though. Your patch here
looks fine if you want stable back-ports, but I haven't heard any
complaints till recently :)
