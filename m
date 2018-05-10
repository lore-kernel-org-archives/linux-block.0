Return-Path: <ming.lei@redhat.com>
Date: Fri, 11 May 2018 04:53:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 6/7] nvme: pci: prepare for supporting error recovery
 from resetting context
Message-ID: <20180510205330.GA3515@ming.t460p>
References: <20180505135905.18815-1-ming.lei@redhat.com>
 <20180505135905.18815-7-ming.lei@redhat.com>
 <031c9974-1ef5-2924-1928-254d8cfdbb71@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <031c9974-1ef5-2924-1928-254d8cfdbb71@broadcom.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 07, 2018 at 08:04:18AM -0700, James Smart wrote:
> 
> 
> On 5/5/2018 6:59 AM, Ming Lei wrote:
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2365,14 +2365,14 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
> >   		nvme_put_ctrl(&dev->ctrl);
> >   }
> > -static void nvme_reset_work(struct work_struct *work)
> > +static void nvme_reset_dev(struct nvme_dev *dev)
> >   {
> > -	struct nvme_dev *dev =
> > -		container_of(work, struct nvme_dev, ctrl.reset_work);
> >   	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
> >   	int result = -ENODEV;
> >   	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
> > +	mutex_lock(&dev->ctrl.reset_lock);
> > +
> >   	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
> >   		goto out;
> 
> I believe the reset_lock is unnecessary (patch 5) as it should be covered by
> the transition of the state to RESETTING which is done under lock.
> 
> Thus the error is:
> instead of:
> ���� if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
> ���� ��� goto out;
> 
> it should be:
> ���� if (dev->ctrl.state != NVME_CTRL_RESETTING))
> ���� ��� return;
> 

Right, I have dropped this patch in V5(not posted yet):

https://github.com/ming1/linux/commits/v4.17-rc-nvme-timeout.V5

Thanks,
Ming
