Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360D2D60A
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062137; cv=none; b=PbGxSDSZll+G7p0wJ7TfM1R7AWeo/AFdmk7ZMQm9wmiNyIFm2JLqBnw3EyGJK5KES+2wFXto/0r1eaz1eFZ82BUE1+NhLbgmYufA/uVxSeLTYXUN2GAENiftaQSORkg8s3RPpKKzZ3EpgBp5ZsaM7T6OjMl9Xyda7NIavQ3anX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062137; c=relaxed/simple;
	bh=e19pUq2d4EkXxhDaBL2bHOPKnIpFyNjk852ElIrWEFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EGX3K2Pw11wYX1vCoJU1EMhlXn6CQf/3xh4vQg2egazA1UiO9Tg4vCkYyZ3cxsh+xAwblHM3OTONq4a4oz4N3qSjP36GQn0DiSFATOC420WduQhS4J6MfN6+3N9Tqa86rO7FeQ1/91mct0GLBikpHvaaQGPK7UNA8ETbt6SoC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N109IXEw; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N109IXEw"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da9db319e2so9174339f.0
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714062135; x=1714666935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDDOngjWK731E6UBDqZGdo2I2MIWDNPfxf2+ybIKWt8=;
        b=N109IXEwhY67O8psHa7xUWCvlZo4U90d2a5V1A723jwKhZTZlIGFAiEq5ULD8n8cs8
         09T5T8k7Fls59f0972g++Vd6IvCt4cLq8RG1d9Hwu1365HJs6iNSRwGHcDNEjTOS0sli
         TvJsbv0drDEPZj3bAXPVF745XHtOMzK62ac263GuwhbUQiRS+fyacMlwmhC4kZU22LOz
         37HChq6ncbm5GKoRlMENf2JrM8C1lUJStdyxjgLeJ+EHheM8NmAYzC2ZnupcqrtmHpjB
         U9K3PlbSNCgU0Idq2AoGkFroexdRfU67mbnbQbvL7DfrtQgCH0S42B0kbIEHaBAhngOZ
         ZkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062135; x=1714666935;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDDOngjWK731E6UBDqZGdo2I2MIWDNPfxf2+ybIKWt8=;
        b=o2NlQz++JYNLO3SmcTcCIo7+Yb2HoXXwC8S8PjcSAyVUoMdhFGgPtPAExqMxpiod1z
         NTbA3HssBK+uWQTqIyi5TQnrf0ninjyPqXR7P0Tft63uL53fYbuAVweHpVs9zXZkMwrv
         IbLc+H9vba9AAeuEgwEw4SZJqOjGxI38ZbyO4G/lWlndVbijOftFb9uvsSJDorN6UYZS
         34XDze16/pRhY/ZLE0S5UDPvSBWDGqDKxDuPvO6WX+Z/wihcOJfPU8U62idV7c/9Gs/M
         ktygNyCkqW4yg8nrowZHo17g2AmRxXbUcQaZQws4qSDw9XGxgZ4Pr7/BwzV69nh0whsP
         L9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWr5siQj4nMyCiMXFZrj0o7iBN7g42K1cELbiCTj9woFt5VRYvzY5f6hxdt9ldM7IlNMLAOTQ40wW58HR/y2ZzVdPPA1+LIbpd8va0=
X-Gm-Message-State: AOJu0YyUXNmHnNmXK/zupN2MIrGYDkO9t5c8j+KYLXcXtvHLu5mv6rjI
	jZ0U0yB+AEIkQZat1fLRStlZKX3hJponzJORgGPOMxjR0c9LsLLiNNWtPni36Ws=
X-Google-Smtp-Source: AGHT+IGZw3w/4/dOP7F31NqL0pr5wxpDADqLdlhYysm2kOhL2TAJguz/A7Q3EsqvWiS3rbP4tF7Lyw==
X-Received: by 2002:a5e:c603:0:b0:7d6:9d75:6de2 with SMTP id f3-20020a5ec603000000b007d69d756de2mr157909iok.2.1714062134677;
        Thu, 25 Apr 2024 09:22:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t6-20020a056638204600b00482ca5a153fsm4784819jaj.118.2024.04.25.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:22:14 -0700 (PDT)
Message-ID: <5f922577-514e-49c8-8046-79f6cf7baab3@kernel.dk>
Date: Thu, 25 Apr 2024 10:22:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] null_blk: Fix the problem "mutex_destroy missing"
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, dlemoal@kernel.org,
 linux-block@vger.kernel.org
References: <20240425153844.20016-1-yanjun.zhu@linux.dev>
 <65f8ef75-0555-47e8-9da9-c5a99892202a@linux.dev>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <65f8ef75-0555-47e8-9da9-c5a99892202a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/24 10:16 AM, Zhu Yanjun wrote:
> ? 2024/4/25 17:38, Zhu Yanjun ??:
>> When a mutex lock is not used any more, the function mutex_destroy
>> should be called to mark the mutex lock uninitialized.
>>
> 
> Sorry. Fixes tag is missing.
> I will send out the V2 with this Fixes tag.

Then please also fix the commit title, it's pretty bad. Make it
something ala:

null_blk: fix missing mutex_destroy() at module removal

-- 
Jens Axboe

