Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963663A5
	for <linux-block@vger.kernel.org>; Sat, 20 Jan 2024 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705708846; cv=none; b=t2moHMa7IG/038ZPFxb/01BjU3QUJAEImxaQODNrKcIAW+KH8ty9JvPJ7gpffzjSSKTHQxMacNsLULYFu4IlqJNnIZvQrUZ4hLwn+f3MRCqfZT6qGhZjgNLgTD1qWIlEINUaVBcrFROSZRaSEIamkZH4VBR6WuXqZi2PK3xleHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705708846; c=relaxed/simple;
	bh=QWHLLXtN3S5NGGjo7FYQTBbppNXrieDgGv206Sm2Wjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dABKkvlBoCQ5poIcEnhzZ9QYZh+F7UUWpG20npPdSXl8zUJSjwR8MDscvx5n5BCpCurf58cryNEJjl8XtwlJHJUXTk2xG4GKQHyZESD3bfQVXzQ2quwPjs3JPAeP0ZaduifKAwa1PhE6gup0Dx8WTq8Ft+HPpP2XytYX1WqtaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q4Z+zR1e; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q4Z+zR1e"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9ab48faeaso323960b3a.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 16:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705708842; x=1706313642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zq6AorF3a2jpm4SSUjyVvG0hSnilHOqR9RqfV53g5EE=;
        b=q4Z+zR1eHjnv164ZYczaIwhOL1/rmlyKWX6DU3BphUv4R7XR2iqCQ7mwMUjVQFin4Q
         U4A7V0ek48X4axctxw+X6Sob9lzwTifDyjblXBbtpJfsREpn51ReP7V+0FmksJlWHk3B
         U1NQqGCt7VkiAdZHdzO5YWEtiFCaTZtj15UI9qNfLHYBBgg62/DiS4ZC5AWfSeQqXTrj
         noWVRsSlo7AuRlydIl9LonHRm2MJzdt1W43kYbxMl5Erc46Et1onAP7qIonM27i5I9iM
         Io0asTx4RVG5E3zV1UZxQXbs93eaxcfX3YCwdKjDJwVOLP4nUuZMjLACVi5BODJqV1jW
         zy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705708842; x=1706313642;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq6AorF3a2jpm4SSUjyVvG0hSnilHOqR9RqfV53g5EE=;
        b=K7qjTb4SvOg/mKxF7ZMtCassT6rWzhcmo938Th2WIJo0OkBi3ENvVf31cs1D/Zv/YK
         iRd+DUqp4UeA+Tq3Md3s0mZOtaVoAjZY6tIEBaKboQPQUnpIVe0DIh34QjeHX5qxlKNj
         vdvbqMipwiBsbosyk8B4EE3o5Lfn1mDvJTucyK9b+4Ha2a24WjFAIqsw0worC2EPKQqJ
         ztbhqMrjWIRfcC5dlxnJIBC7Th34KzE/fDWo8KKGuTQsZh32220l5IjHA6QavPTduWhz
         WyodBcMuAhBRX0GM+kRMby/dsP9dfIHFCUsmejnXpSCMv/pcc7DdqhAdUBh4qqY5LwEA
         GtQg==
X-Gm-Message-State: AOJu0Yyq5dTLY+sWykAQWaxC+Z+dmaa9HadlxIYN1kWokQYmhPcPTOud
	FzBMLL0COYOvy6lzSJmUqxNBHDeJpSdfDIICyHi2SHrvE0kw2qS8VAvxnpnIinN2jkCXTU9S7dr
	zLUI=
X-Google-Smtp-Source: AGHT+IEvgXE3L8oRaTe+pcvJu4xOaW2MOyFgvzJnxS+y3I0ToXyYej8el43nzdPWA5lBsTKJc6o8Dw==
X-Received: by 2002:a17:90a:55ce:b0:290:6b5f:fb0b with SMTP id o14-20020a17090a55ce00b002906b5ffb0bmr144250pjm.0.1705708842135;
        Fri, 19 Jan 2024 16:00:42 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id pv3-20020a17090b3c8300b002906b0fcc0fsm110927pjb.46.2024.01.19.16.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 16:00:41 -0800 (PST)
Message-ID: <b769a55e-c5ae-4df0-9516-67e5e46825fa@kernel.dk>
Date: Fri, 19 Jan 2024 17:00:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240119160338.1191281-1-axboe@kernel.dk>
 <20240119160338.1191281-3-axboe@kernel.dk>
 <711e450e-e8ef-40b0-a519-dba510bffa86@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <711e450e-e8ef-40b0-a519-dba510bffa86@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 4:24 PM, Bart Van Assche wrote:
> On 1/19/24 08:02, Jens Axboe wrote:
>> +    /*
>> +     * If someone else is already dispatching, skip this one. This will
>> +     * defer the next dispatch event to when something completes, and could
>> +     * potentially lower the queue depth for contended cases.
>> +     *
>> +     * See the logic in blk_mq_do_dispatch_sched(), which loops and
>> +     * retries if nothing is dispatched.
>> +     */
>> +    if (test_bit(DD_DISPATCHING, &dd->run_state) ||
>> +        test_and_set_bit(DD_DISPATCHING, &dd->run_state))
>> +        return NULL;
>> +
>>       spin_lock(&dd->lock);
>>       rq = dd_dispatch_prio_aged_requests(dd, now);
>>       if (rq)
>> @@ -616,6 +635,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>       }
>>     unlock:
>> +    clear_bit(DD_DISPATCHING, &dd->run_state);
>>       spin_unlock(&dd->lock);
> 
> From Documentation/memory-barriers.txt: "These are also used for atomic RMW
> bitop functions that do not imply a memory barrier (such as set_bit and
> clear_bit)." Does this mean that CPUs with a weak memory model (e.g. ARM)
> are allowed to execute the clear_bit() call earlier than where it occurs in
> the code? I think that spin_trylock() has "acquire" semantics and also that
> "spin_unlock()" has release semantics. While a CPU is allowed to execute
> clear_bit() before the memory operations that come before it, I don't think
> that is the case for spin_unlock(). See also
> tools/memory-model/Documentation/locking.txt.

Not sure why I didn't do it upfront, but they just need to be the _lock
variants of the bitops. I'll make that change.

-- 
Jens Axboe

