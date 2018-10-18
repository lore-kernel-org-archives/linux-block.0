Return-Path: <BATV+8bbc4aa54a9b92872f27+5534+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org
Subject: convert drivers/block to the generic DMA API
Date: Thu, 18 Oct 2018 15:15:10 +0200
Message-Id: <20181018131516.10629-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Switch all remaining users of the legacy PCI DMA API to the
generic DMA API.
