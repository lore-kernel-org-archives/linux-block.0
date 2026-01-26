Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8228248B;
	Mon, 26 Jan 2026 02:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769395542; cv=none; b=rgtbgEtGFakynBjkELpLMtChOkqh9uPSqzWnGieQEeIJrTjX7nnm1JkCTWtSn2fRqIUfoAIeI5r2+h5Gw5lBJTeqh1vfU46XhUyLeDhu7oUYyyDRz1Lg/rukT93bBCje1p6OiRVhuzP5H+hqTtxNE2nZwzR9B3lDeohEiMylCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769395542; c=relaxed/simple;
	bh=+cN5ZOiciUWvsWPyD8/EilVaTmFNcsbKfHcYB9FJcKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4+aJ3Lg80vjdMewX3vlaaKRH3opvpRZ+y51S4gDNPONGJ7slGl02v8je+of1BibzMaK0cuQqDiSitk+cGr/SZgewo6qW3DhKq+Sl+bsVVg55grnItcKT+0udISsXSpHvugDOQKXLSbCgCPaLycZ2gkBN6VlojQyFk1fCqnXQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1798514cfa6111f0b0f03b4cfa9209d1-20260126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:57b3c94e-ee81-4ec5-8cd1-c4119b88192b,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:57b3c94e-ee81-4ec5-8cd1-c4119b88192b,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:1e55da3c77d56adf754c616902a7389a,BulkI
	D:260124043231HN9O7BOU,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1798514cfa6111f0b0f03b4cfa9209d1-20260126
X-User: tianyaxiong@kylinos.cn
Received: from [10.200.43.20] [(223.153.105.152)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2040554667; Mon, 26 Jan 2026 10:45:36 +0800
Message-ID: <d9e906f5-adfe-45da-84fe-d47ef9a159ba@kylinos.cn>
Date: Mon, 26 Jan 2026 10:45:32 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tracing: Export eval_map_wq for asynchronous use by
 other modules
To: Steven Rostedt <rostedt@goodmis.org>
Cc: axboe@kernel.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260122032051.386331-1-tianyaxiong@kylinos.cn>
 <20260122032415.395548-1-tianyaxiong@kylinos.cn>
 <20260123153247.004688f6@gandalf.local.home>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20260123153247.004688f6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/1/24 04:32, Steven Rostedt 写道:
> On Thu, 22 Jan 2026 11:24:15 +0800
> Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>
>> The eval_map_work_func() function, though queued in eval_map_wq,
>> holds the trace_event_sem read-write lock for a long time during
>> kernel boot. This causes blocking issues for other functions.
>>
>> Making eval_map_wq extern allows other modules to schedule their
>> work asynchronously on this queue,  preventing it from blocking
>> the main boot thread.
> If you are going to make this wq generic for other parts of the tracing
> code, then let's rename it. As "eval_map" is specific to the enum mappings
> being updated (which I hope someday I can get that update working at build
> time. And when I do, the name will be totally meaningless).
>
> Let's rename it to "trace_init_wq" instead.
>
> -- Steve

Thank you for your suggestion. I have renamed it to trace_init_wq and 
released the V2 version.



