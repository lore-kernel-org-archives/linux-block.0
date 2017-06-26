Return-Path: <BATV+8132ee8c7e24eb087ca3+5055+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nvme: allocate queues for all possible CPUs
Date: Mon, 26 Jun 2017 12:20:58 +0200
Message-Id: <20170626102058.10200-4-hch@lst.de>
In-Reply-To: <20170626102058.10200-1-hch@lst.de>
References: <20170626102058.10200-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Unlike most drіvers that simply pass the maximum possible vectors to
pci_alloc_irq_vectors NVMe needs to configure the device before allocting
the vectors, so it needs a manual update for the new scheme of using
all present CPUs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 951042a375d6..b3dcd7abc6d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1525,7 +1525,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues, size;
 
-	nr_io_queues = num_online_cpus();
+	nr_io_queues = num_present_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
2.11.0
