Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeDWRE1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Apr 2018 13:04:27 -0400
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc: x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: centralize SWIOTLB config symbol and misc other cleanups V2
Date: Mon, 23 Apr 2018 19:04:07 +0200
Message-Id: <20180423170419.20330-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

this seris aims for a single defintion of the Kconfig symbol.  To get
there various cleanups, mostly about config symbols are included as well.

Chances since V2 are a fixed s/Reviewed/Signed-Off/ for me, and a few
reviewed-by tags.  I'd like to start merging this into the dma-mapping
tree rather sooner than later given that quite a bit of material for
this series depends on it.
