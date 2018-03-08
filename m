Return-Path: <hch@lst.de>
Date: Thu, 8 Mar 2018 08:52:52 +0100
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
Subject: Re: [PATCH V3 4/8] blk-mq: introduce BLK_MQ_F_HOST_TAGS
Message-ID: <20180308075252.GG15748@lst.de>
References: <20180227100750.32299-1-ming.lei@redhat.com> <20180227100750.32299-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180227100750.32299-5-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 27, 2018 at 06:07:46PM +0800, Ming Lei wrote:
> This patch can support to partition host-wide tags to multiple hw queues,
> so each hw queue related data structures(tags, hctx) can be accessed in
> NUMA locality way, for example, the hw queue can be per NUMA node.
> 
> It is observed IOPS can be improved much in this way on null_blk test.

null_blk isn't too interesting, so some real hardware number would
be very useful here.

Also the documentation should be a lot less sparse.  When are we going
to set this flag?  What help are we going to give driver authors to
guide chosing the option?
