Return-Path: <ming.lei@redhat.com>
Date: Fri, 22 Sep 2017 07:25:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 4/4] scsi-mq: Reduce suspend latency
Message-ID: <20170921232543.GG6854@ming.t460p>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
 <20170921212255.12788-5-bart.vanassche@wdc.com>
 <20170921220652.GD6854@ming.t460p>
 <1506033805.2521.27.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506033805.2521.27.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 10:43:26PM +0000, Bart Van Assche wrote:
> On Fri, 2017-09-22 at 06:06 +0800, Ming Lei wrote:
> > On Thu, Sep 21, 2017 at 02:22:55PM -0700, Bart Van Assche wrote:
> > > +	} else {
> > >  		scsi_run_queue(q);
> > > +		while (atomic_read(&sdev->device_busy)) {
> > > +			msleep_interruptible(200);
> > > +			scsi_run_queue(q);
> > > +		}
> > 
> > Are you sure only blk-mq need to drain queue? We need
> > to do that for block legacy too.
> 
> The code above your comment drains the queue for the legacy block layer.

That is just draining the requests dispatched to SCSI layer, and there
might be lots of requests in block I/O scheduler queue or requeue or
whatever.

-- 
Ming
