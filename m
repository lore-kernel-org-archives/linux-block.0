Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600362;
	b=tXz5qkPP5xQ9Dq5HLKbZL9C6jqkaMU/+8ajEpb9QDAeDDmM6zmV/xk8NhFuNypBkOsma
	 dtkZkiYiulpmOl49jKX4RAsZfoaFCRz0OSNq/yinPJjmOB0efr7HPs9pOANFGBVCd+kt+
	 9lxlb1Sxe9yNKVKRbHBhL3rlkQpXu5+SrbUPfD499gbdHF1BWn8ODUj1c7wXPk0VCBAte
	 SOsUfEVYrGviWhUQsV5Xzcu7UnCQ+L60G51IwjsB0f7/bzjP60CMx3Pi3iX8v8OKJLFUE
	 UjJwTJoX+WjESdliviy3XoaR87ROZ3KhVEcJl0jazNRg0VOJ5f4lSAL/OFMm/U9jcTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dC+5Lunx5dUQ5dWu37CHLZRWRMYn1XOzLPwBfQqIc2s=;
	b=iGXvgSsCrJJ7yXazBdAioMBqwa3cb4ZhLKUMGUfQzCLUREg/kdrOYip+26kmLbvIi1rp
	 3fDlKJ5CcyCYTS2IeHY6+5By+s82GotLEPUcqxu7S+KxbWPv5p4wkdtFzj41V5LbEL9eq
	 wLkq/LhvW1LrwWGjgmtAfowUZq+XRqxVsggw+zawBFXjEe/6pvLB4jdYK2HIe4O1vGq5g
	 WY15SbLxH/BlYVv/XHXM3LxmxwYtuJRADj6fH31T/lTqzmFEvUSlgjOv92QdYt/vu7R5Q
	 DCrf2P4v4wsNbvvThieAx1JEGC5iKaevVdqb3mBRNiiBfuxmnKW5EjItYUqM3mq+4XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ok0zsLYF;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F6606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 16:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19F6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ok0zsLYF
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so523137b3a.3
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792600360; x=1793205160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dC+5Lunx5dUQ5dWu37CHLZRWRMYn1XOzLPwBfQqIc2s=;
        b=ok0zsLYF6Jt/8Qjs3Kouo2Hzmuakm+SQxEo0XQvD95+U0UY1ZRvyAH9axs1/PubNR+
         ySRUGtxOsFYH7B6eJCgGD35Q43GfFsIAm0ds7WDg5uKXytYT+K2bu/MiXsK96XEahIrr
         LmV5/vV18/k2UtrB48TVICp3aKT/FrH3PED1mJRwpfur3y4hfNR/I+rq4BGtX8PYXBYe
         xuvq3hZy4pyuzD7ozUn7eG6lO50PP1Rd+k0qvZMyaSA0Kew7qmSo4GZC2IkXbxrMQEmo
         kshvDGnk6gF7pa6O5v63sFlndH/DRnUPOP605Q/EmggJO2qII0sYznH5JUZoXWPa6TTR
         /hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600360; x=1793205160;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dC+5Lunx5dUQ5dWu37CHLZRWRMYn1XOzLPwBfQqIc2s=;
        b=BKAtOcT4NnJJQrCt+bXy+gVa3mEabuy0SWOki1qhCZ3DA2cp/JQeEpmQ274JThEOeM
         DlsttKSaf18mtNQyeriQIZobHOAIyeGLa2ZEf302kfJfNj+sCOP05EEpUpnFLev+KORt
         u8fuOMJlLM/02zBvtHjLzTGZvz1VX0sd6oKAxGHF4NDvUl5yHuWxHS5yDo6nqbhEU8uG
         UWVjEv6c1Lki/DFuRSUyL325gsNzmR6/nK9zjYPpW9q8CeNF2cffyyRDwsjwgRQlFBPa
         6K7X1LFq5kGkRtqoyMPeibBQY5pZk5KJIA+O5wGPnh89OlMxnxG/hJhaqmPU1cEIH0AD
         vDPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzm047JgfsMLGjtZno0mA11mo695rVAYwx7+DdciiXwDI/zT2J70AkVjXfXwykrar+UGWBIlsh8Duv8Xw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJd6arxDmcNiJaCSMzn8tJlvcON/Eua7zD+Hgqv1hdKUlLBxt1Y
	BfNlaBiL2YqKh6hvE7cFKE/zIYcVUmmJVPADR5SSbev7bhtfHULY7jLHoEIgDEjAZec=
X-Gm-Gg: AYBFou16Ky8H1Z9ge70da+0UJufDsG2jUoG0FOEX3qfk8i5jBJ1r6iers0vNplLv8tw
	hzKAXkWtBMVttHZMgG2Mr6oRl+OCqCPNL77pd4PTdPKcUB1tPT9uGCDRlL619CCI++TPqdU5XQL
	JKFN5zqzuWQBkfvUsgyyVWHdMWeIoAj6K/pCj/QfwE07Jdb0bgRzSiAj3rRjiEjfp9ldmrc6COF
	U4pJdd4w7u33+jlgH9zMPOcuV/1SXRLxiT9lJgPIJXL5WNks8JCT981os4kxIYyRfyplaUJLrQI
	FMNoJWwc2HGTw3sFdS3erW+i36P+vbXZxFHCm+uJz24XtJyHGRLjc1tV+16eMhaIuAsaRIWGYfs
	+AmFqiY9lMp9ArLRVYVqVh9Y4sdPm9FhlKU17TLVmtEou8NG1+/E0Q3lRMdfjZ4fHdpa+UcQbyx
	+dURBkFwkG6/dKKPcMTM0O2i3hiXK0mFwbGsPWBxxp79vLge0jMR6bGjjG7ApkX7Hgc3gsH+7m+
	NpRO/CEWX8rT5HMk4gF2EpYmP0iKPob++Y1q7CLzWEuh29Sre2yOPZgAEiy534FDE7RlvZ4rPoB
	e722nUcA09pbSfNnNF1lNGCgWq+z+hdNdHTQj9EA+LwbwyOWf+N14ch6XOgo
X-Received: by 2002:a05:6a20:9154:b0:3e0:b445:5612 with SMTP id adf61e73a8af0-3e287dd624emr2111224637.14.1792600359159;
        Wed, 21 Oct 2026 09:32:39 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b8482048sm247328a12.7.2026.10.21.09.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:32:36 -0700 (PDT)
Message-ID: <db225771-106e-4014-bc43-3cd8f0e459cb@kernel.dk>
Date: Wed, 21 Oct 2026 10:32:35 -0600
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
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
To: Bart Van Assche <bvanassche@acm.org>, Nirmoy Das <nirmoyd@nvidia.com>
Cc: ming.lei@redhat.com, hare@suse.de, dwagner@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
 <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
 <29692751-e80e-4f29-a07a-ea0221f1116e@kernel.dk>
 <a39c904d-4d84-49ef-84b2-16db1b28b706@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a39c904d-4d84-49ef-84b2-16db1b28b706@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/26 9:18 AM, Bart Van Assche wrote:
> On 10/20/26 7:39 AM, Jens Axboe wrote:
>> On 10/20/26 8:13 AM, Bart Van Assche wrote:
>>> On 10/20/26 5:51 AM, Nirmoy Das wrote:
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 025a799f35b924d..00b75eb95dd943a 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -4002,6 +4002,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>>>>            goto fail;
>>>>          hctx->queue_num = hctx_idx;
>>>> +    clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>>>>          hctx->tags = set->tags[hctx_idx];
>>>
>>> Why clear_bit() instead of __clear_bit()?
>>
>> Since this isn't a hot path at all, going into details like
>> that does more harm than good. clear_bit() is totally fine
>> and honestly preferred.
> 
> Although I'm fine with the patch as-is, I want to clarify that
> the concern behind my reply is code readability rather than a
> micro-optimization. No other context should be accessing a hctx while
> blk_mq_init_hctx() is in progress. Using clear_bit() instead of
> __clear_bit() might make readers of this code wonder whether any other
> context might be accessing the hctx concurrently with the
> blk_mq_init_hctx() call.

I know that was your intent, but it just reads the opposite to
me. Whenever someone uses the __ variants it should only be
for optimization purposes, and preferably with a comment
explaining why it's safe. Unless there's a reason to do so,
using the normal variants is just preferable to me.

-- 
Jens Axboe
