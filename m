Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-debugfs: add mapping show for hw queue to cpu
To: weiping <zhangweiping@didichuxing.com>
References: <20170712165400.GA9696@localhost.didichuxing.com>
 <d9e4984e-07f1-c1bd-07be-4e0a4b2a71df@kernel.dk>
 <20170712171331.GA13374@localhost.didichuxing.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3d69dcde-2f8e-b7e3-5a3a-f0cb7f8caee8@kernel.dk>
Date: Wed, 12 Jul 2017 11:25:12 -0600
MIME-Version: 1.0
In-Reply-To: <20170712171331.GA13374@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/12/2017 11:13 AM, weiping zhang wrote:
> On Wed, Jul 12, 2017 at 10:57:37AM -0600, Jens Axboe wrote:
>> On 07/12/2017 10:54 AM, weiping zhang wrote:
>>> A mapping show as following:
>>>
>>> hctx		cpus
>>> hctx0		  0   1
>>> hctx1		  2
>>> hctx2		  3
>>> hctx3		  4   5
>>
>> We already have that information in the /sys/block/<dev>/mq/X/cpu_list
>>
>> where X is the hardware queue number. Why do we need it in debugfs as
>> well, presented differently?
> 
> this arribute give a more obviously showing, only by 1 "cat" command.
> /sys/bloc/<dev>/mq/X/cpu_list not easy get mapping for all hctx by 1
> command.
> also /sys/kernel/debug/block/xxx/hctxN/cpuX can export that info, but
> these two methods both not obviously.

The point is the information is there, and I'm sure most people can
work out the shell logic to collect this info. I see zero benefit to
adding this to debugfs.

-- 
Jens Axboe
