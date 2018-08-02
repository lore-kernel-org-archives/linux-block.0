Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Aug 2018 00:58:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180802165831.GB8928@ming.t460p>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
 <20180801085841.GA27962@ming.t460p>
 <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 02, 2018 at 03:52:00PM +0000, Bart Van Assche wrote:
> On Wed, 2018-08-01 at 16:58 +0800, Ming Lei wrote:
> > On Wed, Aug 01, 2018 at 10:17:30AM +0800, jianchao.wang wrote:
> > > However, due to the limits in hctx_may_queue, q_b still cannot get the
> > > tags. The RR restart also will not wake up q_a.
> > > This is unfair for q_a.
> > > 
> > > When we remove RR restart fashion, at least, the q_a will be waked up by
> > > the hctx restart.
> > > Is this the improvement of fairness you said in driver tag allocation ?
> > 
> > I mean the fairness is totally covered by the general tag allocation
> > algorithm now, which is sort of FIFO style because of waitqueue, but RR
> > restart wakes up queue in the order of request queue.
> 
> From sbitmap.h:
> 
> #define SBQ_WAIT_QUEUES 8
> 
> What do you think is the effect of your patch if more than eight LUNs are
> active and the SCSI queue is full?

Jens introduces multiple wait queues for scattering atomic operation on
multiple counters, in theory, the way is understood easily if you just
treat it as one whole queue in concept.

And about the situations you mentioned, no any special as normal cases
or thousands of LUNs. Just a batch of queues are waken up from one
single wait queue(sbq_wait_state), and inside each wait queue, queues
are handled actually in FIFO order.

Or what is your expected ideal behaviour about fairness?

thanks, 
Ming
