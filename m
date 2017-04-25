Return-Path: <hare@suse.de>
Subject: Re: [PATCH v4 09/10] blk-mq: Add blk_mq_ops.show_rq()
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "hare@suse.com" <hare@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-10-bart.vanassche@sandisk.com>
 <1e88d065-5a98-1edc-658e-c0194e471994@suse.com>
 <1493070705.3394.21.camel@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <43f3d07e-610e-f5a1-8d3a-bdd06213764f@suse.de>
Date: Tue, 25 Apr 2017 17:16:13 +0200
MIME-Version: 1.0
In-Reply-To: <1493070705.3394.21.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/24/2017 11:51 PM, Bart Van Assche wrote:
> On Mon, 2017-04-24 at 09:32 +0200, Hannes Reinecke wrote:
>> On 04/22/2017 01:40 AM, Bart Van Assche wrote:
>>> --- a/include/linux/blk-mq.h
>>> +++ b/include/linux/blk-mq.h
>>> @@ -121,6 +121,12 @@ struct blk_mq_ops {
>>>  	softirq_done_fn		*complete;
>>>  
>>>  	/*
>>> +	 * Used by the debugfs implementation to show driver-specific
>>> +	 * information about a request.
>>> +	 */
>>> +	void (*show_rq)(struct seq_file *m, struct request *rq);
>>> +
>>> +	/*
>>>  	 * Called when the block layer side of a hardware queue has been
>>>  	 * set up, allowing the driver to allocate/init matching structures.
>>>  	 * Ditto for exit/teardown.
>>>
>>
>> I don't really like this; what does happen if someone disabled
>> CONFIG_BLK_DEBUGFS? Won't we end up with a stale callback?
> 
> Hello Hannes,
> 
> How about surrounding (*show_rq)() function pointer with #ifdef CONFIG_BLK_DEBUGFS /
> #endif?
> 
Nope.

Then you'll end up with different offsets in the structures, depending
on how the kernel is compiled. Making debugging a nightmare.

Not sure what would be the best way here ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
