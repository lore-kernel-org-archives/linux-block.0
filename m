Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB62DF68
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604152; cv=none; b=oVTd3CMtKe40YwtUq00o6sqI8zSqpQaP3aRjuF3pT6i+eRiFlcuD6+IX8kL+PvKPpbODqe02CaJYJ1hNWOhH/H/E6MDDf1bYfkWXyd1R1iDwLuUq4JFFtPcAIqP76mGNMYn+J2UQIVwIf2UyP6xyMjxlv4qDSk6kH/fxD8cHbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604152; c=relaxed/simple;
	bh=JUiao2tbiqPs02c+3Yuc91GM7JBJJK946dDBDxlwWt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YTWNM9Li34vDK4RY0FBO5+nCUsrHJuWyJPfBH48MfjWq+1ewyI2ivwnP32AjbMmcnJUjmcGO9tyr1miyogpvVQYyfQ1/6urQor5bzI8YEEAuNqlNl7C360Fz2f/Gn+b80M9w+l+59Nvb5GmeLAF1yQsPQQqFrqTs45VDJoxVuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GRKFUcWx; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GRKFUcWx"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bee01886baso49928339f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705604149; x=1706208949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W49R8CBe6tc7SCs17WAk1daZ60gNay+8tkI0bVApQFo=;
        b=GRKFUcWxIZxExzO+2RsqRBRYy7NgBxwum6lflExnHcTzvgkloFBp9rHgllWZfTWs8x
         FAKuYeFep3SC9ow4zy2z/HjFR31+nbgBpeSLyMib4WkcfFNspaFFqLTmJlIMKfRAi938
         XCkhXFu6ffcCRdkwlAGYB+4FVa+lxcdeuExf3N7UE1UGIxC5Eyt9ZGbP1lHQUQBqIFHR
         3PY0IDXyYr67FtqTF0gLWuf9oBhfaZtKU5sdIEe6flAiBh/a4Tf0hdSL9NuCyDpOeDra
         BjqyfJIH0+fAZPUfyJGkktyf5uO5bJr3AVL70iu46JeFQ6y+/jmH9egORk2lTWp6LxFM
         ZySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705604149; x=1706208949;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W49R8CBe6tc7SCs17WAk1daZ60gNay+8tkI0bVApQFo=;
        b=QxEF3gC7VvEP0PoshMtZ8KjMouiqfyplJpqDdsM0XGVcNYqR+OElnVQvp15QfP9n+F
         z3PaPYt99F4swjV6P0/Fb9M1y8W86RYiShug171JMZBMdtCSwjEgPSEgQLFiTzv0WSC5
         I8wutRFTvLBAJfSDYVG5K1Jp4A+Rf8nZI/5MxSWspwin11Ef7C2oliBcFNHnHu1FmeOF
         1dz1QehRHJZHmkWFD5eRjCp5MvDDgObwP245kXeukhbidCDowDxpGdYlZywJdOErb6Jn
         cZxMYMdk7Nd9pUF//y8GoulPdbL/s7scU8z+IoLXvaJrlqVcp2VFb/K7Pd37O5x+27Jq
         HjQA==
X-Gm-Message-State: AOJu0YxRgp4DZHcAwbfyCk6W2Wross60ewd9aKAomR/nEpxSCBXQrwPX
	I0jkS7W45ObobZ3OvFM6iJZeb63r1YQoAenz2wIWH4LcA9xrWYtM2PGIIQMV69k=
X-Google-Smtp-Source: AGHT+IEDlp84snpsi2bLTeYmzY7AB+2LTDbelEhcvnLOE/p7oVGAsW8WBV/5Yt3FJ1etXN37e46S8w==
X-Received: by 2002:a5d:8b50:0:b0:7bf:7374:edd2 with SMTP id c16-20020a5d8b50000000b007bf7374edd2mr317642iot.0.1705604148826;
        Thu, 18 Jan 2024 10:55:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d980a000000b007bf45b1c049sm2243874iol.0.2024.01.18.10.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:55:48 -0800 (PST)
Message-ID: <ba770235-7c2f-4886-9507-2fc2ff521e35@kernel.dk>
Date: Thu, 18 Jan 2024 11:55:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-2-axboe@kernel.dk>
 <d8485e78-5cf5-47c1-89d4-89f52ba7149f@acm.org>
 <3910157f-dbb7-4048-ac52-a2b354048be6@kernel.dk>
 <5f1e2bd2-b376-4272-93ce-a77c9b0c81ca@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5f1e2bd2-b376-4272-93ce-a77c9b0c81ca@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 11:51 AM, Bart Van Assche wrote:
> On 1/18/24 10:45, Jens Axboe wrote:
>> Do you read the replies to the emails, from the other thread?
> 
> Yes.

Well it's been a bit frustrating to say the least, as you seem to either
not read them or just ignore what's in them.

>  > And secondly, this avoids a RMW if it's already set.
> From the spinlock implementation (something I looked up before I wrote
> my previous reply):
> 
> static __always_inline int queued_spin_trylock(struct qspinlock *lock)
> {
>     int val = atomic_read(&lock->val);
> 
>     if (unlikely(val))
>         return 0;
> 
>     return likely(atomic_try_cmpxchg_acquire(&lock->val, &val,
>                                                  _Q_LOCKED_VAL));
> }
> 
> I think this implementation does not perform a RMW if the spinlock is
> already locked.

This looks like a generic trylock, is the same true for the arch
variants? Because your attempt either failed because of RMW or because
you are hammering it repeatedly, or both.

In any case, even if any trylock would avoid the initial atomic, it
doesn't give you anything that a bitop would not just do, and we use the
latter trick elsewhere in blk-mq.

-- 
Jens Axboe

