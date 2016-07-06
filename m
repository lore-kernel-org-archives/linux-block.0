Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160705222626.GC25394@htj.duckdns.org>
References: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com> <20160705222626.GC25394@htj.duckdns.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 6 Jul 2016 09:14:23 +0800
Message-ID: <CACVXFVNAc9YeRsbbe=dNuTDzCZ7FEC-qFUE=7AfL=hNLRAGRmg@mail.gmail.com>
Subject: Re: cgroup: Fix split bio been throttled more than once
To: Tejun Heo <tj@kernel.org>
Cc: Jiale Li <aaronlee0817@163.com>, Jens Axboe <axboe@kernel.dk>, Ming Lin <mlin@kernel.org>,
	Shaohua Li <shli@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cgroup@vger.kernel.org,
	jiale0817.li@samsung.com, yanzi.zhang@samsung.com, zhen1.zhang@samsung.com,
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 6, 2016 at 6:26 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Mon, Jul 04, 2016 at 10:46:54PM +0800, Jiale Li wrote:
>> These days, we have tested the cgroup blkio throttle function use fio,
>> and we found a problem that when we use buffered IO or set the big block
>> size like 1M, then the IO performance cannot reach the value we set.
>> For example we set blkio.throttle.read_bps_device as 10M, in kernel
>> version 4.3 IO performance can only reach 6M, and in kernel version
>> 4.4 the actual IO bps is only 3.1M.
>>
>> Then we did some research and find that in kernel version 4.3 brought in
>> blk_queue_split() function to split the big size bio into several parts,
>> and some of them are calling the generic_make_request() again, this result
>> the bio been throttled more than once. so the actual bio sent to device is
>> less than we expected.
>>
>> We have checked the newest kernel of 4.7-rc5, this problem is still exist.
>>
>> Based on this kind of situation, we propose a fix solution to add a flag bit
>> in bio to let the splited bio bypass the blk_queue_split(). Below is the patch
>> we used to fix this problem.
>
> Thanks a lot for the report.  Hmmm... there was another brekage around
> split bios, I wonder whether the two can be handled together somehow.
>
>  http://lkml.kernel.org/g/1466583730-28595-1-git-send-email-lars.ellenberg@linbit.com
>

That is another issue, which is a deadlock caused by queuing the remainder
bio from splitting before BIOs generated in .make_request_fn().

>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 2613531..7b17a65 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -190,6 +190,7 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
>>
>>               bio_chain(split, *bio);
>>               trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
>> +             bio_set_flag(*bio, BIO_SPLITED);
>
> Split's past participle form is split, so BIO_SPLIT would be right
> here.
>
>>               generic_make_request(*bio);
>>               *bio = split;
>>       }
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 47a3e54..4ffde95 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -1403,6 +1403,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>>
>>       WARN_ON_ONCE(!rcu_read_lock_held());
>>
>> +     /* if the bio has been splited, should not throttle again */
>> +     if (bio_flagged(bio, BIO_SPLITED))
>> +             goto out;
>> +
>
> But that said, can't we just copy BIO_THROTLED while splitting?
>
> Thanks.
>
> --
> tejun


Thanks,
Ming Lei
