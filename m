Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B32524CB
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f5qMNERN"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so67241639f.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 09:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704993513; x=1705598313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZhHrJy24atJwgGbXhZHSC7K1jat9qtuTEA/BAEFCko=;
        b=f5qMNERNz95zNbVNGL6acokJmrZ/kp2G6okaBqL4gw2awlpH2rRdvQQTW/5CZKisrx
         g/n6D3jVSNxGvhCuCNKQYZOUDmC2Ae1O/98lbnSHhNEJZtdEpPFRkDMIqw1XG+Sydi4W
         bjpN8xJyCNFL7TNM8DylsLcDkWx8dV98J8VAfkG/9akP2WQOOrFR/nFIg1O+04to3pD2
         0P0YOqIcb8TrqAChZw2AsMPebgSettKXlRRtlhgwVXshSeRlfxl/Frzx3M1UtK7WKRis
         JLx+x08sj2BQCUYWADWgS5C44btT9eYKrzMS3lw7q7z//vvE9FwBGAWUhAPmM8KggX9R
         LrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704993513; x=1705598313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZhHrJy24atJwgGbXhZHSC7K1jat9qtuTEA/BAEFCko=;
        b=uTtKdFgyV9rXAmiwPKmBolSf9bK0X6vK/Fv+Uw5X7yCf1RcziscHM8dedlP23BhI7v
         cjJVQvZY6iErdVb40IOw2qPvBPf7V1bAHjjP7nDO9W5xHdil6AvofyQuDfrHF6MbUV/+
         jvs9JXbX7XgIibo35awmZLixk6Cv+cTR5WtTxeFO2FLN0bzo3PmGfFCcpCiD5n6sUrDP
         YMZ2zrAhHnF2+zRx5gaPd/1BDIB7X4jVHlxr75UsH9y8MLH5VVDfHfXO7m2ECtHvwtzb
         6NkYA6iGk3XlgW1BXCNha9W1k1qMPw5yUMzjLxLnls6u+HKTWyMCPhTQi2MwWwa2NyfM
         pQrw==
X-Gm-Message-State: AOJu0Yy2GkgjZrFMtNyn8smT/TCnh64ymX78IdVl5fhESbmQimgJ9ugO
	htwtzAree9CM/WJxAVAwMzunUV34yn5ronII0at7KDaex5z8RQ==
X-Google-Smtp-Source: AGHT+IFnpjOXcMqfax6ZRmdy28pzwUfg/RKdu+lt3lcvCbgm/3cqUtAGVrsAQ7dBaXdTrOhQB+OqHA==
X-Received: by 2002:a6b:c882:0:b0:7be:edbc:629f with SMTP id y124-20020a6bc882000000b007beedbc629fmr3106122iof.0.1704993513036;
        Thu, 11 Jan 2024 09:18:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gh7-20020a056638698700b0046b4a8df4f1sm410609jab.75.2024.01.11.09.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:18:32 -0800 (PST)
Message-ID: <8a2ab893-c4e1-4bc3-9c0a-556c62f8f921@kernel.dk>
Date: Thu, 11 Jan 2024 10:18:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20240111135705.2155518-1-hch@lst.de>
 <20240111135705.2155518-3-hch@lst.de>
 <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk>
 <20240111161440.GA16626@lst.de>
 <d91cb6ee-50bd-4397-b82f-d34dfc135b4a@kernel.dk>
 <20240111171002.GA20150@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240111171002.GA20150@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 10:10 AM, Christoph Hellwig wrote:
> On Thu, Jan 11, 2024 at 09:17:41AM -0700, Jens Axboe wrote:
>> On 1/11/24 9:14 AM, Christoph Hellwig wrote:
>>> On Thu, Jan 11, 2024 at 09:12:23AM -0700, Jens Axboe wrote:
>>>> On 1/11/24 6:57 AM, Christoph Hellwig wrote:
>>>>> q_usage_counter is the only thing preventing us from the limits changing
>>>>> under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold it.
>>>>>
>>>>> Change __submit_bio to always acquire the q_usage_counter counter before
>>>>> branching out into bio vs request based helper, and let blk_mq_submit_bio
>>>>> tell it if it consumed the reference by handing it off to the request.
>>>>
>>>> This causes hangs for me on shutdown/reset:
>>>
>>>> which seems to indicate that a reference is being leaked. Haven't poked
>>>> any further at it, I'll drop these two for now.
>>>
>>> Can you send me your .config?
>>
>> Don't think it's .config related, hit it on my test box and then in my
>> vm as well. It's likely due to batched allocations, would be my guess.
>> I can start/halt the vm fine with just a boot, but if I do:
> 
> Yupp, cached rqs it was.  The incremental patch below fixes it.
> Can you add some cached request testing to blktests so that this gets
> covered by default?
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 421db29535ba50..39eb4b99320c11 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2967,8 +2967,14 @@ bool blk_mq_submit_bio(struct bio *bio)
>  		if (rq && rq->q == q) {
>  			if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
>  				return false;
> -			if (blk_mq_use_cached_rq(rq, plug, bio))
> +			if (blk_mq_use_cached_rq(rq, plug, bio)) {
> +				/*
> +				 * We're using the reference already owned by
> +				 * rq from here on.
> +				 */
> +				blk_queue_exit(q);
>  				goto has_rq;
> +			}
>  		}
>  	}

This also highlights a potential inefficiency in the patch, as now we're
grabbing+dropping references when we don't need to. May not be a big
deal, but it's one of the things that cached requests got rid of. Though
I'm not quite sure how to refactor to get rid of that, as we'd need to
shuffle the splitting and request get for that.

Could you take another look at the series with that in mind?

-- 
Jens Axboe

