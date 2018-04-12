Return-Path: <hch@lst.de>
Date: Thu, 12 Apr 2018 15:56:51 +0200
From: "hch@lst.de" <hch@lst.de>
To: "tj@kernel.org" <tj@kernel.org>
Cc: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
	the cgroup controller
Message-ID: <20180412135651.GA6181@lst.de>
References: <20180412015852.26014-1-bart.vanassche@wdc.com> <20180412053431.GB29881@lst.de> <e96f485e61db6a3f9f62ee4f50ff8c469a53bed9.camel@wdc.com> <20180412131440.GA5476@lst.de> <20180412134812.GW793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412134812.GW793541@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 12, 2018 at 06:48:12AM -0700, tj@kernel.org wrote:
> > Which sounds like a very good reason not to use a driver controller
> > lock for internals like blkcq.
> > 
> > In fact splitting the lock used for synchronizing access to queue
> > fields from the driver controller lock used to synchronize I/O
> > in the legacy path in long overdue.
> 
> It'd be probably a lot easier to make sure the shared lock doesn't go
> away till all the request_queues using it go away.  The choice is
> between refcnting something which carries the lock and double locking
> in hot paths.  Can't think of many downsides of the former approach.

We've stopped sharing request_queues between different devices a while
ago.  The problem is just that for legacy devices the driver still controls
the lock life time, and it might be shorter than the queue lifetime.
Note that for blk-mq we basically don't use the queue_lock at all,
and certainly not in the hot path.
