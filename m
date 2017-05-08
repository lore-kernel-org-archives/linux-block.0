Return-Path: <keith.busch@intel.com>
Date: Mon, 8 May 2017 11:11:24 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: remove disk after hw queue is started
Message-ID: <20170508151123.GA463@localhost.localdomain>
References: <20170508112457.10236-1-ming.lei@redhat.com>
 <20170508124638.GD5696@ming.t460p>
 <20170508150720.GB32736@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170508150720.GB32736@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 08, 2017 at 11:07:20AM -0400, Keith Busch wrote:
> I'm almost certain the remove_work shouldn't even be running in this
> case. If the reset work can't transition the controller state correctly,
> it should assume something is handling the controller.

Here's the more complete version of what I had in mind. Does this solve
the reported issue?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd0..46a37fb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1792,7 +1792,7 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_dev_disable(dev, false);
 
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
-		goto out;
+		return;
 
 	result = nvme_pci_enable(dev);
 	if (result)
@@ -1854,7 +1854,7 @@ static void nvme_reset_work(struct work_struct *work)
 
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
 		dev_warn(dev->ctrl.device, "failed to mark controller live\n");
-		goto out;
+		return;
 	}
 
 	if (dev->online_queues > 1)
--
