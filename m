Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CF1F2395
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469578; cv=none; b=XoAhF027i+f8o/SZwmjxi2pijcQCZAGcWkt5awwxo03E6TBl/2ZXydr7IaItPreNz0GGQbkQTtChryUvBRLjHro37+yRMkQpKaHaA8CTHrfusIf0VolbgNAPMs8F08XIQm8c1Qu5Sf0js4GajVkJolQ+kbo+4cb/MKX2nXNe/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469578; c=relaxed/simple;
	bh=7B0UExx/8kXvSUMbRNUWrcrX/wF9odUMxmaDZS52uJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chuwZ0izI1Mt/QujJ4bhCEeSmK2saFlZFAFRiaKCPVkxZFqGx70ysFd7KaAto6GDZleAre8LiGyT3HGpdr08MJlDRc7su+ie/ktCeyt508oewBEq+CRoE8r5CZYgVMPGDtjveZvuTcLl7q6XpAQGMPyPG2p83NkocVHJxea5EJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aUcDkPYB; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aUcDkPYB"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCTr83VrBzlff0M;
	Tue, 17 Dec 2024 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734469574; x=1737061575; bh=W+fxPZgBAR3X0/yYw0BBm7nx
	R5aKjBzC98Ypb29qPHw=; b=aUcDkPYBeg04fcUUWC7ZM3OloQDRRBMHn1+Y3ocM
	bIyHM/bKqKRzavFoooRILJL0oMhv6aUJB2UzMmDkAAMfJQYEzJwsYl2R4LR3e56e
	aB6UMrpLc7oM2TjndsML7jaQ7tw/AlH5JkdQNS/lkoiZdldbJnafKoFSqyMKuJCP
	i96gG8PVVlNb/6+YvcHkDCWQBftSGFM+xNEOo1jq81bxSau3fx8/qwg7kSK/FXiu
	1jFXh1pyBMkp3xy5SeZ7EJSD2GOlwh1R6mjtwzRa5pR7YbVBrSU+qrRZeqGBNViU
	hgg6f+FB++iACUkYUswZC6rf3zxMvzE1k2uAgRvgPBGsYA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YpWbAeUfoYfn; Tue, 17 Dec 2024 21:06:14 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCTr53dv1zlffl6;
	Tue, 17 Dec 2024 21:06:13 +0000 (UTC)
Message-ID: <b17872ef-46ad-4a6a-9a6b-17edc4a25630@acm.org>
Date: Tue, 17 Dec 2024 13:06:12 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: Move more error handling into
 blk_mq_submit_bio()
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
References: <20241216201901.2670237-1-bvanassche@acm.org>
 <20241216201901.2670237-3-bvanassche@acm.org> <20241217041819.GB15286@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241217041819.GB15286@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 8:18 PM, Christoph Hellwig wrote:
> On Mon, Dec 16, 2024 at 12:19:01PM -0800, Bart Van Assche wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8d2aab4d9ba9..80eb91296142 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2971,8 +2971,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>>   	if (rq)
>>   		return rq;
>>   	rq_qos_cleanup(q, bio);
>> -	if (bio->bi_opf & REQ_NOWAIT)
>> -		bio_wouldblock_error(bio);
>>   	return NULL;
> 
> Please turn this into:
> 
> 	if (rq)
> 		rq_qos_cleanup(q, bio);
> 	return rq;
> 
> Otherwise this looks like a nice cleanup.

It seems to me that there is a typo in the above code? Unless if you 
tell me otherwise, I will assume that this is what you meant:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8d2aab4d9ba9..f4300e608ed8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2968,12 +2968,9 @@ static struct request 
*blk_mq_get_new_requests(struct request_queue *q,
  	}

  	rq = __blk_mq_alloc_requests(&data);
-	if (rq)
-		return rq;
-	rq_qos_cleanup(q, bio);
-	if (bio->bi_opf & REQ_NOWAIT)
-		bio_wouldblock_error(bio);
-	return NULL;
+	if (!rq)
+		rq_qos_cleanup(q, bio);
+	return rq;
  }

  /*
@@ -3106,8 +3103,11 @@ void blk_mq_submit_bio(struct bio *bio)
  		blk_mq_use_cached_rq(rq, plug, bio);
  	} else {
  		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
-		if (unlikely(!rq))
+		if (unlikely(!rq)) {
+			if (bio->bi_opf & REQ_NOWAIT)
+				bio_wouldblock_error(bio);
  			goto queue_exit;
+		}
  	}

  	trace_block_getrq(bio);



Thanks,

Bart.
