Return-Path: <ming.lei@redhat.com>
Date: Thu, 8 Mar 2018 18:59:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Don Brace <don.brace@microsemi.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 7/8] scsi: hpsa: improve scsi_mq performance via
 .host_tagset
Message-ID: <20180308105928.GB31062@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-8-ming.lei@redhat.com>
 <20180308075442.GH15748@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308075442.GH15748@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 08, 2018 at 08:54:43AM +0100, Christoph Hellwig wrote:
> > +	/* 256 tags should be high enough to saturate device */
> > +	int max_queues = DIV_ROUND_UP(h->scsi_host->can_queue, 256);
> > +
> > +	/* per NUMA node hw queue */
> > +	h->scsi_host->nr_hw_queues = min_t(int, nr_node_ids, max_queues);
> 
> I don't think this magic should be in a driver.  The per-node hw_queue
> selection seems like something we'd better do in the core code.

The thing is that driver code may need to know if multiple queues are used,
then driver may partition its own resource into multi hw queues, and
improve its .queuecommand and .complete_command. That seems what
megaraid_sas should do in next time.

> 
> Also the whole idea to use nr_hw_queues for just partitioning tag
> space on hardware that doesn't really support multiple hardware queues
> seems more than odd.

The per-node hw queue is used together with BLK_MQ_F_HOST_TAGS, which is
really for improving the single queue case(single tagset). If driver/device
supports real multiple hw queues, they don't need this approach.

Thanks,
Ming
