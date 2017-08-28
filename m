Return-Path: <james_p_freyensee@linux.intel.com>
Message-ID: <1503951680.4860.3.camel@linux.intel.com>
Subject: Re: [PATCH 07/10] nvme: track shared namespaces
From: J Freyensee <james_p_freyensee@linux.intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Jens
	Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Mon, 28 Aug 2017 13:21:20 -0700
In-Reply-To: <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
References: <20170823175815.3646-1-hch@lst.de>
	 <20170823175815.3646-8-hch@lst.de>
	 <bee7c6c3-bf6b-8f7e-ad8f-fd5e238a94ef@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-08-28 at 09:51 +0300, Sagi Grimberg wrote:
> 
> On 23/08/17 20:58, Christoph Hellwig wrote:
> > Introduce a new struct nvme_ns_head [1] that holds information about
> > an actual namespace, unlike struct nvme_ns, which only holds the
> > per-controller namespace information.  For private namespaces there
> > is a 1:1 relation of the two, but for shared namespaces this lets us
> > discover all the paths to it.  For now only the identifiers are moved
> > to the new structure, but most of the information in struct nvme_ns
> > should eventually move over.
> > 
> > To allow lockless path lookup the list of nvme_ns structures per
> > nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> > structure through call_srcu.
> 
> I haven't read the later patches yet, but what requires sleep in the
> path selection?
> 
> > 
> > [1] comments welcome if you have a better name for it, the current one
> > is
> >      horrible.  One idea would be to rename the current struct nvme_ns
> >      to struct nvme_ns_link or similar and use the nvme_ns name for the
> >      new structure.  But that would involve a lot of churn.
> 
> maybe nvme_ns_primary?

Since it looks like it holds all unique identifier values and should hold
other namespace characteristics later, maybe:

nvme_ns_item?
Or nvme_ns_entry?
Or nvme_ns_element?
Or nvme_ns_unit?
Or nvme_ns_entity?
Or nvme_ns_container?

> > +/*
> > + * Anchor structure for namespaces.  There is one for each namespace
> > in a
> > + * NVMe subsystem that any of our controllers can see, and the
> > namespace
> > + * structure for each controller is chained of it.  For private
> > namespaces
> > + * there is a 1:1 relation to our namespace structures, that is ->list
> > + * only ever has a single entry for private namespaces.
> > + */
> > +struct nvme_ns_head {
> > +	struct list_head	list;
> 
> Maybe siblings is a better name than list,
> and the nvme_ns list_head should be called
> sibling_entry (or just sibling)?


I think that sounds good too.


> 
> > +	struct srcu_struct      srcu;
> > +	unsigned		ns_id;
> > +	u8			eui64[8];
> > +	u8			nguid[16];
> > +	uuid_t			uuid;
> > +	struct list_head	entry;
> > +	struct kref		ref;
> > +};
> > +
> >   struct nvme_ns {
> >   	struct list_head list;
> >   
> >   	struct nvme_ctrl *ctrl;
> >   	struct request_queue *queue;
> >   	struct gendisk *disk;
> > +	struct list_head siblings;
> >   	struct nvm_dev *ndev;
> >   	struct kref kref;
> > +	struct nvme_ns_head *head;
> >   	int instance;
> >   
> > -	u8 eui[8];
> > -	u8 nguid[16];
> > -	uuid_t uuid;
> > -
> > -	unsigned ns_id;
> >   	int lba_shift;
> >   	u16 ms;
> >   	u16 sgs;
> > 
> 
> 
