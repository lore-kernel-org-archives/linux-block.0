Return-Path: <hch@lst.de>
Date: Mon, 2 Oct 2017 18:14:33 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v4 4/7] block: Add the QUEUE_FLAG_PREEMPT_ONLY request
	queue flag
Message-ID: <20171002161433.GA11022@lst.de>
References: <20170925202924.16603-1-bart.vanassche@wdc.com> <20170925202924.16603-5-bart.vanassche@wdc.com> <20171002134755.GA7571@lst.de> <1506959767.3368.18.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506959767.3368.18.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 02, 2017 at 03:56:08PM +0000, Bart Van Assche wrote:
> Since queue_flag_set() and queue_flag_clear() use non-atomic primitives to
> set and clear flags it is essential to protect calls of these functions with
> the queue lock. Otherwise flag updates could get lost due to concurrent
> queue_flag_set() or queue_flag_clear() calls.
> 
> One of the reasons why I introduced this helper function is to keep the
> wake_up_all(&q->mq_freeze_wq) call that is added to this function by a later
> patch in the block layer.

Oh, despite the _unlocked versions existing it doesn't do any atomic
ops.  Yeah, we'll need the queue lock then.

But please split it into one helper for setting the queue blocked
and to clear it, especially if the clear needs to do an additional
wake_up.
