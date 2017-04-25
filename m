Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 09/10] blk-mq: Add blk_mq_ops.show_rq()
To: Hannes Reinecke <hare@suse.de>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>, "hare@suse.com" <hare@suse.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-10-bart.vanassche@sandisk.com>
 <1e88d065-5a98-1edc-658e-c0194e471994@suse.com>
 <1493070705.3394.21.camel@sandisk.com>
 <43f3d07e-610e-f5a1-8d3a-bdd06213764f@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <535c4cf7-0ff5-5837-45d6-915591d4cf0b@kernel.dk>
Date: Tue, 25 Apr 2017 09:34:39 -0700
MIME-Version: 1.0
In-Reply-To: <43f3d07e-610e-f5a1-8d3a-bdd06213764f@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/25/2017 08:16 AM, Hannes Reinecke wrote:
> On 04/24/2017 11:51 PM, Bart Van Assche wrote:
>> On Mon, 2017-04-24 at 09:32 +0200, Hannes Reinecke wrote:
>>> On 04/22/2017 01:40 AM, Bart Van Assche wrote:
>>>> --- a/include/linux/blk-mq.h
>>>> +++ b/include/linux/blk-mq.h
>>>> @@ -121,6 +121,12 @@ struct blk_mq_ops {
>>>>  	softirq_done_fn		*complete;
>>>>  
>>>>  	/*
>>>> +	 * Used by the debugfs implementation to show driver-specific
>>>> +	 * information about a request.
>>>> +	 */
>>>> +	void (*show_rq)(struct seq_file *m, struct request *rq);
>>>> +
>>>> +	/*
>>>>  	 * Called when the block layer side of a hardware queue has been
>>>>  	 * set up, allowing the driver to allocate/init matching structures.
>>>>  	 * Ditto for exit/teardown.
>>>>
>>>
>>> I don't really like this; what does happen if someone disabled
>>> CONFIG_BLK_DEBUGFS? Won't we end up with a stale callback?
>>
>> Hello Hannes,
>>
>> How about surrounding (*show_rq)() function pointer with #ifdef CONFIG_BLK_DEBUGFS /
>> #endif?
>>
> Nope.
> 
> Then you'll end up with different offsets in the structures, depending
> on how the kernel is compiled. Making debugging a nightmare.

That's nonsense, we deal with this all the time already.

-- 
Jens Axboe
