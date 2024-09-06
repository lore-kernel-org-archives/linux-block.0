Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CF1C7B93
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634263; cv=none; b=a5xJz0skXnNF0YVxL0LwWs/pcmVYiIrZdkzgFHkZK1eAhtCJYBPMObyxeiFmFAHizp/0XXBd2wNapt4Q2tskbcbWnomyc2fReaWAO6Ie1g4dHFY4fagbfT/SJGPOU0xeIm64JJXgf8F6ntL+Uj9i/TidUnw554Ltg65oWemP3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634263; c=relaxed/simple;
	bh=Bg9hJ5AL+IvxGCWyvU8rqLJ6yreb3n3IQc5S28odOj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tglI7QV2H/x3NKCZq1UtGd/pWV2vhFP7tXyyQPMA0cVUFPjlf97zXFjeSOCr3NpIeZ0JxHQF8Zg3qxQcx4EfeySUFW/QUTVQgFURdF4iBdP9uI2GPyR7CLIFuRR2Az5eI+5B5rtl1JZ+db2qoB1HcDTsKt5mbx70G2SeqW+nKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1jCn0htg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1jCn0htg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so1471938a91.0
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2024 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725634260; x=1726239060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5lBMEQHLKMaF3jRPCocf543Y2cCOhdzZyzb/i804/c=;
        b=1jCn0htg9rIKVG3gr4RyvBW2xerbZqNoisHQnPRG3iEK14vJmz7L+TWa6jhp/zEyOn
         XBEM7LhlinIvDP54mlsId1BJ9NCGfEsXam4H9q+r2aQP5ei7jiw8aq2lAZsUNf9Td6lL
         LQ9ftrpH46BRFmXFj/iCgLdxyYNWlABeEpzNigeazYPsFyMZpCB/K4IcOHNtBsUx5adF
         TYdp2cScJ6QpzWlSsW5/vEoGW2SHWXQMblHIYZnmVhlSAOCQ+yDAQZjWyIwLbw9wzXxp
         ZFKVWoxtVJrvAixbsfWr4CPQMnl2pTYX/EkUL4j9NhITGqas0Y0l3iVwwDMfsidti9O/
         W+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634260; x=1726239060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5lBMEQHLKMaF3jRPCocf543Y2cCOhdzZyzb/i804/c=;
        b=ruXMIHNsQvbfWVsNmY6l/vpP3WvvNopDmIQpAwP1WU97MoGkLoLQllrRdcamH8KA1b
         8LbfOyr+GUZl6Kh9lIR4ggfxmI+g6//G0cSzMCRPg6k0sY5F5rqf1DdwueNnkIsO67e1
         NdHg2q8fzp/r9pKC92EBkw/YL3/k9h0fBKSORf9e0hGNjwjn0U9jfa70COGc6RmwE0ZC
         tu8+msWHqlSSf7++e2+JrAP3jucnEWhHLeVvUMlvF8BhrFP2DeRPNQ/kNf2GF+Xb2it9
         W9dHhEWDjaGWWx2llowQJCzxfyy9lZWcuCSYvniiExAVQ+a/lKEcEyi24Eti0IBgyRck
         RApg==
X-Gm-Message-State: AOJu0Ywd0khI60AM9G1juSqWJV24y0+k3HoFfcZHQJujrlYtRsI2ghTy
	CUqUvENURPBi1bzn6y2fpAZAQlrumbMfek7b3NkIskt3Dcqh+dwLZ7niqFQoYgo=
X-Google-Smtp-Source: AGHT+IEsBiV55U4YTmFuWCBXZ4clh9+5GpKkqbHGl45VMScWAVU6JAkZCc2jfIndMU3vKbc1JBztKg==
X-Received: by 2002:a17:90b:1083:b0:2d8:89c3:1b57 with SMTP id 98e67ed59e1d1-2da8f2f3f81mr15557313a91.15.1725634259950;
        Fri, 06 Sep 2024 07:50:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc07681asm1657102a91.33.2024.09.06.07.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:50:59 -0700 (PDT)
Message-ID: <ce1999f3-4b30-4e12-bbb9-9b0c090a7092@kernel.dk>
Date: Fri, 6 Sep 2024 08:50:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] zram: Replace bit spinlocks with a spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Galbraith <umgwanakikbuti@gmail.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
 <feb77bdc-512a-4f59-8a9e-1dc7751a2fa7@kernel.dk>
 <20240906144849.HrQCoqvn@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240906144849.HrQCoqvn@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 8:48 AM, Sebastian Andrzej Siewior wrote:
> On 2024-09-06 08:31:23 [-0600], Jens Axboe wrote:
>> On 9/6/24 8:14 AM, Sebastian Andrzej Siewior wrote:
>>> Hi,
>>>
>>> this is follow up to the previous posting, making the lock
>>> unconditionally. The original problem with bit spinlock is that it
>>> disabled preemption and the following operations (within the atomic
>>> section) perform operations that may sleep on PREEMPT_RT. Mike expressed
>>> that he would like to keep using zram on PREEMPT_RT.
>>
>> Looks good to me:
>>
>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Thank you.
> This is routed via your tree, right?

I can certainly take it - Minchan let me know if you have concerns.

-- 
Jens Axboe

