Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
To: Tejun Heo <tj@kernel.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org> <57174CA7.5000706@linaro.org>
 <20160422181321.GV7822@mtj.duckdns.org>
 <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org>
 <20160422184110.GX7822@mtj.duckdns.org>
 <C1A89D63-CBC4-4C92-8D5A-9FB55A53FBCF@linaro.org>
 <20160422193221.GY7822@mtj.duckdns.org>
 <57F65679-CD8E-43BA-8C46-C165B4C20677@linaro.org>
 <20160425192436.GE7822@mtj.duckdns.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
From: Paolo <paolo.valente@linaro.org>
Message-ID: <571E7E63.6010103@linaro.org>
Date: Mon, 25 Apr 2016 22:30:27 +0200
MIME-Version: 1.0
In-Reply-To: <20160425192436.GE7822@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Il 25/04/2016 21:24, Tejun Heo ha scritto:
> Hello, Paolo.
>

Hi

> On Sat, Apr 23, 2016 at 09:07:47AM +0200, Paolo Valente wrote:
>> There is certainly something I don’t know here, because I don’t
>> understand why there is also a workqueue containing root-group I/O
>> all the time, if the only process doing I/O belongs to a different
>> (sub)group.
>
> Hmmm... maybe metadata updates?
>

That's what I thought in the first place. But one half or one third of
the IOs sounded too much for metadata (the percentage varies over time
during the test). And root-group IOs are apparently large. Here is an
excerpt from the output of

grep -B 1 insert_request trace

     kworker/u8:4-116   [002] d...   124.349971:   8,0    I   W 3903488 
+ 1024 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.349978:   8,0    m   N cfq409A 
  / insert_request
--
     kworker/u8:4-116   [002] d...   124.350770:   8,0    I   W 3904512 
+ 1200 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.350780:   8,0    m   N cfq96A 
/seq_write insert_request
--
     kworker/u8:4-116   [002] d...   124.363911:   8,0    I   W 3905712 
+ 1888 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.363916:   8,0    m   N cfq409A 
  / insert_request
--
     kworker/u8:4-116   [002] d...   124.364467:   8,0    I   W 3907600 
+ 352 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.364474:   8,0    m   N cfq96A 
/seq_write insert_request
--
     kworker/u8:4-116   [002] d...   124.369435:   8,0    I   W 3907952 
+ 1680 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.369439:   8,0    m   N cfq96A 
/seq_write insert_request
--
     kworker/u8:4-116   [002] d...   124.369441:   8,0    I   W 3909632 
+ 560 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.369442:   8,0    m   N cfq96A 
/seq_write insert_request
--
     kworker/u8:4-116   [002] d...   124.373299:   8,0    I   W 3910192 
+ 1760 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.373301:   8,0    m   N cfq409A 
  / insert_request
--
     kworker/u8:4-116   [002] d...   124.373519:   8,0    I   W 3911952 
+ 480 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.373522:   8,0    m   N cfq96A 
/seq_write insert_request
--
     kworker/u8:4-116   [002] d...   124.381936:   8,0    I   W 3912432 
+ 1728 [kworker/u8:4]
     kworker/u8:4-116   [002] d...   124.381937:   8,0    m   N cfq409A 
/ insert_request


>> Anyway, if this is expected, then there is no reason to bother you
>> further on it. In contrast, the actual problem I see is the
>> following. If one third or half of the bios belong to a different
>> group than the writer that one wants to isolate, then, whatever
>> weight is assigned to the writer group, we will never be able to let
>> the writer get the desired share of the time (or of the bandwidth
>> with bfq and all quasi-sequential workloads). For instance, in the
>> scenario that you told me to try, the writer will never get 50% of
>> the time, with any scheduler. Am I missing something also on this?
>
> While a worker may jump across different cgroups, the IOs are still
> coming from somewhere and if the only IO generator on the machine is
> the test dd, the bios from that cgroup should dominate the IOs.  I
> think it'd be helpful to investigate who's issuing the root cgroup
> IOs.
>

Ok (if there is some quick way to get this information without
instrumenting the code, then any suggestion or pointer is welcome).

Thanks,
Paolo

> Thanks.
>
