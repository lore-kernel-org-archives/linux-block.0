Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41328 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbcGJD72 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sat, 9 Jul 2016 23:59:28 -0400
Date: Sun, 10 Jul 2016 05:59:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@fb.com,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] nvme: switch to use pci_alloc_irq_vectors
Message-ID: <20160710035926.GD15720@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de> <1467621574-8277-13-git-send-email-hch@lst.de> <20160707193019.GA8802@dhcp-27-118.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160707193019.GA8802@dhcp-27-118.brq.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 07, 2016 at 09:30:19PM +0200, Alexander Gordeev wrote:
> On Mon, Jul 04, 2016 at 05:39:33PM +0900, Christoph Hellwig wrote:
> > @@ -1575,6 +1546,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
> >  		dev->tagset.cmd_size = nvme_cmd_size(dev);
> >  		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
> >  		dev->tagset.driver_data = dev;
> > +		dev->tagset.affinity_mask = to_pci_dev(dev->dev)->irq_affinity;
> >  
> >  		if (blk_mq_alloc_tag_set(&dev->tagset))
> >  			return 0;
> 
> Are there any post-init uses of blk_mq_tag_set::affinity_mask other than
> calling to blk_mq_alloc_tag_set()? If no, blk_mq_tag_set::affinity_mask
> is redundant, since the mask could be passed as a parameter.

We'll have to look at it in the block code when reinitializing rebuilding
the queue topology.  This isn't currently done, but we'll need it rather
soon.
