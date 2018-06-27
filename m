Return-Path: <ming.lei@redhat.com>
Date: Thu, 28 Jun 2018 07:24:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "drjones@redhat.com" <drjones@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [blk-mq Bug] race on removing hctx->dispatch_wait from wait queue
Message-ID: <20180627232424.GB7583@ming.t460p>
References: <20180624101605.GA32610@ming.t460p>
 <da4a45a9d7764ffee5eea2c6c355dc4b7c23265a.camel@wdc.com>
 <20180625072433.GA23016@ming.t460p>
 <83853e8f-169e-8c0e-a8f5-d830c20158b8@wdc.com>
 <20180627004858.GA9970@ming.t460p>
 <9285867f-1534-ddbe-0f9f-62dff527de4b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9285867f-1534-ddbe-0f9f-62dff527de4b@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 27, 2018 at 01:00:08PM -0700, Bart Van Assche wrote:
> On 06/26/18 17:49, Ming Lei wrote:
> > Only the waitqueue's lock is held for blk_mq_dispatch_wake(), but this
> > hctx->dispatch_wait can be added to another waitqueue, so it isn't
> > enough to just hold waitqueue's lock.
> 
> Hello Ming,
> 
> That makes sense to me. I will post an update that addresses this issue.

I have sent a new patch days ago:

	https://marc.info/?l=linux-block&m=152998658713265&w=2

Thanks,
Ming
