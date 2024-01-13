Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D321C20
	for <linux-block@vger.kernel.org>; Sat, 13 Jan 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tZE80aJr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3b84173feso14281905ad.1
        for <linux-block@vger.kernel.org>; Sat, 13 Jan 2024 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705160328; x=1705765128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8aDzDJWkFT2sBdUPsb2TfPykxnhaEOsneoizTzP5Nk=;
        b=tZE80aJrigvlgVTkWeb6depqJPONwkNFvApEAHpGeWjtw/BEPoSfmM4vKZi8QebJWM
         B6ZpbqazgqRHA+gtYj1HnaVKJI5keMPe1nn+gV2exj4vZUGNyfbhoEHzp5VcKf6TICT9
         //qncfIAniP3R8tx+vNEqM8aqV+LSren4C3Yky8XENd2vGYBhL7HcSTdzht43IK05kKw
         V1shTGTYCv44TK5ejj5UHFFHAjP/0X0EPyq2anJghsmbDatOPGzaPq3ftMmSH6LPy4Mo
         Clk3J3T1gA49HaE3iu+j7YKPC5pybTf7C3Qdf40FLFToOSWTJgfvW599F5J62RPAAQ1f
         gD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705160328; x=1705765128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8aDzDJWkFT2sBdUPsb2TfPykxnhaEOsneoizTzP5Nk=;
        b=vixTm4bLQzruaPK5yZ8SrEPvNh+jzIaxzWcZVh2xQcY3JuDbavB+u/K4VfR+7x0n+G
         V5dMVQSzvoApGacJStHRIt0UeMmI0g40Ql9y97ZzrsaBIRzQUVnja/rSaDxGg0OCUgN/
         JU0n2SmhhbJ3B3RBCsnfsbR+Of1KSGpD6xZgi9YIz3huqIwMz1GDArOj4dDtP1TQzltK
         ACb1g3SzzeZiQFiOn9a6M+7CXBatIihjvn/RqiC5uyxZsMQs+lUPX6OerIWeEuJY3Hs+
         BclihuUB1jwCYXbTumHG2kBQigbwU//pdVq+dJcAojDp1rijEodPkaz/hXRxvEg481z0
         mMZA==
X-Gm-Message-State: AOJu0Yxf+vYKtnAg/Y3sUl8TbP0jl2wdznzl0mvus7sFLakY3muk7dFz
	raHEEmmUoqAkEscVZZGmyj7elpyLz8He1V0Rn/UMRFaPqsrghg==
X-Google-Smtp-Source: AGHT+IFe57r7XYeWsVAH5timSKvySOpXmBayHgyKk6h9M3VU7bLmcuZJNuAcVteAl/jArx/4aKS8dA==
X-Received: by 2002:a17:902:da85:b0:1d3:f36a:9d21 with SMTP id j5-20020a170902da8500b001d3f36a9d21mr5678540plx.4.1705160328445;
        Sat, 13 Jan 2024 07:38:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id sh2-20020a17090b524200b0028dfdfc9a8esm4739940pjb.37.2024.01.13.07.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 07:38:47 -0800 (PST)
Message-ID: <a860d844-7cc8-4a8b-ab34-49160ac4ac45@kernel.dk>
Date: Sat, 13 Jan 2024 08:38:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: ensure we hold a queue reference when using queue
 limits
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <575be19c-01f4-4159-874b-d1e5dcbdc935@kernel.dk>
 <CAFj5m9LdX+Jf6pJTPWqCWvqqmQ5yVhBN71p8WH_1FwjhQ-HjnQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFj5m9LdX+Jf6pJTPWqCWvqqmQ5yVhBN71p8WH_1FwjhQ-HjnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 7:05 PM, Ming Lei wrote:
> On Sat, Jan 13, 2024 at 12:15?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> q_usage_counter is the only thing preventing us from the limits changing
>> under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold
>> it while calling into it.
>>
>> Move the splitting inside the region where we know we've got a queue
>> reference. Ideally this could still remain a shared section of code, but
>> let's keep the fix simple and defer any refactoring here to later.
>>
>> Reported-by: Christoph Hellwig <hch@lst.de>
>> Fixes: 9d497e2941c3 ("block: don't protect submit_bio_checks by q_usage_counter")
> 
> The fixes tag is wrong, and it should be:
> 
> Fixes: 900e08075202 ("block: move queue enter logic into blk_mq_submit_bio()")

You're right, I fixed it up.

-- 
Jens Axboe

