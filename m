Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Aug 2018 01:17:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180802171723.GD8928@ming.t460p>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
 <20180801085841.GA27962@ming.t460p>
 <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
 <20180802165831.GB8928@ming.t460p>
 <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 02, 2018 at 05:08:55PM +0000, Bart Van Assche wrote:
> On Fri, 2018-08-03 at 00:58 +0800, Ming Lei wrote:
> > And about the situations you mentioned, no any special as normal cases
> > or thousands of LUNs. Just a batch of queues are waken up from one
> > single wait queue(sbq_wait_state), and inside each wait queue, queues
> > are handled actually in FIFO order.
> > 
> > Or what is your expected ideal behaviour about fairness?
> 
> Hello Ming,
> 
> What I expect is if the number of LUNs is really large that all LUNs are treated
> equally. Unless someone can set up a test that demonstrates that this is still

Some of idle LUNs shouldn't be treated equally as other LUNs which need
to serve.  

Also as I mentioned, the original RR style isn't better than the new
way actually, since now we handle queues in sort of FIFO style, thanks
wait queue.

Not mentioning big CPU utilization is consumed unnecessarily for iterating
over all queues even though there is only one active queue, is this fair from
system view?

Thanks,
Ming
