Return-Path: <houtao1@huawei.com>
Subject: Re: [PATCH] cfq-iosched: fix the delay of cfq_group's vdisktime under
 iops mode
To: Jan Kara <jack@suse.cz>
References: <1488334064-34883-1-git-send-email-houtao1@huawei.com>
 <20170302102945.GA31792@quack2.suse.cz>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <jmoyer@redhat.com>,
        <stable@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <cb362b2f-e74a-afa8-02f0-22d061c0e5a6@huawei.com>
Date: Fri, 3 Mar 2017 21:20:44 +0800
MIME-Version: 1.0
In-Reply-To: <20170302102945.GA31792@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>


On 2017/3/2 18:29, Jan Kara wrote:
> On Wed 01-03-17 10:07:44, Hou Tao wrote:
>> When adding a cfq_group into the cfq service tree, we use CFQ_IDLE_DELAY
>> as the delay of cfq_group's vdisktime if there have been other cfq_groups
>> already.
>>
>> When cfq is under iops mode, commit 9a7f38c42c2b ("cfq-iosched: Convert
>> from jiffies to nanoseconds") could result in a large iops delay and
>> lead to an abnormal io schedule delay for the added cfq_group. To fix
>> it, we just need to revert to the old CFQ_IDLE_DELAY value: HZ / 5
>> when iops mode is enabled.
>>
>> Cc: <stable@vger.kernel.org> # 4.8+
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> 
> OK, I agree my commit broke the logic in this case. Thanks for the fix.
> Please add also tag:
> 
> Fixes: 9a7f38c42c2b92391d9dabaf9f51df7cfe5608e4
> 
> I somewhat disagree with the fix though. See below:
> 
>> +static inline u64 cfq_get_cfqg_vdisktime_delay(struct cfq_data *cfqd)
>> +{
>> +	if (!iops_mode(cfqd))
>> +		return CFQ_IDLE_DELAY;
>> +	else
>> +		return nsecs_to_jiffies64(CFQ_IDLE_DELAY);
>> +}
>> +
> 
> So using nsecs_to_jiffies64(CFQ_IDLE_DELAY) when in iops mode just does not
> make any sense. AFAIU the code in cfq_group_notify_queue_add() we just want
> to add the cfqg as the last one in the tree. So returning 1 from
> cfq_get_cfqg_vdisktime_delay() in iops mode should be fine as well.
Yes, nsecs_to_jiffies64(CFQ_IDLE_DELAY) is odd here, the better way is to
define a new macro with a value of 1 or 200 and use it directly, but I still
prefer to use 200 to be consistent with the no-hrtimer configuration.

> Frankly, vdisktime is in fixed-point precision shifted by
> CFQ_SERVICE_SHIFT so using CFQ_IDLE_DELAY does not make much sense in any
> case and just adding 1 to maximum vdisktime should be fine in all the
> cases. But that would require more testing whether I did not miss anything
> subtle.
Although the current implementation has done this, I don't think we should
add the cfq_group as the last one in the service tree. In some test cases,
I found that the delayed vdisktime of cfq_group is smaller than its last
vdisktime when the cfq_group was removed from the service_tree, and I think
it hurts the fairness. Maybe we can learn from CFS and calculate the delay
dynamically, but it would be the topic of another thread.

Regards,

Tao

> 
>>  static void
>>  cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
>>  {
>> @@ -1380,7 +1388,8 @@ cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
>>  	n = rb_last(&st->rb);
>>  	if (n) {
>>  		__cfqg = rb_entry_cfqg(n);
>> -		cfqg->vdisktime = __cfqg->vdisktime + CFQ_IDLE_DELAY;
>> +		cfqg->vdisktime = __cfqg->vdisktime +
>> +			cfq_get_cfqg_vdisktime_delay(cfqd);
>>  	} else
>>  		cfqg->vdisktime = st->min_vdisktime;
>>  	cfq_group_service_tree_add(st, cfqg);
>> -- 
>> 2.5.0
>>
