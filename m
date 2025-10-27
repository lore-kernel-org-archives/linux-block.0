Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298F2E88BD;
	Mon, 27 Oct 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552707; cv=none; b=qgMxsjI/3KLq6VepsiMuR742Ziuj4mrHubTD+89oAXdRRXMK4xyMUx994dmLzyuQxFqlHw1QR43LUZwDwL9H0kpUNwJcdnnV6QzQwYhSmm+CY2a+TICb8+MsV+QV9L1nxrcP1Woqe2UlszOT6ggWHhbY8p8BgbsBSM0iHDMT1Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552707; c=relaxed/simple;
	bh=LsO/MJw/AJqdqKC7ddkKYCrAbIsh8PHQaAB1Eh6VHBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaU+arnb+iVZtGSwVhxEsstqqA9vJuAenNcdUBl0w+0mHD+zXkU7pP6/L3WBRUNyMkS4JrZesijqwhCvlp7O0cce7R2NKzVz/KfSMdLMTq0WjzUNVhnk0FPO+MDSCf3b2/IvnSxQOBd4pTz87tT53PYCJFsrwTwhr0/1uMV5Npk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV8C839O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV8C839O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A18C113D0;
	Mon, 27 Oct 2025 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761552706;
	bh=LsO/MJw/AJqdqKC7ddkKYCrAbIsh8PHQaAB1Eh6VHBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LV8C839OFzewvtfZUREE/0JxblWlKuETClB1qIvkcOjxUpclNy5TgYKvngOGzMPL2
	 2NRBWiquLHyN1Eov0werOznTjkJoyaeLUw2pJlPPUkBu2WlNcqkpo3UwAFsmNHxp7x
	 9kaiak4v4c6wdPJ+kTzGCAqieit/+cJg2LPfuWaUtvvv1jqHIV3gZQ1oqh4PKhjSSu
	 j/PN4RDWrY8Qr9GA93MnU29MxSQUD/461kWd6OvTOCz5GHlHPetOQbgwR6WnUy72m3
	 8MZbN5KHzPKTGnIm+aq+WT6bcbtEVMq9J4PblkB10lZW8qe9sw4tofl9pD+f0uIRGM
	 DNwJEdnqFrCHw==
Date: Mon, 27 Oct 2025 10:11:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <20251027081142.GG12554@unreal>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <20251027074922.GA14543@lst.de>
 <20251027075738.GF12554@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027075738.GF12554@unreal>

On Mon, Oct 27, 2025 at 09:57:38AM +0200, Leon Romanovsky wrote:
> On Mon, Oct 27, 2025 at 08:49:22AM +0100, Christoph Hellwig wrote:
> > > +	switch (iter.p2pdma.map) {
> > > +	case PCI_P2PDMA_MAP_BUS_ADDR:
> > > +		iod->flags |= IOD_DATA_P2P;
> > > +		break;
> > > +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > > +		iod->flags |= IOD_DATA_MMIO;
> > > +		break;
> > > +	default:
> > > +		return BLK_STS_RESOURCE;
> > 
> > I almost wonder if we should just the pci_p2pdma_map_type values into
> > place.  But that's a future cleanup, I'd rather get this going now.
> 
> I thought about it, but decided to use flags as more space efficient.
> PCI_P2PDMA_MAP_BUS_ADDR == 3 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE == 4.
> It means that will need to occupy 6 bits (extra u8 IOD field), while
> this flags encoding takes only 4 bits (without extra IOD field).

BTW, one can reorganize pci_p2pdma_map_type to make sure that
PCI_P2PDMA_MAP_BUS_ADDR will be 2 and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
will be 3, so it will be possible to take 2 bits per-type instead of 3.

diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 951f81a38f3a..2280e5a55b1f 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -112,14 +112,6 @@ enum pci_p2pdma_map_type {
         */
        PCI_P2PDMA_MAP_NONE,

-       /*
-        * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
-        * traverse the host bridge and the host bridge is not in the
-        * allowlist. DMA Mapping routines should return an error when
-        * this is returned.
-        */
-       PCI_P2PDMA_MAP_NOT_SUPPORTED,
-
        /*
         * PCI_P2PDMA_MAP_BUS_ADDR: Indicates that two devices can talk to
         * each other directly through a PCI switch and the transaction will
@@ -136,6 +128,14 @@ enum pci_p2pdma_map_type {
         * case of IOMMUs) should be used to program the DMA engine.
         */
        PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+
+       /*
+        * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
+        * traverse the host bridge and the host bridge is not in the
+        * allowlist. DMA Mapping routines should return an error when
+        * this is returned.
+        */
+       PCI_P2PDMA_MAP_NOT_SUPPORTED,
 };

 struct pci_p2pdma_map_state {

Thanks
