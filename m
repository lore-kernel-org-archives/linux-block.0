Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d28bca3a-196d-1520-35cf-bec1e1872d34@oracle.com>
Date: Fri, 24 Aug 2018 10:06:56 +0800
MIME-Version: 1.0
In-Reply-To: <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens

On 08/23/2018 11:42 PM, Jens Axboe wrote:
>> -
>> -	__set_current_state(TASK_RUNNING);
>> -	remove_wait_queue(&rqw->wait, &wait);
>> +	wbt_init_wait(&wait, &data);
>> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
>> +			TASK_UNINTERRUPTIBLE);
>> +	if (lock) {
>> +		spin_unlock_irq(lock);
>> +		io_schedule();
>> +		spin_lock_irq(lock);
>> +	} else
>> +		io_schedule();
> Aren't we still missing a get-token attempt after adding to the
> waitqueue? For the case where someone frees the token after your initial
> check, but before you add yourself to the waitqueue.

I used to think about this.
However, there is a very tricky scenario here:
We will try get the wbt budget in wbt_wake_function.
After add a task into the wait queue, wbt_wake_function has been able to
be invoked for this task. If we get the wbt budget after prepare_to_wait_exclusive,
we may get wbt budget twice.

Thanks
Jianchao                                                               
