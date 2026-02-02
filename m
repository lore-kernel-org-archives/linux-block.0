Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF73EBF3D;
	Mon,  2 Feb 2026 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770003413; cv=none; b=iYXRDMnR9meqzHefMiKNyrHOHhc8OP/zD+it7DijXuqIvV6+Q8uRNNwXbVEJXxLxYz98cqygeFxkxmH6CLC+XAGOdbbCbBLWm1UbBAkCHRIyaw0xdGzFCuHHLdJxjuUIc7YcvFdVvNxKpFxq3TIDZvS41lC7iuXMXxDm7prOp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770003413; c=relaxed/simple;
	bh=sa0ZTje5cCKG9BYgwI82GPOPyRH6hQgIOZP79ycjiTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xkpzd7k0cqsh9i4YNN3h+uF9Ladjru+2aewpqfd073zVXqpxctei6wYZ+4JF0YzDiYn0tUUjCchfqeGiFj9bMjQbj9ZZXYz5rHmx6KGpoup0JOVDu1C8p+h0vbGZuL5RwgvCpiB1wR4BVILbB2yTlJ+mYg7xGk+LLDp6H5S9PLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 65db17a4ffe811f0b0f03b4cfa9209d1-20260202
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f190fc87-00d9-4362-82cf-66f16955bade,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:a14d4cab7e9cf8a581fba014ede1612d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 65db17a4ffe811f0b0f03b4cfa9209d1-20260202
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1191676911; Mon, 02 Feb 2026 11:36:45 +0800
Message-ID: <277638df-1812-46fd-b9ad-893495f5c5a6@kylinos.cn>
Date: Mon, 2 Feb 2026 11:36:42 +0800
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

Hi Steven and Jens:

I've been thinking about this further. If we need to consider the 
possibility of non-traditional blktrace usage during the boot phase, 
could we perhaps use a grub parameter like 'ftrace=blk' to handle this? 
More specifically, we could check this through 
the|default_bootup_tracer|mechanism.

+bool __init trace_check_need_bootup_tracer(struct tracer *type)
+{
+       if (!default_bootup_tracer)
+               return false;
+
+       if (strncmp(default_bootup_tracer, type->name, MAX_TRACER_SIZE))
+               return false;
+       else
+               return true;
+}
+

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
>
> -- Steve
