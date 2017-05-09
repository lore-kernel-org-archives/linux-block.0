Return-Path: <ming.lei@redhat.com>
Date: Tue, 9 May 2017 11:26:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: remove disk after hw queue is started
Message-ID: <20170509032654.GA15037@ming.t460p>
References: <20170508112457.10236-1-ming.lei@redhat.com>
 <20170508124638.GD5696@ming.t460p>
 <20170508150720.GB32736@localhost.localdomain>
 <20170508151123.GA463@localhost.localdomain>
 <20170508161524.GE5696@ming.t460p>
 <20170508172511.GA1750@localhost.localdomain>
 <20170509011025.GA13210@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170509011025.GA13210@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

Hi Keith.

On Tue, May 09, 2017 at 09:10:30AM +0800, Ming Lei wrote:
> Hi Keith,
> 
> Thanks for looking at this issue!
> 
> On Mon, May 08, 2017 at 01:25:12PM -0400, Keith Busch wrote:
> > On Tue, May 09, 2017 at 12:15:25AM +0800, Ming Lei wrote:
> > > This patch looks working, but seems any 'goto out' in this function
> > > may have rick to cause the same race too.
> > 
> > The goto was really intended for handling totally broken contronllers,
> > which isn't the case if someone requested to remove the pci device while
> > we're initializing it. Point taken, though, let me run a few tests and
> > see if there's a better way to handle this condition.
> 
> The thing is that remove can happen any time, either from hotplug or
> unbinding driver or 'echo 1 > $PCI_PATH/remove'. At the same time,
> the reset can be ongoing.
> 
> Also looks the hang in del_gendisk() is fixed by this change, but I
> just found a new issue which is triggered after the NVMe PCI device is rescaned
> again after last remove.
> 
> [  504.135554] VFS: Dirty inode writeback failed for block device nvme0n1p1 (err=-5).
> 
> > 
> > > Another solution I thought of is to kill queues earlier, what do you
> > > think about the following patch?
> > 
> > That should get it unstuck, but it will error all the IO that fsync_bdev
> > would probably rather complete successfully.
> 
> nvme_dev_disable(false) has been completed already before killing queues in
> nvme_remove_dead_ctrl(), so both hw queue is stopped and nvmeq->cq_vector is
> set as -1 in nvme_suspend_queue(). That means no new I/O(include IO in
> fsync_bdev) can be submitted successfully any more, so looks it is reasonable
> to kill queue in nvme_remove_dead_ctrl().
> 
> > 
> > Question though, why doesn't the remove_work's nvme_kill_queues in
> > its current place allow forward progress already?
> 
> That is because .remove_work may not be run before del_gendisk() is
> started even though the .reset_work is flushed, and we can't flush
> .remove_work simply here.

The following patch should be a complete version, and the io stress test
with pci reset/remove has been survived for hours, and previously
the hang can be reproduced in at most half an hour.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..f74cdf8e710f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2097,6 +2097,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 					&nvme_ns_attr_group);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
+
+		/*
+		 * If queue is dead, we have to abort requests in
+		 * requeue list first because fsync_bdev() in removing disk
+		 * path may wait for these IOs, which can't
+		 * be submitted to hardware too.
+		 */
+		if (blk_queue_dying(ns->queue))
+			blk_mq_abort_requeue_list(ns->queue);
 		del_gendisk(ns->disk);
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c8541c3dcd19..661b5ff7c168 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1892,6 +1892,14 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 
 	kref_get(&dev->ctrl.kref);
 	nvme_dev_disable(dev, false);
+
+	/*
+	 * nvme_dev_disable() has suspended queues, then no new I/O
+	 * can be submitted to hardware successfully any more, so
+	 * kill queues now for avoiding race between reset failure
+	 * and remove.
+	 */
+	nvme_kill_queues(&dev->ctrl);
 	if (!schedule_work(&dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
@@ -1998,7 +2006,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	nvme_kill_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
 		device_release_driver(&pdev->dev);
 	nvme_put_ctrl(&dev->ctrl);


Thanks,
Ming
