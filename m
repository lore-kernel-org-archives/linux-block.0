Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239427;
	b=sQhCJqVktc8Jt/lkQF21eOgk8AJC24mHamfoRhht3pNX2tu6JURG81m9FOfZ091J7MPq
	 J8jV1zwUvQ+fz31ses7LBCn22JW+WiAAClDRk4+q5BIci9M2H7SSNdSfFGcwPo+bAj/5q
	 pd6gZc4e4DbJYbvUlZCrvST5JH1zJiHT6LYpfJKa5P3hELaPy1dMQTgTkgsHXipaX3I36
	 UJgokkwKVwigMVLdnmin6olsylokh9KewE0a9r1ADir74mbXOtudO1L3h9eNGaIGNiSdq
	 pVjgKZmdlDVNSF7N1WEcKwJNIHb7/4yghOGlZTg73qhzdBmxmH0ILM7/2xfzH0h2Mfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AsnSGg8exQXHAvH8e6ZZOoW948UBbT6BqlocJ1f7fow=;
	b=c/GedyDHSRvxwtpfgNhwtWzDmPsH2nzF/u9Wm9vCUyMBl1e2oinuc50lO5dPG73eCheB
	 jOWhnlcGsAQZQRZfqti0dDFlz6mHKR9nZszZnoosgXICQXnZpn6NkdWqGrVvpcw0CtO7g
	 Ca8NLhWK1IQhs+DLIHzQXpRoPNvgRE7URiSWhurtS4PIirxiQ+0V8q0VbFrdQUAH9p6Ma
	 dmqFFbxLJK4e5uhwFXObYN6S5L9PC0I6ZBpjO752VKpJvlsmBY1CBwz1rgT+KZsiRtR9A
	 FwFGTA9nkVmVYBTuYuuWfOTXKoOrhcemf7+NuYnZlm55gb6aLrhcpfeD6kf5IILdm6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AapPFsoi;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397D606A32A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 02:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6397D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AapPFsoi
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-19305bcb72cso1569145c88.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793239425; x=1793844225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsnSGg8exQXHAvH8e6ZZOoW948UBbT6BqlocJ1f7fow=;
        b=AapPFsoinRToC4xsPssYG3ZYzKRJq+xrSPgKtR1tougA16IQEg4t8ZdsawNct5Rr3P
         XiyVdOxru18EzvJwFuk+eetPmpRVa6Nevcn6OMkuyoIOLcbALZ2kYYnMVi0NwtS8USy+
         Ll09dx93uZiCUDpZpY22z+8ycGviM397y+XlfDxhUQEQF+To/B5UfZMfT6n6mwZSG2da
         LZ+cGV5JdCDNnUz3lKOQ2FZJ9DIH0l8e9owJD0vve0briutOpb30cEXLTwGR9uOao7t0
         YLA8EwSO531gPqniMOn0TxLDjDrRilFuBjf7sV15iG4qhcxnxjl0UJyautZ/DVAkjhUY
         +1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793239425; x=1793844225;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AsnSGg8exQXHAvH8e6ZZOoW948UBbT6BqlocJ1f7fow=;
        b=qNO93LX2n4IOb0RgP9iZGLJCAOp6POHrs0zkicLDV8yuA24/76QvMVQbpIMpBY+BZ6
         /J4j7un8+1FDJD/83V8Ce12dncMdsWOWltW+cwxFvhyJemp7zeYQtJddWU8Rsn2fATZX
         We9/SkAWkmLKti4oLG86JGo3HkllfMRIHGpYQ9bb9K8DnRZE1lLMJHBbF9EGUwlStnCP
         hdrnSss92Ij/bFjza8/uspGRtnViohgKBt54nhwy+25M1raXiLDVBMrJVpd3Q7CAZDjs
         rYkqQpWRhR7c5JvS9PFml9AsTFXpG7P+WA+glKPL+2ZyaqXPoN9uQxUJ4fM4KUzbsaBj
         jkNw==
X-Gm-Message-State: AFq9FYLH0s/oDKjN5AvASglqFcm2VLQUpxoLpUSlr42zwkqHZ/I1hQCu
	676rOWcvzR0SpvAkmL/7qYBtfE5zPePLYXSjNo2gthJvGAxB+8uhQCKMEk/DFdVNlhw=
X-Gm-Gg: AYBFou0tUZ9H61drK4d6QGYQZEi/+0SHm4KSyqS7x20HThDLTmtQVcxLCGxDQQwzm9C
	OuymC8qFhc9rK+H/D5uLjODDeMbrT0PKTCOu3zv0AQ4pEasJXt/AVMYUdoYPIhFWg3c42aed1cf
	KdaETKUtD+0oGnspV7xI9RV5K99IIovLODhCNbLEKYwB/fazgxfI/nbvEG4IGytEgQkcMe47koP
	Jq7/qVPyUwAeq592EUUIpQ2Wyqkn5XKAPmM5RsuzvBGAxWveC6pHjGVAlUnp1fhV2nzPB6XWphX
	9VhawjgUNcTBg+fAQYzoVMaw03Ei9Baw8AkYcn/epa22NGFCzvE/Svhhtpzy3/OujNH57Nfa4N1
	Y912OhzNHm0y94ZnzrK93NUr7dThxiybBePiVDi/wLymvXo7hCG1dCWLl2HjC26CqIjRMzYqEbg
	d9lPgBNAUuU8FYZ3SwM5jh0pbZQg0TNeQa4Ior3kBC6Q614yTUHKiyDDPfBd9zC8wXQNPoVkOsu
	qZywhpBjlse6xvUr+GzJQrOYMXheQnkZdepben6L4jEy+FLO1K37wNQfJR5IU/Jsb9qN4A2vJPy
	/GCxtepegDh33v/mLA++D64V3oiqENyLPcXehPe6HY4L/ZM+tMymRmRdmhIp1GwWd6KYV6sE8+h
	t++lJxBSoSyjl
X-Received: by 2002:a05:701b:4517:20b0:17f:7280:1332 with SMTP id a92af1059eb24-1a6d059e59amr5108614c88.40.1793239425170;
        Wed, 28 Oct 2026 19:03:45 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c9fd2b4sm10345640c88.6.2026.10.28.19.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 19:03:44 -0700 (PDT)
Message-ID: <1c931f12-7b83-45f3-a9b0-a0db6ae1af33@kernel.dk>
Date: Wed, 28 Oct 2026 20:03:43 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/98] zram: accept lz4 dictionaries of more than 64 KiB
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Minchan Kim <minchan@kernel.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-25-axboe@kernel.dk> <auKfEyDhNK0lf0c6@google.com>
 <beffc39a-9680-45c3-83d0-6251e28840fc@kernel.dk>
 <auKnXsfgwSfCrjPh@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <auKnXsfgwSfCrjPh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 7:55 PM, Sergey Senozhatsky wrote:
> On (26/10/28 19:54), Jens Axboe wrote:
>> On 10/28/26 7:20 PM, Sergey Senozhatsky wrote:
>>> On (26/10/28 10:41), Jens Axboe wrote:
>>> [..]
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/lz4.h>
>>>> +#include <linux/sizes.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/vmalloc.h>
>>>>  
>>>> @@ -48,7 +49,8 @@ static int lz4_setup_params(struct zcomp_params *params)
>>>>  
>>>>  	ret = LZ4_loadDict(dict_stream,
>>>>  			   params->dict, params->dict_sz);
>>>> -	if (ret != params->dict_sz) {
>>>> +	/* Only the last 64 KiB of a dictionary are of use */
>>>> +	if (ret != min_t(size_t, params->dict_sz, SZ_64K)) {
>>>>  		kfree(dict_stream);
>>>>  		return -EINVAL;
>>>>  	}
>>>> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
>>>> index d8aa01bb258f..d163ff0ae8ae 100644
>>>> --- a/drivers/block/zram/backend_lz4hc.c
>>>> +++ b/drivers/block/zram/backend_lz4hc.c
>>>> @@ -4,6 +4,7 @@
>>>>  
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/lz4.h>
>>>> +#include <linux/sizes.h>
>>>>  #include <linux/slab.h>
>>>>  #include <linux/vmalloc.h>
>>>>  
>>>> @@ -96,7 +97,8 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>>>>  		LZ4_resetStreamHC(zctx->cstrm, params->level);
>>>>  		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
>>>>  				     params->dict_sz);
>>>> -		if (ret != params->dict_sz)
>>>> +		/* Only the last 64 KiB of a dictionary are of use */
>>>> +		if (ret != min_t(size_t, params->dict_sz, SZ_64K))
>>>>  			return -EINVAL;
>>>
>>> I think this should patch lz4hc_setup_params() instead.
>>> Similarly to lz4 hunk.
>>
>> You're the maintainer, so queue up a patch like that. Like I told
>> Bart, I'm not sending this out to get review. Either ack it if it's
>> good, and if not, as the maintainer of this driver, just fix it and
>> I'll happily drop this one.
> 
> Works for me, I'll queue up a fix (will give you credit).

Perfect, thank you! I'll drop this one.

-- 
Jens Axboe

