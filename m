Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq: preparation of the ground for BFQ inclusion
To: Paolo Valente <paolo.valente@linaro.org>
References: <347F26BB-2D0A-4DBE-9FC5-BA6C05AE02B2@linaro.org>
 <1b5b6b66-1561-0bf2-f543-15342b00e90f@kernel.dk>
 <4c23fa60-9ea4-8040-0a06-7f4c1baf3537@kernel.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Brown
 <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Omar Sandoval <osandov@osandov.com>, Jan Kara <jack@suse.cz>,
 Bart Van Assche <bart.vanassche@sandisk.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2d7dff1-06fa-c510-4897-5c828c05c26b@kernel.dk>
Date: Thu, 1 Dec 2016 17:27:20 -0700
MIME-Version: 1.0
In-Reply-To: <4c23fa60-9ea4-8040-0a06-7f4c1baf3537@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/01/2016 02:03 PM, Jens Axboe wrote:
> On 11/14/2016 03:42 PM, Jens Axboe wrote:
>> On 11/14/2016 03:13 PM, Paolo Valente wrote:
>>> Hi Jens,
>>> have you had time to look into the first extensions/changes required?
>>> Any time plan?
>>
>> I was busy last week on the writeback and on the polling. I should have
>> something end this week.
> 
> It's coming together, running some testing and fixing some issues. But I
> now have unmodified legacy IO schedulers running under blk-mq, for
> single queue devices. Scheduler queue depth is independent of the device
> queue depth.

Here is the branch, btw:

http://git.kernel.dk/cgit/linux-block/log/?h=for-4.11/blk-mq-legacy-sched

if you want to look at it or test it. It's not in a clean state, I
wanted to get this reasonably working before cleaning it up. Should be
ready for testing, I've successfully run various IO tests on deadline
and CFQ with null_blk loaded with queue_mode=2 submit_queues=1
use_sched=1.

-- 
Jens Axboe
