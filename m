Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA95F84A
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967729; cv=none; b=kBDKZnyk7tRzyIvaM4Mwod+vatUzqRUkBvQJX/SUmW7bscEdco/7hubsXq0d1wPWb9tdY6w8B8NowJp45LqbHz94GE4aqGQqlhJbWYRYRTrIMag8+SueLwozgC3XpH3/Cp9tFduiIB0sZzy2kTsiyL4Y4iYpYak7FHGYiKLatZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967729; c=relaxed/simple;
	bh=xVyVD7GxLtKycixfGjXqkAB5Zh2y1l5iWBFg3ntDf2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lxZAajTMYTPn1EzSiuv1dYFplkqqhs3Z9u5qO3R363v40U0rzIz2pnDvFhfUavQ3fHIlVpNcnRs2ke5BUhFh85Jlg6WxAHnUJAqxTN7aOAkyWcCEP9mIaSuRhcHRvdg4YQhpXksxF/ejWjUkMKvbvUGY2uIUO0tzOva28p3Ehas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dbebe4938bso789155b3a.3
        for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 15:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705967727; x=1706572527;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVyVD7GxLtKycixfGjXqkAB5Zh2y1l5iWBFg3ntDf2Q=;
        b=fr5YYV6QlskaKXTk34IJYLzXOcv+yTFn3kM6RXLG4hFw7QQNmeVAdTipJwfg051j9Z
         /tHd4gkruoNO9ND7m18x0+/llRx4SFh+bcWYot6ztis4pl3pCbbMqNfR7hDqT0UmSFoY
         8WCgykCozBrcd8TOlcI6vTqv99Eojbi+jyMn8CWpqBEXdukOrd0MwDJRIalEOajZd9pG
         4xhvmZUHZwWUqUKCSZvgPgT2WoFQdcTDP7OEOw4OYLBgAW8nDsVHC1sfcBHgeOfMgQJV
         dn2hR7eOH0KAxUTG4UgvPinAm4D1eT7nAfH1QRZ87QeSr2VoANp+6aL2y6a0jcrK6HP9
         pD/Q==
X-Gm-Message-State: AOJu0YwCGF3t9VTiqDRBXTzuasfVj/DyaQKrLArRokFB4E6obXv54lFU
	OlNz9+L5VMcbG8z6R7WqPp5my2Lex120I0k3mgRsIpTW93n/jCTa0mSGWj1X
X-Google-Smtp-Source: AGHT+IEPkC2/0Tw/Ts7x/nKkCulZ4ZYW1OfiF9LgYbG1Wb9fmm7CxP43wXye138ToztAYBFoMcMVsA==
X-Received: by 2002:a05:6a00:99d:b0:6db:d7ef:325c with SMTP id u29-20020a056a00099d00b006dbd7ef325cmr2277599pfg.13.1705967727369;
        Mon, 22 Jan 2024 15:55:27 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id k11-20020aa79d0b000000b006da04f1b884sm10038566pfp.105.2024.01.22.15.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 15:55:27 -0800 (PST)
Message-ID: <cd8a804c-0439-40ae-90f3-61c0219e844d@acm.org>
Date: Mon, 22 Jan 2024 15:55:26 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240119160338.1191281-1-axboe@kernel.dk>
 <20240119160338.1191281-4-axboe@kernel.dk>
 <9bf23380-b006-4e80-95a6-f5b95c35a475@acm.org>
 <af2f895c-ee57-41a1-ae14-1f531b5671e0@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <af2f895c-ee57-41a1-ae14-1f531b5671e0@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 16:05, Jens Axboe wrote:
> Can you send a "proper" patch and I'll just replace the one that I have?

Please take a look at
https://lore.kernel.org/linux-block/20240122235332.2299150-1-bvanassche@acm.org/T/#u

Thanks,

Bart.


