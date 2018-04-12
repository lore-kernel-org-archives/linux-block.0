Return-Path: <hch@lst.de>
Date: Thu, 12 Apr 2018 15:21:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] blk-mq: Avoid that a completion can be ignored for
	BLK_EH_RESET_TIMER
Message-ID: <20180412132137.GB5476@lst.de>
References: <20180410210157.30477-1-bart.vanassche@wdc.com> <20180411021104.GC4494@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411021104.GC4494@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 11, 2018 at 10:11:05AM +0800, Ming Lei wrote:
> On Tue, Apr 10, 2018 at 03:01:57PM -0600, Bart Van Assche wrote:
> > The blk-mq timeout handling code ignores completions that occur after
> > blk_mq_check_expired() has been called and before blk_mq_rq_timed_out()
> > has reset rq->aborted_gstate. If a block driver timeout handler always
> > returns BLK_EH_RESET_TIMER then the result will be that the request
> > never terminates.
> 
> Under this situation:
> 
> IMO, if this request has been handled by driver's irq handler, and if
> driver's .timeout still returns BLK_EH_RESET_TIMER, it is driver's bug,
> and the correct return value should be BLK_EH_HANDLED.

We have plenty drivers that do that, so we'll need to audit all the
drivers first.  I guess a start would be to find a way that disables
timeouts entirely.
