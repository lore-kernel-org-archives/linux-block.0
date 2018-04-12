Return-Path: <hch@lst.de>
Date: Thu, 12 Apr 2018 15:14:40 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
	the cgroup controller
Message-ID: <20180412131440.GA5476@lst.de>
References: <20180412015852.26014-1-bart.vanassche@wdc.com> <20180412053431.GB29881@lst.de> <e96f485e61db6a3f9f62ee4f50ff8c469a53bed9.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e96f485e61db6a3f9f62ee4f50ff8c469a53bed9.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 12, 2018 at 11:52:11AM +0000, Bart Van Assche wrote:
> On Thu, 2018-04-12 at 07:34 +0200, Christoph Hellwig wrote:
> > On Wed, Apr 11, 2018 at 07:58:52PM -0600, Bart Van Assche wrote:
> > > Several block drivers call alloc_disk() followed by put_disk() if
> > > something fails before device_add_disk() is called without calling
> > > blk_cleanup_queue(). Make sure that also for this scenario a request
> > > queue is dissociated from the cgroup controller. This patch avoids
> > > that loading the parport_pc, paride and pf drivers triggers the
> > > following kernel crash:
> > 
> > Can we move the cleanup to put_disk in general and not just for
> > this case?  Having alloc/free routines pair up generally avoids
> > a lot of confusion.
> 
> Hello Christoph,
> 
> At least the SCSI ULP drivers drop the last reference to a disk after
> the blk_cleanup_queue() call. As explained in the description of commit
> a063057d7c73, removing a request queue from blkcg must happen before
> blk_cleanup_queue() finishes because a block driver may free the
> request queue spinlock immediately after blk_cleanup_queue() returns.
> So I don't think that we can move the code that removes a request
> queue from blkcg into put_disk(). Another challenge is that some block
> drivers (e.g. skd) clear the disk->queue pointer if device_add_disk()
> has not been called to avoid that put_disk() causes a request queue
> reference count imbalance.

Which sounds like a very good reason not to use a driver controller
lock for internals like blkcq.

In fact splitting the lock used for synchronizing access to queue
fields from the driver controller lock used to synchronize I/O
in the legacy path in long overdue.
