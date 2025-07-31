Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6204225784;
	Thu, 31 Jul 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981979; cv=none; b=UHfpCbjDlUmhapzZIfGUdqaC+Vd76w8oJCZrd9jP1WVFTmkSm1InTwr0OliMe0QEK29HE+EAQJhzG+PHsVFCHnlQcc66XEZZ7c+TVIOwUEPfSyrVZEQVsW0mdl56f8SZBDY3KZJdVvdpLUUrPpmB4xOIP5f9mWV5UBPykJ0TOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981979; c=relaxed/simple;
	bh=749QrL7J0/QGXNnQBMQXrAxmTfG1i6S/8klvDMbN0Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcJ4pPzvCzWkLFcONWI40rYp06pBPMARC0qAFEjXvdEIcc7170foVQwg+4Q4JV+dcPWkmBkJL9gcbzHf4EaCqFnZzgw3fUniKtD7XAPeIwRVkve7GdbV8B9vxvcM3Y2UTEwcT1Oep4VQAR3E1qEq1/aM84tGyMxmpQ4CEJEbVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj5JV3tO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj5JV3tO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA434C4CEEF;
	Thu, 31 Jul 2025 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753981979;
	bh=749QrL7J0/QGXNnQBMQXrAxmTfG1i6S/8klvDMbN0Zk=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kj5JV3tOEOJziKA5GcWydOQLVXuuxUDhzo9hx04OjNFlbGyFVdEkNEXiEBglYUOFe
	 w3UhNalj62focn6MClwC3yB/MJpPvVC1NskaaVyX6V+yymHVY5QdigQSugDkn6q48a
	 P55+BzlRK41SUDOHMzn5OYagSncHkdOwaeMM6aRrXo+Oi5tx3mMfosRU4bqVr0pZRh
	 K7gFBnpVaIH81SnKxhQknFTZMtkmae5WnjeJEZpamKBdFUQINSWRdV1vlQ+EltrqFH
	 tpjgJRSSGa7R46LoRuN6ZWkOX4YS3a/MtLCZmG1XHy3irrUz4KRFWIR1PfT/PyZ6ZC
	 9HmClJewkmwTw==
Message-ID: <2ca5109a-341c-497a-9da7-422d56620348@kernel.org>
Date: Fri, 1 Aug 2025 01:12:55 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH] blk-wbt: Fix io starvation in wbt_rqw_done()
To: Yizhou Tang <tangyeechou@gmail.com>, Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, stable@vger.kernel.org,
 Julian Sun <sunjunchao@bytedance.com>
References: <20250731123319.1271527-1-sunjunchao@bytedance.com>
 <CAOB9oOZV5ObqvgNxr9m0ztm7ruM9N9RMi8QHmiG5WL4sNbLxuw@mail.gmail.com>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <CAOB9oOZV5ObqvgNxr9m0ztm7ruM9N9RMi8QHmiG5WL4sNbLxuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/31 23:40, Yizhou Tang 写道:
> Hi Julian,
>
> On Thu, Jul 31, 2025 at 8:33 PM Julian Sun <sunjunchao2870@gmail.com> wrote:
>> Recently, we encountered the following hungtask:
>>
>> INFO: task kworker/11:2:2981147 blocked for more than 6266 seconds
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> kworker/11:2    D    0 2981147      2 0x80004000
>> Workqueue: cgroup_destroy css_free_rwork_fn
>> Call Trace:
>>   __schedule+0x934/0xe10
>>   schedule+0x40/0xb0
>>   wb_wait_for_completion+0x52/0x80
> I don’t see __wbt_wait() or rq_qos_wait() here, so I suspect this call
> stack is not directly related to wbt.
>
>
>>   ? finish_wait+0x80/0x80
>>   mem_cgroup_css_free+0x3a/0x1b0
>>   css_free_rwork_fn+0x42/0x380
>>   process_one_work+0x1a2/0x360
>>   worker_thread+0x30/0x390
>>   ? create_worker+0x1a0/0x1a0
>>   kthread+0x110/0x130
>>   ? __kthread_cancel_work+0x40/0x40
>>   ret_from_fork+0x1f/0x30
This is writeback cgroup is waiting for writeback to be done, if you 
figured out
they are throttled by wbt, you need to explain clearly, and it's very 
important to
provide evidence to support your analysis. However, the following 
analysis is
a mess :(
>>
>> This is because the writeback thread has been continuously and repeatedly
>> throttled by wbt, but at the same time, the writes of another thread
>> proceed quite smoothly.
>> After debugging, I believe it is caused by the following reasons.
>>
>> When thread A is blocked by wbt, the I/O issued by thread B will
>> use a deeper queue depth(rwb->rq_depth.max_depth) because it
>> meets the conditions of wb_recent_wait(), thus allowing thread B's
>> I/O to be issued smoothly and resulting in the inflight I/O of wbt
>> remaining relatively high.
>>
>> However, when I/O completes, due to the high inflight I/O of wbt,
>> the condition "limit - inflight >= rwb->wb_background / 2"
>> in wbt_rqw_done() cannot be satisfied, causing thread A's I/O
>> to remain unable to be woken up.
>  From your description above, it seems you're suggesting that if A is
> throttled by wbt, then a writer B on the same device could
> continuously starve A.
> This situation is not possible — please refer to rq_qos_wait(): if A
> is already sleeping, then when B calls wq_has_sleeper(), it will
> detect A’s presence, meaning B will also be throttled.
Yes, there are three rq_wait in wbt, and each one is FIFO. It will be 
possible
if  A is backgroup, and B is swap.
>
> Thanks,
> Yi
>
>> Some on-site information:
>>
>>>>> rwb.rq_depth.max_depth
>> (unsigned int)48
>>>>> rqw.inflight.counter.value_()
>> 44
>>>>> rqw.inflight.counter.value_()
>> 35
>>>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
>> (unsigned long)3
>>>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
>> (unsigned long)2
>>>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
>> (unsigned long)20
>>>>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
>> (unsigned long)12
>>
>> cat wb_normal
>> 24
>> cat wb_background
>> 12
>>
>> To fix this issue, we can use max_depth in wbt_rqw_done(), so that
>> the handling of wb_recent_wait by wbt_rqw_done() and get_limit()
>> will also be consistent, which is more reasonable.
Are you able to reproduce this problem, and give this patch a test before
you send it?

Thanks,
Kuai
>>
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>> Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
>> ---
>>   block/blk-wbt.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index a50d4cd55f41..d6a2782d442f 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -210,6 +210,8 @@ static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
>>          else if (blk_queue_write_cache(rwb->rqos.disk->queue) &&
>>                   !wb_recent_wait(rwb))
>>                  limit = 0;
>> +       else if (wb_recent_wait(rwb))
>> +               limit = rwb->rq_depth.max_depth;
>>          else
>>                  limit = rwb->wb_normal;
>>
>> --
>> 2.20.1
>>
>>

