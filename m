Return-Path: <msnitzer@redhat.com>
Date: Tue, 11 Apr 2017 14:03:58 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 6/6] dm rq: Avoid that request processing stalls
 sporadically
Message-ID: <20170411180358.GA19660@redhat.com>
References: <20170407181654.27836-1-bart.vanassche@sandisk.com>
 <20170407181654.27836-7-bart.vanassche@sandisk.com>
 <20170411160958.GA19222@redhat.com>
 <1491928005.2654.6.camel@sandisk.com>
 <20170411174739.GA19620@redhat.com>
 <1491933092.2654.10.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1491933092.2654.10.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 11 2017 at  1:51pm -0400,
Bart Van Assche <Bart.VanAssche@sandisk.com> wrote:

> On Tue, 2017-04-11 at 13:47 -0400, Mike Snitzer wrote:
> > Other drivers will very likely be caught about by
> > this blk-mq quirk in the future.
> 
> Hello Mike,
> 
> Are you aware that the requirement that blk-mq drivers rerun the queue after
> having returned BLK_MQ_RQ_QUEUE_BUSY is a requirement that is shared with
> traditional block drivers? From dm_old_request_fn():
> 
> 	if (... ||�(ti->type->busy && ti->type->busy(ti))) {
> 		blk_delay_queue(q, 10);
> 		return;
> 	}

No, and pointing to DM code that does something with the old .request_fn
case to justify why blk-mq requires the same is pretty specious.

Rather than working so hard to use DM code against me, your argument
should be: "blk-mq drivers X, Y and Z rerun the hw queue; this is a well
established pattern"

I see drivers/nvme/host/fc.c:nvme_fc_start_fcp_op() does.  But that is
only one other driver out of ~20 BLK_MQ_RQ_QUEUE_BUSY returns
tree-wide.

Could be there are some others, but hardly a well-established pattern.
