Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51460 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeCLHwE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Mar 2018 03:52:04 -0400
Date: Mon, 12 Mar 2018 08:52:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
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
Message-ID: <20180312075202.GB5232@lst.de>
References: <20180309033218.23042-1-ming.lei@redhat.com> <20180309033218.23042-2-ming.lei@redhat.com> <20180310100959.GA32022@lst.de> <20180310150138.GA26361@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180310150138.GA26361@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 10, 2018 at 11:01:43PM +0800, Ming Lei wrote:
> > I really dislike this being open coded in drivers.  It really should
> > be helper chared with the blk-mq map building that drivers just use.
> > 
> > For now just have a low-level blk_pci_map_queues that
> > blk_mq_pci_map_queues, hpsa and megaraid can share.  In the long run
> > it might make sense to change the blk-mq callout to that low-level
> > prototype as well.
> 
> The way for selecting reply queue is needed for non scsi_mq too.

Which still doesn't prevent you from using a common helper.
