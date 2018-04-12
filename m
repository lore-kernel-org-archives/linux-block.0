Return-Path: <hch@lst.de>
Date: Thu, 12 Apr 2018 07:34:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
	the cgroup controller
Message-ID: <20180412053431.GB29881@lst.de>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412015852.26014-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 11, 2018 at 07:58:52PM -0600, Bart Van Assche wrote:
> Several block drivers call alloc_disk() followed by put_disk() if
> something fails before device_add_disk() is called without calling
> blk_cleanup_queue(). Make sure that also for this scenario a request
> queue is dissociated from the cgroup controller. This patch avoids
> that loading the parport_pc, paride and pf drivers triggers the
> following kernel crash:

Can we move the cleanup to put_disk in general and not just for
this case?  Having alloc/free routines pair up generally avoids
a lot of confusion.
