Return-Path: <ming.lei@redhat.com>
Date: Wed, 28 Feb 2018 11:09:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] blk-mq: Make sure that the affected zone is unlocked if
 a request times out
Message-ID: <20180228030940.GE11230@ming.t460p>
References: <20180228002830.3052-1-bart.vanassche@wdc.com>
 <20180228013537.GD11230@ming.t460p>
 <7354e215-9f6a-acde-112a-e9f81a34b7d4@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7354e215-9f6a-acde-112a-e9f81a34b7d4@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hi Damien,

On Wed, Feb 28, 2018 at 02:21:49AM +0000, Damien Le Moal wrote:
> Ming,
> 
> On 2018/02/27 17:35, Ming Lei wrote:
> > On Tue, Feb 27, 2018 at 04:28:30PM -0800, Bart Van Assche wrote:
> >> If a request times out the .completed_request() method is not called
> > 
> > If BLK_EH_HANDLED is returned from .timeout(), __blk_mq_complete_request()
> > should have called .completed_request(). Otherwise, somewhere may be
> > wrong about timeout handling. Could you investigate why .completed_request
> > isn't called under this situation?
> 
> Actually, the commit message is a little misleading. The problem is not only for
> timeout but also for commands completing with a failure. This is very easy to
> reproduce by simply doing an unaligned write to a sequential zone on an ATA
> zoned block device. In this case, the scheduler .completed_request method is not
> called, which result in the target zone of the failed write to remain locked.

Actually request should have been completed in case of timeout,
otherwise the race between timeout and normal completion can't be
avoided.

But for dispatch failure, we deal with that with blk_mq_end_request(IOERR)
directly, please see blk_mq_dispatch_rq_list(), so the failed request is
freed without completion.

> 
> Hence the addition of a .finish_request method in mq-deadline pointing to the
> same function as .completed_request to ensure that the command target zone is
> unlocked. To ensure that the .finish_request method is called, the RQF_ELVPRIV
> flag is set when the request is dispatched after the target zone was locked.

> 
> >> and the .finish_request() method is only called if RQF_ELVPRIV has
> > 
> > .finish_request() is counter-pair of .prepare_request(), and both
> > aren't implemented by mq-deadline, so RQF_ELVPRIV needn't to be set,
> > and the current rule is that this flag is managed by block core.
> 
> Indeed. So do you think it would be better to rather force a call to
> .completed_request for failed command in ATA case ? Currently, it is not called
> after all retries for the command failed.

Now we know the reason, seems fine with either way:

1) handle it before calling blk_mq_end_request(IOERR)

2) introduce both .prepare_request()/.finish_request(), and do req zone
write lock in .dispatch_reqeust, but unlock in .finish_request, just like
what kyber does.


Thanks,
Ming
