Return-Path: <ming.lei@redhat.com>
Date: Mon, 13 Aug 2018 18:48:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH V2 04/17] blk-mq: don't reserve tags for admin queue
Message-ID: <20180813104822.GA18557@ming.t460p>
References: <20180811071220.357-1-ming.lei@redhat.com>
 <20180811071220.357-5-ming.lei@redhat.com>
 <14c6e892-b05f-7422-0fd3-da45a645d3ba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14c6e892-b05f-7422-0fd3-da45a645d3ba@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 13, 2018 at 06:02:18PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 08/11/2018 03:12 PM, Ming Lei wrote:
> > Not necessary to reserve tags for admin queue since there isn't
> > many inflight commands in admin queue usually.
> > 
> > This change won't starve admin queue too because each blocked queue
> > has equal priority to get one new tag when one driver tag is released,
> > no matter it is freed from any queue.
> > 
> 
> We don't count the adminq into tags->active_queues,

Yes, just like without this patchset.

> there maybe following side-effect following:
>  - if send a admin request for the LUN_a, it may cause LUN_b cannot get request even though its
>    budget is allowed. And when the admin request for LUN_a is completed, LUN_b may not be in the
>    first batch to be waked up.
> 
>  - all the LUNs still have to share a limited budget of tags

It is nothing to do with where the admin request is sent, so no any
difference wrt. this issue between with and without this patchset,
right?


Thanks,
Ming
