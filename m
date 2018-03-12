Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751384AbeCLJT0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Mar 2018 05:19:26 -0400
Date: Mon, 12 Mar 2018 17:19:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH V4 1/4] scsi: hpsa: fix selection of reply queue
Message-ID: <20180312091908.GC23903@ming.t460p>
References: <20180309033218.23042-1-ming.lei@redhat.com>
 <20180309033218.23042-2-ming.lei@redhat.com>
 <20180310100959.GA32022@lst.de>
 <20180310150138.GA26361@ming.t460p>
 <20180312075202.GB5232@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312075202.GB5232@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 12, 2018 at 08:52:02AM +0100, Christoph Hellwig wrote:
> On Sat, Mar 10, 2018 at 11:01:43PM +0800, Ming Lei wrote:
> > > I really dislike this being open coded in drivers.  It really should
> > > be helper chared with the blk-mq map building that drivers just use.
> > > 
> > > For now just have a low-level blk_pci_map_queues that
> > > blk_mq_pci_map_queues, hpsa and megaraid can share.  In the long run
> > > it might make sense to change the blk-mq callout to that low-level
> > > prototype as well.
> > 
> > The way for selecting reply queue is needed for non scsi_mq too.
> 
> Which still doesn't prevent you from using a common helper.

The only common code is the following part:

+       for (queue = 0; queue < instance->msix_vectors; queue++) {
+               mask = pci_irq_get_affinity(instance->pdev, queue);
+               if (!mask)
+                       goto fallback;
+
+               for_each_cpu(cpu, mask)
+                       instance->reply_map[cpu] = queue;
+       }

For megraraid_sas, the fallback code need to handle mapping in the
following way for legacy vectors:

       for_each_possible_cpu(cpu)
               instance->reply_map[cpu] = cpu % instance->msix_vectors;


So not sure if it is worth of a common helper, given there may not be
potential users of the helper.

Thanks,
Ming
