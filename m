Return-Path: <fangwei1@huawei.com>
Subject: Re: [PATCH] block: fix a type conversion error in __get_request()
To: Jens Axboe <axboe@kernel.dk>
References: <1467637420-4967-1-git-send-email-fangwei1@huawei.com>
 <577BEF75.7010208@kernel.dk>
CC: <linux-block@vger.kernel.org>
From: Wei Fang <fangwei1@huawei.com>
Message-ID: <577C675D.8040801@huawei.com>
Date: Wed, 6 Jul 2016 10:05:17 +0800
MIME-Version: 1.0
In-Reply-To: <577BEF75.7010208@kernel.dk>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>

Hi, Jens,

On 2016/7/6 1:33, Jens Axboe wrote:
> On 07/04/2016 07:03 AM, Wei Fang wrote:
>> Theoretically, request only flags in enum rq_flag_bits can bigger
>> than 31 after we add some new flags in the future, so we can't
>> store REQ_IO_STAT in op_flags which is a int type in __get_request().
>> Actually, when REQ_IO_STAT become 31, the most-significant bit of
>> op_flags will be 1, and OR it to ->cmd_flags will cause the top 32
>> bits of ->cmd_flags become 1.
>>
>> Fix it by using a u64-type object to store flags.
> 
> Why not change op_flags to a 64-bit type, if the flags are already overflowing?
> 
> Either that, or we need a BUILD_BUG_ON() for the flags not being > 32 bit.
> 

op_flags passed into __get_request() is used to store bio flags which won't
be > 31 bit, so it can not be overflowing when it passed in. But request
only flags, e.g. REQ_IO_STAT, that op_flags try to store in __get_request()
may be > 31 bit in the future, so op_flags will be overflowing in that
case. (I already met that problem after I added some new common flags.)

Converting int to u64 can be problematic when the most-significant bit of
op_flags is 1 when it passed in (it may happen theoretically?), so I add
a explicit cast between op_flags and cmd_flags.

Thanks,
Wei
