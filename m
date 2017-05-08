Return-Path: <keith.busch@intel.com>
Date: Mon, 8 May 2017 13:25:12 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: remove disk after hw queue is started
Message-ID: <20170508172511.GA1750@localhost.localdomain>
References: <20170508112457.10236-1-ming.lei@redhat.com>
 <20170508124638.GD5696@ming.t460p>
 <20170508150720.GB32736@localhost.localdomain>
 <20170508151123.GA463@localhost.localdomain>
 <20170508161524.GE5696@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170508161524.GE5696@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 09, 2017 at 12:15:25AM +0800, Ming Lei wrote:
> This patch looks working, but seems any 'goto out' in this function
> may have rick to cause the same race too.

The goto was really intended for handling totally broken contronllers,
which isn't the case if someone requested to remove the pci device while
we're initializing it. Point taken, though, let me run a few tests and
see if there's a better way to handle this condition.

> Another solution I thought of is to kill queues earlier, what do you
> think about the following patch?

That should get it unstuck, but it will error all the IO that fsync_bdev
would probably rather complete successfully.

Question though, why doesn't the remove_work's nvme_kill_queues in
its current place allow forward progress already?
 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c8541c3dcd19..16740e8c4225 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1892,6 +1892,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
>  
>  	kref_get(&dev->ctrl.kref);
>  	nvme_dev_disable(dev, false);
> +	nvme_kill_queues(&dev->ctrl);
>  	if (!schedule_work(&dev->remove_work))
>  		nvme_put_ctrl(&dev->ctrl);
>  }
> @@ -1998,7 +1999,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
>  	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
> -	nvme_kill_queues(&dev->ctrl);
>  	if (pci_get_drvdata(pdev))
>  		device_release_driver(&pdev->dev);
>  	nvme_put_ctrl(&dev->ctrl);
