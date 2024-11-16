Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D651917D0;
	Sat, 16 Nov 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756785; cv=none; b=WFHyfl4OfSFwRbBVo3zi8+JT+fLBjT4KVxn1DPF28nLpc/Ws1gLDXsVm/qzfeHdUznSlRVKbOKGt9Bg/putNnaKkpJ0oykVhVrRxcgSluU+Eh8ShbitPcz6o6V8hQyX7gqPSLfYr/NyCPYE18J2Hd9Y5q6tep9H4Mvdys3bcbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756785; c=relaxed/simple;
	bh=klMsOcsnU2C5A6NOzXibzpAs2jZS9KhWRu6JwZ7TDh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8PAJSKkRWnADFuQlRFGme5Q30ja5Ot/vC/XHtX9zuqb9RJhG/WFHGMz7JUVLgLF+0Buq9JOilvBFa4Avd4j9235ZIYdOEWsLezCSQGVIFfHpR5spI+zAeoMTbs4V569K2wWUmhZqfSFfrxK9aQ0dGNfVh5jLD6c5ZuV3qpwRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkVdjbAX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkVdjbAX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2710125b3a.1;
        Sat, 16 Nov 2024 03:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731756783; x=1732361583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpKjjailJtub/Xow/CfKdQ/p+NBXaW+7PVrX4G8t8cQ=;
        b=BkVdjbAXncv28B9IvbeaYuuPqRPtUWoGIK9hMlVlmrjAoEoaOSvWaww1k2Puz5ly4p
         4Kso9MHjx11ovDMyRe9BO9cOx1JDdJ9WBbgTMGP8MEuYoDJSeTwejEF433fy5ImmLpUw
         RJNFmx+aLvpp5/O4uWdHzo3ZU71gDOb4LMRCyAk59ok5m9ort2D3n6R6A5gwQ3R4gSUC
         BjErBwdOjBmY6sXgvBIMdbV3jr9MOhcQ9uo1uzcjDtx2gBUddp2od+BMB/HhAX5fD7PG
         xINCjAPGgolhv+62jTb+/GkZ7isRv6t3JfHktioVkFimlWFk06PWk1tfv5EAYo1yqqHu
         +8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731756783; x=1732361583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpKjjailJtub/Xow/CfKdQ/p+NBXaW+7PVrX4G8t8cQ=;
        b=Wym1+qXol+S+18m8GwCVjLx01jBSkkFF3Vk3woBI6bwgDhKa7iWw5y/vKi8/hB3gAY
         kLF+Nd6igwXxfEM3qadwoifbIk96eL9QQagqCaIuhWArZXhcfNnYJ1Sl8wUZS/3m+J5Q
         iXv83lZog/OQNvGnxRPM0kLI80l7BzhntPJECO1oW9KxROeTpAe/nox/cojFSndZjddV
         1qvCvBI5x6m40C0UXYRCzcOjqUuP7XmHpAvGK4TxmTAemCRA8zVCfoIoJHbwSWADS/P4
         OpRzJCLXIQ7DwYaTA+OwqyNMcdzGFcFaH6f0lHD55Alyz1onGeW68/3NIxsGhj/Wo44T
         qXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYKq8nu935DLUbjZ6nMxe+bYbSZEbrjxRNALdnLgXgAFCdU2u0K3iwNSMTz0zUv83RLqXY6ct+YSKZx88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8isaPO3qhKVEypXxRIbgd+2X3whqUQCCT8nGePCfhSugJ8pjV
	hO7epLMsEedbceObJ3+st7MkHRGhiiNzoWe350lchs8UNB01lIpEGZI7AQ==
X-Google-Smtp-Source: AGHT+IH5CCY4aGZc0wgs9SqkS2ezMEtsfs0/Zl1EDQiKLeW3qQjTatxWKN2kJTI6jKQLVB8LuwWReQ==
X-Received: by 2002:a05:6a00:240a:b0:71e:5d1d:1aa2 with SMTP id d2e1a72fcca58-72476b96ceamr6384441b3a.7.1731756783588;
        Sat, 16 Nov 2024 03:33:03 -0800 (PST)
Received: from ?IPV6:2409:4040:6e99:f02a:954f:e157:760e:3d30? ([2409:4040:6e99:f02a:954f:e157:760e:3d30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0d43sm2901482b3a.114.2024.11.16.03.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 03:33:03 -0800 (PST)
Message-ID: <f90b485d-a78e-4bcf-bb77-94f68ad575cf@gmail.com>
Date: Sat, 16 Nov 2024 17:02:57 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 hch@infradead.org
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
 <70996029-be8a-4f97-88fc-a27cff4f5df4@gmail.com>
 <f6a50924-e3f8-4175-a97e-4e77ed24b72b@kernel.dk>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <f6a50924-e3f8-4175-a97e-4e77ed24b72b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/24 21:40, Jens Axboe wrote:
> On 11/15/24 9:07 AM, Suraj Sonawane wrote:
>> On 08/10/24 23:22, SurajSonawane2415 wrote:
>>> Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
>>> to resolve the following error:
>>> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.
>>>
>>> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
>>> ---
>>> V1 - Initialize 'bio' to NULL.
>>> V2 - Move bio_put(bio) into the bio_ctr error handling block,
>>> ensuring memory cleanup occurs only when the bio_ctr fail.
>>> V3 - Moved the bio declaration into the loop scope, eliminating
>>> the need to set it to NULL at the end of the loop.
>>> V4 - Adjusted position of arguments of bio_alloc_clone.
>>>
>>>    block/blk-mq.c | 13 ++++++-------
>>>    1 file changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 4b2c8e940..89c9a6c4d 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -3156,19 +3156,21 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>>>                  int (*bio_ctr)(struct bio *, struct bio *, void *),
>>>                  void *data)
>>>    {
>>> -    struct bio *bio, *bio_src;
>>> +    struct bio *bio_src;
>>>          if (!bs)
>>>            bs = &fs_bio_set;
>>>          __rq_for_each_bio(bio_src, rq_src) {
>>> -        bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
>>> -                      bs);
>>> +        struct bio *bio = bio_alloc_clone(rq->q->disk->part0, bio_src,
>>> +                    gfp_mask, bs);
>>>            if (!bio)
>>>                goto free_and_out;
>>>    -        if (bio_ctr && bio_ctr(bio, bio_src, data))
>>> +        if (bio_ctr && bio_ctr(bio, bio_src, data)) {
>>> +            bio_put(bio);
>>>                goto free_and_out;
>>> +        }
>>>              if (rq->bio) {
>>>                rq->biotail->bi_next = bio;
>>> @@ -3176,7 +3178,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>>>            } else {
>>>                rq->bio = rq->biotail = bio;
>>>            }
>>> -        bio = NULL;
>>>        }
>>>          /* Copy attributes of the original request to the clone request. */
>>> @@ -3196,8 +3197,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>>>        return 0;
>>>      free_and_out:
>>> -    if (bio)
>>> -        bio_put(bio);
>>>        blk_rq_unprep_clone(rq);
>>>          return -ENOMEM;
>>
>> Hello Jens!
>>
>> I wanted to follow up on this patch I submitted. I have done all the
>> suggested changes till v4. I was wondering if you had a chance to
>> review it and if there are any comments or feedback.
> 
> Sorry missed this one. Is this a legit case of it being used
> uninitialized, or is it just cleaning up the code so that smatch is
> happy? The commit is woefully non-descriptive, unfortunately. So perhaps
> resend this one and improve the commit message.
> 

Apologies for any confusion earlier, and thank you for your attention to 
this. After further analysis, I realize that this change isn't 
necessary, as bio is already set to NULL by bio_alloc_clone on failure, 
preventing any real case of uninitialized use. My initial patch aimed to 
clean up the code and satisfy smatch, ensuring better readability and 
error handling.

I appreciate your feedback and the opportunity to learn from this. I now 
understand that no change is needed here. Thank you for your guidance 
and understanding.

Best regards,
Suraj Sonawane
