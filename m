Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E39433D1
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037272; cv=none; b=e520Bjlbh2cRYXD/4xhnpufSwypum+bHv+BEbYci3YuEVFmfMj/2nDmCELed2F9Yqq1iotm83zr+deq90hw+8+uymVTnZW8VbcSaDzfEVcmMMpdc4OWLqkNV4ONhksTxjBYtl1aG7UDML3TrGpCB0SErJ9GKgjvyi9tEj80wQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037272; c=relaxed/simple;
	bh=eBajf3ISObsRIG7JQ/RPEAp0s+nIITL7Nt0Izf8t6ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A/ByLnz3bJr810Fpr4w4VkKLoikYK3VTDqbGXqfK/JiyhyKHKun9TqM82AofpjKav88BripuLT6bDhxiHmZEJWZYD0vzHXIvXOKFnXbAq6XutE1xRHtztnxtgpBtZu/yKPSYPJObVHj7YVVv7qwLSrSRFqREY6bp2Ijtu6YBg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=grT9f57E; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="grT9f57E"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bed82030faso61135739f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 11:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706037269; x=1706642069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1HkWB/Encjn8bzslDtZS5KE0bhsTmkHs4/p4tV8Q94=;
        b=grT9f57Eth+3bhvXLi86pK7in86jyj4JUCdcskwpoZf6KlRnC/4kaRh6xsuNswFtag
         ZXSlFQS0XkNEypRBnfgbw+dQa3e8QNtqw07UZrQNY4yMP92Yl4uzEq/asiKyeN+4Z6iN
         EYw0u+XozrHx5j0A+Jo7TNVGdsV9X/z2wQKtZFP82tfSbI9WUErO84hyPBscgUdzyr2j
         PhaGx1xuFSj9h/0gWE9ZgDyBAIXf4BwVNPyKDF0TH4368Rx7wf1fi1kWnJ3GNe1PfNkj
         UIrCqZ5xuTAqH1P8HeFvfxw3EdddBEJtUWBB0b2aLspe9K2DoYpHl7xbyb9LFeFxoexz
         BPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037269; x=1706642069;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1HkWB/Encjn8bzslDtZS5KE0bhsTmkHs4/p4tV8Q94=;
        b=iRUqbB+tihekm6sBXDPGv30/YX6cMIGZPHS/RhrXxt4AyZ/Sr2pzYEOV70NrhbdWQo
         m6DmzE+JfZePfRqLBh/wsqBhzf+Knv/+ccwRArTb5/zhv5HKdDFFIiWNqdlTuy9BxZsW
         nTKZeNWn7ovRfy03YLO7ppwHSOX7m1GGaGw+QlzCphuthG0hADa2AtU1WFGEh1lOG3oY
         UQGUHUKyrWAXVHnxsVD3o4fWOLG2t09Njg75EJv65c6Pb1FSYe2n1ew8nwhfxT/zosn8
         MJkf8ZtwhLa1Xd6JBQtQsP4ZNxHkm4oPs9HTzkjhgnAjwYyXGT2Oja3ARpp2evNRoW/Q
         yCIA==
X-Gm-Message-State: AOJu0YzR9uEmRRJY4vYLj2Hn+gKEEGKtR4ko5Yz5Gcr7cH4ltDphRKtY
	kTEv3PBlk/4i3o0owUBOVdAO4aHi3Q2xIe4eEspBDedlzZIkmxlSZ7aax9TFlDcdp03tbIvnoTJ
	f+uo=
X-Google-Smtp-Source: AGHT+IHRxNvcS10HWTaL4Gbp16G/evkBwOEA+YXLxo2GVj1qDJqWUQQ5LXmPdYMzewRa0MWyMn/K3Q==
X-Received: by 2002:a05:6e02:1d95:b0:361:969c:5b4b with SMTP id h21-20020a056e021d9500b00361969c5b4bmr185268ila.3.1706037269472;
        Tue, 23 Jan 2024 11:14:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l4-20020a056e020e4400b00361a956a57bsm3445104ilk.53.2024.01.23.11.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:14:28 -0800 (PST)
Message-ID: <f6f52e0b-2cd5-46fa-b8ec-a1c9770d5a1b@kernel.dk>
Date: Tue, 23 Jan 2024 12:14:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] block/bfq: serialize request dispatching
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-7-axboe@kernel.dk>
 <dfd46b3b-0135-4e1c-987f-91f52cafee4c@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <dfd46b3b-0135-4e1c-987f-91f52cafee4c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 11:40 AM, Bart Van Assche wrote:
> On 1/23/24 09:34, Jens Axboe wrote:
>> If we're entering request dispatch but someone else is already
>> dispatching, then just skip this dispatch. We know IO is inflight and
>> this will trigger another dispatch event for any completion. This will
>> potentially cause slightly lower queue depth for contended cases, but
>> those are slowed down anyway and this should not cause an issue.
>>
>> By itself, this patch doesn't help a whole lot, as the dispatch
>> lock contention reduction is just eating up by the same dd->lock now
>                                                           ^^^^^^^^
> Does this perhaps need to be modified into bfqd->lock?

Oops yeah indeed, I'll update the commit message.

>>   struct bfq_data {
>> +    struct {
>> +        spinlock_t lock;
>> +    } ____cacheline_aligned_in_smp;
> 
> Hmm ... why is the spinlock surrounded with a struct { }? This is not
> clear to me. Otherwise this patch looks good to me.

Mostly just prep for the later patch, I can add the struct here on in
that patch. Doesn't really matter to me.

-- 
Jens Axboe

