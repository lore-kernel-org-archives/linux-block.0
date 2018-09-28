Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/5][v2] blk-iolatency: Fixes and tweak the miss algo for
 ssds
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180928174543.28486-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f132b363-da12-9e1c-104a-8bede6514b1a@kernel.dk>
Date: Fri, 28 Sep 2018 11:48:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180928174543.28486-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/28/18 11:45 AM, Josef Bacik wrote:
> v1->v2:
> - rebased onto a recent for-4.20/block branch
> - dropped the changed variable cleanup.
> 
> -- Original message --
> 
> Testing on ssd's with the current iolatency code wasn't working quite as well.
> This is mostly because ssd's don't behave like rotational drives, they are more
> spikey which means that using the average latency for IO wasn't very responsive
> until the drive was extremely over taxed.  To deal with this I've reworked
> iolatency to use a p(90) based approach for ssd latencies.  I originally
> intended to use this approach for both ssd's and rotational drives, but p(90)
> was too high of a bar to use.  By the time we were exceeding p(90) things were
> already pretty bad.  So to keep things simpler just use p(90) for ssd's since
> their latency targets tend to be orders of magnitude lower than rotational
> drives, and keep the average latency calculations for rotational drives.
> 
> This testing also showed a few issues with blk-iolatency, so the preceding
> patches are all fixing issues we saw in testing.  Using q->nr_requests instead
> of blk_queue_depth() is probably the most subtle and important change.  We want
> to limit the IO's based on the number of outstanding requests we can have in the
> block layer, not necessarily how many we can have going to the device.  So make
> this explicity by using nr_requests directly.  These patches have been in
> production for a week on both our rotational and ssd tiers and everything is
> going smoothly.  Thanks,

Applied for 4.20, thanks for respinning.

-- 
Jens Axboe
