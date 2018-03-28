Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39704 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbeC1Ufg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Mar 2018 16:35:36 -0400
Date: Wed, 28 Mar 2018 14:38:03 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Block <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] nvme-pci: Separate IO and admin queue IRQ vectors
Message-ID: <20180328203803.GL13039@localhost.localdomain>
References: <20180327153908.3732-1-keith.busch@intel.com>
 <20180327153908.3732-3-keith.busch@intel.com>
 <20180328073214.GA18726@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180328073214.GA18726@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 28, 2018 at 09:32:14AM +0200, Christoph Hellwig wrote:
> On Tue, Mar 27, 2018 at 09:39:08AM -0600, Keith Busch wrote:
> > -	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
> > +	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev),
> > +				     dev->num_vecs > 1);
> 
> Can you turn this into:
> 
> -	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
> 			     dev->num_vecs > 1 ? 1 /* admin queue */ : 0);
> 
> no functional change, but much easier to understand.
> 
> Except for that the whole series looks good:

Sounds good, thanks for the reviews, Christoph and Ming.

Updated with your suggestion and applied (Jens picked up the blk-mq part;
nvme-4.17 is rebased to that).
