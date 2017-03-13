Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] brd: make rd_size static
To: Jason Yan <yanaijie@huawei.com>, linux-block@vger.kernel.org
References: <1489131159-840-1-git-send-email-yanaijie@huawei.com>
 <4dd2367b-61b9-d390-5bb1-955e90fef0b0@kernel.dk>
 <58C5EE51.4000703@huawei.com>
Cc: miaoxie@huawei.com, zhaohongjiang@huawei.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a12a26bf-cb6a-949f-a896-01fc437163ba@kernel.dk>
Date: Sun, 12 Mar 2017 20:56:58 -0600
MIME-Version: 1.0
In-Reply-To: <58C5EE51.4000703@huawei.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/12/2017 06:56 PM, Jason Yan wrote:
> 
> On 2017/3/12 6:29, Jens Axboe wrote:
>> On 03/10/2017 12:32 AM, Jason Yan wrote:
>>> Fixes the following sparse warning:
>>>
>>> drivers/block/brd.c:411:15: warning: symbol 'rd_size' was not declared.
>>> Should it be static?
>>
>> If you do a search on this topic, you'll find others that attempted
>> to do the same. Arm uses it for tag parsing, for some reason, your
>> patch below would break it.
>>
>> It'd be great if this was fixed up for real, though.
>>
> 
> how about fix this like this, looks ugly but works:
> 
> #ifndef CONFIG_ARM
> static
> #endif

No, that solves nothing, and is arguably worse. Either leave it
alone, perhaps with a comment to prevent others from making the
same error, or fix it for real.

-- 
Jens Axboe
