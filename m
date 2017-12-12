Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbdLLPMo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 10:12:44 -0500
Date: Tue, 12 Dec 2017 23:12:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/6] blk-mq: avoid to map CPU into stale hw queue
Message-ID: <20171212151219.GB15078@ming.t460p>
References: <20171212110232.12495-1-ming.lei@redhat.com>
 <20171212110232.12495-5-ming.lei@redhat.com>
 <20171212141243.GA7849@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212141243.GA7849@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 12, 2017 at 03:12:43PM +0100, Christoph Hellwig wrote:
> On Tue, Dec 12, 2017 at 07:02:30PM +0800, Ming Lei wrote:
> > blk_mq_pci_map_queues() may not map one CPU into any hw queue, but its
> > previous map isn't cleared yet, and may point to one stale hw queue
> > index.
> > 
> > This patch fixes the following issue by clearing the mapping table before
> > setting it up in blk_mq_pci_map_queues().
> 
> This needs to be done in the caller intead of the transport specific
> queue map helpers.

OK, there is such issue on other .map_queues() too, such as virtio, ...

Thanks,
Ming
