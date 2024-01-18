Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3355241F5
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591507; cv=none; b=u0cGfOswH2tGSYFHXQ0HxzIIzkak4GoLxAVRDjlbWjaVuX/gGf5iSUJPalS+/BMJ0C7Uvd0IniCOCl7038nGdpEcBHFQaI7ewTGRDwHx6b2KYytxiRXedGnMqS3zLr5B2hCuTeVLrH1IhYDbrbyCJ3/Qa08VGZqKY/kg57D5lHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591507; c=relaxed/simple;
	bh=IYR3Jzw01YcfGwtb5rambh1PKBRtFsitKigEFRyFURg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=SjbtCve/g5U1NCkraNXu3fEehnOKLhyKNviMpPGx/7/W71s808g1cKeAtswsauGiLy6rOtmjLNFyd5w6XdpQx8lRzEtgxIttD8P6sbcToxm7DHvO+iX9+QJc3EzkCvBBrgLetoggRwkJ+wTmY8y8k9v9HOK+N3i/hEs0dwY4r4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OqXRnez2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OqXRnez2"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36095e0601bso5049135ab.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 07:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705591505; x=1706196305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFL5X15KuQLcS388GPwWZDaWQMBpmHgQW0pzQBtWIdI=;
        b=OqXRnez2/w9xjjAHavbab/30k2EYJW18w2ZxWztwjtkFR5xNRChFkdI4OmSmiP+Vti
         Xo41SHygdO52m0t0PFrJZJp0OxbNcnNL6ptIdO7x6Mugh+ZEXLt9A5IKGERWnwT0/unZ
         +3pS6NWXb4lbIxt/9PAsmhYLWlABLCxJjqyzUoQenEWZBuVAhpF+Fl7VAORX2qyFH4sD
         4uFCghGiCdwdZD+1YvPlmhfznmF/AnLlGjoOiNsddamVbDB07FoQqFi5PETj1Q9PV+DJ
         LQxX9eTxwFTZVyeZ+5HpjmJYAQPtanF8brC5L1a+P2pAhsR3aEfVcbSSlbaFy7c3aEYZ
         wJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591505; x=1706196305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFL5X15KuQLcS388GPwWZDaWQMBpmHgQW0pzQBtWIdI=;
        b=gmNQCxk6/Kp53CCiGkpS65mLZo45pX+Y6JDTz9HUBnJyCwhYWjQVDd35M6n8ZFxRRQ
         ENO0cIocnmFwBblsd9UQI++NADOpAPjWmfZ5Vxx4J03L5tgkUVLyEJ7Fbre3FkGvh9ox
         emmO7j4bhrHVcavIoP68xEcojipLRwdzufQT+jNvenMY9Ne98KSkBRipfIB0D6yro09K
         +a8FxxwjrBr//kV7tyMWAe2IDInNomLuMy8jEBPqE2bHktjPYnXU7nZFkY/N81EptoNP
         5FB02sHuS/x7K0U7UA9nhWrjKWURBXVJZOWkTOkdkzAlVSZpfaaSc08aNA9AOeswiBNF
         Zorw==
X-Gm-Message-State: AOJu0YzcQTgGXErWOm1HlbiBwuL3HOvtN/BQu7I2RYpz3Gdwrj/7vN+Y
	BCap1/EyiBJuvuoFVpzkO9+q9Ig9do2NihdZxfhzvctMdWLeYTbUhL78lQOKXfM=
X-Google-Smtp-Source: AGHT+IGLSEKKcRl6iOEKMase+1gBLbVkYe0VPODaqFZN3SPVROjtQc5jyRCY5FjMsEu5XS88sJE4zQ==
X-Received: by 2002:a5d:97d7:0:b0:7bf:356b:7a96 with SMTP id k23-20020a5d97d7000000b007bf356b7a96mr2205437ios.2.1705591504819;
        Thu, 18 Jan 2024 07:25:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j1-20020a02a681000000b0046eb643c68asm439333jam.44.2024.01.18.07.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 07:25:04 -0800 (PST)
Message-ID: <33cef193-044a-4f25-8248-b10a9db9e0ba@kernel.dk>
Date: Thu, 18 Jan 2024 08:25:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] block: introduce activity based ioprio
Content-Language: en-US
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 steve.kang@unisoc.com
References: <20240117092348.2873928-1-zhaoyang.huang@unisoc.com>
 <00afbc29-9f25-403e-af18-08953fa79e24@kernel.dk>
 <CAGWkznGSreuTvYUoqhL0KaWEg-NpBazfjAcjGLJ3Oh8puzQF0g@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGWkznGSreuTvYUoqhL0KaWEg-NpBazfjAcjGLJ3Oh8puzQF0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 12:48 AM, Zhaoyang Huang wrote:
>>> +static enum dd_prio dd_req_ioprio(struct request *rq)
>>> +{
>>> +     enum dd_prio prio;
>>> +     const u8 ioprio_class = dd_rq_ioclass(rq);
>>> +#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
>>> +     struct bio *bio;
>>> +     struct bio_vec bv;
>>> +     struct bvec_iter iter;
>>> +     struct page *page;
>>> +     int gen = 0;
>>> +     int cnt = 0;
>>> +
>>> +     if (req_op(rq) == REQ_OP_READ) {
>>> +             __rq_for_each_bio(bio, rq) {
>>> +                     bio_for_each_bvec(bv, bio, iter) {
>>> +                             page = bv.bv_page;
>>> +                             gen += PageWorkingset(page) ? 1 : 0;
>>> +                             cnt++;
>>> +                     }
>>> +             }
>>> +             prio = (gen >= cnt / 2) ? ioprio_class_to_prio[IOPRIO_CLASS_RT] :
>>> +                     ioprio_class_to_prio[ioprio_class];
>>> +     } else
>>> +             prio = ioprio_class_to_prio[ioprio_class];
>>> +#else
>>> +     prio = ioprio_class_to_prio[ioprio_class];
>>> +#endif
>>> +     return prio;
>>> +}
>>
>> This is pretty awful imho, you're iterating the pages which isn't
>> exactly cheap. There's also a ternary operator (get rid of it), and
>> magic cnt / 2 which isn't even explained.

> ok. The iterating is on purpose here to not enlarge the bio and
> request structure. The magic number would be replaced by an more
> sensible criteria like MULTI_GEN's thrashing tier things.

It's totally backwards, you're adding code that both dips into parts it
very much should not, and attempting to fix things up after the fact.
Again, not passing any judgement on whether this kind of thing makes
sense, but if it did, you'd do it when adding the page to the bio, as I
mentioned elsewhere in the email. There's no need to grow struct bio, it
already has an ioprio field.

-- 
Jens Axboe

