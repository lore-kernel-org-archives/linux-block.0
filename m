Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB32F1FFE
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905374; cv=none; b=KOe/rF24DS2lKFWSnO6UnF4CVOzloZ88iSExT4D10OBymdCqqWPIrmAfuG66We2F5Qtxl1duM8JzfRwR/2NHNH5LcNP7XKqijt3PtpGo1jLxTTLkxj4hqpxaTofoseCaKTLTZ/m2YQSsqV0Kj72fBfu3RErPEIwiYZdLwxS4X80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905374; c=relaxed/simple;
	bh=AffLqmle439f76Batn9z25muWqa/PWI1cB3mmDFodbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgppdVbHWaUtU8w2nupOgLfCjWwRLIcNeoRmVjRPKzOSM4CmPl4bLDfsgepYdesjWez1hYm/DhIwEKEBuIZ0lwVQD20SF09OkhTuNV0MgeTFVE9YUwQhYvpiQ1mb3rsscsDsJydVaZnvRn+AD8QnDIivcM9AzlIItPpH2wtOZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OQ3ju8SE; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OQ3ju8SE"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-45c733ccc32so2016058b6e.0
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 06:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770905370; x=1771510170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32XJ9y+Yy71t88Pn/7srvyPyza7VGbFksQW+o+n2NfA=;
        b=OQ3ju8SEZ5gCbiPZ1eDQO7FCCA6KLgZSebGKOFt+JmQXXZFNX8L2xcX2IT1uKA8LiF
         dT8Dr/v9K/Smz/mgtviUwM+pCMu+FxlR8UXhdwXp0zsEdt6vgRLzBqG5zmRyaISpCohV
         MuJJq+H6YXfK8u7JQaBaCF3fyi5gr6IesEH7jjjijKGPl+SBQghVDQY9iHji/FDh1JAx
         RWMGsBOOKZ33HQk4ybDDev1iCkyiSBjsaTnmRaSVNAL87HYtwKNM3FlYXtA9uLaT1An6
         D65ccOYitoGU6sd1n8SI5YC7+LTHDAlg8edmlLq/UaSbVy5uSExZdLGcRt/xCk4hOL5h
         Au5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905370; x=1771510170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32XJ9y+Yy71t88Pn/7srvyPyza7VGbFksQW+o+n2NfA=;
        b=eP/+DDAGUmn3nTjh21Azkj6/pN2csNwYUxVkMfttHSX/X8Ku/IzdJG6Oq4ndGBg5+o
         MiFjAj+OV4Gzj0NYqz7p2mmuDBmxZXW7sXZ3UC9Ic3eAH75/IbREcs0pcTaA7+F6g7YJ
         DNBT/LHiev2ThirgqJsCWcjKAPb0n1d/gjQg38JASFUm9ns+SVzF2ITHAINRpP/jeHZH
         EHYNjj6cilS+AFElm5cpxUf8JlmriIWi0RHwfo8c3HdShw502m8h0P9Y+pGoDP8IKFBJ
         p9gP15kx9vNNb1r4KyWNj4x+UOrX4tOEINa5jWVigYTpGiDwP1HfFxvJEjQ1QiY35Hdn
         QsLA==
X-Forwarded-Encrypted: i=1; AJvYcCXIHKANJbsldz73K1oAQUr2i4Z30m6GSC3zV8Z5tg215qEPAV2PEZLptkGLRdSPAlZV6RwhGiS+C35Hzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35wz+uWr1l9o9g7FrbqsxBJeVBMdRSOWxevqJNAtDwQ9ZMWdK
	FIdqovGoimaH5kvYaHMu/CpUrLNPZaX3ci+36ojRxAC3T7C6GHCX7wnMpw6oQPFBLE4=
X-Gm-Gg: AZuq6aLz/vk30PwXL07RKwLvAwSGrGrTPAw2rVWK9Bf5pfk36k7ZKVN4JiERACCODVP
	YvK1h1Xi0USQ/Yewfq6dBuwJ6afK3Ipq3n75/m+JCWKlCDztdDEuptI7bcBEnKLGsKiSwm4nT/u
	c3JqRnXfh4Xhhlbf0x/lL1frGnp2G3mYb+TPxFVRZE0Vbj4bRkaKLidsbMaiiFEGXisUaUfbLa1
	6m8XieOhHPeJ833Zkla+oYWynB97zx14FO7vZQuZKIXutrJHUTMBe+BHunYtt/LLZmDySiVEKy+
	sEiXAeZAq6/l7C6+6lkzIcOo8ECExI76rlIQmKjKHpN/PJPgIjO1mF0bSiTfDGLB3SNph8XHzLT
	uA0nynJ3JEVtVqm7a6fWWCAiollYILQ8IwQ+z3ZgQqgDJyqVftKnwGTyhS+RJsA6YIqIl/JqF4d
	UZfxSeP0s2LpRu+7VNm/TgJll2fvj8Sr+BceV/MuOutQ3pvZZq1oA1dJ2vx/HQoBCLap0vp3WfO
	CG2PtYAzoTHwyB+AP0c
X-Received: by 2002:a05:6820:4a12:b0:672:a49f:127b with SMTP id 006d021491bc7-675dae67e97mr711425eaf.3.1770905369831;
        Thu, 12 Feb 2026 06:09:29 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67475fbc91bsm2680419eaf.15.2026.02.12.06.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 06:09:29 -0800 (PST)
Message-ID: <0576dcec-3e8f-4e77-b532-052ae8c6137e@kernel.dk>
Date: Thu, 12 Feb 2026 07:09:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
To: Hillf Danton <hdanton@sina.com>,
 "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: torvalds@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bigeasy@linutronix.de
References: <20260212132644.2998-1-hdanton@sina.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260212132644.2998-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/26 6:26 AM, Hillf Danton wrote:
> On Thu, 12 Feb 2026 09:14:18 +0200 Ionut Nechita (Wind River) wrote:
>>
>> PREEMPT_RT has been merged into mainline since v6.12. There is no
>> separate RT tree for this kind of fix anymore. The spinlock in question
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/

Hillf, just stop. Not just this thread, but replying in general. It's
always useless, time wasting, and unproductive.

-- 
Jens Axboe

