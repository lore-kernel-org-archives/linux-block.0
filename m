Return-Path: <mgorman@techsingularity.net>
Date: Mon, 4 Sep 2017 09:14:51 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	broonie@kernel.org, lee.tibbert@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/3] three bfq fixes restoring
 service guarantees with random sync writes in bg
Message-ID: <20170904081451.swq52kn2x24guphz@techsingularity.net>
References: <20170831064631.2223-1-paolo.valente@linaro.org>
 <20170831144257.oa5nm6vzihpam6kw@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20170831144257.oa5nm6vzihpam6kw@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 31, 2017 at 03:42:57PM +0100, Mel Gorman wrote:
> On Thu, Aug 31, 2017 at 08:46:28AM +0200, Paolo Valente wrote:
> > [SECOND TAKE, with just the name of one of the tester fixed]
> > 
> > Hi,
> > while testing the read-write unfairness issues reported by Mel, I
> > found BFQ failing to guarantee good responsiveness against heavy
> > random sync writes in the background, i.e., multiple writers doing
> > random writes and systematic fdatasync [1]. The failure was caused by
> > three related bugs, because of which BFQ failed to guarantee to
> > high-weight processes the expected fraction of the throughput.
> > 
> 
> Queued on top of Ming's most recent series even though that's still a work
> in progress. I should know in a few days how things stand.
> 

The problems with parallel heavy writers seem to have disappeared with this
series. There are still revisions taking place on Ming's to overall setting
of legacy vs mq is still a work in progress but this series looks good.

Thanks.

-- 
Mel Gorman
SUSE Labs
