Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AD1F9408
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543360; cv=none; b=KF5vH8pnvZuAD+GsUKMJ7cq3D/x1kQ+B3r2EF8JBz6xfHEht/l7HM+FhleoaBC+snV1ae0vILvAcREjHQnq6uDQrxpxKLFVWqqOdMonHzBpnUFfZwYzO9vfK9mnG5IikJZ3vjrS/FFTsU0TIFXXlBuoHPgX5b+8YusuEPUfaaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543360; c=relaxed/simple;
	bh=7fHoM9WgC0AzQJvulIgXYlUENUOkNvYrrofdOzuA99w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJOK+uiIpGx9Bd1Gsi/cV8bqzIBFQ3WTiAfpnFnlOYVfOgNvWDxRVvXLB6WgNbr++VQXs7HpZwAdKR0MTPs503/DayEHBBzMuk5eHEOYKEb/EvOtkJkvTm0FPovs0Jm/zOAc1LK+/w6Ev9GTrpFNDH15tNPQdifrBlbcxexDVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WFRcOPNS; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WFRcOPNS"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YD17242NDz6ClY9D;
	Wed, 18 Dec 2024 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734543356; x=1737135357; bh=OaVcGL/g+GUOiKSFRU/CD9TV
	Q0yJACLgYPhobYhNKZI=; b=WFRcOPNSOauFynwywESr/a1DF96YMPcbE2QAvpI1
	0uUcuCVoF7Dxy8jZzo+DU3rjmKDP9DEXs1Eon1tsWOkGBKRlzzJVaBRCTy+HuJoX
	Fe8dc/juMmOpCYU1W62pv/ipiT2q1RdI+BNFwdtkW5RgEXvNnmbllWYXbQdSSGgq
	QCU8jiPkWa/SeuGJ6SB0b64tfjmctOBDNwGmtsXG7hDK76Bvc/9ZQIyjjRUSppdm
	2RsIRvN7sGtbIOoeq9BtziTIWdt4ogqrJWhVO1qk7rhKuVNnPKuGx9JzR/FKPJzG
	UFiz1PX7SKRMOh16CyoSv+XHqm6tKbdKrv4ENbeq3nkKjg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Majh9BW25FzT; Wed, 18 Dec 2024 17:35:56 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YD16z3Cglz6CmQyV;
	Wed, 18 Dec 2024 17:35:54 +0000 (UTC)
Message-ID: <2db24c58-89fc-464b-8153-bbe2dd72969d@acm.org>
Date: Wed, 18 Dec 2024 09:35:54 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] blk-mq: Move more error handling into
 blk_mq_submit_bio()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241217223809.683035-1-bvanassche@acm.org>
 <20241217223809.683035-3-bvanassche@acm.org>
 <9c0b2f84-2562-48fb-98e8-343d68eb792d@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9c0b2f84-2562-48fb-98e8-343d68eb792d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 3:37 PM, Damien Le Moal wrote:
> On 2024/12/17 14:38, Bart Van Assche wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8d2aab4d9ba9..f4300e608ed8 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2968,12 +2968,9 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>>   	}
>>   
>>   	rq = __blk_mq_alloc_requests(&data);
>> -	if (rq)
>> -		return rq;
>> -	rq_qos_cleanup(q, bio);
>> -	if (bio->bi_opf & REQ_NOWAIT)
>> -		bio_wouldblock_error(bio);
>> -	return NULL;
>> +	if (!rq)
> 
> No unlikely() here ?

I will add unlikely here().

Thanks,

Bart.

