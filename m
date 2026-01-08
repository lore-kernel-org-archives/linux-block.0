Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42A213254
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841055; cv=none; b=KAmGhY6jPIzLBVySJ+dxTNmZ52U6r8tNcTxA1S56BGhIEYXn2gTKgObAR4iovMLa6PJiqWWptFrACox989nTEJ71xJoEsjFSkTwK88L1eLR8o8zKIZez0884nNgHVe69I6xRKanBQsHOnJnhrnWJhshui0+/JNW5DCBNKj2B4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841055; c=relaxed/simple;
	bh=lELN0MFdKmh5KijQX4cGYcWLtEjiEiDKh5RTMWd8XFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFbQMwBXAfaj9Ok5bS6UM5rt+LXcTdSeBixPXKhuYfe1OtZLWDEmvZ+IedLP6qEVwJEVtQAG4gHTcZIKTclePuqcVOPIBbWTG+7wbEduZNfXQUAxInO9D9fVAoJnQ33aScfyxWaQM8WAKXEaQw/cDFtehsNihQrbEv2fGJHtVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=uOALkVvC; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="uOALkVvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1767841051;
	bh=LNxegYof74IPP9KhgYLykJdLB7hHFuhQpm3nUOS29DA=;
	h=Message-ID:Date:Subject:From;
	b=uOALkVvCmAUXamqwfp8656Ry2tz8PMA7kfY+DYdRQwP+WNMrRJwIYsbMcUlzXQyZl
	 wvRQCeqsxn0kV5AbVpUBlxxIfTO5I7BsIX8mADFZAz+Zj52rEZ7g3zgYLU6ats+/4g
	 FOK8Eh2cu0SNnsmXGrHhPbej3MGRqKFnPY/0+FwQ=
X-SMAIL-HELO: [10.189.149.126]
Received: from unknown (HELO [10.189.149.126])([114.247.175.249])
	by sina.com (10.54.253.33) with ESMTP
	id 695F1D0F00006204; Thu, 8 Jan 2026 10:57:21 +0800 (CST)
X-Sender: zhangdongdong925@sina.com
X-Auth-ID: zhangdongdong925@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=zhangdongdong925@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangdongdong925@sina.com
X-SMAIL-MID: 8957726685282
X-SMAIL-UIID: 56B5BAE87F644BB09AAD52D6CCF48F14-20260108-105721-1
Message-ID: <a527b179-263f-40ad-9d7c-bfa86731bfde@sina.com>
Date: Thu, 8 Jan 2026 10:57:19 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/7] zram: introduce compressed data writeback
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Richard Chang <richardycc@google.com>, Minchan Kim <minchan@kernel.org>,
 Brian Geffon <bgeffon@google.com>, David Stevens <stevensd@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, Minchan Kim <minchan@google.com>
References: <20251201094754.4149975-1-senozhatsky@chromium.org>
 <20251201094754.4149975-2-senozhatsky@chromium.org>
 <40e38fa7-725b-407a-917a-59c5a76dedcb@sina.com>
 <7bnmkuodymm33yclp6e5oir2sqnqmpwlsb5qlxqyawszb5bvlu@l63wu3ckqihc>
 <2663a3d3-2d52-4269-970a-892d71c966bb@sina.com>
 <z22c2qgw2al73yij2ml2hlle2p24twgpmz4jemfqhjoiekc65f@pvap7olsolfp>
Content-Language: en-US
From: zhangdongdong <zhangdongdong925@sina.com>
In-Reply-To: <z22c2qgw2al73yij2ml2hlle2p24twgpmz4jemfqhjoiekc65f@pvap7olsolfp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/26 18:14, Sergey Senozhatsky wrote:
> On (26/01/07 15:28), zhangdongdong wrote:
>> Hi,Sergey
>>
>> Yes, we have tried high priority workqueues. In fact, our current
>> implementation already uses a dedicated workqueue created with
>> WQ_HIGHPRI and marked as UNBOUND, which handles the read/decompression
>> path for swap-in.
>>
>> Below is a simplified snippet of the queue we are currently using:
>>
>> zgroup_read_wq = alloc_workqueue("zgroup_read",
>> 				 WQ_HIGHPRI | WQ_UNBOUND, 0);
>>
>> static int zgroup_submit_zio_async(struct zgroup_io *zio,
>> 				   struct zram_group *zgroup)
>> {
>> 	struct zgroup_req req = {
>> 		.zio = zio,
>> 	};
>>
> 
> zgroup... That certainly looks like a lot of downstream code ;)
> 
> Do you use any strategies for writeback?  Compressed writeback
> is supposed to be used for apps for which latency is not critical
> or sensitive, because of on-demand decompression costs.
> 

Hi Sergey,

Sorry for the delayed reply — I had some urgent matters come up and only
got back to this now ;)

Yes, we do use writeback strategies on our side. The current 
implementation focuses on batched writeback of compressed data from
zram, managed on a per-app / per-memcg basis. We track and control how
much data from each app is written back to the backing storage, with the
same assumption you mentioned: compressed writeback is primarily
intended for workloads where latency is not critical.

Accurate prefetching on swap-in is still an open problem for us. As you
pointed out, both the I/O itself and on-demand decompression introduce
additional latency on the readback path, and minimizing their impact
remains challenging.

Regarding the workqueue choice: initially we used system_dfl_wq for the
read/decompression path. Later, based on observed scheduling latency
under memory pressure, we switched to a dedicated workqueue created with
WQ_HIGHPRI | WQ_UNBOUND. This change helped reduce scheduling
interference, but it also reinforced our concern that deferring
decompression to a worker still adds an extra scheduling hop on the
swap-in path.

Best regards,
dongdong

