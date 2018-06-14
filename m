Return-Path: <axboe@kernel.dk>
Subject: Re: remove nvme_reinit_tagset and blk_mq_tagset_iter
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20180614123015.5989-1-hch@lst.de>
 <248094d8-afe6-b6b7-8c8b-b8db452ec030@kernel.dk>
 <20180614145422.GA4856@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <23d279da-2450-448e-a117-ca327ea775e6@kernel.dk>
Date: Thu, 14 Jun 2018 08:48:08 -0600
MIME-Version: 1.0
In-Reply-To: <20180614145422.GA4856@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/14/18 8:54 AM, Christoph Hellwig wrote:
> On Thu, Jun 14, 2018 at 08:45:07AM -0600, Jens Axboe wrote:
>> On 6/14/18 6:30 AM, Christoph Hellwig wrote:
>>> Now that nvme-fc moved off the reinit request concept both the core nvme
>>> and blk-mq code for it becomes unused.
>>>
>>> Jens, are you ok with queuing up the blk-mq side with the pending nvme
>>> changes?
>>
>> Are you asking if you can queue it up, presumable because the nvme-fc
>> change isn't upstream yet? That's fine with me, you can add my
>> reviewed-by to the patches.
> 
> Yes, that is the plan.  The nvme changes are fixes I'm going to send
> you ASAP, and I think we can just send the dead code removal along.

OK, that sounds fine then. Please do send them asap, so I can ship
what I have for Linus before he cuts -rc1 on Sunday.

-- 
Jens Axboe
