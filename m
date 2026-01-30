Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC652AEE4;
	Fri, 30 Jan 2026 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767188; cv=none; b=dEildheSDZrhYpapiAj28az97p/PGTbhk2Yvq2+jkBz8pD/lv+jPT8S1OzSUSYMWWGYRQpjtjGvU7x5n6zkY9tOP96KFTSzwV7chuNlSTfLCjUgL4SL7084wiLd+pH6pH+rmFffLxr6FQt7oecgAQdWZUws2L+W8A4YHWAxliVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767188; c=relaxed/simple;
	bh=YGvYE1yGye3usboBMJz4T9DZAbf9vHqZQFDtQ12YWBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ub3DotEGzgukp1CO6xKo4LlaKydhRGOcWSqPJIfKoEAKgNk3D9aEgNgUjzeBitQV82eeFFBJflaoID3o9fY2MX4DkNWijy1ubkKSsKuUwaRA7BY/CHGSd4vh3i86UB9VNHXvi664pSxfTfPdBY6qmDSWGNz3Mh6QhiK21zqh0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5f5152c2fdc211f0b0f03b4cfa9209d1-20260130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dacac5f0-8548-4193-b280-e887edce23e6,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:f477d8c7c696d8a04fbea3d8093fce5b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5f5152c2fdc211f0b0f03b4cfa9209d1-20260130
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1982855113; Fri, 30 Jan 2026 17:59:31 +0800
Message-ID: <63d5e338-3ba4-4def-926f-a32490c6fea9@kylinos.cn>
Date: Fri, 30 Jan 2026 17:59:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous when
 trace_async_init set
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@kernel.dk>, mathieu.desnoyers@efficios.com,
 corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260128194104.30051be1@gandalf.local.home>
 <56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
 <20260129152958.05c1ca46@gandalf.local.home>
 <20260130183022.add316050dd9638e6d71a469@kernel.org>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260130183022.add316050dd9638e6d71a469@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/1/30 17:30, Masami Hiramatsu (Google) 写道:
> On Thu, 29 Jan 2026 15:29:58 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Wed, 28 Jan 2026 19:25:46 -0700
>> Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> On Jan 28, 2026, at 5:40 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>>> ﻿
>>>> Jens,
>>>>
>>>> Can you give me an acked-by on this patch and I can take the series through
>>>> my tree.
>>> On phone, hope this works:
>>>
>>> Acked-by: Jens Axboe <axboe@kernel.dk>
>> Thanks!
>>
>>>> Or perhaps this doesn't even need to test the trace_async_init flag and can
>>>> always do the work queue? Does blk_trace ever do tracing at boot up? That
>>>> is, before user space starts?
>>> Not via the traditonal way of running blktrace.
>> Masami and Yaxiong,
>>
>> I've been thinking about this more and I'm not sure we need the
>> trace_async_init kernel parameter at all. As blktrace should only be
>> enabled by user space, it can always use the work queue.
>>
>> For kprobes, if someone is adding a kprobe on the kernel command line, then
>> they are already specifying that tracing is more important.
>>
>> Patch 3 already keeps kprobes from being an issue with contention of the
>> tracing locks, so I don't think it ever needs to use the work queue.
>>
>> Wouldn't it just be better to remove the trace_async_init and make blktrace
>> always use the work queue and kprobes never do it (but exit out early if
>> there were no kprobes registered)?
> Yeah, for kprobes event case, that sounds good to me. I think [3/5] is
> enough to speed it up if user does not define kprobe events on cmdline.
>
> Thank you,

Agreed.

Hi Jens：

  what do you think about this proposal (making blktrace always use the 
work queue)?

>
>> That is, remove patch 2 and 4 and make this patch always use the work queue.
>>
>> -- Steve
>
