Return-Path: <ming.lei@redhat.com>
Date: Fri, 3 Aug 2018 08:35:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180803003507.GE16047@ming.t460p>
References: <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
 <20180801085841.GA27962@ming.t460p>
 <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
 <20180802165831.GB8928@ming.t460p>
 <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
 <20180802171723.GD8928@ming.t460p>
 <4868e0b82ac6e87aede7fc52da67d3a7913d680b.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4868e0b82ac6e87aede7fc52da67d3a7913d680b.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 02, 2018 at 05:24:15PM +0000, Bart Van Assche wrote:
> On Fri, 2018-08-03 at 01:17 +0800, Ming Lei wrote:
> > Not mentioning big CPU utilization is consumed unnecessarily for iterating
> > over all queues even though there is only one active queue, is this fair from
> > system view?
> 
> I hope that someone will come up some day with a better solution than the
> list_for_each_entry_rcu_rr() loop. But as long as such a solution has not yet
> been found that loop should stay in order to preserve fair handling of large
> numbers of LUNs.

Again list_for_each_entry_rcu_rr() isn't fair for small number of active
queue in this case, because this way decreases IOPS a lot and consumes CPU
much just for checking all thousands of queues unnecessarily, even though 99%
of them are idle.

Thanks,
Ming
