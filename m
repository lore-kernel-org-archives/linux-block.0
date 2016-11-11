Return-Path: <axboe@kernel.dk>
Subject: Re: Regression: nvme timeouts and oopses
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <af308491-a381-f13d-2d87-89bbca68d99e@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6cd8bb58-6749-02e2-ee27-46d8813cbfd2@kernel.dk>
Date: Fri, 11 Nov 2016 12:18:34 -0700
MIME-Version: 1.0
In-Reply-To: <af308491-a381-f13d-2d87-89bbca68d99e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/11/2016 11:47 AM, Jens Axboe wrote:
> Hi,
>
> I've been running into problems when stability testing my 4.10 branch,
> and I finally got an easy reproducer today (on the laptop, no less) and
> was able to bisect it. Boils down to this:
>
> 2253efc850c4cf690516bbc07854eeb1077202ba is the first bad commit
> commit 2253efc850c4cf690516bbc07854eeb1077202ba
> Author: Bart Van Assche <bart.vanassche@sandisk.com>
> Date:   Fri Oct 28 17:20:02 2016 -0700
>
>     blk-mq: Move more code into blk_mq_direct_issue_request()

I think I see what it is - you're grabbing a request off the plug list,
and then you assume that it's the same hardware queue. That's not safe.
So you end up issuing a request from hwq A to hwq B, oops. Let me test
that theory with a patch.

-- 
Jens Axboe
