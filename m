Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E94623D291;
	Tue, 27 Jan 2026 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477047; cv=none; b=C1LYXe4dWrFdXr3516/mKaaOqUzXkWAWzF6WhM/KAt9vlG50XrfpBLmSHIXNrKwyUeP9Gd3trQ88BcV77TJ3TwRecKfEHlDt7fRqMD1RCDJCCWSe4FjleL5DyoRW2Pz4UGl0zFmKcLDwf8F+/AXkyfPqGiortqNuXOv9ymo7boM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477047; c=relaxed/simple;
	bh=8em6UWzC5vOczi8379pMwNGb8nxf0WtOt7uyUfjrzEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XU0BZdQfjdOt4hGR+GkopC+BTvaR0jLNnWsIFubv1Q66MFjE1HCdXPdArqk5DJlVYkbS1zeHJpU82mZwbrSyoDrlxA9tz3GptvCPluZXu9FCqWUp6rl/vBxhcdYkq/1tkOrbZbX8nBo4e9PQ7/zHb9X0f0+HcHN4A+mWtWmRBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dcedaf7efb1e11f0b0f03b4cfa9209d1-20260127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2cc104e6-55c2-48f3-8710-d9cb08233ce7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:417de895736c93fb2731a3aad87c890c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dcedaf7efb1e11f0b0f03b4cfa9209d1-20260127
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1247447266; Tue, 27 Jan 2026 09:24:02 +0800
Message-ID: <5b9016cf-ccec-463e-acad-fb95c08c7602@kylinos.cn>
Date: Tue, 27 Jan 2026 09:23:59 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tracing: Rename `eval_map_wq` and export it for
 asynchronous use by other modules
To: Steven Rostedt <rostedt@goodmis.org>
Cc: axboe@kernel.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260126024033.290136-1-tianyaxiong@kylinos.cn>
 <20260126024316.297178-1-tianyaxiong@kylinos.cn>
 <20260126093646.3922b905@gandalf.local.home>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260126093646.3922b905@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/1/26 22:36, Steven Rostedt 写道:
> On Mon, 26 Jan 2026 10:43:16 +0800
> Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>
> Hi,
>
> Some of your terminology is a little confusing. The subject says "modules"
> but no module will use it (the term module means loadable code at runtime
> into the Linux kernel). A better subject would be:
>
>
>    tracing: Rename `eval_map_wq` and allow other parts of tracing use it
>
>
>> The eval_map_work_func() function, though queued in eval_map_wq,
>> holds the trace_event_sem read-write lock for a long time during
>> kernel boot. This causes blocking issues for other functions.
>>
>> Rename eval_map_wq to trace_init_wq and export it, thereby allowing
> Also saying "export" for a function means something like "EXPORT_SYMBOLE()"
> which again deals with Linux modules. A better term is "make it global".
>
>> other modules to schedule work on this queue asynchronously and
>   .. other parts of tracing ..
>
>> avoiding blockage of the main boot thread.
>>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> Other than that, this patch looks good.
>
> -- Steve

    Yes, those statements were not quite accurate. I have addressed them
    in Version 3.


