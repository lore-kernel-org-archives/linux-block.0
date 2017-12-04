Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbdLDQgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 11:36:03 -0500
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: replace PCI_DMA_BUS_IS_PHYS with a per-instance flag
Date: Mon,  4 Dec 2017 08:35:58 -0800
Message-Id: <20171204163601.3055-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

this small series tries to get rid of the global and misnamed
PCI_DMA_BUS_IS_PHYS flag, and replace it with a setting in each
struct dma_map_ops instance.
