Return-Path: <ming.lei@redhat.com>
Date: Fri, 22 Sep 2017 07:53:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 4/4] scsi-mq: Reduce suspend latency
Message-ID: <20170921235327.GH6854@ming.t460p>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
 <20170921212255.12788-5-bart.vanassche@wdc.com>
 <20170921220652.GD6854@ming.t460p>
 <1506033805.2521.27.camel@wdc.com>
 <20170921232543.GG6854@ming.t460p>
 <1506036752.2521.32.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506036752.2521.32.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 21, 2017 at 11:32:33PM +0000, Bart Van Assche wrote:
> On Fri, 2017-09-22 at 07:25 +0800, Ming Lei wrote:
> > On Thu, Sep 21, 2017 at 10:43:26PM +0000, Bart Van Assche wrote:
> > > On Fri, 2017-09-22 at 06:06 +0800, Ming Lei wrote:
> > > > On Thu, Sep 21, 2017 at 02:22:55PM -0700, Bart Van Assche wrote:
> > > > > +	} else {
> > > > >  		scsi_run_queue(q);
> > > > > +		while (atomic_read(&sdev->device_busy)) {
> > > > > +			msleep_interruptible(200);
> > > > > +			scsi_run_queue(q);
> > > > > +		}
> > > > 
> > > > Are you sure only blk-mq need to drain queue? We need
> > > > to do that for block legacy too.
> > > 
> > > The code above your comment drains the queue for the legacy block layer.
> > 
> > That is just draining the requests dispatched to SCSI layer, and there
> > might be lots of requests in block I/O scheduler queue or requeue or
> > whatever.
> 
> There is no requeue list for the legacy block layer. There is only a requeue
> list for blk-mq.
> 
> Waiting for I/O requests that are in scheduler queues is not the purpose of
> scsi_quiesce_device(). The purpose of that function is to wait for requests
> that have already been started. The sdev->device_busy counter represents the
> number of started requests so waiting until that counter has reached zero is
> sufficient.

Then that is simply not enough since the issue is that request pool can
be used up easily when SCSI device is quiesced, then no request is left
for RQF_PREEMPT(PM), and I/O hang is triggered.

It has been discussed for long time, I am sorry you still don't
understand it.

-- 
Ming
