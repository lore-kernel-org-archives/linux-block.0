Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 07:56:32 -0700
From: Tejun Heo <tj@kernel.org>
To: Alexandru Moise <00moses.alexander00@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411145632.GK793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411145123.GJ793541@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

Hello, again.

On Wed, Apr 11, 2018 at 07:51:23AM -0700, Tejun Heo wrote:
> Oh, it wasn't Joseph's change.  It was Bart's fix for a problem
> reported by Joseph.  Bart, a063057d7c73 ("block: Fix a race between
> request queue removal and the block cgroup controller") created a
> regression where a request_queue can be destroyed with blkgs still
> attached.  The original report is..
> 
>  http://lkml.kernel.org/r/20180407102148.GA9729@gmail.com

And looking at the change, it looks like the right thing we should
have done is caching @lock on the print_blkg side and when switching
locks make sure both locks are held.  IOW, do the following in
blk_cleanup_queue()

	spin_lock_irq(lock);
	if (q->queue_lock != &q->__queue_lock) {
		spin_lock(&q->__queue_lock);
		q->queue_lock = &q->__queue_lock;
		spin_unlock(&q->__queue_lock);
	}
	spin_unlock_irq(lock);

Otherwise, there can be two lock holders thinking they have exclusive
access to the request_queue.

Thanks.

-- 
tejun
