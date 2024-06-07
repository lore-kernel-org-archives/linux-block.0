Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736F12B82
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727912; cv=none; b=pJbTXoBOu1CRru48TOzFF4PoTsXo+IFli48gShI9UgxLH/cGV2W5GshK9Br1GU1/W+kh7FLFsoVbkijZsc1WhDxcRhVNEtZPl7DirO4PCchP84DfOG+WKkw92yqZpRwYKDflc3WKMhcW8LfX+szv8npdvMat466J5Cpd7vQygGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727912; c=relaxed/simple;
	bh=row/k4V06BFcsKgcUwM71N/fgid6G8p8OJYSYQRn+K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AELb7+hiNlWpld+N09enGBAzYLo8Ir9ydEMqANasUvJUYEUV9cBY9xYcRVcXY4fnS97c0GxG80JyqZH7P/l8vFkBsrQWxAe/Yki8sEq3ETVVctXh2cXK9l1pvbzLkea7Nqysuv41LziurmENOye8nlAB5k1chqwLSeVTeXo/3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cf8+kVsX; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cf8+kVsX"
X-Envelope-To: f.weber@proxmox.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717727906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5cl22TJx1Pe154z2+5RY4NsMXHNLckBEoj8Ony60l8=;
	b=Cf8+kVsXvI6K4CaFDvg72k3cZXoSFxSpH3Q6lPBdT4N9wn7+i9Ioc7Jg9QFQ+GsUxAJGPG
	AbwGre14z1Tyg9KvkQtnNLvDJNgBo/QUQSBE64brnXnbb2ZiYCQ2sRKp1/XIujrXhXuXP1
	8l4/fPBq7IyVIh/yU7j/yVC5roM6GMg=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: hch@lst.de
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: t.lamprecht@proxmox.com
Message-ID: <dea87c0a-1c36-4737-bea5-cb7fa273b724@linux.dev>
Date: Fri, 7 Jun 2024 10:37:58 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
Content-Language: en-US
To: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
 <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
 <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
 <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev>
 <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/6 16:44, Friedrich Weber wrote:
> On 05/06/2024 16:27, Chengming Zhou wrote:
>> On 2024/6/5 21:34, Friedrich Weber wrote:
>>> On 05/06/2024 12:54, Friedrich Weber wrote:
>>> [...]
>>>
>>> My results:
>>>
>>> Booting the Debian (virtual) machine with mainline kernel v6.10-rc2
>>> (c3f38fa61af77b49866b006939479069cd451173):
>>> works fine, no crash
>>>
>>> Booting the Debian (virtual) machine with patch "block: fix
>>> request.queuelist usage in flush" applied on top of v6.10-rc2: The
>>> Debian (virtual) machine crashes during boot with [1].
>>>
>>> Hope this helps! If I can provide anything else, just let me know.
>>
>> Thanks for your help, I still can't reproduce it myself, don't know why.
> 
> Weird -- when booting the Debian machine into mainline kernel v6.10-rc2
> with "block: fix request.queuelist usage in flush" applied on top, it
> crashes reliably for me. The machine having its root on LVM seems to be
> essential to reproduce the crash, though.

Yeah, right, it seems LVM may create this special request that only has
PREFLUSH | POSTFLUSH without any DATA, goes into the flush state machine.
Then, cause the request double list_add_tail() without list_del_init().
I don't know the reason behind it, but well, it's allowable in the current
flush code.

> 
> Maybe the fact that I'm running the Debian machine virtualized makes the
> crash more likely to trigger. I'll try to reproduce on bare metal to
> narrow down the reproducer and get back to you.

Thanks much for your very detailed process on that thread!

> 
>> Could you help to test with this diff?
>>
>> diff --git a/block/blk-flush.c b/block/blk-flush.c
>> index e7aebcf00714..cca4f9131f79 100644
>> --- a/block/blk-flush.c
>> +++ b/block/blk-flush.c
>> @@ -263,6 +263,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
>>                 unsigned int seq = blk_flush_cur_seq(rq);
>>
>>                 BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
>> +               list_del_init(&rq->queuelist);
>>                 blk_flush_complete_seq(rq, fq, seq, error);
>>         }
> 
> I used mainline kernel v6.10-rc2 as base and applied:
> 
> - "block: fix request.queuelist usage in flush"
> - Your `list_del_init` addition from above
> 
> and if I boot the Debian machine into this kernel, I do not get the
> crash anymore.

Good to hear. So can I merge these two diffs into one patch and add
your Tested-by?

> 
> Happy to run more tests for you, just let me know.

Thanks again!
