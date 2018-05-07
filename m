Return-Path: <james.smart@broadcom.com>
Return-Path: <james.smart@broadcom.com>
Subject: Re: [PATCH V4 6/7] nvme: pci: prepare for supporting error recovery
 from resetting context
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Laurence Oberman <loberman@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20180505135905.18815-1-ming.lei@redhat.com>
 <20180505135905.18815-7-ming.lei@redhat.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <031c9974-1ef5-2924-1928-254d8cfdbb71@broadcom.com>
Date: Mon, 7 May 2018 08:04:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180505135905.18815-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 5/5/2018 6:59 AM, Ming Lei wrote:
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2365,14 +2365,14 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
>   		nvme_put_ctrl(&dev->ctrl);
>   }
>   
> -static void nvme_reset_work(struct work_struct *work)
> +static void nvme_reset_dev(struct nvme_dev *dev)
>   {
> -	struct nvme_dev *dev =
> -		container_of(work, struct nvme_dev, ctrl.reset_work);
>   	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
>   	int result = -ENODEV;
>   	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
>   
> +	mutex_lock(&dev->ctrl.reset_lock);
> +
>   	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
>   		goto out;
>   

I believe the reset_lock is unnecessary (patch 5) as it should be 
covered by the transition of the state to RESETTING which is done under 
lock.

Thus the error is:
instead of:
      if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
          goto out;

it should be:
      if (dev->ctrl.state != NVME_CTRL_RESETTING))
          return;


-- james
