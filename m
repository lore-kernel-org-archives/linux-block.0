Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
To: Bart Van Assche <bart.vanassche@sandisk.com>, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com>
 <12323199-84d1-7586-9189-3bf5644248a0@sandisk.com>
Cc: hch@lst.de
From: Jens Axboe <axboe@fb.com>
Message-ID: <0c36737f-2397-c84c-f43e-44bd0683f054@fb.com>
Date: Thu, 3 Nov 2016 08:18:40 -0600
MIME-Version: 1.0
In-Reply-To: <12323199-84d1-7586-9189-3bf5644248a0@sandisk.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/03/2016 08:10 AM, Bart Van Assche wrote:
> On 11/01/2016 03:05 PM, Jens Axboe wrote:
>> +void blk_stat_init(struct blk_rq_stat *stat)
>> +{
>> +    __blk_stat_init(stat, ktime_to_ns(ktime_get()));
>> +}
>> +
>> +static bool __blk_stat_is_current(struct blk_rq_stat *stat, s64 now)
>> +{
>> +    return (now & BLK_STAT_NSEC_MASK) == (stat->time &
>> BLK_STAT_NSEC_MASK);
>> +}
>> +
>> +bool blk_stat_is_current(struct blk_rq_stat *stat)
>> +{
>> +    return __blk_stat_is_current(stat, ktime_to_ns(ktime_get()));
>> +}
>
> Hello Jens,
>
> What is the performance impact of these patches? My experience is that
> introducing ktime_get() in the I/O path of high-performance I/O devices
> measurably slows down I/O. On https://lkml.org/lkml/2016/4/21/107 I read
> that a single ktime_get() call takes about 100 ns.

Hmm, on the testing I did, it didn't seem to have any noticeable
slowdown. If we do see a slowdown, we can look into enabling it only
when we need it.

Outside of the polling, my buffered writeback throttling patches also
use this stat tracking. For that patchset, it's easy enough to enable it
if we have wbt enabled. For polling, it's a bit more difficult. One easy
way would be to have a queue flag for it, and the first poll would
enable it unless it has been explicitly turned off.

-- 
Jens Axboe
