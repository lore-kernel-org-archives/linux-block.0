Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Apr 2018 07:07:15 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: "hch@lst.de" <hch@lst.de>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Message-ID: <20180412140715.GA793541@devbig577.frc2.facebook.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
 <20180412053431.GB29881@lst.de>
 <e96f485e61db6a3f9f62ee4f50ff8c469a53bed9.camel@wdc.com>
 <20180412131440.GA5476@lst.de>
 <20180412134812.GW793541@devbig577.frc2.facebook.com>
 <20180412135651.GA6181@lst.de>
 <20180412135821.GZ793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412135821.GZ793541@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 12, 2018 at 06:58:21AM -0700, tj@kernel.org wrote:
> Cool, can we just factor out the queue lock from those drivers?  It's
> just really messy to be switching locks like we do in the cleanup
> path.

So, looking at a couple drivers, it looks like all we'd need is a
struct which contains a spinlock and a refcnt.  Switching the drivers
to use that is a bit tedious but straight-forward and the block layer
can simply put that struct on queue release.

Thanks.

-- 
tejun
