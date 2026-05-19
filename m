Received: from out198-27.us.a.mail.aliyun.com (out198-27.us.a.mail.aliyun.com [47.90.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8045233956;
	Tue, 19 May 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186627; cv=none; b=fTxU5/VLTdRAs2GzYynRcKauSMRoturde9pa7yuc9HpkLSURct0CIoahMwa1BTWF8pplnXjASDVqM4w6l/k6m26zN1ZsylEIUDC2b2xMVTKjvZqYoy8cVMXL7c08/Ldp0u8XFhZc+VgdDtPl2HoJgiV11O7FdtUUbBpa2CuOgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186627; c=relaxed/simple;
	bh=cepgeDKs1koqgrhVMrrXfvgQvA/i5rV6SjluyAtnkSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2ahrRZwH/QU39Jrlx93Do9iUjgIuleHJg2/zreVM08XWFJ44l1OymzciUME0zxQI59maQ6VxDJQz5Whlr+I5BAG/262lYSQPurcjE9xyTd10lbrN7q3FtR3x3BlS+AIQEButwUjVWfAbk3TJLrBotSuivbpkW21pAYlLCaoKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=47.90.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07441588|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.287083-0.0013714-0.711545;FP=13184623255375802610|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.hb0LmYB_1779186604;
Received: from 192.168.208.183(mailfrom:michael@allwinnertech.com fp:SMTPD_---.hb0LmYB_1779186604 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 18:30:05 +0800
Message-ID: <5cc796a0-de5e-9a53-0445-1c8eb65ab47b@allwinnertech.com>
Date: Tue, 19 May 2026 18:30:03 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
Content-Language: en-US
To: Xiaosen <xiaosen.he@oss.qualcomm.com>, Ming Lei <tom.leiming@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
 <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
 <20260512124021.GA2214256@noisy.programming.kicks-ass.net>
 <agNLCof3zO5-QAo9@fedora> <agNgdIMacaG-41vj@slm.duckdns.org>
 <agPcx_vuO3ZYbAy1@fedora>
 <20260513073039.GG1889694@noisy.programming.kicks-ass.net>
 <agQxg-pBzF8rp1Ii@fedora>
 <6611f3ea-b70f-45c7-9332-235647643a49@oss.qualcomm.com>
From: Michael Wu <michael@allwinnertech.com>
In-Reply-To: <6611f3ea-b70f-45c7-9332-235647643a49@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The patch you mentioned also solves my problem; I've verified and tested 
it on my platform.

On 5/15/2026 2:18 PM, Xiaosen wrote:
> https://lore.kernel.org/lkml/20260427183848.698551-2-jstultz@google.com/
> The above change can resolve the deadlock I reported before by setting
> task's state to TASK_RUNNING before switching context.
> 
> There is the likely alternative fix below.
> https://lore.kernel.org/lkml/20260512025635.2840817-1-jstultz@google.com/
> 
> Regards,
> Xiaosen
> 
> On 5/13/2026 4:08 PM, Ming Lei wrote:
>> On Wed, May 13, 2026 at 09:30:39AM +0200, Peter Zijlstra wrote:
>>> On Wed, May 13, 2026 at 10:07:03AM +0800, Ming Lei wrote:
>>>> On Tue, May 12, 2026 at 07:16:36AM -1000, Tejun Heo wrote:
>>>>> Hello, Ming.
>>>>>
>>>>> On Tue, May 12, 2026 at 11:45:14PM +0800, Ming Lei wrote:
>>>>>> On Tue, May 12, 2026 at 02:40:21PM +0200, Peter Zijlstra wrote:
>>>>>>> On Tue, May 12, 2026 at 02:04:32PM +0200, Peter Zijlstra wrote:
>>>>>>>> On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
>>>>>>>>> On preemptible kernels, a deadlock can occur when a task with plugged IO
>>>>>>>>> calls schedule_preempt_disabled():
>>>>>>>>>
>>>>>>>>>    schedule_preempt_disabled()
>>>>>>>>>      sched_preempt_enable_no_resched()  // preemption now enabled
>>>>>>>>>      schedule()                         // <-- preemption can happen here
>>>>>>>>>        sched_submit_work()
>>>>>>>>>          blk_flush_plug()
>>>>>>>>>
>>>>>>>>> After sched_preempt_enable_no_resched() re-enables preemption, the task
>>>>>>>>> can be preempted (e.g., by a higher-priority RT task) before reaching
>>>>>>>>> blk_flush_plug() in sched_submit_work(). Since the task's state is
>>>>>>>>> already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
>>>>>>>>> requests in current->plug remain unflushed for an unbounded time.
>>>>>>>>>
>>>>>>>>> If another task depends on those plugged requests to make progress (e.g.,
>>>>>>>>> to release a lock the sleeping task needs), a deadlock results:
>>>>>>>>>
>>>>>>>>>    - Task A (writeback worker): holds plugged IO, preempted before
>>>>>>>>>      flushing, stuck on run queue behind higher-priority work
>>>>>>>>>    - Task B: waiting for IO completion from Task A's plug, holds a lock
>>>>>>>>>      that Task A needs to be woken up
>>>>>
>>>>> My memory is hazy around io_schedule but the above reads really weird to me.
>>>>> A task, regardless of its current state stays on the runqueue when
>>>>> preempted, so the condition is temporary. As soon as the preempted task can
>>>>> get CPU, it should unwind the situation. That's not a deadlock. Is the
>>>>> problem that there can be preemption-induced delay in flushing the plugs?
>>>>
>>>> IMO, preempting a `!TASK_RUNNING` task can be thought as effective sleep,
>>>
>>> No it cannot be. Preemption ignores task state.
>>
>> Yeah, I get similar conclusion too with AI's assistance.
>>
>> But both two reports show that the preempted task aren't switched back for
>> long enough time, can you share any idea for Michael & Xiaosen to investigate
>> further from scheduler side?
>>
>> https://lore.kernel.org/linux-block/20260417082744.30124-1-michael@allwinnertech.com/
>>
>> https://lore.kernel.org/linux-block/5660795d-87de-46f5-add4-7729a02225ef@oss.qualcomm.com/
>>
>>
>> Thanks,
>> Ming

-- 
Regards,
Michael Wu
