Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0221E8358
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659167; cv=none; b=JHYAm8SFNnxCXwG/vvg7s19cqurB9Qd/FS0c1bSrH/py1RT+NCMQ6iO1UOB3g7DlG1j4gHI66Jhzt+mdBa9dKo9zLxLynOZcwBpJiiiLvZVpQtoGlCuU/DrN49wItsmNNGHWJCXiQjHZx0IE8Wb8amJsG2MIOpzx+jedxhr+9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659167; c=relaxed/simple;
	bh=fKCue/QRAGLJEvsZ48ApXivr3PElq2mFF2q18ziSqeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wsc6aXWqivHLp3u51yoATjfT/S/AndLL8vsn2vsIhW7FJJerYdRG1F14b58UYgtLV//n5d2a3svQ4Wy7Tb6+kH1cEzVxe35dJdaMZGRnme45ycOqocT5tRM4/ZA89Mzb4PvEmHRg7ZKVLWhSQzM0nrIvHG5idjWoMl86b8KCGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1tcDAkU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1tcDAkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F112C4CEE3;
	Wed, 11 Jun 2025 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659166;
	bh=fKCue/QRAGLJEvsZ48ApXivr3PElq2mFF2q18ziSqeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1tcDAkUdPJ8BLQiFMQqrOoJlInDmXRG40dxIRDrTuna8Wm1UOs9VNUZpdTo62mm7
	 4P3xKc01nGq35CE11qepOwBQ8aKO/lTo2C/7NqmB2Ww+y0u/m7Eefp39KlxyqNAff9
	 H/pE8vi6X5NliSRGC/GbaYZiB/CGFHnyIIW2L7VlAJVbwsnezI+hm3u/2eLeg2ekTq
	 niJrrHie2h1T3B2kl17ZTHlYSXZG0IC6ko99lFj8FiLBbeNf9d3butB94yhsLi6C7x
	 Qx9ihtcZbnXBFyCO+WRqUZytAZdw6AVAdWVEchGJz9rb4JkM9MfpWpj5AtifJ3XE//
	 YVuR0+ywOsypw==
Date: Wed, 11 Jun 2025 10:26:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aEmuG1dUDGuci7VW@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
 <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611034316.GA2869@lst.de>

On Wed, Jun 11, 2025 at 05:43:16AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 09:37:30AM -0600, Keith Busch wrote:
> > I may be out of the loop here. Is this an optimization to make something
> > easier for the DMA layer?
> 
> Yes.  P2P that is based on a bus address (i.e. using a switch) uses
> a completely different way to DMA MAP than the normal IOMMU or
> direct mapping.  So the optimization of collapsing all host physical
> addresses into an iova can't work once it is present.
> 
> > I don't think there's any fundamental reason
> > why devices like nvme couldn't handle a command that uses memory mixed
> > among multiple devices and/or host memory, at least.
> 
> Sure, devices don't even see if an IOVA is P2P or not, this is all
> host side.

Sorry for my ignorant questions here, but I'm not sure how this setup
(P2P transactions with switches and IOMMU enabled) actually works and
would like to understand better.

If I recall correctly, the PCIe ACS features will default redirect
everything up to the root-complex when you have the IOMMU on. A device
can set its memory request TLP's Address Type field to have the switch
direct the transaction directly to a peer device instead, but how does
the nvme device know how to set the it memory request's AT field?
There's nothing that says a command's addresses are untranslated IOVAs
vs translated peer addresses, right?  Lacking some mechanism to specify
what kind of address the nvme controller is dealing with, wouldn't you
be forced to map peer addresses with the IOMMU, having P2P transactions
make a round trip through it only using mapped IOVAs?
