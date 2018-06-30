Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39313 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935851AbeF3Blb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 21:41:31 -0400
Date: Fri, 29 Jun 2018 18:41:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [V2, 2/2] scsi: avoid to hold host-wide counter of host_busy for
 scsi_mq
Message-ID: <20180630014129.GB10966@roeck-us.net>
References: <20180624140327.28146-3-ming.lei@redhat.com>
 <20180629162054.GA19036@roeck-us.net>
 <20180630013028.GB12152@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180630013028.GB12152@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jun 30, 2018 at 09:30:30AM +0800, Ming Lei wrote:
> On Fri, Jun 29, 2018 at 09:20:54AM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > On Sun, Jun 24, 2018 at 10:03:27PM +0800, Ming Lei wrote:
> > > It isn't necessary to check the host depth in scsi_queue_rq() any more
> > > since it has been respected by blk-mq before calling scsi_queue_rq() via
> > > getting driver tag.
> > > 
> > > Lots of LUNs may attach to same host, and per-host IOPS may reach millions
> > > level, so we should avoid to this expensive atomic operations on the
> > > hostwide counter in IO path.
> > > 
> > > This patch implemens scsi_host_busy() via blk_mq_tagset_busy_iter() for
> > > reading the count of busy IOs for scsi_mq.
> > > 
> > > It is observed that IOPS is increased by 15% in IO test on scsi_debug
> > > (32 LUNs, 32 submit queues, 1024 can_queue, libaio/dio) in one
> > > dual-socket system.
> > > 
> > 
> > This patch breaks two of my qemu test builds in -next: parisc:defconfig
> > and arm:versatilepb-scsi:versatile_defconfig (which is versatilepb booting
> > from scsi disk). The symptom is the same for both: Boot stalls after scsi
> > bus initialization.
> > 
> > arm:
> > 
> > sym53c8xx 0000:00:0c.0: enabling device (0100 -> 0103)
> > sym0: <895a> rev 0x0 at pci 0000:00:0c.0 irq 66
> > sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
> > sym0: SCSI BUS has been reset.
> > scsi host0: sym-2.2.3
> > random: fast init done
> > [stalls]
> > 
> > parisc:
> > 
> > sym53c8xx 0000:00:00.0: enabling SERR and PARITY (0107 -> 0147)
> > sym0: <895a> rev 0x0 at pci 0000:00:00.0 irq 17
> > sym0: PA-RISC Firmware, ID 7, Fast-40, LVD, parity checking
> > sym0: SCSI BUS has been reset.
> > scsi host0: sym-2.2.3
> > random: fast init done
> > [stalls]
> > 
> > Reverting the patch fixes the problem. Bisect log is attached.
> 
> Please test the patch of 'scsi: fix scsi_host_queue_ready', which has
> been posted on linux-scsi list and CCed to you.
> 
Yes, that fixes the problem. Thanks for the quick turnaround!

Guenter
