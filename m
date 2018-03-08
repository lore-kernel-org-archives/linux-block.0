Return-Path: <hch@lst.de>
Date: Thu, 8 Mar 2018 08:54:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>,
	Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microsemi.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 7/8] scsi: hpsa: improve scsi_mq performance via
	.host_tagset
Message-ID: <20180308075442.GH15748@lst.de>
References: <20180227100750.32299-1-ming.lei@redhat.com> <20180227100750.32299-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180227100750.32299-8-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> +	/* 256 tags should be high enough to saturate device */
> +	int max_queues = DIV_ROUND_UP(h->scsi_host->can_queue, 256);
> +
> +	/* per NUMA node hw queue */
> +	h->scsi_host->nr_hw_queues = min_t(int, nr_node_ids, max_queues);

I don't think this magic should be in a driver.  The per-node hw_queue
selection seems like something we'd better do in the core code.

Also the whole idea to use nr_hw_queues for just partitioning tag
space on hardware that doesn't really support multiple hardware queues
seems more than odd.
