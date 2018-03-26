Return-Path: <keith.busch@intel.com>
Date: Mon, 26 Mar 2018 08:48:09 -0600
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] nvme-pci: Remove unused queue parameter
Message-ID: <20180326144809.GN12909@localhost.localdomain>
References: <20180323221923.24545-1-keith.busch@intel.com>
 <20180323221923.24545-2-keith.busch@intel.com>
 <20180326014706.GC9828@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180326014706.GC9828@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 26, 2018 at 09:47:07AM +0800, Ming Lei wrote:
> On Fri, Mar 23, 2018 at 04:19:22PM -0600, Keith Busch wrote:
> > @@ -1629,9 +1627,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
> >  	int ret = 0;
> >  
> >  	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
> > -		/* vector == qid - 1, match nvme_create_queue */
> > -		if (nvme_alloc_queue(dev, i, dev->q_depth,
> > -		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
> > +		if (nvme_alloc_queue(dev, i, dev->q_depth)) {
> >  			ret = -ENOMEM;
> >  			break;
> >  		}
> 
> nvme_create_io_queues() is called after pci_alloc_irq_vectors() returns,
> and the above pci_irq_get_node() should return the correct node info,
> right?

Right, the return is correct. It's just not being used anymore.
