Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98BD167264
	for <linux-block@vger.kernel.org>; Wed, 29 May 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972625; cv=none; b=YClKo6EGLnORQe2zLEoNGb45YC46EfLkAnYuUgos03v/CiiowJbypXnG8QBRF+idy+Q9VZCedAz8oreNe9MJFSUYL7MHw/epn+2D4EivhhLwYAjpoOxOswNq4gwqaoj/MzDA5VWjqjmeL5dL+4aW+AYTAEI3WpaUsIPU/UNR6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972625; c=relaxed/simple;
	bh=bMb+JyJpOXSX7QHTPYWPm6pWiP7vcKhZlnsvLQdAUj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJEW9njsEoh81O4PV+KuNur4l/Nl7Um39NmZNmryNko24gJMuNaA+8s4TQKIq//eywCRxTLpbkm0ZIlpRJdu0GvWPnofV7XCZKCH2daKLH3jaBO2W240wOQSWLsER4eB5ahm93/lLkejtL+br70WT8fDXvtBK32MUZ/6qpVaIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GfZrbXch; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GfZrbXch"
X-Envelope-To: f.weber@proxmox.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716972619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgeF/JVXnC3EJ3fydg2FceQhkcpdIREaF3etaTJsIyc=;
	b=GfZrbXchwPcILQR8k+fioMNwsnPpJpfQe6SrTViBirmOwLh6b9eAqd2ZHwBUMcUaGyvANR
	a4Q0qUhK57Pe9pMSCmDwHn0bAZ73dAVTyUv69NcfdTqmQSUCsp9C53H7mVceZeiIjV5Te4
	abGcO5BhPL1jNJ4nfwumDJMD5uLlI3E=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: hch@lst.de
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <b73d3891-9a52-4f0c-b154-5a6d6117c697@linux.dev>
Date: Wed, 29 May 2024 16:50:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state
 machine
Content-Language: en-US
To: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
 <20230717040058.3993930-5-chengming.zhou@linux.dev>
 <14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com>
 <984f1f77-288c-441a-a649-5f320249b576@linux.dev>
 <4d799672-378b-42b1-896b-38df2c5e9c84@proxmox.com>
 <0783d367-4608-4b16-9b88-6eaf5d5706eb@linux.dev>
 <8b1400e6-b35e-486b-8ea0-de76270267c0@linux.dev>
 <87f495c2-7504-4d22-b355-608b13c456cd@linux.dev>
 <cb0fab18-ba27-420f-ace3-b099c74398c6@proxmox.com>
 <09be2bc6-d16a-4740-908a-f157dcd97ca8@linux.dev>
 <acc28f2c-0e72-409d-bb61-791ef62ddfd4@proxmox.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <acc28f2c-0e72-409d-bb61-791ef62ddfd4@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/28 22:40, Friedrich Weber wrote:
> On 28/05/2024 11:09, Chengming Zhou wrote:
>> On 2024/5/28 16:42, Friedrich Weber wrote:
>>> Hope I did this correctly. With this, the reproducer triggered a BUG
>>> pretty quickly, see [0]. If I can provide anything else, just let me know.
>>
>> Thanks for your patience, it's correct. Then how about this fix?
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index d98654869615..b2ec5c4c738f 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -485,6 +485,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>>         if (data->nr_tags > 1) {
>>                 rq = __blk_mq_alloc_requests_batch(data);
>>                 if (rq) {
>> +                       INIT_LIST_HEAD(&rq->queuelist);
>>                         blk_mq_rq_time_init(rq, alloc_time_ns);
>>                         return rq;
>>                 }
>>
> 
> Nice, seems like with this patch applied on top of 6.9, the reproducer
> does not trigger crashes anymore for me! Thanks!

Good news. Thanks.

> 
> To verify that the reproducer hits the new INIT_LIST_HEAD, I added debug
> prints before/after:
[...]
> And indeed, I see quite some printouts where rq->queuelist.next differs
> before/after the request, e.g.
> 
> May 28 16:31:25 reproflushfull kernel: before init: list:
> 000000001e0a144f next: 00000000aaa2e372 prev: 000000001e0a144f
> May 28 16:31:25 reproflushfull kernel: after init: list:
> 000000001e0a144f next: 000000001e0a144f prev: 000000001e0a144f
> May 28 16:31:26 reproflushfull kernel: before init: list:
> 000000001e0a144f next: 00000000aaa2e372 prev: 000000001e0a144f
> May 28 16:31:26 reproflushfull kernel: after init: list:
> 000000001e0a144f next: 000000001e0a144f prev: 000000001e0a144f
> 
> I know very little about the block layer, but if I understand the commit
> message of the original 81ada09cc25e correctly, it's expected that
> queuelist needs to be reinitialized at some places. I'm just a little

Yes, because we use list_move_tail() in the flush sequences. Maybe we can
just use list_add_tail() so we don't need the queuelist initialized. It
should be ok since rq can't be on any list when PREFLUSH or POSTFLUSH,
so there isn't any move actually.

But now I'm concerned that rq->queuelist maybe changed by driver after
request end? Don't know if this is a reasonable behavior, or I'm afraid
that the safest way is to revert the last patch. Want to know what Jens,
Ming and Christoph think?

> confused to see the same pointer 00000000aaa2e372 in two subsequent
> "before init" printouts for the same queuelist 000000001e0a144f. Is this
> expected too?
Not sure, but it seems possible. This is a rq_list in the plug cache,
000000001e0a144f is a PREFLUSH request, it will be freed after request end.
Then next time we again allocate it and put it in the plug cache,
just before 00000000aaa2e372 again. The reason why block doesn't use
00000000aaa2e372 maybe it's from a different queue or hardware queue.
But these are just my guess.

> 
> Also, just out of interest: Can you estimate whether this issue is
> specific to software RAID setups, or could similar NULL pointer
> dereferences also happen in setups without software RAID?

I think it can also happen without software RAID.

Thanks.
