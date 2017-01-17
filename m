Return-Path: <prvs=2190b29283=axboe@fb.com>
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <2B1CBA75-606E-48FA-A2FC-A435FBB3968E@linaro.org>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Linux-Kernal
	<linux-kernel@vger.kernel.org>, <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <048a5a0a-1793-4698-4bc0-213d36fad161@fb.com>
Date: Mon, 16 Jan 2017 18:47:19 -0800
MIME-Version: 1.0
In-Reply-To: <2B1CBA75-606E-48FA-A2FC-A435FBB3968E@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 12/22/2016 09:49 AM, Paolo Valente wrote:
> 
>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> This is basically identical to deadline-iosched, except it registers
>> as a MQ capable scheduler. This is still a single queue design.
>>
> 
> One last question (for today ...):in mq-deadline there are no
> "schedule dispatch" or "unplug work" functions.  In blk, CFQ and BFQ
> do these schedules/unplugs in a lot of cases.  What's the right
> replacement?  Just doing nothing?

You just use blk_mq_run_hw_queue() or variants thereof to kick off queue
runs.

-- 
Jens Axboe
