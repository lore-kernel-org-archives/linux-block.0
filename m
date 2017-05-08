Return-Path: <ming.lei@redhat.com>
Date: Tue, 9 May 2017 00:15:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: remove disk after hw queue is started
Message-ID: <20170508161524.GE5696@ming.t460p>
References: <20170508112457.10236-1-ming.lei@redhat.com>
 <20170508124638.GD5696@ming.t460p>
 <20170508150720.GB32736@localhost.localdomain>
 <20170508151123.GA463@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170508151123.GA463@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 08, 2017 at 11:11:24AM -0400, Keith Busch wrote:
> On Mon, May 08, 2017 at 11:07:20AM -0400, Keith Busch wrote:
> > I'm almost certain the remove_work shouldn't even be running in this
> > case. If the reset work can't transition the controller state correctly,
> > it should assume something is handling the controller.
> 
> Here's the more complete version of what I had in mind. Does this solve
> the reported issue?
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 26a5fd0..46a37fb 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1792,7 +1792,7 @@ static void nvme_reset_work(struct work_struct *work)
>  		nvme_dev_disable(dev, false);
>  
>  	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> -		goto out;
> +		return;
>  
>  	result = nvme_pci_enable(dev);
>  	if (result)
> @@ -1854,7 +1854,7 @@ static void nvme_reset_work(struct work_struct *work)
>  
>  	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
>  		dev_warn(dev->ctrl.device, "failed to mark controller live\n");
> -		goto out;
> +		return;
>  	}
>  
>  	if (dev->online_queues > 1)

This patch looks working, but seems any 'goto out' in this function
may have rick to cause the same race too.

Another solution I thought of is to kill queues earlier, what do you
think about the following patch?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c8541c3dcd19..16740e8c4225 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1892,6 +1892,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 
 	kref_get(&dev->ctrl.kref);
 	nvme_dev_disable(dev, false);
+	nvme_kill_queues(&dev->ctrl);
 	if (!schedule_work(&dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
@@ -1998,7 +1999,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	nvme_kill_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
 		device_release_driver(&pdev->dev);
 	nvme_put_ctrl(&dev->ctrl);


Thanks,
Ming
