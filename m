Return-Path: <ming.lei@redhat.com>
Date: Fri, 2 Mar 2018 08:47:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Don Brace <don.brace@microsemi.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
Message-ID: <20180302004716.GA9200@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-2-ming.lei@redhat.com>
 <633459ac33bf49c9a3ff6e515aa790de@microsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <633459ac33bf49c9a3ff6e515aa790de@microsemi.com>
List-ID: <linux-block@vger.kernel.org>

Hi Don,

Thanks for your test!

On Thu, Mar 01, 2018 at 04:18:17PM +0000, Don Brace wrote:
> > -----Original Message-----
> > From: Ming Lei [mailto:ming.lei@redhat.com]
> > Sent: Tuesday, February 27, 2018 4:08 AM
> > To: Jens Axboe <axboe@kernel.dk>; linux-block@vger.kernel.org; Christoph
> > Hellwig <hch@infradead.org>; Mike Snitzer <snitzer@redhat.com>
> > Cc: linux-scsi@vger.kernel.org; Hannes Reinecke <hare@suse.de>; Arun Easi
> > <arun.easi@cavium.com>; Omar Sandoval <osandov@fb.com>; Martin K .
> > Petersen <martin.petersen@oracle.com>; James Bottomley
> > <james.bottomley@hansenpartnership.com>; Christoph Hellwig <hch@lst.de>;
> > Don Brace <don.brace@microsemi.com>; Kashyap Desai
> > <kashyap.desai@broadcom.com>; Peter Rivera <peter.rivera@broadcom.com>;
> > Laurence Oberman <loberman@redhat.com>; Ming Lei
> > <ming.lei@redhat.com>; Meelis Roos <mroos@linux.ee>
> > Subject: [PATCH V3 1/8] scsi: hpsa: fix selection of reply queue
> > 
> > EXTERNAL EMAIL
> > 
> > 
> > From 84676c1f21 (genirq/affinity: assign vectors to all possible CPUs),
> > one msix vector can be created without any online CPU mapped, then one
> > command's completion may not be notified.
> > 
> > This patch setups mapping between cpu and reply queue according to irq
> > affinity info retrived by pci_irq_get_affinity(), and uses this mapping
> > table to choose reply queue for queuing one command.
> > 
> > Then the chosen reply queue has to be active, and fixes IO hang caused
> > by using inactive reply queue which doesn't have any online CPU mapped.
> > 
> > Cc: Hannes Reinecke <hare@suse.de>
> > Cc: Arun Easi <arun.easi@cavium.com>
> > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> > Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
> > Cc: Christoph Hellwig <hch@lst.de>,
> > Cc: Don Brace <don.brace@microsemi.com>
> > Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> > Cc: Peter Rivera <peter.rivera@broadcom.com>
> > Cc: Laurence Oberman <loberman@redhat.com>
> > Cc: Meelis Roos <mroos@linux.ee>
> > Fixes: 84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> I am getting some issues that need to be tracked down:

I check the patch one more time, not find odd thing, and the only one
is that inside hpsa_do_reset(), wait_for_device_to_become_ready() is
called to send 'test unit ready' always by the reply queue 0. Do you know
if something bad may happen if other non-zero reply queue is used?

Could you share us how you reproduce this issue?

Looks you can boot successfully, so could you please provide the
following output?

1) what is your server type? We may find one in our lab, so that I can
try to reproduce it.

2) lscpu

3) irq affinity info, and you need to pass the 1st column of
'lspci' of your hpsa PCI device to this script:

#!/bin/sh
if [ $# -ge 1 ]; then
    PCID=$1
else
    PCID=`lspci | grep "Non-Volatile memory" | cut -c1-7`
fi
PCIP=`find /sys/devices -name *$PCID | grep pci`
IRQS=`ls $PCIP/msi_irqs`

echo "kernel version: "
uname -a

echo "PCI name is $PCID, dump its irq affinity:"
for IRQ in $IRQS; do
    CPUS=`cat /proc/irq/$IRQ/smp_affinity_list`
    echo "\tirq $IRQ, cpu list $CPUS"
done


Thanks,
Ming
