Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783008F40
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652048; cv=none; b=Y28/EvnN9dAiRYVs6bNnILCUFFD3qP2Ny12fvMHEPu394WOWOwGZY/ShvStJtD2isrei6WJF74MfYVni0MCavZmSrotogSIS46X83hyNd/nuYhGRW5GqL5xbVdpA5JHc3Hs52fIBlL333eYlR01eIro+boo9uLqR6s5ZlB/CSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652048; c=relaxed/simple;
	bh=TIRh66icGgGezgzsqgs7P3L7KfAhtSSEJfm6TyOQI4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvx+smefubxEaVJM8jFK03i+k8WUrOAFnKo7JIsAnlcpDVI9OhZzCksUOX3yhsRewWUgceiL0LvJAP/yphZy3l94r5WRxRLOR4nUk+/a+7RUAodo0xEVZnl49e/6SQIjpbYl9siPXJ/43POmLViAO18GXsioKr9o4N7grsA4jSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1vltctfr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1vltctfr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so1632005e9.1
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758652042; x=1759256842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Tpv6P8JmM6lXIi7hhEW08iRJIJzegZma6FTeTqinVs=;
        b=1vltctfr+cWuUv7aCqwSs/+s9NXOGfpw+Yqg4Kw/Y39QM+zstOBZa6jgzCCtHzVKaK
         zmfzhm3Ng6kh8lbPo5fcuYudKZLcX+sj4kNsn4Eq1Ko/4NjZIyVXHzipXAI58R66gRZ2
         pSreK6hjVlILaGaYHlHLOrjGW5Oys1Ij0UGj7GRPTNBUOdUvnRO3/HMih15fKoBh892b
         0X+S9/z4jZmgJJnEv4FCYtOz1RwuFr73LNRe4AuQt8vhh8ajSbYG8o4Xoa3sci5elwQp
         MqWvFlIhvk69YperK21NL3HzLu0lWGu5PizaCG3R9AxRrwYKfFvO7PQlOXUg3WDC19Ly
         qQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758652042; x=1759256842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Tpv6P8JmM6lXIi7hhEW08iRJIJzegZma6FTeTqinVs=;
        b=N/Sa3vKH0WRPzCDfO8CfBIjJfugx7jPNaO6ygcUy+x2Tm/0m3QtEaNRkE6McB5KBM/
         GL7oCyCzawM1rsRIq8GU39ZU5JU4YFo/BAHb4IN7RtPPjDReOaigJwBSkIDvAU8edbjR
         JGV0aGWVhLU0SJgnui+AVE8vk8CBBEaIg1Jh7FBr/Sz/KgYNFE9v8ldAxevpmwXlsCpz
         QGrRFU/wNSKqfoldl9eG5/vSVns3mojvbuu0Wx+SjgS6LQ+S+P4kVxNtXI/SpwXMtsMz
         jBFK9QwZdV4QOEQjMzOc+Y+8IjSGywGbvyUqM5acelORRQ8spxr8dAi8KDu6y5b4OPtd
         lj6w==
X-Gm-Message-State: AOJu0YxgZGhHXRyRuSsL+d5bQpQWUePoIy+egtkzBm7ZkubMlBAZ6eGt
	ni8bjFxpJuTP8AT1jMyqQCuhvNEWxZ4H/5wzokiWGvb3gQAADM6WetwB8PCP9DUrJ/s=
X-Gm-Gg: ASbGncspqdw7FOwvniNrb0JNS39QHWJZcjwZNBPm3opWuvKd4SrrpB3YEbXrfhJuFuV
	CkByLDXTU/sQqs7V8Eq/sGmDPxDhb50Sosuw71mxyOgm5oPUanc0+ufeykiRMOUJGXuu/MbJtMG
	ybvoIHSk1SqC5GcnRmRg6o9Yfb/VUZZ6P5zJq+NugV7lIiLjymi08lX7uBcwOoyZQEPbKtLViKw
	qHb2pgUSIuymDCzhzxydbZlmg7STPovqwgVXp01D1bprumHkTdK8ILg0VyEtRfbHZorV3oGcZoS
	/W13VIazkUoGDzafEH7cP0ZXlfmfVOA2D8814iBaXgvoekpPrt3zWZ02RA5/G6aXLZ2vQKOnGWE
	s4+eOuDEYkRSyANXkyEOn
X-Google-Smtp-Source: AGHT+IHKGh4qVOyD6LIIIINW3oEE+gJP8wA608qR91ZoF/P1odN6oDrgCoh7tWIYzJ74YfWOMS+n3w==
X-Received: by 2002:a05:600c:3582:b0:45b:71ac:b45a with SMTP id 5b1f17b1804b1-46e1d980718mr41615935e9.11.1758652041659;
        Tue, 23 Sep 2025 11:27:21 -0700 (PDT)
Received: from [172.17.2.81] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613ddc01e6sm285145315e9.18.2025.09.23.11.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 11:27:21 -0700 (PDT)
Message-ID: <49377ab3-0e5c-4767-8351-65a8d2340ad2@kernel.dk>
Date: Tue, 23 Sep 2025 12:27:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Fix more tag iteration function documentation
To: Bart Van Assche <bvanassche@acm.org>, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
References: <20250922201324.106701-1-bvanassche@acm.org>
 <d61889c5-a3e2-4a4c-a569-041c9f3e916e@oracle.com>
 <3f32e7ee-e532-4d69-8848-43d44693e93a@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3f32e7ee-e532-4d69-8848-43d44693e93a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 9:59 AM, Bart Van Assche wrote:
> On 9/23/25 12:51 AM, John Garry wrote:
>> On 22/09/2025 21:13, Bart Van Assche wrote:
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 0602ca7f1e37..271fa005c51e 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -297,15 +297,15 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>>   /**
>>>    * bt_for_each - iterate over the requests associated with a hardware queue
>>>    * @hctx:    Hardware queue to examine.
>>> - * @q:        Request queue to examine.
>>> + * @q:        Request queue @hctx is associated with (@hctx->queue).
>>
>> eh, sometimes hctx is NULL, so it is odd to be saying that it is the q is associated with that (being NULL)
> 
> Thanks for the feedback John.
> 
> Jens, please let me know whether you want me to address this feedback in
> a follow-up patch or by posting a second version of this patch.

As per my applied email, it's already applied. And it's sitting a few
patches down at this point. I don't think there's a rush in fixing a
comment, so perhaps just do it next time you're touching that area
anyway.

-- 
Jens Axboe
