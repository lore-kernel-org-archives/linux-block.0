Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 5/9] sbitmap: fix missed wakeups caused by
 sbitmap_queue_get_shallow()
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, osandov@fb.com, efault@gmx.de,
 paolo.valente@linaro.org
References: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
 <1525969467-12476-6-git-send-email-axboe@kernel.dk>
 <20180510170110.GE30485@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d7ade6ae-5066-3106-4a26-619beb2563e6@kernel.dk>
Date: Thu, 10 May 2018 11:09:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180510170110.GE30485@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/10/18 11:01 AM, Omar Sandoval wrote:
> On Thu, May 10, 2018 at 10:24:23AM -0600, Jens Axboe wrote:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> The sbitmap queue wake batch is calculated such that once allocations
>> start blocking, all of the bits which are already allocated must be
>> enough to fulfill the batch counters of all of the waitqueues. However,
>> the shallow allocation depth can break this invariant, since we block
>> before our full depth is being utilized. Add
>> sbitmap_queue_min_shallow_depth(), which saves the minimum shallow depth
>> the sbq will use, and update sbq_calc_wake_batch() to take it into
>> account.
>>
>> Acked-by: Paolo Valente <paolo.valente@linaro.org>
>> Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Reviewed -- haha, wait, thanks for picking this one up :)

Just checking if you're awake!

-- 
Jens Axboe
