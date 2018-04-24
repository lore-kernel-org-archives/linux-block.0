Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57424 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751089AbeDXGyW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 02:54:22 -0400
Date: Tue, 24 Apr 2018 08:55:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to
        lib/Kconfig
Message-ID: <20180424065549.GA18468@lst.de>
References: <20180423170419.20330-1-hch@lst.de> <20180423170419.20330-12-hch@lst.de> <20180423235205.GH16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180423235205.GH16141@n2100.armlinux.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 24, 2018 at 12:52:05AM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 23, 2018 at 07:04:18PM +0200, Christoph Hellwig wrote:
> > This way we have one central definition of it, and user can select it as
> > needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
> > indicate the architecture supports swiotlb at all, so that we can still
> > make the usage optional for a few architectures that want this feature
> > to be user selectable.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Hmm, this looks like we end up with NEED_SG_DMA_LENGTH=y on ARM by
> default, which probably isn't a good idea - ARM pre-dates the dma_length
> parameter in scatterlists, and I don't think all code is guaranteed to
> do the right thing if this is enabled.

We shouldn't end up with NEED_SG_DMA_LENGTH=y on ARM by default.
It is only select by ARM_DMA_USE_IOMMU before the patch, and it will
now also be selected by SWIOTLB, which for arm is never used or seleted
directly by anything but xen-swiotlb.

Then again looking at the series there shouldn't be any need to
even select NEED_SG_DMA_LENGTH for swiotlb, as we'll never merge segments,
so I'll fix that up.
