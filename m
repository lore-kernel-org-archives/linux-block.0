Return-Path: <prvs=76613167f=fllinden@amazon.com>
From: "van der Linden, Frank" <fllinden@amazon.com>
To: Jens Axboe <axboe@kernel.dk>, Jianchao Wang <jianchao.w.wang@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Agarwal,
 Anchal" <anchalag@amazon.com>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
Date: Thu, 23 Aug 2018 16:24:00 +0000
Message-ID: <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 8/23/18 8:37 AM, Jens Axboe wrote:=0A=
> On 8/23/18 7:08 AM, Jianchao Wang wrote:=0A=
>> 2887e41 (blk-wbt: Avoid lock contention and thundering herd=0A=
>> issue in wbt_wait) introduces two cases that could miss wakeup:=0A=
>>  - __wbt_done only wakes up one waiter one time. There could be=0A=
>>    multiple waiters and (limit - inflight) > 1 at the moment.=0A=
>>=0A=
>>  - When the waiter is waked up, it is still on wait queue and set=0A=
>>    to TASK_UNINTERRUPTIBLE immediately, so this waiter could be=0A=
>>    waked up one more time. If a __wbt_done comes and wakes up=0A=
>>    again, the prevous waiter may waste a wakeup.=0A=
>>=0A=
>> To fix them and avoid to introduce too much lock contention, we=0A=
>> introduce our own wake up func wbt_wake_function in __wbt_wait and=0A=
>> use wake_up_all in __wbt_done. wbt_wake_function will try to get=0A=
>> wbt budget firstly, if sucesses, wake up the process, otherwise,=0A=
>> return -1 to interrupt the wake up loop.=0A=
> I really like this approach, since it'll naturally wake up as many=0A=
> as we can instead of either being single wakeups, or wake all.=0A=
>=0A=
> BTW, you added Anchal and Frank to the CC in the patch, but they =0A=
> are not actually CC'ed. Doing that now - can you guys give this=0A=
> a whirl? Should still solve the thundering herd issue, but be=0A=
> closer to the original logic in terms of wakeup. Actually better,=0A=
> since we remain on list and remain ordered.=0A=
>=0A=
> Leaving the patch below for you guys.=0A=
>=0A=
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>=0A=
>> Fixes: 2887e41 (blk-wbt: Avoid lock contention and thundering herd issue=
 in wbt_wait)=0A=
>> Cc: Anchal Agarwal <anchalag@amazon.com>=0A=
>> Cc: Frank van der Linden <fllinden@amazon.com>=0A=
>> ---=0A=
>>  block/blk-wbt.c | 78 +++++++++++++++++++++++++++++++++++++++-----------=
-------=0A=
>>  1 file changed, 54 insertions(+), 24 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c=0A=
>> index c9358f1..2667590 100644=0A=
>> --- a/block/blk-wbt.c=0A=
>> +++ b/block/blk-wbt.c=0A=
>> @@ -166,7 +166,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt=
_flags wb_acct)=0A=
>>  		int diff =3D limit - inflight;=0A=
>>  =0A=
>>  		if (!inflight || diff >=3D rwb->wb_background / 2)=0A=
>> -			wake_up(&rqw->wait);=0A=
>> +			wake_up_all(&rqw->wait);=0A=
>>  	}=0A=
>>  }=0A=
>>  =0A=
>> @@ -481,6 +481,40 @@ static inline unsigned int get_limit(struct rq_wb *=
rwb, unsigned long rw)=0A=
>>  	return limit;=0A=
>>  }=0A=
>>  =0A=
>> +struct wbt_wait_data {=0A=
>> +	struct task_struct *curr;=0A=
>> +	struct rq_wb *rwb;=0A=
>> +	struct rq_wait *rqw;=0A=
>> +	unsigned long rw;=0A=
>> +};=0A=
>> +=0A=
>> +static int wbt_wake_function(wait_queue_entry_t *curr, unsigned int mod=
e,=0A=
>> +		int wake_flags, void *key)=0A=
>> +{=0A=
>> +	struct wbt_wait_data *data =3D curr->private;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * If fail to get budget, return -1 to interrupt the wake up=0A=
>> +	 * loop in __wake_up_common.=0A=
>> +	 */=0A=
>> +	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))=0A=
>> +		return -1;=0A=
>> +=0A=
>> +	wake_up_process(data->curr);=0A=
>> +=0A=
>> +	list_del_init(&curr->entry);=0A=
>> +	return 1;=0A=
>> +}=0A=
>> +=0A=
>> +static inline void wbt_init_wait(struct wait_queue_entry *wait,=0A=
>> +		struct wbt_wait_data *data)=0A=
>> +{=0A=
>> +	INIT_LIST_HEAD(&wait->entry);=0A=
>> +	wait->flags =3D 0;=0A=
>> +	wait->func =3D wbt_wake_function;=0A=
>> +	wait->private =3D data;=0A=
>> +}=0A=
>> +=0A=
>>  /*=0A=
>>   * Block if we will exceed our limit, or if we are currently waiting fo=
r=0A=
>>   * the timer to kick off queuing again.=0A=
>> @@ -491,31 +525,27 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt=
_flags wb_acct,=0A=
>>  	__acquires(lock)=0A=
>>  {=0A=
>>  	struct rq_wait *rqw =3D get_rq_wait(rwb, wb_acct);=0A=
>> -	DECLARE_WAITQUEUE(wait, current);=0A=
>> -	bool has_sleeper;=0A=
>> -=0A=
>> -	has_sleeper =3D wq_has_sleeper(&rqw->wait);=0A=
>> -	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))=0A=
>> +	struct wait_queue_entry wait;=0A=
>> +	struct wbt_wait_data data =3D {=0A=
>> +		.curr =3D current,=0A=
>> +		.rwb =3D rwb,=0A=
>> +		.rqw =3D rqw,=0A=
>> +		.rw =3D rw,=0A=
>> +	};=0A=
>> +=0A=
>> +	if (!wq_has_sleeper(&rqw->wait) &&=0A=
>> +			rq_wait_inc_below(rqw, get_limit(rwb, rw)))=0A=
>>  		return;=0A=
>>  =0A=
>> -	add_wait_queue_exclusive(&rqw->wait, &wait);=0A=
>> -	do {=0A=
>> -		set_current_state(TASK_UNINTERRUPTIBLE);=0A=
>> -=0A=
>> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))=0A=
>> -			break;=0A=
>> -=0A=
>> -		if (lock) {=0A=
>> -			spin_unlock_irq(lock);=0A=
>> -			io_schedule();=0A=
>> -			spin_lock_irq(lock);=0A=
>> -		} else=0A=
>> -			io_schedule();=0A=
>> -		has_sleeper =3D false;=0A=
>> -	} while (1);=0A=
>> -=0A=
>> -	__set_current_state(TASK_RUNNING);=0A=
>> -	remove_wait_queue(&rqw->wait, &wait);=0A=
>> +	wbt_init_wait(&wait, &data);=0A=
>> +	prepare_to_wait_exclusive(&rqw->wait, &wait,=0A=
>> +			TASK_UNINTERRUPTIBLE);=0A=
>> +	if (lock) {=0A=
>> +		spin_unlock_irq(lock);=0A=
>> +		io_schedule();=0A=
>> +		spin_lock_irq(lock);=0A=
>> +	} else=0A=
>> +		io_schedule();=0A=
>>  }=0A=
>>  =0A=
>>  static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *b=
io)=0A=
>>=0A=
>=0A=
I like it, this combines some of the ideas outlined in our previous=0A=
thread in to a good solution.=0A=
=0A=
One comment, though: I think we need to set the task state back to=0A=
TASK_RUNNING after being woken up, right?=0A=
=0A=
Frank=0A=
=0A=
