Return-Path: <prvs=1162d78414=axboe@fb.com>
Subject: Re: [PATCH 7/8] mq-deadline: add blk-mq adaptation of the deadline IO
 scheduler
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <1481933536-12844-8-git-send-email-axboe@fb.com>
 <99111D0B-F051-4D8F-94EF-E7962F47FFD9@linaro.org>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Linux-Kernal
	<linux-kernel@vger.kernel.org>, <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <ae644260-2290-021f-24dc-4379766a4603@fb.com>
Date: Tue, 20 Dec 2016 08:46:19 -0700
MIME-Version: 1.0
In-Reply-To: <99111D0B-F051-4D8F-94EF-E7962F47FFD9@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

On 12/20/2016 02:34 AM, Paolo Valente wrote:
> 
>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> This is basically identical to deadline-iosched, except it registers
>> as a MQ capable scheduler. This is still a single queue design.
>>
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>> ...
>> +
>> +static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
>> +{
>> +	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
>> +
>> +	return !list_empty_careful(&dd->dispatch) ||
>> +		!list_empty_careful(&dd->fifo_list[0]) ||
>> +		!list_empty_careful(&dd->fifo_list[1]);
> 
> Just a request for clarification: if I'm not mistaken,
> list_empty_careful can be used safely only if the only possible other
> concurrent access is a delete.  Or am I missing something?

We can "solve" that with memory barriers. For now, it's safe to ignore
on your end.


-- 
Jens Axboe
