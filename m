Return-Path: <sboisvert@gydle.com>
Subject: Re: [PATCH 17/17] null_blk: remove legacy IO path
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-18-axboe@kernel.dk>
 <2b272814-d4b9-a761-0d6c-22bb85d86c58@gydle.com>
 <ea2fb124-9b80-0621-36f2-45516a5a3252@kernel.dk>
From: =?UTF-8?Q?S=c3=a9bastien_Boisvert?= <sboisvert@gydle.com>
Message-ID: <e1824355-3d63-e21c-00d5-456790d1fbb3@gydle.com>
Date: Fri, 12 Oct 2018 13:37:16 -0400
MIME-Version: 1.0
In-Reply-To: <ea2fb124-9b80-0621-36f2-45516a5a3252@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 2018-10-12 01:30 PM, Jens Axboe wrote:
> On 10/12/18 11:24 AM, Sébastien Boisvert wrote:
>>> +	if (g_queue_mode == NULL_Q_RQ) {
>>> +		pr_err("null_blk: legacy IO path no longer available\n");
>>> +		return -EINVAL;
>>> +	}
>>
>> Is this the only location where the value NULL_Q_RQ has be checked ?
> 
> I've since fixed a few more, all should be well now. The updated version
> is here:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=mq-conversions&id=d6fd3bd94a7333a8cd0bf7ef18f719ef7e052dc4
> 
>> Since the enum that contains NULL_Q_RQ is in
>> drivers/block/null_blk_main.c, and not in a linux header file, would
>> it be thinkable to remove NULL_Q_RQ from the enum too, and not adding
>> this legacy check ?
>>
>> Would that break user space (the number one rule) ?
> 
> It wouldn't break user space. In any case, if someone is currently using
> queue_mode=1, it'd fail to load after this patch.
> 

Just curious, where can this be passed (mount option, boot option, /sys, /proc, driver code, or whatnot) ?

> I'm checking that at the bottom, we could remove NULL_Q_RQ if we just
> made that check == 1 instead. But cleaner to keep it, imho.
> 

I agree, if queue_mode=1 can be passed.


Reviewed-by: Sébastien Boisvert <sboisvert@gydle.com>
