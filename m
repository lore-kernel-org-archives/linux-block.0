Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E502FD1CF;
	Fri, 30 Jan 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742577; cv=none; b=CBIAiOHqVhDBR6Bal0b9jW3IYmrfMcS1uc/ccE2+2/5jqXjSnnGi3wYiLGB7l3bjgc/0/hN+U+NZpaz83SqN1IXrzOhYcD6PKBeKh565dNo9PThJSxnXOYDJzosqEZm8p9FxMOQwF+bPJOpBaAimUCCF8V/aE1Nh9vJJbodKyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742577; c=relaxed/simple;
	bh=ivk12fCPB4AZDfbvbI/JAr/3pIQLl4I1fnC8cnY62Hg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u6G4Z+4DrJSIRke0R9zDXikHJX6wFtUE7jYQHBYNtXg9cnd0Hx+Tmlg7d57EjQNLuieI7pvksLwvSiV7f60J5K3VOZnJx3jBfQ7ke3/h/zWkZA7E0R0JfaA8vhIzyT5UQ34edzVhuNOhG8B+wJ/DoaNYqAkGF8OWmJn9mj2vz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 173c34e0fd8911f0b0f03b4cfa9209d1-20260130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3293df93-80af-4451-9e8e-309ba420c3f2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:740cfd24e9cd9c0545e4654a31070357,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 173c34e0fd8911f0b0f03b4cfa9209d1-20260130
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 950376002; Fri, 30 Jan 2026 11:09:29 +0800
Message-ID: <a61e6bc0-58d1-46f0-8a4f-17f02503fe17@kylinos.cn>
Date: Fri, 30 Jan 2026 11:09:26 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous when
 trace_async_init set
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-trace-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260128194104.30051be1@gandalf.local.home>
 <56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
 <20260129152958.05c1ca46@gandalf.local.home>
 <bb29a10c-6130-4040-8521-0b5375c017ef@kylinos.cn>
Content-Language: en-US
In-Reply-To: <bb29a10c-6130-4040-8521-0b5375c017ef@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/1/30 09:35, Yaxiong Tian 写道:
>
> 在 2026/1/30 04:29, Steven Rostedt 写道:
>> On Wed, 28 Jan 2026 19:25:46 -0700
>> Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> On Jan 28, 2026, at 5:40 PM, Steven Rostedt <rostedt@goodmis.org> 
>>> wrote:
>>>> ﻿
>>>> Jens,
>>>>
>>>> Can you give me an acked-by on this patch and I can take the series 
>>>> through
>>>> my tree.
>>> On phone, hope this works:
>>>
>>> Acked-by: Jens Axboe <axboe@kernel.dk>
>> Thanks!
>>
>>>> Or perhaps this doesn't even need to test the trace_async_init flag 
>>>> and can
>>>> always do the work queue? Does blk_trace ever do tracing at boot 
>>>> up? That
>>>> is, before user space starts?
>>> Not via the traditonal way of running blktrace.
>> Masami and Yaxiong,
>>
>> I've been thinking about this more and I'm not sure we need the
>> trace_async_init kernel parameter at all. As blktrace should only be
>> enabled by user space, it can always use the work queue.
>>
>> For kprobes, if someone is adding a kprobe on the kernel command 
>> line, then
>> they are already specifying that tracing is more important.
>>
>> Patch 3 already keeps kprobes from being an issue with contention of the
>> tracing locks, so I don't think it ever needs to use the work queue.
>>
>> Wouldn't it just be better to remove the trace_async_init and make 
>> blktrace
>> always use the work queue and kprobes never do it (but exit out early if
>> there were no kprobes registered)?
>>
>> That is, remove patch 2 and 4 and make this patch always use the work 
>> queue.
>
> Yesterday, I was curious about|trace_event_update_all()|, so I 
> added|pr_err(xx)|prints within the function's loop. I discovered that 
> these prints appeared as late as 14 seconds later (printing is 
> time-consuming), by which time the desktop had already been up for 
> quite a while. However,|trace_eval_sync()|had already finished running 
> at 0.6 seconds.
>
> This implies that I originally 
> thought|trace_eval_sync()|'s|destroy_workqueue()|would wait for all 
> tasks to complete, but it seems that might not be the case. From this, 
> if the above conclusion is true, then strictly speaking, tasks 
> using|queue_work(xx)|cannot be guaranteed to finish before the init 
> process executes. If it's necessary to strictly ensure initialization 
> completes before user space starts, 
> using|async_synchronize_full()|or|async_synchronize_full_domain()|would 
> be better in such scenarios.
I need to double-check this issue—theoretically, it shouldn't exist. But 
I'm not sure why the print appeared at the 14-second mark.
>
> Of course, the situation described above is an extreme case. I don't 
> oppose this approach; I only hope to make the startup faster for 
> ordinary users who don’t use trace, while minimizing the impact on 
> others as much as possible.
>
>>
>> -- Steve
