Return-Path: <ming.lei@redhat.com>
Date: Wed, 28 Feb 2018 23:21:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microsemi.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via
 .host_tagset
Message-ID: <20180228152124.GA28612@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-9-ming.lei@redhat.com>
 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 28, 2018 at 08:28:48PM +0530, Kashyap Desai wrote:
> Ming -
> 
> Quick testing on my setup -  Performance slightly degraded (4-5% drop)for
> megaraid_sas driver with this patch. (From 1610K IOPS it goes to 1544K)
> I confirm that after applying this patch, we have #queue = #numa node.
> 
> ls -l
> /sys/devices/pci0000:80/0000:80:02.0/0000:83:00.0/host10/target10:2:23/10:
> 2:23:0/block/sdy/mq
> total 0
> drwxr-xr-x. 18 root root 0 Feb 28 09:53 0
> drwxr-xr-x. 18 root root 0 Feb 28 09:53 1

OK, thanks for your test.

As I mentioned to you, this patch should have improved performance on
megaraid_sas, but the current slight degrade might be caused by
scsi_host_queue_ready() in scsi_queue_rq(), I guess.

With .host_tagset enabled and use per-numa-node hw queue, request can be
queued to lld more frequently/quick than single queue, then the cost of
atomic_inc_return(&host->host_busy) may be increased much meantime,
think about millions of such operations, and finally slight IOPS drop
is observed when the hw queue depth becomes half of .can_queue.

> 
> 
> I would suggest to skip megaraid_sas driver changes using shared_tagset
> until and unless there is obvious gain. If overall interface of using
> shared_tagset is commit in kernel tree, we will investigate (megaraid_sas
> driver) in future about real benefit of using it.

I'd suggest to not merge it until it is proved that performance can be
improved in real device.

I will try to work to remove the expensive atomic_inc_return(&host->host_busy)
from scsi_queue_rq(), since it isn't needed for SCSI_MQ, once it is done, will
ask you to test again.


Thanks,
Ming
