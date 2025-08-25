Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6B2857FA
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134542; cv=none; b=o/EfVlqZxigFxvKPGwxtBG/10eoKfxHv+WG5mq/v9EIlZ1KyG2TM45sCIAIrjdVytKpSD9gWeXcrkt01qJzLBy+4AnQ+y/V10/fGjNZXXqAU79Q6rD34jIX2FFtZ4SCHbL0zfZlY0IK4VbnkxfFoVyOSbtYSkbvz0HJ6aBoBLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134542; c=relaxed/simple;
	bh=xWIldgWahO2KrWGRuCTETz3zZgNPSw8Oc4ErMmnA9s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOyBC3n7SBlD5+QJ33UwXhjx/VuKX/jnqONUCPvL8qCfkkLOhCyfvKy5TL2Aq2gsZepQ8Nqsx3KvyEnBVUbxG1B8BNLcKnmeLWjCxP8eOMuRC0TJxSqtTFGzh/nFaqEqv9awfdMqec9HDb05p0Wa37Ai5DHWMkmTqlO7tPdhnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=5EGsEfW6; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="5EGsEfW6"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c9Z1w6yLGzm174B;
	Mon, 25 Aug 2025 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756134531; x=1758726532; bh=C0zJJ9o2VrnkEoclTGzZ4ohY
	VFG+iTR7TRpav9R7VZ8=; b=5EGsEfW6g+nvaj+aBr6yx0aPTAM8Iiftm8dRJhjK
	1hj5Bs7C7/QVYfT1JKOJv98WW3xYeGVObvdsDRSDCJnk86LMdhOKrlb+h+uxMTFB
	OV7EIu+3drN5tyqy1EDIqEqVJTS4FiM7mrVALEE9yN5Ooz/VJc1t+JN69jL6gnDy
	hXIFjb82UaT9iEG7bgzBGuFwJ5xVCx3qlA1DmfvkHz1POCntDhrAHhcIOXnEs+PZ
	fWzBkG4KJs273sd8XeWmh4Fl2nP6G1cH1IcQPXWhn+G9bgNKmuo/wq2Ocq6FqrHa
	Grs9xmINH7s/QgKtxAEf7AcQIxDWiD5275EXEhW5thg8PA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RZHdNIrvbNge; Mon, 25 Aug 2025 15:08:51 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c9Z1s0Rwkzm1748;
	Mon, 25 Aug 2025 15:08:48 +0000 (UTC)
Message-ID: <17b4a517-c35a-412b-843d-e9ee47b12370@acm.org>
Date: Mon, 25 Aug 2025 08:08:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Move a misplaced comment in queue_wb_lat_store()
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <20250822200157.762148-1-bvanassche@acm.org>
 <61bf6a0f-05de-44c6-b4eb-87254fca4d24@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <61bf6a0f-05de-44c6-b4eb-87254fca4d24@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/25 6:48 AM, Jens Axboe wrote:
> On Fri, Aug 22, 2025 at 2:02?PM Bart Van Assche <bvanassche@acm.org> wrote:
>> blk_mq_quiesce_queue() does not wait for pending I/O to finish. Freezing
>> a queue waits for pending I/O to finish. Hence move the comment that
>> refers to waiting for pending I/O above the call that freezes the
>> request queue. This patch moves this comment back to the position where
>> it was when this comment was introduced. See also commit c125311d96b1
>> ("blk-wbt: don't maintain inflight counts if disabled").
> 
> Doesn't apply to the current tree, what is this against?

These patches are in my local tree and are causing the failure to apply:
"[PATCH 0/3] Fix a deadlock related to modifying queue attributes"
(https://lore.kernel.org/linux-block/20250702182430.3764163-1-bvanassche@acm.org/). 
I should have removed these from my local tree
before I posted this patch.

> In any case, please resend.

Sure, I will do that.

Thanks,

Bart.


