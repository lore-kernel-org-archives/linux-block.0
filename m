Return-Path: <bootc@boo.tc>
Subject: Re: Hard lockup in blk_mq_free_request() / wbt_done() / wake_up_all()
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <9788e0e6-a448-bf85-1f41-88f42dc0071d@boo.tc>
 <ac2c7156-f405-4047-564d-816159d5968b@kernel.dk>
From: Chris Boot <bootc@boo.tc>
Message-ID: <7080a91c-8d9a-6305-2b67-dc27a374327a@boo.tc>
Date: Tue, 12 Jun 2018 17:19:57 +0100
MIME-Version: 1.0
In-Reply-To: <ac2c7156-f405-4047-564d-816159d5968b@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/06/18 17:09, Jens Axboe wrote:
> On 6/12/18 9:38 AM, Chris Boot wrote:
>> Hi folks,
>>
>> I maintain a large (to me) system with 112 threads (4x Intel E7-4830 v4)
>> which has a MegaRAID SAS 9361-24i controller. This system is currently
>> running Debian's 4.16.12 kernel (from stretch-backports) with blk_mq
>> enabled.
>>
>> I've run into a lockup which appears to involve blq_mq and writeback
>> throttling. It's hard to tell if I've run into this same thing with
>> older kernels; I'm trying to track down a deadlock but so far I've been
>> fairly certain that involved the OOM killer, but this doesn't seem to.
[snip]
> 
> Hmm that's really weird, I don't see how we could be spinning on the
> waitqueue lock like that. I haven't seen any wbt bug reports like this
> before.
> 
> Are things generally stable if you just turn off wbt? You can do that
> for sda, for instance, by doing:
> 
> # echo 0 > /sys/block/sda/queue/wbt_lat_usec
> 
> It'd be interesting to get this data point. Eg leave blk-mq enabled, and
> then just disable wbt.

Hi Jens,

Thanks for the speedy response. I'll see if I can get that tested soon;
if the system is stable without blk_mq I can see the users wanting to
keep it that way for a while. I'll let you know.

> Is anything disabling wbt in the system otherwise?

Not that I'm aware of, no.

Thanks,
Chris

-- 
Chris Boot
bootc@boo.tc
