Return-Path: <ming.lei@redhat.com>
Date: Wed, 27 Sep 2017 13:37:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 5/7] scsi: Reduce suspend latency
Message-ID: <20170927053718.GA5988@ming.t460p>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
 <20170925202924.16603-6-bart.vanassche@wdc.com>
 <20170926222322.GA8050@ming.t460p>
 <1506481279.2822.5.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506481279.2822.5.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 27, 2017 at 03:43:11AM +0000, Bart Van Assche wrote:
> On Wed, 2017-09-27 at 06:23 +0800, Ming Lei wrote:
> >         mutex_lock(&sdev->state_mutex);
> >         err = scsi_device_set_state(sdev, SDEV_QUIESCE);
> >         if (err == 0)
> >                 blk_set_preempt_only(q, true);
> >         mutex_unlock(&sdev->state_mutex);
> > 
> >         if (err)
> >                 return err;
> > 
> >         blk_mq_freeze_queue(q);
> >         blk_mq_unfreeze_queue(q);
> > 
> > Any requests allocated before scsi_device_set_state() and
> > dispatched after scsi_device_set_state() can't be drained up
> > any more, then blk_mq_freeze_queue() will wait forever for the
> > drain up, so not only this patchset can't fix the current quiesce
> > issue, but also introduces new I/O hang in scsi_device_quiesce().
> 
> That's a good catch, but fortunately this is very easy to fix: move the
> blk_mq_freeze_queue() call before the mutex_lock() and scsi_device_set_state()
> calls. The error path will also need some adjustment.

I am also working towards that direction, patches have been ready.

-- 
Ming
