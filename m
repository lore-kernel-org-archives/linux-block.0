Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D0188CD8
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687012; cv=none; b=np6CBNFxeBCKjSu2XZFRd0HoN7ODb2e/LUMUKyduYtdSbMcN4n0KdM51b7NOPp09jRYWGrfnkKt6sTBwF0cUDI8r3pzZOI29EfAuOYK1NtimTPL0n/5qlShJxARRbB/fcycQNUSLyG2DdetXE1/JziaLlRsbSC22/USt3zpbVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687012; c=relaxed/simple;
	bh=vmWeSZlPyuAPHl7bkcFDFWthS0bpQDeyutDPFhJM7O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrIAdtTiKbSBVhkbSXEWfhGe4/+kd4nGyCZf7aYwnGT0WZQCksWl04qVIhLrGV8UaoxGjXMijDOAVLo6PwwTE2z9HksZP6jZaB+g8ZfvXCPoaV2+jNDzbjyhfg91icMmFVmWoIBi9bLr2Bjtx7/tDvg/TtMcHyFlo60gqNY9eHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M9cglWs3; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M9cglWs3"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29538198f2fso1074487fac.1
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731687009; x=1732291809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7TALngXZSHnANqevaSkMoczViCSyBm7hpmNZQzIthE=;
        b=M9cglWs3CmP0nNeC1SbYCdCuvBpRsCrq4mv+P4S7ut8fGPzOO4f/Sy5X3zda7bhyIQ
         FDyq+M0KSEzGdCx3UNqNfCjXJcXa+RRx1Z7+yO9/XkIh7tckP9xk1hhrxDPc5tGhlv2e
         ce0BSyqpGAO5xk2Vx1DR2ycGOsgUCKxtEcup+Z+QweY6+zX1/P8GL/XKa74WvQr3NAC+
         e6fNbDdQM3pHRD0BlaGGMrFpy3jpiVaWDKgmmpc+yZ+mkVqIIAZmYDevQW3tsurJyz7A
         OLddghcKUjyFLXI5w+gE9ZUT6hCbJ5PhHylTT52gp/PyWS/1q8CSVkCjzvEVe2YEL4T8
         e+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731687009; x=1732291809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7TALngXZSHnANqevaSkMoczViCSyBm7hpmNZQzIthE=;
        b=LXc2kVWFRjRpcEIx8PSbw3KvPjOQ+3N8P7ZPLRjkufM5WBgRpnm5rfQSuOH6atDsjN
         gn9bBGowbKixDfKFCc7EhSqD4cvAbMpRERdWCJ8TcC/zJhn2zSvMJGp+sSyjJBDay+bI
         XEyMU/+YTzJNwbJshHbuIcAibyWyros/TNU5RfBNj8AbIXFFzplXo/lYrf1TW1pk2hQH
         2EZEpL8NY2LFsuS6zERBn87/5Ct+8+BYwFN4MFyuIfqN7ErXngXxYUAsdP3p8O4avAqI
         kWGa4yCndRXuonGeSKEz04m2ENJBZE7rzStpoKRo0/ia1Bwytt+SOJudYNBwr9pzMk7t
         Pjkg==
X-Gm-Message-State: AOJu0Yy6u3yphOpYIVJS0u5x5JmaxJ27GIGdYdy/PVzXt2m05GbsVhPF
	aT0j7wwIkgQVNmurG3BkcFTxY6n7fX7qpXWeWpYnjoX1X6DIx4u+/ohiC723tNtZPq2iN2RlOyj
	F51E=
X-Google-Smtp-Source: AGHT+IELHseqXG68WXiQMEPK0xyw/tcLQI37dl4CQZSHJAkjkbb1bGtFEMBMTP84dYtmQLbI5kdy8w==
X-Received: by 2002:a05:6870:6188:b0:27b:580f:3bdd with SMTP id 586e51a60fabf-2962dc91bc2mr3345666fac.9.1731687009252;
        Fri, 15 Nov 2024 08:10:09 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29610803f82sm1559962fac.2.2024.11.15.08.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 08:10:08 -0800 (PST)
Message-ID: <f6a50924-e3f8-4175-a97e-4e77ed24b72b@kernel.dk>
Date: Fri, 15 Nov 2024 09:10:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 hch@infradead.org
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
 <70996029-be8a-4f97-88fc-a27cff4f5df4@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <70996029-be8a-4f97-88fc-a27cff4f5df4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 9:07 AM, Suraj Sonawane wrote:
> On 08/10/24 23:22, SurajSonawane2415 wrote:
>> Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
>> to resolve the following error:
>> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.
>>
>> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
>> ---
>> V1 - Initialize 'bio' to NULL.
>> V2 - Move bio_put(bio) into the bio_ctr error handling block,
>> ensuring memory cleanup occurs only when the bio_ctr fail.
>> V3 - Moved the bio declaration into the loop scope, eliminating
>> the need to set it to NULL at the end of the loop.
>> V4 - Adjusted position of arguments of bio_alloc_clone.
>>
>>   block/blk-mq.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 4b2c8e940..89c9a6c4d 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3156,19 +3156,21 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>>                 int (*bio_ctr)(struct bio *, struct bio *, void *),
>>                 void *data)
>>   {
>> -    struct bio *bio, *bio_src;
>> +    struct bio *bio_src;
>>         if (!bs)
>>           bs = &fs_bio_set;
>>         __rq_for_each_bio(bio_src, rq_src) {
>> -        bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
>> -                      bs);
>> +        struct bio *bio = bio_alloc_clone(rq->q->disk->part0, bio_src,
>> +                    gfp_mask, bs);
>>           if (!bio)
>>               goto free_and_out;
>>   -        if (bio_ctr && bio_ctr(bio, bio_src, data))
>> +        if (bio_ctr && bio_ctr(bio, bio_src, data)) {
>> +            bio_put(bio);
>>               goto free_and_out;
>> +        }
>>             if (rq->bio) {
>>               rq->biotail->bi_next = bio;
>> @@ -3176,7 +3178,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>>           } else {
>>               rq->bio = rq->biotail = bio;
>>           }
>> -        bio = NULL;
>>       }
>>         /* Copy attributes of the original request to the clone request. */
>> @@ -3196,8 +3197,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>>       return 0;
>>     free_and_out:
>> -    if (bio)
>> -        bio_put(bio);
>>       blk_rq_unprep_clone(rq);
>>         return -ENOMEM;
> 
> Hello Jens!
> 
> I wanted to follow up on this patch I submitted. I have done all the
> suggested changes till v4. I was wondering if you had a chance to
> review it and if there are any comments or feedback.

Sorry missed this one. Is this a legit case of it being used
uninitialized, or is it just cleaning up the code so that smatch is
happy? The commit is woefully non-descriptive, unfortunately. So perhaps
resend this one and improve the commit message.

-- 
Jens Axboe
