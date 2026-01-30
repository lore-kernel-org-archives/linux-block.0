Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E40331219;
	Fri, 30 Jan 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736937; cv=none; b=ahqf2dbAqVZCvwNI3Ll2fI4rfnQkP7WmqeF7RzhV8nJhfiyh0nMNthxjQGxUcILE5NjiBX4qeu9RcE0rEchB4EVABv2JTYdbeBGV6F9Fr7Ek4uNJ7PYMT+pS7/zK0X9/YU3xfXJfA2Q8zfk2w/xGvCEnczocRA9IjNiq5o8e/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736937; c=relaxed/simple;
	bh=M4lJFzbs3sThhnPMjseUYFhfXfOwZwYWbo2v43gZ2KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdIeRddPN8rAh53l9DbOpKoT+jTumXVqI78E9fFIE6ff5SScnechCvxzsYHRtdnLDHws4SSyrHoMC0mMi6OireztVuG8XmGJQugytoxtT7KtEW+muzXlbGl8KnRrGX4r9X3eLAANGDmqt2dwwrM9aH9KG4MkkVtQKkLqYuM8ZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f5ae0a5efd7b11f0b0f03b4cfa9209d1-20260130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3571bded-f79e-41b7-a556-1d538611884a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:5b7095bc802a393161668d2dd3a31971,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f5ae0a5efd7b11f0b0f03b4cfa9209d1-20260130
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 269246397; Fri, 30 Jan 2026 09:35:29 +0800
Message-ID: <bb29a10c-6130-4040-8521-0b5375c017ef@kylinos.cn>
Date: Fri, 30 Jan 2026 09:35:26 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous when
 trace_async_init set
To: Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-trace-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260128194104.30051be1@gandalf.local.home>
 <56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
 <20260129152958.05c1ca46@gandalf.local.home>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260129152958.05c1ca46@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/1/30 04:29, Steven Rostedt 写道:
> On Wed, 28 Jan 2026 19:25:46 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
>
>> On Jan 28, 2026, at 5:40 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> ﻿
>>> Jens,
>>>
>>> Can you give me an acked-by on this patch and I can take the series through
>>> my tree.
>> On phone, hope this works:
>>
>> Acked-by: Jens Axboe <axboe@kernel.dk>
> Thanks!
>
>>> Or perhaps this doesn't even need to test the trace_async_init flag and can
>>> always do the work queue? Does blk_trace ever do tracing at boot up? That
>>> is, before user space starts?
>> Not via the traditonal way of running blktrace.
> Masami and Yaxiong,
>
> I've been thinking about this more and I'm not sure we need the
> trace_async_init kernel parameter at all. As blktrace should only be
> enabled by user space, it can always use the work queue.
>
> For kprobes, if someone is adding a kprobe on the kernel command line, then
> they are already specifying that tracing is more important.
>
> Patch 3 already keeps kprobes from being an issue with contention of the
> tracing locks, so I don't think it ever needs to use the work queue.
>
> Wouldn't it just be better to remove the trace_async_init and make blktrace
> always use the work queue and kprobes never do it (but exit out early if
> there were no kprobes registered)?
>
> That is, remove patch 2 and 4 and make this patch always use the work queue.

Yesterday, I was curious about|trace_event_update_all()|, so I 
added|pr_err(xx)|prints within the function's loop. I discovered that 
these prints appeared as late as 14 seconds later (printing is 
time-consuming), by which time the desktop had already been up for quite 
a while. However,|trace_eval_sync()|had already finished running at 0.6 
seconds.

This implies that I originally 
thought|trace_eval_sync()|'s|destroy_workqueue()|would wait for all 
tasks to complete, but it seems that might not be the case. From this, 
if the above conclusion is true, then strictly speaking, tasks 
using|queue_work(xx)|cannot be guaranteed to finish before the init 
process executes. If it's necessary to strictly ensure initialization 
completes before user space starts, 
using|async_synchronize_full()|or|async_synchronize_full_domain()|would 
be better in such scenarios.

Of course, the situation described above is an extreme case. I don't 
oppose this approach; I only hope to make the startup faster for 
ordinary users who don’t use trace, while minimizing the impact on 
others as much as possible.

>
> -- Steve
