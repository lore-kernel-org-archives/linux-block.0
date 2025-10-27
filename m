Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F81C6A3;
	Mon, 27 Oct 2025 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553340; cv=none; b=XfjIx8tLz3W5pH5zR5JDhvTj5i6H+1TMHFWiZAkDA8hMS+N0ykRfLKRAFoJ3eB8ePTVozJvNzUlj4yo3qVDqy1EuzcdlZ/M0EHSEb30B39GatD2TkNL3vxyVSvqZ/6NDo7rVKbqcsnABfGr5VOiEshGNWdlP6+lqyqKkdaL6vYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553340; c=relaxed/simple;
	bh=ql+BZhNvD24lFAr0m8oGRVb6NxzFtRyzqioXOwAhNrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQrYa5STIeeR7MQ1tGe/XDLMNvGGcKz+idn5Ofo8bJN3jqCcG7FZtiywHdJYWPQXRIYJEEDUst3WxLaWDb/oFX+jkjWjliopen2RSYcXk1vjmzC53XKZfu16GI4T3pDGG40brVMgSVDPmLu2sDVOWcEREjTyeAW8QKvziaYRKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuP+2aKO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuP+2aKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFD4C4CEF1;
	Mon, 27 Oct 2025 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761553339;
	bh=ql+BZhNvD24lFAr0m8oGRVb6NxzFtRyzqioXOwAhNrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuP+2aKO3ar4pbdjUcaMokMQO54MmE0odQM7D+wdywnTnF0mKUQKYcbcBOawGW6OG
	 Tv3Il0jJq//3vBQRCfwY/5RYESQR1uD1i0r6X5LIviRVSlIWDPr6cVbx0cQMgcKOMN
	 ApWOakX3ku9paZwpZjr7knCtPUh66YwHx1gv8jIb/ElHevhMu9exGzPZG6tlrcnW1J
	 u+l8UV+XPKZhuHEqsy9bez1xS7T+9nqokVY5Rf1aukVTLAo1RlD0kvJDYUAXowsLtn
	 lBR+o0X3Fk5WqpOH+jSQHDwn8jIKvI58mWnRdbtTVL3docQv+X0pNuFOGS9Z1Bsqdi
	 sU8UO/g6yEpeA==
Date: Mon, 27 Oct 2025 10:22:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027082215.GH12554@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <20251027074922.GA14543@lst.de>
 <20251027075738.GF12554@unreal>
 <20251027081142.GG12554@unreal>
 <20251027081658.GA15229@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027081658.GA15229@lst.de>

On Mon, Oct 27, 2025 at 09:16:58AM +0100, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 10:11:42AM +0200, Leon Romanovsky wrote:
> > BTW, one can reorganize pci_p2pdma_map_type to make sure that
> > PCI_P2PDMA_MAP_BUS_ADDR will be 2 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
> > will be 3, so it will be possible to take 2 bits per-type instead of 3.
> 
> Maybe.  I'd be happy to leave this as-is and then see if we can optimize
> things once we grow more users.

Completely agree, thanks for the patience and review.
