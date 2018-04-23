Return-Path: <linux-block-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45418 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeDWXw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Apr 2018 19:52:27 -0400
Date: Tue, 24 Apr 2018 00:52:05 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
 lib/Kconfig
Message-ID: <20180423235205.GH16141@n2100.armlinux.org.uk>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180423170419.20330-12-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 23, 2018 at 07:04:18PM +0200, Christoph Hellwig wrote:
> This way we have one central definition of it, and user can select it as
> needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
> indicate the architecture supports swiotlb at all, so that we can still
> make the usage optional for a few architectures that want this feature
> to be user selectable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hmm, this looks like we end up with NEED_SG_DMA_LENGTH=y on ARM by
default, which probably isn't a good idea - ARM pre-dates the dma_length
parameter in scatterlists, and I don't think all code is guaranteed to
do the right thing if this is enabled.

For example, arch/arm/mach-rpc/dma.c doesn't use the dma_length
member of struct scatterlist.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
