Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD372BE644;
	Wed, 28 Jan 2026 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589558; cv=none; b=OeIneUUPb0ZgveFcKS4GrsrfQbZkK9OgRumuM8MGYivkgLSy9nwC8SPipjUBpttCrBG0IeJ78Oj7GniCkAwUoeh+33WfeDayRS8Y3vM9t4rlfBTH4awakV80tirHM7mfhtAqRRvLt7mkbSV5OnS6smZGhVLM2+zB0TX7LABpmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589558; c=relaxed/simple;
	bh=jyDIBgd2dVoTOoNBEgP2eQ8ROxB5IpkQMTnov8i8hAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KK51PlAsUt27v3AwYjwm4pQAbbPljpvYuDrOPbHP4vso9S8hRoyMq4zg6NQCqZ7YGYG8VOSmLHu7pYSGrjBiYBNs/MxQLjyIsvJIo92Y5YueGXavepXyFI+mETTipt+xuaD46dZolEm6I2xYIinqE2Sw9p+/LkJI86K65j2BAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cfd1b43cfc2411f0b0f03b4cfa9209d1-20260128
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:0c86a15a-a7bb-45b4-a610-52085b897074,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:2f617db6a462fa1cb07923e6f2d777b4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cfd1b43cfc2411f0b0f03b4cfa9209d1-20260128
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1474635869; Wed, 28 Jan 2026 16:39:08 +0800
Message-ID: <5044e453-4fd8-4530-a793-292adc2888ac@kylinos.cn>
Date: Wed, 28 Jan 2026 16:39:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tracing/kprobes: Make setup_boot_kprobe_events()
 asynchronous
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, axboe@kernel.dk, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260127012016.76713-1-tianyaxiong@kylinos.cn>
 <20260127012312.84659-1-tianyaxiong@kylinos.cn>
 <20260128134936.539782c2112073e55e7a0304@kernel.org>
 <6ab04276-8897-4d5e-a86c-e656cf1f6f91@kylinos.cn>
 <20260128165302.1c67c6fc1c54525247d7f553@kernel.org>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260128165302.1c67c6fc1c54525247d7f553@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/1/28 15:53, Masami Hiramatsu (Google) 写道:
> On Wed, 28 Jan 2026 15:24:15 +0800
> Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>
>> 在 2026/1/28 12:49, Masami Hiramatsu (Google) 写道:
>>> On Tue, 27 Jan 2026 09:23:12 +0800
>>> Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>>>
>>>> During kernel boot, the setup_boot_kprobe_events() function causes
>>>> significant delays, increasing overall startup time.
>>>>
>>>> The root cause is a lock contention chain: its child function
>>>> enable_boot_kprobe_events() requires the event_mutex, which is
>>>> already held by early_event_add_tracer(). early_event_add_tracer()
>>>> itself is blocked waiting for the trace_event_sem  read-write lock,
>>>> which is held for an extended period by trace_event_update_all().
>>>>
>>>> To resolve this, we have moved the execution of
>>>> setup_boot_kprobe_events() to the trace_init_wq  workqueue, allowing
>>>> it to run asynchronously.
>>>>
>>>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>> ---
>>>>    kernel/trace/trace_kprobe.c | 14 +++++++++++++-
>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
>>>> index 9953506370a5..4c6621f02696 100644
>>>> --- a/kernel/trace/trace_kprobe.c
>>>> +++ b/kernel/trace/trace_kprobe.c
>>>> @@ -2031,6 +2031,13 @@ static __init int init_kprobe_trace_early(void)
>>>>    }
>>>>    core_initcall(init_kprobe_trace_early);
>>>>    
>>>> +static struct work_struct kprobe_trace_work __initdata;
>>>> +
>>>> +static void __init kprobe_trace_works_func(struct work_struct *work)
>>>> +{
>>>> +	setup_boot_kprobe_events();
>>>> +}
>>>> +
>>>>    /* Make a tracefs interface for controlling probe points */
>>>>    static __init int init_kprobe_trace(void)
>>>>    {
>>>> @@ -2048,7 +2055,12 @@ static __init int init_kprobe_trace(void)
>>>>    	trace_create_file("kprobe_profile", TRACE_MODE_READ,
>>>>    			  NULL, NULL, &kprobe_profile_ops);
>>>>    
>>>> -	setup_boot_kprobe_events();
>>>> +	if (trace_init_wq) {
>>>> +		INIT_WORK(&kprobe_trace_work, kprobe_trace_works_func);
>>>> +		queue_work(trace_init_wq, &kprobe_trace_work);
>>> Hmm, this queue_work is not required if kprobe_boot_events_buf[] is
>>> empty. We should check it because most of the time we don't need it.
>> Yes, I will improve it in the next version.
>>> Also, deferring initialization makes it indeterminate when this
>>> tracing will begin.
>> Indeed, While most scenarios don't need boot-time tracing, and users
>> prioritize boot speed, we must balance the need for deterministic traces
>> with faster startup.
> I just wonder why don't you define kprobe events after boot (e.g.
> from init script) instead of kernel cmdline. Using cmdline means
> it will be used for tracing kernel boot.
>
> - tracing kernel boot -> use kernel cmdline (synchronous)
> - tracing user boot -> use tracefs (asynchronous)
I was actually working on a boot optimization task when I found that my 
machine was getting blocked on trace-related operations.
>
>>> For kprobe event use case, I think setup_boot_kprobe_events() should
>>> check the kprobe_boot_events_buf is empty at first. But I think Yaxiong
>>> use case happens when you are using kprobe events via cmdline, is that
>>> correct?
>> The issue was identified without enabling kprobe events via the cmdline.
> Interesting. So is it fixed by another patch [1]?
>
> [1] https://lore.kernel.org/all/20260127053848.108473-1-sunliming@linux.dev/
>
Yes, specifically looking at trace_kprobe in isolation, that issue is 
indeed resolved. However, the process still ends up blocking the 
initialization of blktrace later on.
>> The core finding is that asynchronous initialization can drastically cut
>> boot time under different workloads. As blocking occurs elsewhere in the
>> tracing infrastructure beyond just kprobe events, adopting async is a
>> broadly applicable strategy for boot time optimization.
> Yes, but it is also possible to set it up from user space, because that
> user process can work asynchronously.
> We can make the ftrace initialization async to accelerate boot time, but
> that means it is not useful for tracing kernel boot.
>
>>> I think introducing "async" cmdline option is more preferable.
>> Agreed, this works. Users focused on boot speed over early-boot tracing
>> can opt for this parameter to gain a startup performance boost.
> Yeah, that is an option. Anyway, basically, users have another option to
> setup ftrace after boot user space asynchronously. That is my
> recommendation for such use case.
Yes, that's what I normally do.
>
>>> BTW, I found that the kprobe events from kernel cmdline will be made
>>> after boot-time tracing from bootconfig. Maybe it should be run this
>>> earlier timing too.
>> Yes. Additionally, this optimization does not conflict with the current
>> patch series at all.
>>
>> I'll submit the updated patch for the next version promptly.
> OK.
>
> Thank you,
>
>>> Thank you,
>>>
>>>
>>>> +	} else {
>>>> +		setup_boot_kprobe_events();
>>>> +	}
>>>>    
>>>>    	return 0;
>>>>    }
>>>> -- 
>>>> 2.25.1
>>>>
>
