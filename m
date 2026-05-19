Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E3229B12
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152951; cv=none; b=DnBzOE7/PfJW91RKrRlvoQlORlawqCWzDDQrDPWOszMIr57X7ok/zAj6d0xpGPt3IeO0qNJNzDq7oYFhDRw+TPjWsliEcBJR1n2eXCNC08WqXFIVjg7Yp9ikL02H9iMNJ9uV56DqGpAsos3LHJGBOEQUG0EkLB9XyT2uCRW7+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152951; c=relaxed/simple;
	bh=7KsrajsOnaFxWUpNuzInvvAVGL5emmvIbZDYUPfYKH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Umo57l3i4QSsHTKZwHgsvDn7ZNSs0T7vyaEYFZd0Ejpq0GoFytd24yKXEwwTsbdOFgl1dU8p/60Qwfz1Px2IM5q1bBz61qo1qMlnaJMKQtyPb5V0jsWyqHCI3rHw9LG7jETXrP8Hwg/7ZNZ2eM8hzF2cNh9IbZjEOC3mLQZUolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5352f39c531f11f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f6f5ee46-a637-457e-9c34-60f05995171c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:f6f5ee46-a637-457e-9c34-60f05995171c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:0c0abba9b59a9f67d23beee9f7fc041b,BulkI
	D:2605190319169S5WQJQG,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5352f39c531f11f1aa26b74ffac11d73-20260519
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1752752359; Tue, 19 May 2026 09:09:03 +0800
Message-ID: <81e4ddb6-284a-4e24-a362-b743156343f9@kylinos.cn>
Date: Tue, 19 May 2026 09:08:58 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup-rwstat: add missing DISCARD counter in
 blkg_rwstat_total()
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20260516044752.446995-1-cuitao@kylinos.cn>
 <agtmKyx4GqRQrftf@slm.duckdns.org>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <agtmKyx4GqRQrftf@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/5/19 3:19, Tejun Heo 写道:
> On Sat, May 16, 2026 at 12:47:52PM +0800, Tao Cui wrote:
>> Since commit 636620b66d5d ("blkcg: Track DISCARD statistics and output
>> them in cgroup io.stat"), blkg_rwstat_add() routes discard IOs into
>> BLKG_RWSTAT_DISCARD, but blkg_rwstat_total() still only sums READ and
>> WRITE.  This makes the total inconsistent with the per-type counters
>> whenever discard IOs are present.
>>
>> On mixed read/write/discard workloads, the total undercounts the
>> actual IO activity.  If only discard requests are queued, the total
>> returns 0 outright.  In BFQ this causes avg_queue_size to be
>> underestimated and the group to be incorrectly marked empty.
>>
>> The affected BFQ code paths are all gated by CONFIG_BFQ_CGROUP_DEBUG
>> and used only for statistics display (bfq.sectors, bfq.avg_queue_size,
>> bfq.empty_time).  No scheduling decisions depend on these values.
> 
> I don't think including discard in total io amount is an improvement. This
> will throw off a lot of people.
> 
Thanks for the review. 
You're right - for stats.bytes (displayed as
bfq.sectors), including discard doesn't make semantic sense since
discard doesn't transfer data.

The original motivation was the stats.queued case in BFQ: when only
discard requests are pending, blkg_rwstat_total() returns 0, so
bfqg_stats_set_start_empty_time() incorrectly marks the group as empty.
However, this code path is gated by CONFIG_BFQ_CGROUP_DEBUG and is
purely for debug display, so the practical impact is minimal.

I'll drop this patch.

Thanks.
--
Tao

