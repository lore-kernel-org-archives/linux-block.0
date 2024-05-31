Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE081754
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143431; cv=none; b=ByvzoJiPkUljtvJ5pxV9usNzpQ3SvMdSHL6+0b6QFkicFRPnOQgzM7uSwH2fJySbi+5C54ujkgx+vUA0n4zUUpmWdsVdRBuPcIwXWVryBOqr7xQbJuXurVEEwnGndWwiJ6ff2vbj6lnQ4Vl7YncPJqPEOoher3CiO+ZRAC5fJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143431; c=relaxed/simple;
	bh=5dHqdUCORxMwbjC56qe7RX8eYPQZ/a64TgykFdt3cOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3IlYAKACUAT2O8GPDFUAcQxO/rS5pIHFxQpsBrKzW1YWAY83xzO4xOY6tqtcXi6KCIcYbxazSapi8tTcICQ88bO1nyx3HZrDw4hxVNS/3xa3/j+kCbyyHNZehYiV9Qj6HmUUv1E5+enrwXzYn/7aCaPRGhB8QferEqNr6Wt69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAWZs1XE; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAWZs1XE"
X-Envelope-To: hch@lst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717143427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzXq8h/OWpyiBz5bXWyZc17AMHVIAg5md23jvDLRStM=;
	b=SAWZs1XE541oVcDwYRqqzOSJQ4QAPJ6Ex2GJjeBRBWuWhhiTLObFcejxUa3jyIw+of2TVJ
	WNR322RbNIn95pJXy+Qo2KhGlWE2iCHlH8kII7HqHEl8NCAjxOLipZSOARGfkU2BlOh4Fr
	NSZT4sH+CjsGszssjdMYiLejAzTy3i0=
X-Envelope-To: f.weber@proxmox.com
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <e437a447-33ac-465e-ac9b-7b9a9005c24e@linux.dev>
Date: Fri, 31 May 2024 16:16:37 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state
 machine
To: Christoph Hellwig <hch@lst.de>
Cc: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
 ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com>
 <984f1f77-288c-441a-a649-5f320249b576@linux.dev>
 <4d799672-378b-42b1-896b-38df2c5e9c84@proxmox.com>
 <0783d367-4608-4b16-9b88-6eaf5d5706eb@linux.dev>
 <8b1400e6-b35e-486b-8ea0-de76270267c0@linux.dev>
 <87f495c2-7504-4d22-b355-608b13c456cd@linux.dev>
 <cb0fab18-ba27-420f-ace3-b099c74398c6@proxmox.com>
 <09be2bc6-d16a-4740-908a-f157dcd97ca8@linux.dev>
 <acc28f2c-0e72-409d-bb61-791ef62ddfd4@proxmox.com>
 <b73d3891-9a52-4f0c-b154-5a6d6117c697@linux.dev>
 <20240531061708.GB18075@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240531061708.GB18075@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/31 14:17, Christoph Hellwig wrote:
> On Wed, May 29, 2024 at 04:50:02PM +0800, Chengming Zhou wrote:
>> Yes, because we use list_move_tail() in the flush sequences. Maybe we can
>> just use list_add_tail() so we don't need the queuelist initialized. It
>> should be ok since rq can't be on any list when PREFLUSH or POSTFLUSH,
>> so there isn't any move actually.
> 
> Sounds good.

Ok, I could send a fix that changes to use list_add_tail() later.

> 
>> But now I'm concerned that rq->queuelist maybe changed by driver after
>> request end?
> 
> How could the driver change it?

I don't know much about drivers. Normally, they will detach rq->queuelist
from their internal list and do blk_mq_end_request(), in which we reuse
this queuelist to add rq to the post-flush list.

Strictly speaking, that rq's ownership still belongs to the drivers until
they call blk_mq_free_request(), right? So I'm not sure if the drivers
would touch rq->queuelist after blk_mq_end_request(). If the drivers don't
have such behaviors, then we are good.

> 
>>> Also, just out of interest: Can you estimate whether this issue is
>>> specific to software RAID setups, or could similar NULL pointer
>>> dereferences also happen in setups without software RAID?
>>
>> I think it can also happen without software RAID.
> 
> Seems to be about batch allocation.  So you either need a plug in
> the stacking device, or io_uring.  I guess people aren't using the
> io_uring high performance options on devices with a write cache
> all that much, as that should immediately reproduce the problem.
> 
