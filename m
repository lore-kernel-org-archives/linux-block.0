Return-Path: <yanaijie@huawei.com>
Subject: Re: [PATCH] brd: make rd_size static
To: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
References: <1489131159-840-1-git-send-email-yanaijie@huawei.com>
 <4dd2367b-61b9-d390-5bb1-955e90fef0b0@kernel.dk>
CC: <miaoxie@huawei.com>, <zhaohongjiang@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <58C5EE51.4000703@huawei.com>
Date: Mon, 13 Mar 2017 08:56:49 +0800
MIME-Version: 1.0
In-Reply-To: <4dd2367b-61b9-d390-5bb1-955e90fef0b0@kernel.dk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-block@vger.kernel.org>


On 2017/3/12 6:29, Jens Axboe wrote:
> On 03/10/2017 12:32 AM, Jason Yan wrote:
>> Fixes the following sparse warning:
>>
>> drivers/block/brd.c:411:15: warning: symbol 'rd_size' was not declared.
>> Should it be static?
>
> If you do a search on this topic, you'll find others that attempted
> to do the same. Arm uses it for tag parsing, for some reason, your
> patch below would break it.
>
> It'd be great if this was fixed up for real, though.
>

how about fix this like this, looks ugly but works:

#ifndef CONFIG_ARM
static
#endif
