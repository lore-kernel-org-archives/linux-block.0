Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DB481DD
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664393; cv=none; b=iuw/tP4KVWNY02Ixsi9JJKEoTY0N23P+E4Os6mXtpIIX+mUqqKtAeVXfx0JVDJIvp3QLQJYLT9KDGdLrf6mPq14MytiZJujjtkXHbxPAVZ9BHjZOeTuDzm16YMcfrqY5v/c9Gml1vP0ELZnWKqD+A4EKk8RorOeidYAleK13u3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664393; c=relaxed/simple;
	bh=n29SWBKl7oswJ0dyj3UVtBm7SSsFZICxshrtfZP+XjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nv2PPhvbYEE5tp9wbkdp4jIsZD+/AJBGmDzW915JtDAeS1AHeIh+5HBYpe3s3USkIURPJMawl6wKjDMaqRCYx/DeCXw7S/u6OoVNmX4azmzOG7vE8gYTwLjB0g5pbLeDzav0ir+zGVz9nEzP0LIVG82t9XcIusH6ri6GL/KMqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=emuXcj6Q; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="emuXcj6Q"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3dc6f653152so614145ab.3
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749664389; x=1750269189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UWhblRKeJ7uV8gaFTJfI5e6Ljnl9SB2XSSji8BfVNmE=;
        b=emuXcj6QpFwH5UHGfX5k9kLuYtWV0RhK4FWVm1gY2N75rkEsecAZohaioDpFqiOYvB
         /Z9mA2/H2Um2kzd8FpL0SoEFTzwqy+m18jnH+sr+Zbv3ppKiisA2k5k4CG+55UB3qqFz
         fnExKGEsm0VoR0VWisQ4Isaow77XntFOBI4K0oBGVGDguzRJsd8b05iwsX4+PAcJF4ZO
         HmpP11qkNjenWelW/gq/CFY+agY33l5YqVvP6OP9Iv1GiX8hH7XpBaRmJ0e14eoYGNJk
         dvYdOE7Co13fP2+q4idvjIOXX98SPE9byxOXKXQlUk9oDAmfykfog6oEzHA0epDI6RZK
         RdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664389; x=1750269189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWhblRKeJ7uV8gaFTJfI5e6Ljnl9SB2XSSji8BfVNmE=;
        b=qLUOa+IVYmfqrHISFFWziMBmXk/D6MuyFWF/FJftfmM7JxqoghZhRUzhngNR2dOnTB
         dURRFY7G89P9Eaibh/GFnqoPEDwXozksxKmaQ0idwZYATywToRk2i+MZZkB3XKLBJhwQ
         NRJANimm0sZm5sBOAHYDsdf0LSSFthMJdE8Hn+A0RBopB4vR6tRaSW6N+G9wgbVecbhB
         nKo2gpyDd6iNwi/5QfojTG+4GH2iff+SiN5O9P616FhiDwz3GKZNk+trbxhL3jDehUU0
         ulCstbtDxzJxivipChTNwX4+WE7U8Qsl/UrIbUnrIvLJWHISKJ8C2bEhZx6iwIlVaRQA
         x5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU14EgyNtak1ufKmQc3lfKf1NIqjOD4pRyQITjAdDx7pQUjoEgc428XPYmm9EfG8TPrDJFPQGlLpb3AEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQrBtYlvKFLUsWdskGms9JS8uA3sz7Hz9J9C29BB5jxo2zWUl
	DMMgQXPg+6VohIZf58bEXDXm+F4CO4jGEyZI38DKCJZZnJVYo6PxQ4AXU5Y9g9uca7pChAm3jUF
	BFXoR
X-Gm-Gg: ASbGncs2X19HwQuV3AMSjZ7XO2qvGAOsWyn9dWaS3oxrtQyka78q1tpVXsdBa2THBQf
	YLvFY01/AXPG/fJ6/TS8bqZ8WhZAMabFx62ooV1+eNyupHfqUGJb7xumxs7JA3+vOTg2wcUCFIZ
	aMe9toOdjF0X5X7sHceEXFMasHw1omHZ0BJYcA31wwEFPhCNm7yGXiOYX8LkHUTGR75Zj5RkWfN
	wPGYOehaazzAzgBfjU5Ru/TxqV8z9KULdmTLMNUz+tHfhNoq9oySFKhRnRqwSvLu4be1Ktq7nTQ
	I81WBDmZltI+GZjAWNR0KuBfShPn+yXUSpkiMQNjNkKklGp7ko22d7YrUd0=
X-Google-Smtp-Source: AGHT+IEpNfAkKPEj5aJrsVruUMnbze0d4lV1ZnV/zM8+ULGDMOEcWU66yBCpQY7xzAzwbfBsGHR6tQ==
X-Received: by 2002:a05:6e02:1b07:b0:3dd:88da:e804 with SMTP id e9e14a558f8ab-3ddf42ff1a1mr56237335ab.18.1749664388763;
        Wed, 11 Jun 2025 10:53:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddf46643e3sm5206995ab.18.2025.06.11.10.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 10:53:08 -0700 (PDT)
Message-ID: <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
Date: Wed, 11 Jun 2025 11:53:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
To: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 10:55 AM, Mohamed Abuelfotoh, Hazem wrote:
> On 11/06/2025 15:53, Jens Axboe wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> Previously, the block layer stored the requests in the plug list in
>> LIFO order. For this reason, blk_attempt_plug_merge() would check
>> just the head entry for a back merge attempt, and abort after that
>> unless requests for multiple queues existed in the plug list. If more
>> than one request is present in the plug list, this makes the one-shot
>> back merging less useful than before, as it'll always fail to find a
>> quick merge candidate.
>>
>> Use the tail entry for the one-shot merge attempt, which is the last
>> added request in the list. If that fails, abort immediately unless
>> there are multiple queues available. If multiple queues are available,
>> then scan the list. Ideally the latter scan would be a backwards scan
>> of the list, but as it currently stands, the plug list is singly linked
>> and hence this isn't easily feasible.
>>
>> Cc: stable@vger.kernel.org
>> Link: https://lore.kernel.org/linux-block/20250611121626.7252-1-abuehaze@amazon.com/
>> Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
>> Fixes: e70c301faece ("block: don't reorder requests in blk_add_rq_to_plug")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 3af1d284add5..70d704615be5 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -998,20 +998,20 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>>          if (!plug || rq_list_empty(&plug->mq_list))
>>                  return false;
>>
>> -       rq_list_for_each(&plug->mq_list, rq) {
>> -               if (rq->q == q) {
>> -                       if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
>> -                           BIO_MERGE_OK)
>> -                               return true;
>> -                       break;
>> -               }
>> +       rq = plug->mq_list.tail;
>> +       if (rq->q == q)
>> +               return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
>> +                       BIO_MERGE_OK;
>> +       else if (!plug->multiple_queues)
>> +               return false;
>>
>> -               /*
>> -                * Only keep iterating plug list for merges if we have multiple
>> -                * queues
>> -                */
>> -               if (!plug->multiple_queues)
>> -                       break;
>> +       rq_list_for_each(&plug->mq_list, rq) {
>> +               if (rq->q != q)
>> +                       continue;
>> +               if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
>> +                   BIO_MERGE_OK)
>> +                       return true;
>> +               break;
>>          }
>>          return false;
>>   }
>>
>> -- 
>> Jens Axboe
>>
> 
> Thanks for posting this fix, I can confirm that this patch mitigated
> the regression reported in [1], my only concern is the impact when we
> have multiple queues available as you explained in the commit message.
> Given that reverting e70c301faece ("block: don't reorder requests in
> blk_add_rq_to_plug") will break zoned storage support and the plug
> list is singly linked, I don't think we have a better solution here.

Yes we can't revert it, and honestly I would not want to even if that
was an option. If the multi-queue case is particularly important, you
could just do something ala the below - keep scanning until you a merge
_could_ have happened but didn't. Ideally we'd want to iterate the plug
list backwards and then we could keep the same single shot logic, where
you only attempt one request that has a matching queue. And obviously we
could just doubly link the requests, there's space in the request
linkage code to do that. But that'd add overhead in general, I think
it's better to shove a bit of that overhead to the multi-queue case.

I suspect the below would do the trick, however.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be5..4313301f131c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1008,6 +1008,8 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	rq_list_for_each(&plug->mq_list, rq) {
 		if (rq->q != q)
 			continue;
+		if (blk_try_merge(rq, bio) == ELEVATOR_NO_MERGE)
+			continue;
 		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
 		    BIO_MERGE_OK)
 			return true;

-- 
Jens Axboe
