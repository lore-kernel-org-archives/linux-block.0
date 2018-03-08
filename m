Return-Path: <ming.lei@redhat.com>
Date: Thu, 8 Mar 2018 17:35:47 +0800
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
Subject: Re: [PATCH V3 4/8] blk-mq: introduce BLK_MQ_F_HOST_TAGS
Message-ID: <20180308093546.GC24816@ming.t460p>
References: <20180227100750.32299-1-ming.lei@redhat.com>
 <20180227100750.32299-5-ming.lei@redhat.com>
 <20180308075252.GG15748@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308075252.GG15748@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 08, 2018 at 08:52:52AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 27, 2018 at 06:07:46PM +0800, Ming Lei wrote:
> > This patch can support to partition host-wide tags to multiple hw queues,
> > so each hw queue related data structures(tags, hctx) can be accessed in
> > NUMA locality way, for example, the hw queue can be per NUMA node.
> > 
> > It is observed IOPS can be improved much in this way on null_blk test.
> 
> null_blk isn't too interesting, so some real hardware number would
> be very useful here.

About 10~20% IOPS improvement can be observed on scsi_debug too, which is
setup on one dual-sockets system.

It needs one hpsa or megaraid_sas host with dozens of SSDs, which seems
not easy to setup for me.

And Kashyap is very cooperative to test patches, looks V3 is much
better than before by using per-node hw queue.

If atomic operations on scsi_host->host_busy are removed, and
megaraid_sas IO path can be optimized a bit, we should get some improvement
by per-node hw queue with BLK_MQ_F_HOST_TAGS on megaraid_sas.

> 
> Also the documentation should be a lot less sparse.  When are we going
> to set this flag?  What help are we going to give driver authors to
> guide chosing the option?

OK, will do that in next version.

Thanks,
Ming
