Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F62202981
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660068; cv=none; b=FHq8l6LrDPVGKFPxRdxluAkWQmJ6QV+USf0BAgMN/Lay5/OLsBz1FAhDgf15lhXNyE+WXOQzu/IjS0Irmo7XEDoiJIyfVx36hbl0btZMlrlNrU8i3iTwl3txkMkRmflzyDYDVG9mT0H5DVqUOB2hTT2s1x2TFv383YtxPkXvq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660068; c=relaxed/simple;
	bh=jt3O5IPQHNammy3/MrnhUEdQ/0Oy5mhawihvpVMuoyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqLwtJXmoFAUZMvw6ej41B7innPRHIYsFJ9V8hjKyiIFo2+jv55w+rrGVxOi1wz2wNMuumjCynA4Wf2PbYD360GLFhsY4nxHBlIV69RgERwj+5687eLF+3E8cwAHyuhry7mSL01X2bzF7jUA44Zxv17umbYi8J1bUOVLB4x+1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6ci2n/C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6ci2n/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A548BC4CEE3;
	Wed, 11 Jun 2025 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660066;
	bh=jt3O5IPQHNammy3/MrnhUEdQ/0Oy5mhawihvpVMuoyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6ci2n/CZ2HGKJ+ktuqs22I3wHoDuPwE4Uuv1oF86ldfKSPpkZIIN42DWBIqHUWZ3
	 v4jm68qNpnLzq2fNKdcQvlQ/V4lARwMPAPXoqNVkY9TUNgSSYDmLSR1QM2zXsSc9Go
	 ax/NNTTrqTny0QKqRYiijnpk8NO4v8SVlntffrzy7J6kiliclqL2H2vAYCzyXaL8pq
	 Tw2hfaJb7yXml5ff2MK7n8887f+FzS8Nq7pFFg6NHrZS4qvbUzJy00EC1ZvmhnoLz1
	 Nsr24m7oh1IJHfmGJoRmC83bZdtbMq4CVxwuEcSBfhKhWY0uHF3rROVyXXbKoKISxL
	 b7iF2y8yMFkRw==
Date: Wed, 11 Jun 2025 10:41:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aEmxn0K6m34HsZeN@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
 <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de>
 <aEmuG1dUDGuci7VW@kbusch-mbp>
 <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>

On Wed, Jun 11, 2025 at 10:39:17AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2025-06-11 10:26, Keith Busch wrote:
> > If I recall correctly, the PCIe ACS features will default redirect
> > everything up to the root-complex when you have the IOMMU on. A device
> > can set its memory request TLP's Address Type field to have the switch
> > direct the transaction directly to a peer device instead, but how does
> > the nvme device know how to set the it memory request's AT field?
> > There's nothing that says a command's addresses are untranslated IOVAs
> > vs translated peer addresses, right?  Lacking some mechanism to specify
> > what kind of address the nvme controller is dealing with, wouldn't you
> > be forced to map peer addresses with the IOMMU, having P2P transactions
> > make a round trip through it only using mapped IOVAs?
> 
> That is all correct. In order to use P2P on a switch, with the IOMMU
> enabled, it is currently required to disable ACS for the devices in
> question. This is done with the command line parameter disable_acs_redir
> or config_acs.

Is there some other mechansim that ensures a host memory mapped IOVA
doesn't collide with a PCI bus address then?
