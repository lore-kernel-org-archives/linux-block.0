Return-Path: <keith.busch@intel.com>
Date: Mon, 8 May 2017 11:07:20 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: remove disk after hw queue is started
Message-ID: <20170508150720.GB32736@localhost.localdomain>
References: <20170508112457.10236-1-ming.lei@redhat.com>
 <20170508124638.GD5696@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170508124638.GD5696@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 08, 2017 at 08:46:39PM +0800, Ming Lei wrote:
> On Mon, May 08, 2017 at 07:24:57PM +0800, Ming Lei wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index c8541c3dcd19..ebe13e157c00 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2185,8 +2185,8 @@ static void nvme_remove(struct pci_dev *pdev)
> >  	}
> >  
> >  	flush_work(&dev->reset_work);
> > -	nvme_uninit_ctrl(&dev->ctrl);
> >  	nvme_dev_disable(dev, true);
> > +	nvme_uninit_ctrl(&dev->ctrl);
> >  	nvme_dev_remove_admin(dev);
> >  	nvme_free_queues(dev, 0);
> >  	nvme_release_cmb(dev);
> 
> This patch should be wrong, and looks the correct fix should be
> flushing 'dev->remove_work' before calling nvme_uninit_ctrl().

Yeah, disabling the device before calling "nvme_uninit_ctrl" shouldn't
be required. If you disable the device first, del_gendisk can't flush
dirty data on an orderly removal request.

> But it might cause deadloack by calling flush_work(&dev->remove_work)
> here simply.

I'm almost certain the remove_work shouldn't even be running in this
case. If the reset work can't transition the controller state correctly,
it should assume something is handling the controller.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd0..d81104d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1792,7 +1797,7 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_dev_disable(dev, false);
 
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
-		goto out;
+		return;
 
 	result = nvme_pci_enable(dev);
 	if (result)
--
