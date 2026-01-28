Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88051A285;
	Wed, 28 Jan 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769585070; cv=none; b=O6RXrOSMzOfnAP/+UK9FrMYKx1S1J84O31V7ZYWqq8USrtaj4g5Lv2YU4YHnRb/nUFFN/v4hH23bLqeSxDZbGwXVEydT2cmvUGCMto7qYtMvstSwjraClYN0OKoJIaQMxuQKOhGZt3SBWdE9EDMmar5ujMICp95/oxjduhpWK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769585070; c=relaxed/simple;
	bh=X3vkGGiawfSJyIU94BOjCdFV2SqWZmFFTpCUR9GJS3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcIXwNG++bzjIWHNrAH21fZqdgfkRG4EChMGq/QzNdTQmXoZr4ZfQ4FaIJ9d5mN+b1GR3TCpdwvCXv5BP8gj86pzUwnSA5A7vUu2F2lE6vOsX4F4jNX2o3dwcNFajREvhkdIqBOqjV7Wu8NsMW34UevZtb6i8yVlZ+nlNDeZm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b9d7c2cfc1a11f0b0f03b4cfa9209d1-20260128
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b85a8993-7159-4b88-aa5f-53aad656943e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:5aaa4de4c293ab30bcf762f8b0bddaa9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5b9d7c2cfc1a11f0b0f03b4cfa9209d1-20260128
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2118149314; Wed, 28 Jan 2026 15:24:18 +0800
Message-ID: <6ab04276-8897-4d5e-a86c-e656cf1f6f91@kylinos.cn>
Date: Wed, 28 Jan 2026 15:24:15 +0800
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
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260128134936.539782c2112073e55e7a0304@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/1/28 12:49, Masami Hiramatsu (Google) 写道:
> On Tue, 27 Jan 2026 09:23:12 +0800
> Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>
>> During kernel boot, the setup_boot_kprobe_events() function causes
>> significant delays, increasing overall startup time.
>>
>> The root cause is a lock contention chain: its child function
>> enable_boot_kprobe_events() requires the event_mutex, which is
>> already held by early_event_add_tracer(). early_event_add_tracer()
>> itself is blocked waiting for the trace_event_sem  read-write lock,
>> which is held for an extended period by trace_event_update_all().
>>
>> To resolve this, we have moved the execution of
>> setup_boot_kprobe_events() to the trace_init_wq  workqueue, allowing
>> it to run asynchronously.
>>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> ---
>>   kernel/trace/trace_kprobe.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
>> index 9953506370a5..4c6621f02696 100644
>> --- a/kernel/trace/trace_kprobe.c
>> +++ b/kernel/trace/trace_kprobe.c
>> @@ -2031,6 +2031,13 @@ static __init int init_kprobe_trace_early(void)
>>   }
>>   core_initcall(init_kprobe_trace_early);
>>   
>> +static struct work_struct kprobe_trace_work __initdata;
>> +
>> +static void __init kprobe_trace_works_func(struct work_struct *work)
>> +{
>> +	setup_boot_kprobe_events();
>> +}
>> +
>>   /* Make a tracefs interface for controlling probe points */
>>   static __init int init_kprobe_trace(void)
>>   {
>> @@ -2048,7 +2055,12 @@ static __init int init_kprobe_trace(void)
>>   	trace_create_file("kprobe_profile", TRACE_MODE_READ,
>>   			  NULL, NULL, &kprobe_profile_ops);
>>   
>> -	setup_boot_kprobe_events();
>> +	if (trace_init_wq) {
>> +		INIT_WORK(&kprobe_trace_work, kprobe_trace_works_func);
>> +		queue_work(trace_init_wq, &kprobe_trace_work);
> Hmm, this queue_work is not required if kprobe_boot_events_buf[] is
> empty. We should check it because most of the time we don't need it.
Yes, I will improve it in the next version.
> Also, deferring initialization makes it indeterminate when this
> tracing will begin.
Indeed, While most scenarios don't need boot-time tracing, and users 
prioritize boot speed, we must balance the need for deterministic traces 
with faster startup.

>
> For kprobe event use case, I think setup_boot_kprobe_events() should
> check the kprobe_boot_events_buf is empty at first. But I think Yaxiong
> use case happens when you are using kprobe events via cmdline, is that
> correct?
The issue was identified without enabling kprobe events via the cmdline. 
The core finding is that asynchronous initialization can drastically cut 
boot time under different workloads. As blocking occurs elsewhere in the 
tracing infrastructure beyond just kprobe events, adopting async is a 
broadly applicable strategy for boot time optimization.
>
> I think introducing "async" cmdline option is more preferable.

Agreed, this works. Users focused on boot speed over early-boot tracing 
can opt for this parameter to gain a startup performance boost.

>
> BTW, I found that the kprobe events from kernel cmdline will be made
> after boot-time tracing from bootconfig. Maybe it should be run this
> earlier timing too.

Yes. Additionally, this optimization does not conflict with the current 
patch series at all.

I'll submit the updated patch for the next version promptly.

> Thank you,
>
>
>> +	} else {
>> +		setup_boot_kprobe_events();
>> +	}
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.25.1
>>
>
