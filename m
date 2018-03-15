Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v5] blk-throttle: fix race between blkcg_bio_issue_check()
 and cgroup_rmdir()
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, xuejiufei <jiufei.xue@linux.alibaba.com>,
 Caspar Zhang <caspar@linux.alibaba.com>,
 linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
References: <5c99ef07-1133-a45a-9a09-7c29e8139f5b@linux.alibaba.com>
 <20180314140901.GV2943022@devbig577.frc2.facebook.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <d988a1eb-98c0-6a79-d271-778f5ca17b3e@linux.alibaba.com>
Date: Thu, 15 Mar 2018 09:18:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180314140901.GV2943022@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hello Tejun,

Thanks for your quick response.

On 18/3/14 22:09, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 14, 2018 at 02:18:04PM +0800, Joseph Qi wrote:
>> Fixes: ae1188963611 ("blkcg: consolidate blkg creation in blkcg_bio_issue_check()")
>> Reported-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
>> Cc: stable@vger.kernel.org #4.3+
> 
> I'm a bit nervous about tagging it for -stable.  Given the low rate of
> this actually occurring, I'm not sure the benefits outweigh the risks.
> Let's at least cook it for a couple releases before sending it to
> -stable.
> 
>> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
>> index 69bea82..dccd102 100644
>> --- a/include/linux/blk-cgroup.h
>> +++ b/include/linux/blk-cgroup.h
>> @@ -88,6 +88,7 @@ struct blkg_policy_data {
>>  	/* the blkg and policy id this per-policy data belongs to */
>>  	struct blkcg_gq			*blkg;
>>  	int				plid;
>> +	bool				offlined;
>>  };
> 
> This is pure bike-shedding but offlined reads kinda weird to me, maybe
> just offline would read better?  Other than that,
> 
Do I need to resend a new version for this?

Thanks,
Joseph

>  Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks a lot for seeing this through.
> 
