Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA927FD6F
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547388; cv=none; b=nX3k8VLMvMbfyyAYG8WwbXN4nv4fik16EUgyz5c5iuddmCcxN9ZwdzYvuB7S3hKiRAP4jShIT3lTxry7omftdcrOFtOpobW9CsP5dEwj1UyQLdWqEGxN0oubdnK3XquVkDR8zIw8YOIjhWHhUsJuKA+52d8zGTWW9gCEEnmBjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547388; c=relaxed/simple;
	bh=24uoHi10i0HxqHGkDnd9Rec0+Fi2ODT6fqrdzLAuiWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzFoKrYmuwKfUBaFDwb3J7+Mn+EDBCKUa/9+okr9g2+GziLTI83mVN6l7YY5W39knnh32YvjWT7G4MWT9ISzwhTr1QBK4CFaQ3Ps9/89Zk76YZq3pbYMTxwOvbNGfoTNzlLXt8ADpmiY37ZMItHM2nWNKTZW8ELMki3cnb8eZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=q/wd5W1a; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="q/wd5W1a"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZsNTc0jSvzm1Hbj;
	Tue,  6 May 2025 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1746547378; x=1749139379; bh=q0xTY3WI8VBpOIjZtLXdosAU
	uO9Yybi00N1fF2k+GeQ=; b=q/wd5W1alGgiy8WFfuDJCrYvqaRMkxpDDe8uEEkj
	4jA5BFekCtOAIm4EsahcGczDzXMTataNm3e3rjTToNiuo/iVSLVXN2B6ssRht+Dr
	fKypaFm4Iy5j97CMqZNEyh7+GfW+/u+vGltBV8ZzojvVJvfQKdOrX8xTouk1Os68
	nm+UbqcBhPUk1JnsHl3J96NDNLQoCMDdNUuClPAIeThYuCb/pyVqQTRVlDJGkX+P
	AgPBpS+Jw9N/kckFqxFmizl2XQX/bOFK3jlfV+vTmllPV6VKQ6BLsH7OYkQ6vU6T
	xxhnfDciOaZ/n93wfpFRTe096wInVQCkEu0ZdR9OflMp1Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g01OzY2N1wgC; Tue,  6 May 2025 16:02:58 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZsNTT4j7Zzm0ysb;
	Tue,  6 May 2025 16:02:52 +0000 (UTC)
Message-ID: <5ccb451e-f13b-40d8-9494-e5a2cedc84a3@acm.org>
Date: Tue, 6 May 2025 09:02:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: only update request sector if needed
To: Johannes Thumshirn <jth@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 linux-block@vger.kernel.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 4:27 AM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> In case of a ZONE APPEND write, regardless of native ZONE APPEND or the
> emulation layer in the zone write plugging code, the sector the data got
> written to by the device needs to be updated in the bio.
> 
> At the moment, this is done for every native ZONE APPEND write and every
> request that is flagged with 'BIO_ZONE_WRITE_PLUGGING'. But thus
> superfluously updates the sector for regular writes to a zoned block
> device.
> 
> Check if a bio is a native ZONE APPEND write or if the bio is flagged as
> 'BIO_EMULATES_ZONE_APPEND', meaning the block layer's zone write plugging
> code handles the ZONE APPEND and translates it into a regular write and
> back. Only if one of these two criterion is met, update the sector in the
> bio upon completion.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 328075787814..594eeba7b949 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -480,7 +480,8 @@ static inline void blk_zone_update_request_bio(struct request *rq,
>   	 * the original BIO sector so that blk_zone_write_plug_bio_endio() can
>   	 * lookup the zone write plug.
>   	 */
> -	if (req_op(rq) == REQ_OP_ZONE_APPEND || bio_zone_write_plugging(bio))
> +	if (req_op(rq) == REQ_OP_ZONE_APPEND ||
> +	    bio_flagged(bio, BIO_EMULATES_ZONE_APPEND))
>   		bio->bi_iter.bi_sector = rq->__sector;
>   }
>   void blk_zone_write_plug_bio_endio(struct bio *bio);

Does this patch need a "Fixes:" tag? Is the below correct?

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")

Thanks,

Bart.

