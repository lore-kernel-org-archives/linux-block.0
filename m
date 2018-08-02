Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: make iolatency avg_lat exponentially decay
To: Tejun Heo <tj@kernel.org>, Dennis Zhou <dennisszhou@gmail.com>
Cc: Josef Bacik <jbacik@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
 kernel-team@fb.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180802061541.49173-1-dennisszhou@gmail.com>
 <20180802155917.GT1206094@devbig004.ftw2.facebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2694b782-b28e-3885-660d-a1ee6d00e116@kernel.dk>
Date: Thu, 2 Aug 2018 10:01:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180802155917.GT1206094@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/2/18 9:59 AM, Tejun Heo wrote:
> Hello, Dennis.
> 
> On Wed, Aug 01, 2018 at 11:15:41PM -0700, Dennis Zhou wrote:
>> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
>>
>> Currently, avg_lat is calculated by accumulating the mean of every
>> window in a long running cumulative average. As time goes on, the metric
>> becomes less and less useful due to the accumulated history.
>>
>> This patch reuses the same calculation done in load averages to make the
>> avg_lat metric more lively. Unlike load averages, the avg only advances
>> when a window elapses (due to an io). Idle periods extend the most
>> recent window. Bucketing is used to limit the history of avg_lat by
>> binding it to the window size. So, the window range for 1/exp (decay
>> rate) is [1 min, 2.5 min) when windows elapse immediately.
>>
>> The current sample window size is exposed in the debug info to enable
>> calculation of the window range.
>>
>> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Acked-by: Josef Bacik <josef@toxicpanda.com>
> 
> Heh, sorry about not thinking this up from the beginning but I think
> it'd be great to move this to blkcg core so that the stat is always
> available regardless of blk-iolatency.  It's a really important metric
> and can be used for both monitoring and policy implementation.

Just make that change a separate patch, since v3 is already applied.

-- 
Jens Axboe
