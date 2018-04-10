Return-Path: <ming.lei@redhat.com>
Date: Tue, 10 Apr 2018 23:38:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "tj@kernel.org" <tj@kernel.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"maxg@mellanox.com" <maxg@mellanox.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180410153812.GA3219@ming.t460p>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <20180410084133.GB9133@ming.t460p>
 <b36ea1107be4f32fb04fffdde3ee45a2e0fcc36c.camel@wdc.com>
 <20180410135541.GA22340@ming.t460p>
 <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
 <20180410143007.GB22340@ming.t460p>
 <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
 <20180410152553.GC22340@ming.t460p>
 <20180410153031.GO3126663@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410153031.GO3126663@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

Hi Tejun,

On Tue, Apr 10, 2018 at 08:30:31AM -0700, tj@kernel.org wrote:
> Hello, Ming.
> 
> On Tue, Apr 10, 2018 at 11:25:54PM +0800, Ming Lei wrote:
> > +   if (time_after_eq(jiffies, deadline) &&
> > +       blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE)) {
> > +       blk_mq_rq_timed_out(rq, reserved);
> > 
> > Normal completion still can happen between blk_mq_change_rq_state()
> > and blk_mq_rq_timed_out().
> > 
> > In tj's approach, there is synchronize_rcu() between writing aborted_gstate
> > and blk_mq_rq_timed_out, it is easier for normal completion to happen during
> > the big window.
> 
> I don't think plugging this hole is all that difficult, but this
> shouldn't lead to any critical failures.  If so, that'd be a driver
> bug.

I agree, the issue should be in driver's irq handler and .timeout in
theory.

For example, even though one request has been done by irq handler, .timeout
still may return RESET_TIMER.

Thanks,
Ming
