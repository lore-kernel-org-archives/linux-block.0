Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Apr 2018 06:48:12 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: "hch@lst.de" <hch@lst.de>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Message-ID: <20180412134812.GW793541@devbig577.frc2.facebook.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
 <20180412053431.GB29881@lst.de>
 <e96f485e61db6a3f9f62ee4f50ff8c469a53bed9.camel@wdc.com>
 <20180412131440.GA5476@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412131440.GA5476@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Apr 12, 2018 at 03:14:40PM +0200, hch@lst.de wrote:
> > At least the SCSI ULP drivers drop the last reference to a disk after
> > the blk_cleanup_queue() call. As explained in the description of commit
> > a063057d7c73, removing a request queue from blkcg must happen before
> > blk_cleanup_queue() finishes because a block driver may free the
> > request queue spinlock immediately after blk_cleanup_queue() returns.
> > So I don't think that we can move the code that removes a request
> > queue from blkcg into put_disk(). Another challenge is that some block
> > drivers (e.g. skd) clear the disk->queue pointer if device_add_disk()
> > has not been called to avoid that put_disk() causes a request queue
> > reference count imbalance.
> 
> Which sounds like a very good reason not to use a driver controller
> lock for internals like blkcq.
> 
> In fact splitting the lock used for synchronizing access to queue
> fields from the driver controller lock used to synchronize I/O
> in the legacy path in long overdue.

It'd be probably a lot easier to make sure the shared lock doesn't go
away till all the request_queues using it go away.  The choice is
between refcnting something which carries the lock and double locking
in hot paths.  Can't think of many downsides of the former approach.

Thanks.

-- 
tejun
