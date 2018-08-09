Return-Path: <ming.lei@redhat.com>
Date: Thu, 9 Aug 2018 10:52:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 5/9] block: Change the runtime power management
 approach (1/2)
Message-ID: <20180809025204.GC18139@ming.t460p>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
 <20180807225133.27221-6-bart.vanassche@wdc.com>
 <414b8689-f04a-abaa-d659-f29dffed7d3e@oracle.com>
 <6a1acd11-6e71-ea48-d7fc-1e367d4e4dda@oracle.com>
 <2c3fa0fddb9118fb7a5584935fa79b19b062abcb.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2c3fa0fddb9118fb7a5584935fa79b19b062abcb.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 08, 2018 at 05:28:43PM +0000, Bart Van Assche wrote:
> On Wed, 2018-08-08 at 14:43 +0800, jianchao.wang wrote:
> > 
> > On 08/08/2018 02:11 PM, jianchao.wang wrote:
> > > Hi Bart
> > > 
> > > On 08/08/2018 06:51 AM, Bart Van Assche wrote:
> > > > @@ -391,6 +393,9 @@ static struct request *blk_mq_get_request(struct request_queue *q,
> > > >  		}
> > > >  	}
> > > >  	data->hctx->queued++;
> > > > +
> > > > +	blk_pm_add_request(q, rq);
> > > > +
> > > >  	return rq;
> > > >  }
> > > 
> > > The request_queue is in pm_only mode when suspended, who can reach here to do the resume ?
> > 
> > I mean, in the original blk-legacy runtime pm implementation, any new IO could trigger the resume,
> > after your patch set, only the pm request could pass the blk_queue_enter while the queue is suspended
> > and in pm-only mode. But if no resume, where does the pm request come from ?
> > 
> > The blk_pm_add_request should be added to blk_queue_enter.
> > It looks like as following:
> >    1. when an normal io reaches blk_queue_enter, if queue is in suspended mode, it invoke blk_pm_add_request
> >       to trigger the resume, then wait here for the pm_only mode to be cleared.
> >    2. the runtime pm core does the resume work and clear the pm_only more finally
> >    3. the task blocked in blk_queue_enter is waked up and proceed.
> 
> Hello Jianchao,
> 
> Some but not all blk_queue_enter() calls are related to request allocation so

The only one I remember is scsi_ioctl_reset(), in which scsi_autopm_get_host()
is called before allocating this request, that means it is enough to put
host up for handling RESET. Also this request shouldn't have entered the block
request queue.

Or are there other cases in which request allocation isn't related with
blk_queue_enter()?


thanks,
Ming
