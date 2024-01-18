Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986B2E3F0
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603983; cv=none; b=r9Z1Ee19I0vMClfxszF3kosBDSRsRUyxNIVFGTcUvpte6KgV5JsH6LRx9Q3azEDMgk1QQF0RCGPUEPXKIcTN99Gaj/KyZjxKlt77HI1T3ocGjKoCVxxyUHi6R3jEoPImg6oP72PvWVBYfLJcZ2nWQxuJyou3xoya7UVs4zqiiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603983; c=relaxed/simple;
	bh=yOuMewM5I56TmsFTuQuUBwa3Ko3nUD86QcAOcV6ayj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L4IVlPUUUqCOvts7CkEV2P/Cg/HecTBe/A+QTXaUkk2sy5RFoGIrsWw+CNfJcdq78l8BDprQHbF9E0nbpPiU3k+gcnSWW35WWEmLp4uMC8MbWX6BwMN7ru36GGdPcC3qhCtCnz9mIb0KvsVPRlReJqsZkm3qMZ5O8qkVTxtyB7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d427518d52so227745ad.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603981; x=1706208781;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ0Tr5vMRHBDr8II3iK9yvuEASEw+zRgGpxjO0mTQ38=;
        b=Q0zd0zuLeN4u2NWqv3zHqYBIn7XPb99JlHlugwfyPmkB7uCSIbs5RmMiLGvL2zyxzH
         2xbyK7OtgXjQe4HPdlyFABfcpF6DA3Ud58KfFnjdmAZJfejioCntL2Wo5o6kM6t5pwpq
         DiZFvfrY8OIhd0gn70bmw70smpuLRHQRPGIzBLQGvdsYirnxuQnGkgMnexHw6WuthO19
         8VYzsqTjMSCAymnEIXakJ1fBXieG/FUoO7o3WnYfVg1ahy+KDw4Lnbh/cpd3mx30eU5c
         aDn6OAbBRyD8Hl0H8E5+PHjFpX95OcFvBQ+PKrbl2ps89O00iD1e5dycDDPd2CM/TJ2n
         cRGw==
X-Gm-Message-State: AOJu0YxXSnrwRWyQxsE0MXWz1iV9r9WjMUyOFAlRbEsopou4VgYqg4uj
	JoVFoi5Ev9CugAwi+MWs7oQuJ46l+5+NE5mfcgiz/rpsHYQXzULo
X-Google-Smtp-Source: AGHT+IGUhnF8Y0Ph8I4CGB5Qj9etTWNocr3effEzE20zAHIVfGA9l9Lr1h6RFscQoQtcVJjx/sSZ8g==
X-Received: by 2002:a17:902:e5d1:b0:1d5:e75a:6900 with SMTP id u17-20020a170902e5d100b001d5e75a6900mr2192559plf.39.1705603981290;
        Thu, 18 Jan 2024 10:53:01 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:718b:ab80:1dc2:cbee? ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id mf12-20020a170902fc8c00b001d39af62b1fsm1704172plb.232.2024.01.18.10.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:53:00 -0800 (PST)
Message-ID: <e4892064-cdf2-4cd9-8033-901d8db07cbf@acm.org>
Date: Thu, 18 Jan 2024 10:53:00 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
 <0ca63d05-fc5b-4e6a-a828-52eb24305545@acm.org>
 <c9f1b580-2241-4415-aa48-e4b7e1bacdea@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c9f1b580-2241-4415-aa48-e4b7e1bacdea@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 10:33, Jens Axboe wrote:
> On 1/18/24 11:31 AM, Bart Van Assche wrote:
>> On 1/18/24 10:04, Jens Axboe wrote:
>>> If we attempt to insert a list of requests but someone else is already
>>> running an insertion, then fallback to queueing it internally and let
>>> the existing inserter finish the operation.
>>
>> Because this patch adds significant complexity: what are the use cases
>> that benefit from this kind of optimization? Are these perhaps workloads
>> on systems with many CPU cores and fast storage? If the storage is fast,
>> why to use mq-deadline instead of "none" as I/O-scheduler?
> 
> You and others complain that mq-deadline is slow and doesn't scale,
> these two patches help improve that situation. Not sure why this is even
> a question?

How much does this patch improve performance?

Thanks,

Bart.


