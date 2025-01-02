Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E628E3F;
	Thu,  2 Jan 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735811387; cv=none; b=EN0QmiDhdwW5F3fejKgTkNB67W2KzqddZNaMEdQB7S2FX2BVBhN1EC3pTt1OvqSTDHsrRwEo1KDEEyRQU8ha4OKC1tgM+36sxqncUwT32QhVIrTYbflaHbFAMy8qBVKP1X2nTPN8YRj2+1rRH/v+/EFcO7wSEd/KQb4aJaRHFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735811387; c=relaxed/simple;
	bh=tXfAAU26K170fcnqh0owN8PXAjsnMTBCFumiGjaOeBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqpbtACp+SFyDlStRog/3fF/TESpqgR6+NUs4uVvZGi5M7M+LwEjzHUom+WQj5j9s5oynOL7Y3Svida0l04dGx4LspDHjlenSI9S34b4KdHkFtc2Q8HzajnLe1Sw4LxQ/PD2umxVdE1TzXO6GcbP76EIbJw/jBY2NsCBsgDEByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jymOAf3D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jymOAf3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2992C4CED6;
	Thu,  2 Jan 2025 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735811387;
	bh=tXfAAU26K170fcnqh0owN8PXAjsnMTBCFumiGjaOeBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jymOAf3D7m3mfa7J4H+4AdQp8u9ITBFukQZjQSGCcf1jCIi+tFh8LUPsn93CKUekn
	 ZV+A3NPZPdfCraH+d/Df8654DTUCWxocnkDuxolncQhl6spIpsAgKyCU6S0/vd+FPo
	 fM+UTBqmZag9Re3Wm509djGWaeGHZGqbHDI/1lMV9dUloHcwcZM5hZ/2pBOCyoPbXD
	 a2QgPtWadwW1B1HFWk37zRFS8bWsstfnpydiYRy7k+2ZSi/vyfWAqp/uu7C3tJlkfG
	 djL+YkI4j1sLsY3lz31p9rzKQ8EhaRP45bHWa57AUvECyfDSI0mBWdfkYR4gBscK2p
	 i06VwGFRO/JNg==
Date: Thu, 2 Jan 2025 10:49:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z3ZhNYHKZPMpv8Cz@ryzen>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217065614.GA19113@lst.de>

Hello Oliver, Christoph,

On Tue, Dec 17, 2024 at 07:56:14AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 17, 2024 at 02:55:23PM +0800, Oliver Sang wrote:
> > from below information, it seems an 'ahci' to me. but since I have limited
> > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > please let us know. thanks a lot!
> 
> Yes, this looks like ahci.  Thanks a lot!

Did this ever get resolved?

I haven't seen a patch that seems to address this.

AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
reordering when issuing a batch of commands, my guess is that the problem
also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
or block layer.


Kind regards,
Niklas
