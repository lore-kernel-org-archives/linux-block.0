Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9B4D4897
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556855; cv=none; b=K0AE6Z8YanwexAhtUifZ6nFe1bxAIX6I3A4Q3M/GKr6VCU9ymdI3Qq+l3gFUVqaWPTNO7qLuVZFllhJ975iUt7fM6VA+bBOF47kG9jLM+mURwoxEr32iwQCeRBJ45ja2B9fEaJDIwgkcPc69E6aln9yJwEV5GsZsSh396FfDStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556855; c=relaxed/simple;
	bh=iQapXPqyzCyW0yh+hLQEmt32QweFEdb0Dwc5kwmIrgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeoJ1uFuGmFlNORDltob8X4GHd13iiZ6sgw/V7rrX9usjryEpTfmmk/TYE3rMbM7Q9AXbjEbUo6Zmi+2Fi3h4K3edgN7KlBSpCnOUTBmNPFIkPoNZ7+ZNY0op6IDOL2rqq0PI/JHuuk9c3oeyiIRC0lLYEWLKwZDylRZgoKeSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Hk6VkITb; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Hk6VkITb"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-351775aa1c0so2893030eec.0
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791556853; x=1792161653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8pCZ9jzEXeu3V91z7yTFHUowpIkdOUOpn2JEuBADS4=;
        b=Hk6VkITbP++OIKKGM96V5JWIPH2alq8yYq+kvdhRa627RHSFbdlVAfDETgZLVhsk1V
         /+1mFiSiWczDfcdg1Hoo8Qr9vTt7XcBBqD8tgw62N5mwYIx+gSHcpIOGd9OvLn2oMidV
         gTaAWkjK6RE7eNvieLP+xzwd19d+lQV2gDcQvXIGI8MpVS7LRu/CxoZJhq5AeyajaLM1
         LRjXR7AvPuApZ4kuq6iMvC6dwPgZexvkZNOP1Tuz61hYYXt7t8mSmkyJM0MQrLjn2SfO
         8svGStNVGSR0/BPgIPpFya4P17AHN9+jcoTXEa2IMWvFg8KOIO9SnC/u2cLi8t940JNx
         pVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556853; x=1792161653;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8pCZ9jzEXeu3V91z7yTFHUowpIkdOUOpn2JEuBADS4=;
        b=Oj8euJ1kr14ng24/A1aU8HOaur4PCko6oHBPpXyLPyGr0ykxMeqCCNNleF4npBxjIj
         q6a7tlIaQVgmnkTDO7K83k7IXAh+NKWdAZkZEmSG9oJGSFoGB3+sn/Gk1hbnZOJzeTnH
         ISM79PHHW2PSRYA3wTU8gQiuirPyVzk5tBa/zQN0PpSuCTq0cZLadzQFfMl7XTKhXTHu
         eSdYKoRd33svkEDNt33oIYvssBLBlggfKoESzUNxQyMBdebUpcpUvZbtPH+wQIngRjK7
         fW8GMrxn2g1aqWKiWl7X1mkAh8vVvNXGDENUTgi6SUz+LAgwV/A/vvH3Hjn1W5tnfA6B
         hbdQ==
X-Forwarded-Encrypted: i=1; AKwUvBymYGGLu9oV1iEAvbIowcV7qslMJZS88t54IRqNxTi6YfLlsGN068qRpbzeILjzXhk2zBUSdg69L4Igxw==@vger.kernel.org
X-Gm-Message-State: AFq9FYInCPA0XmYOYIi1ARmiGiAyc0KR6lXddUtiTiltPy6xb6xZnFyv
	MaW9HbZY0SQLfWXHxhd9GyYF97v5I97zU+gi/P6V7tYX+89YgWgbzTBn7NPA5TV4+lM=
X-Gm-Gg: AYBFou2whXW93RwmFZanX2fksdgNQtVr11Bc88mIlj2795KRKYmDSCQu3CfxhQWvr07
	35OjcfLK+oF8AfnfU3CUqQjolOl3bl4Lm5p/0JDzFwWoME3BoWsFItVqxVy+HuGc3yZuIOvW1Mg
	WvURP3SbiLFYq+uGdt9rn32HfQ37I3HQxsMZsK1TD4KQxJF6wU6vFHKl4Qo99bpf9mX2j9bRDv0
	2MwhPapeSjYhLlnK56X/NrVclZNV392r2Q3XpjvKPKfS/70q9gzxIRn9/D4I8dU+hZSmZ0qcO1u
	w2JPMDZvTCCudmDyX42WWrLKPYH0GdjJQhAfCqqqUdQ/Av2yUfYEo9UgwTOMBK46nq2gLpT7ukl
	CtQqY4ZuAb/Y0+4onKeFwZhSyED4mpCvGpmyML5eJr2dw9Xho6mzYeP4T6exNzz08nBDGodtPLp
	+DEia6M/dKXRSrnMvNzIH8J987MsTRLAWIZePQfYFgpVqunN1c0UvxIoYJi3XeLKScS5tj5n1P7
	FUTPX+IDS7x1gQKRAGtmlFjU6xsDjgY7O+a0HYDgu3yonIo/tGX8P8DxMYXG5HFvD/bHv86Qo+P
X-Received: by 2002:a05:7301:fc18:b0:341:2466:2d68 with SMTP id 5a478bee46e88-3537e0cf2a1mr2938047eec.38.1791556852849;
        Fri, 09 Oct 2026 07:40:52 -0700 (PDT)
Received: from [10.61.8.29] ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm7578272eec.10.2026.10.09.07.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 07:40:51 -0700 (PDT)
Message-ID: <3b0edaa8-75e4-4282-8310-0dfb878484be@kernel.dk>
Date: Fri, 9 Oct 2026 08:40:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: pull in the headers each received packet type reads
To: Christoph Hellwig <hch@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
 <asdpwPEpGFxfLDNz@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <asdpwPEpGFxfLDNz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 4:00 AM, Christoph Hellwig wrote:
> Can we plus just kill the aoe driver given how buggy both the driver
> and the protocol is instead of playing whack-a-mole?

I'd love to, but not sure it's feasible. I'll have to go search emails
for details, but I know there are people using this driver still,
unfortunately.

-- 
Jens Axboe
