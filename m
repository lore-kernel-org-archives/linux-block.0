Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884373659F0;
	Fri, 30 Jan 2026 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769746233; cv=none; b=ShHUH+k1OhGiU6q+6iZ/3o8keYLbItZelnh6MdG/sWB07SN+JjTgIEOCu1pok7KxMVmfFsKCe7Ufv4GpXuknuDGZ9XLpC4RDOPCfqLkD6QhLyYC3wOMSIe7TibkUQuKOjviJF7gKgPsQFEJsRG/vkCZX3BECR1FsaCm/ze5glMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769746233; c=relaxed/simple;
	bh=WcqOXi51SLaCHI8JsAHkKOX3stPsziuTNF7QsGKhIeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6u/3B8CApKb1ds3ypA4cgb67HXREVPp2dxroZjz74WzwEzuPdHkYSxb0gRIjNLzvopcrnOnw/5bpsYf0tBkkpUzqclXIY6HJOvs3Vg+/Ai/SHZKeM9QXqCXqy6Gejhu+1dUPOoxqFVOdTgRCc3a6dbocjKf5g+njHoMhKoXB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9947ebfcfd9111f0b0f03b4cfa9209d1-20260130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9be15533-7bc8-4271-9ddf-f7e04d5300a2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:d7c5fa5842f10626ae13cb4617c6ad9a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9947ebfcfd9111f0b0f03b4cfa9209d1-20260130
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 460452061; Fri, 30 Jan 2026 12:10:23 +0800
Message-ID: <9f3a26b1-0bcc-47d9-b3ca-645b24a800bd@kylinos.cn>
Date: Fri, 30 Jan 2026 12:10:20 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] blktrace: Make init_blk_tracer() asynchronous when
 trace_async_init set
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Axboe <axboe@kernel.dk>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260128194104.30051be1@gandalf.local.home>
 <56C8934E-3D17-4467-93E6-D813770BF577@kernel.dk>
 <20260129152958.05c1ca46@gandalf.local.home>
 <bb29a10c-6130-4040-8521-0b5375c017ef@kylinos.cn>
 <a61e6bc0-58d1-46f0-8a4f-17f02503fe17@kylinos.cn>
 <20260129222608.7000bffd@robin> <20260129223116.489a01fd@robin>
 <20260129224520.7f043338@robin>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260129224520.7f043338@robin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/1/30 11:45, Steven Rostedt 写道:
> On Thu, 29 Jan 2026 22:31:16 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> I added the below patch and have this result:
>>
>>     kworker/u33:1-79      [002] .....     1.840855: trace_event_update_all: Start syncing
>>         swapper/0-1       [005] .....     6.045742: trace_eval_sync: sync maps
>>     kworker/u33:1-79      [002] .....    12.289296: trace_event_update_all: Finish syncing
>>         swapper/0-1       [005] .....    12.289387: trace_eval_sync: sync maps complete
>>
>> Which shows that the final initcall waited for the work queue to complete:
> Switching to printk() gives me the same results:
>
> # dmesg |grep sync
> [    1.117856] Start syncing
> [    4.498360] sync maps
> [   11.173304] Finish syncing
> [   11.175660] sync maps complete
>
> -- Steve

Sorry, yes, no problem. I confirmed that init_blk_tracer() is running 
properly (when executed sequentially) — if there were an issue, it would 
have already gotten stuck in a lock. It seems like this might be related 
to the print buffer. I’ll look into this issue myself.


Back to this topic — I don’t object to that proposal.
I think each has its own advantages. Let’s see what others think.
