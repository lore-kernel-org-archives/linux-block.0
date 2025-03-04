Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15FB20127F
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080353; cv=none; b=fAIFvKG+RZS2lzHY5fvw4UBXt640osLKMoi2CrNmre9bVSiCU6thp/rHpBjo0TpUVWGegHXfKOK671CSRlrLzMtOQjZVF69cfnI0mzA8+beWYRkIn+a36m0CO/RPk4YWRvT4hMAs+Stnv8qX3L65nbY1cTNb7XeSC+OZEfH8xdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080353; c=relaxed/simple;
	bh=K+SQViid9o31kFh8OoxSQbOwClMeSmHumg1VsUJnA6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmBMNm3ZX//XpmSuueYPAIveQKEHENwSZw6Th80E/yRCLyLASxcm4CM9MmIjgsa3lzVIiOnOwpxgjqb0vViCeI+c8r+Mzz11RgGmIA5MXTJAspzxcoTX/rDcAQs/gips/dtbXwpmDalpQgJ4UdgURLd3iRTnfHIBWBfHJdIb5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG52nHTt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG52nHTt"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac202264f9cso8598866b.0
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741080350; x=1741685150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g8GE73LY9Z4Z3HemCZ+fq1lPTvBfzGIabC8glDTc8WA=;
        b=GG52nHTtldXontDKxX93uw5pMMUD7mbZ9DwOyEq9PF5ePccJMMjwzdQbGpj50DMwjo
         +imrwj0fJeoeVYPefEFdUSLiR4EST0ENSunLHVDfAnc7Hn38v5FwHntaaN2esqGCPHXl
         phG1lCj1aNaJZLg/7IkLsNYuA5vk0ytv5i4v33jlLewZJlrxXRIfYADGVQNuizusDKRN
         8YiFLiXoCQENFM2uTDqfbfAKoW84uKKym4t0yXBy/ASi9APS+GxM4nu/INOKZiqqQssW
         zHgrkxvQi8FGu7bzyiio0n4qoxKt4WKNoUKIbjptNpqNsYI2nXlrK4D0JcEYVMVGQNOg
         M/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080350; x=1741685150;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8GE73LY9Z4Z3HemCZ+fq1lPTvBfzGIabC8glDTc8WA=;
        b=ob5qUbU66P5bMIYhzILQisauEy+UUSn9JXrYSewrIxTk48jdGdYODFvcYpyiq8kVWf
         Vn3ez9MXb7+rtpQgH1GkV60/iaBhz7JYHvIzNb1M0SZhetxxE/6crexitpmThdAcF7ov
         pu6yMacg6itAz+uKlpd9XEeD1XlnZ8yEne9JUs3tTxnvgJlb9T0huKAJAV/POqY/lwu1
         tqmUR/miQ2KVo1Hfp7akkLnqcEXbbMOd+kmq6mwyMB5sB3MED7HUr0kDysMWz3ck9DKK
         B+0aUn0XlyqMaoQxNByok6PSk4vBxz85SnEPxev8Ok22V7frXsuRdqY86QpyJED+LMDC
         Vltg==
X-Forwarded-Encrypted: i=1; AJvYcCXMmOXABonQX4OZDinBcyNrPDSMN80/Uy4NDxXA2DBACrOCi5yDu+jCsg8oroSxaDy3sKdOk4vX/vgcQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziLoD5mIaFuHYQwVjxkH0CnKftQt+dVozyZBTYISJboA2jsXaI
	UZ9vNXmIPriFReQ0ah7Ofayk9zVkgDaaQx8psylMpOiyPwntwbPQ
X-Gm-Gg: ASbGncsoHmrYnYtvk9cyVAXugD//3iMKeSeOWRzqdiSIc7G34f5+hPJqn3+1v0XOGgr
	2PHNtelHKhRvnlZndRE9o5JpkPLqaZnJQp3/FAdPOKUJe2UWhlsf9M1bRSwwlAQDXtsNqW1ByNp
	H1JQzq3rxJImoSoHpyMtbm8wmlXsi2eXTHdn2ovAXhk4FZy8V5K+n6sQOEtEqH4im3Y7APM9+IN
	yw+vfwtY2hxFv5JUmyQw/17+jYjNTVzZP2YdGSwmEnN5A6rzGKPiQrsOFK+qEMxNGuqGjJDqu+o
	xwES42gb23D6S/7gnrWGkSaTsCVB2Hpy6/KvJGl4QAIJ9MLwV+HstE3QFP1rxJecAxMu
X-Google-Smtp-Source: AGHT+IEsmtPrv65pCPgegepdd9Pv3+Ppsl3Ik1ZiPqpg3ZOvBDnELIB5rlsk5zGC/U1rIJtz9GIVfw==
X-Received: by 2002:a17:907:3f22:b0:ac0:e1dd:bc3 with SMTP id a640c23a62f3a-ac0e1dd102fmr658837566b.33.1741080349840;
        Tue, 04 Mar 2025 01:25:49 -0800 (PST)
Received: from [147.251.42.106] (fosforos.fi.muni.cz. [147.251.42.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf55e88748sm560998666b.54.2025.03.04.01.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 01:25:49 -0800 (PST)
Message-ID: <d84313c6-3dd1-446d-910d-e7f9f2e7d53c@gmail.com>
Date: Tue, 4 Mar 2025 10:25:49 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: Jens Axboe <axboe@kernel.dk>
Cc: regressions@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
 linux-block@vger.kernel.org
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
 <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
 <535ff54b-5c49-42f0-af5f-020169b5da79@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <535ff54b-5c49-42f0-af5f-020169b5da79@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 3:32 PM, Ondrej Kozina wrote:
> On 28/02/2025 15:08, Jens Axboe wrote:
>> On 2/28/25 4:59 AM, Ondrej Kozina wrote:
>>> Hi Jens,
>>>
>>> this patch introduced regression to locked SED OPAL2 devices. The locked region no longer returns -EIO upon IO. On read the caller receives block of zeroes, on write it does not report any error either. In both cases, previous to this patch, the caller would get IO error (expected) with locked device.
>>>
>>> It was discovered by cryptsetup testsuite specifically https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/tests/compat-test-opal
>>>
>>> I've attached a simple patch that changes the ioerror condition and it fixed the problem with SED OPAL2 devices for me.
>>>
>>> #regzbot introduced: 1f47ed294a2bd577d5ae43e6e28e1c9a3be4a833
>>
>> Oops thanks - does someone want to send a "real" patch with commit message
>> etc, or do you just want me to queue something up?
>>
> 
> To be honest, my patch was just a quick hack and I'm not sure if it is
> the correct one in general. But I will test (and report) a fix when it
> lands here.

Hi Jens,

do you have some fix for this issue anywhere?

We can easily test the patch (at least for Opal) as our CI is currently
completely red because of this issue :)
  
Thanks,
Milan

