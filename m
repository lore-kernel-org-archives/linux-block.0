Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O scheduler
 as an extra scheduler
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-2-paolo.valente@linaro.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <91b856e8-2c14-00b6-fdd8-b9879b1b9952@kernel.dk>
Date: Sun, 5 Mar 2017 08:16:20 -0700
MIME-Version: 1.0
In-Reply-To: <20170304160131.57366-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/04/2017 09:01 AM, Paolo Valente wrote:
> We tag as v0 the version of BFQ containing only BFQ's engine plus
> hierarchical support. BFQ's engine is introduced by this commit, while
> hierarchical support is added by next commit. We use the v0 tag to
> distinguish this minimal version of BFQ from the versions containing
> also the features and the improvements added by next commits. BFQ-v0
> coincides with the version of BFQ submitted a few years ago [1], apart
> from the introduction of preemption, described below.
> 
> BFQ is a proportional-share I/O scheduler, whose general structure,
> plus a lot of code, are borrowed from CFQ.

I'll take a closer look at this in the coming week. But one quick
comment - don't default to BFQ. Both because it might not be fully
stable yet, and also because the performance limitation of it is
quite severe. Whereas deadline doesn't really hurt single queue
flash at all, BFQ will.

Generally, I think that sort of logic should go into a udev rule. If
a device is rotational it should default to BFQ once the dust has
settled.

-- 
Jens Axboe
