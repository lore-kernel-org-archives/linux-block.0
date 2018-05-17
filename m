Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 16 May 2018 20:20:31 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180517022030.GB21959@localhost.localdomain>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516231058.GB28727@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

Hi Ming,

I'm developing the answers in code the issues you raised. It will just
take a moment to complete flushing those out. In the meantime just want
to point out why I think block/011 isn't a real test.

On Thu, May 17, 2018 at 07:10:59AM +0800, Ming Lei wrote:
> All simulation in block/011 may happen in reality.

If this test actually simulates reality, then the following one line
patch (plus explanation for why) would be a real "fix" as this is very
successful in passing block/011. :)

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1faa32cd07da..dcc5746304c4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2118,6 +2118,12 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	if (pci_enable_device_mem(pdev))
 		return result;
+	/*
+	 * blktests block/011 disables the device without the driver knowing.
+	 * We'll just enable the device twice to get the enable_cnt > 1
+	 * so that the test's disabling does absolutely nothing.
+	 */
+	pci_enable_device_mem(pdev);
 
 	pci_set_master(pdev);
--
