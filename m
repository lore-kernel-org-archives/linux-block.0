Return-Path: <BATV+21eba84c15e1805462fd+5330+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 28 Mar 2018 01:28:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	javier@cnexlabs.com, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: lightnvm: add late setup of block size and
 metadata
Message-ID: <20180328082825.GB31409@infradead.org>
References: <20180205121505.27563-1-mb@lightnvm.io>
 <20180205121505.27563-5-mb@lightnvm.io>
 <343f19d9-0428-f255-6ed0-519035eef46d@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <343f19d9-0428-f255-6ed0-519035eef46d@lightnvm.io>
List-ID: <linux-block@vger.kernel.org>

I really don't want more lightnvm cruft in the core.  We'll need
a proper abstraction.c

On Fri, Mar 23, 2018 at 12:00:08PM +0100, Matias Bj�rling wrote:
> On 02/05/2018 01:15 PM, Matias Bj�rling wrote:
> > The nvme driver sets up the size of the nvme namespace in two steps.
> > First it initializes the device with standard logical block and
> > metadata sizes, and then sets the correct logical block and metadata
> > size. Due to the OCSSD 2.0 specification relies on the namespace to
> > expose these sizes for correct initialization, let it be updated
> > appropriately on the LightNVM side as well.
> > 
> > Signed-off-by: Matias Bj�rling <mb@lightnvm.io>
> > ---
> >   drivers/nvme/host/core.c     | 2 ++
> >   drivers/nvme/host/lightnvm.c | 8 ++++++++
> >   drivers/nvme/host/nvme.h     | 2 ++
> >   3 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f837d666cbd4..740ceb28067c 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1379,6 +1379,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
> >   	if (ns->noiob)
> >   		nvme_set_chunk_size(ns);
> >   	nvme_update_disk_info(disk, ns, id);
> > +	if (ns->ndev)
> > +		nvme_nvm_update_nvm_info(ns);
> >   #ifdef CONFIG_NVME_MULTIPATH
> >   	if (ns->head->disk)
> >   		nvme_update_disk_info(ns->head->disk, ns, id);
> > diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> > index a9c010655ccc..8d4301854811 100644
> > --- a/drivers/nvme/host/lightnvm.c
> > +++ b/drivers/nvme/host/lightnvm.c
> > @@ -814,6 +814,14 @@ int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
> >   	}
> >   }
> > +void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
> > +{
> > +	struct nvm_dev *ndev = ns->ndev;
> > +
> > +	ndev->identity.csecs = ndev->geo.sec_size = 1 << ns->lba_shift;
> > +	ndev->identity.sos = ndev->geo.oob_size = ns->ms;
> > +}
> > +
> >   int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
> >   {
> >   	struct request_queue *q = ns->queue;
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index ea1aa5283e8e..1ca08f4993ba 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -451,12 +451,14 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
> >   #endif /* CONFIG_NVME_MULTIPATH */
> >   #ifdef CONFIG_NVM
> > +void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
> >   int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
> >   void nvme_nvm_unregister(struct nvme_ns *ns);
> >   int nvme_nvm_register_sysfs(struct nvme_ns *ns);
> >   void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
> >   int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
> >   #else
> > +static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
> >   static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
> >   				    int node)
> >   {
> > 
> 
> Hi Keith,
> 
> When going through the patches for 4.17, I forgot to run this patch by you.
> It is part of adding OCSSD2.0 support to the kernel, and slides in between a
> large refactoring, and the 2.0 part. May I add your reviewed by and let Jens
> pick it up after the nvme patches for 4.17 has gone up?
> 
> Thanks!
> 
> -Matias
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
