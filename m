Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5221CC52
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349436; cv=none; b=PD8Zsh3Cyoo7YHnfIhoWBCM6snlGJa6VZQ19unmoWhdW4QCbNoNOjejEhemMnmt2MA253s4l1W0wMfA0nXYyi4A4efbM40zVkAHXcVYJfw5mKP+k2LropqHh3gezQYFKEF7KW3ApqFE86HizDkbQZPpZ4PKDTQK2fNX3xrKsQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349436; c=relaxed/simple;
	bh=4Iky9k1xOnxkJmjy7odfgV61tLiI113GtBHNMqbfGuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMN94Y59SqsPIQ/6VNXk+AiyUuaEtxh0lophiRPPkdEPUaKn/hM2jnuIsVnBZYR2EdFG6tYHHmO7ndHVdrcki7+BxzdzTu4MQb/w/HG9je9C83Trunyb26FGetw8v94K/+RNjXpu/hk3YuNxVy9L9bWwi1j+5Pxok4Yu6E+vRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qn/pDGIB; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qn/pDGIB"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85b40c7d608so582413739f.3
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 18:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742349433; x=1742954233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAtG/3XT8Z4ZhRh/HAzFXzZVyaeq2S82ltLZZg2sZSo=;
        b=qn/pDGIB1a+zoF8L92G4E+iAUSq2nZnL1HjUx38AsUOKrNUAryL1OKXtgIXAhz0JiB
         ZeP+EKYow3zoPwPTVVVisU7JsXK6pVs8Iuk7BX2Rk/Dhg3ZTiW/vfzsC7DVLa9To3tBc
         EK4qXZH0aDrVAQBczH2SNWdfV2KTOBue2hnfwussq2PIN+GaDdTF/0fKn0F0/G/AJ5UK
         zX7ivSn8HlMTEe8+eT+Jkk2623YrYSyvku6sZDh0wQJfxGCyz/Y+Lz2ggNaulUG2Ttn6
         2cPs+9sLge8K1qRLLEnhg11NJHF3ppS9v2bHAgrFYB868QJM8dj+Pijfg/YKv3q3eNDP
         271g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742349433; x=1742954233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAtG/3XT8Z4ZhRh/HAzFXzZVyaeq2S82ltLZZg2sZSo=;
        b=cA25H0JB183oMAWGmGsaXlFgeWAwvMIXcZ/l98UJZC7RCQmsquFmP4MK60kfvfpbxv
         gXoeX3FrAMQBa00mjtFqOVkOcwk7xM3a0XQshuBqXkZxWWxxZAo5kt7mSI1ajmbvCmVa
         rD1QLyt5qLYQAJat2aMLrYm8mHAGCnEWOjgQCSLbAMaWj4GWYgn/0najP5cB7XmY48F4
         7OI88Lunr1PjCzKFT21okMmf9QWxIFoXKomNyJmIXVBl0A+Fy+m1FA57aXsJss3r9rpy
         SCV2RifT06Hr6zJHoXDmW6K1D9GDC33O9jcpOnXFCHxEqS3XGHpjnm8CgvLM39BRs0On
         pI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNE8kFc6C413mfV+xhGjBlgEDnzCTKEpvTvlVtvFh1kgTByInqwsq/1lDjJNxFaDXUjJsCcaI1qCa1kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZjeBDKFQjalQz871zYTAgD1YcxMKNM/kHCwCIXQdHJBMquYn
	POypfkvDvyu62PDeMcZ3bKJXAC6ZS6tMOVDVpbzssgLZPrnPWfjJKRoeLVX4Lcgf5t9UcsQCh7G
	0
X-Gm-Gg: ASbGncuGAYg5zlFIbSn5bDpfs+CmSu+J/QTVi5zenIW9tRCEaR9rSruk/4C3rccgvtg
	1Ki3JU6if9ZU7/mb+WizKfXMmqSlFVs863ZJ7eL66VnGRCDIOAX1hHFxzxK2nLFf6ZnuD3vSAO/
	JmVv21vZU+f/ycAveQY4tTUEwozHGO05KIHGUuJeiBT75+ClJvM62vKn8K6kxbG9eFl62r5pLCu
	fYXXuJJBlFHM8+ngIFVrHXNZWgtTdbnHtHWiY+dYV9oPUhMyxO0aXtyjH3JBUN2Xrjzwp9t7G6z
	twOj3eHTiT+/op04ZCV/bek1Ji0oiFEcxGwYgYQx/A==
X-Google-Smtp-Source: AGHT+IHF7/5McpOTghKiFHWq/2xfOfaFa5C8Kfg8Jj5rTk0KBja8L7jo2jOzdntuucPNbmmOqgwxpw==
X-Received: by 2002:a05:6e02:1d17:b0:3d4:337f:121b with SMTP id e9e14a558f8ab-3d586b2b089mr9206325ab.8.1742349433365;
        Tue, 18 Mar 2025 18:57:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f26382c424sm3023540173.134.2025.03.18.18.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 18:57:12 -0700 (PDT)
Message-ID: <e9fdd761-d7c6-4c2d-8621-cc151d5fad8f@kernel.dk>
Date: Tue, 18 Mar 2025 19:57:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
 <c91dfaf8-d925-4f6d-8ced-06ecb395a360@kernel.dk>
 <Z9m+3qMBXgqDz399@dev-ushankar.dev.purestorage.com>
 <097f0495-b2e8-4938-9a0d-c321f618d49b@kernel.dk> <Z9oYFdWj1qAWH1q3@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9oYFdWj1qAWH1q3@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 7:04 PM, Ming Lei wrote:
> On Tue, Mar 18, 2025 at 12:48:44PM -0600, Jens Axboe wrote:
>> On 3/18/25 12:43 PM, Uday Shankar wrote:
>>> On Tue, Mar 18, 2025 at 12:22:57PM -0600, Jens Axboe wrote:
>>>>>  struct ublk_rq_data {
>>>>> -	struct llist_node node;
>>>>> -
>>>>>  	struct kref ref;
>>>>>  };
>>>>
>>>> Can we get rid of ublk_rq_data then? If it's just a ref thing, I'm sure
>>>> we can find an atomic_t of space in struct request and avoid it. Not a
>>>> pressing thing, just tossing it out there...
>>>
>>> Yeah probably - we do need a ref since one could complete a request
>>> concurrently with another code path which references it (user copy and
>>> zero copy). I see that struct request has a refcount in it already,
>>
>> Right, at least with the current usage, we still do need that kref, or
>> something similar. I would've probably made it just use refcount_t
>> though, rather than rely on the indirect calls. kref doesn't really
>> bring us anything here in terms of API.
>>
>>> though I don't see any examples of drivers using it. Would it be a bad
>>> idea to try and reuse that?
>>
>> We can't reuse that one, and it's not for driver use - purely internal.
>> But I _think_ you could easily grab space in the union that has the hash
>> and ipi_list for it. And then you could dump needing this extra data per
>> request.
> 
> It should be fine to reuse request->ref, since the payload shares same
> lifetime with request.
> 
> But if it is exported, the interface is likely to be misused...

Exactly, that's why I don't want to have drivers mess with this.

And following up on the location, as I forgot to do that in the reply to
Uday - the end_io_data is not a bad idea either, drivers get to use that
as they wish. Then you can't use it with an end_io handler, but it's not
like we've had a need to do that before anyway... It is a bit odd,
however.

But the ipi_list is only used completion side, at which point the driver
is by definition done with the ref. And hash is just for io scheduling,
which we'd never do with requests like this. So still think that's the
best option.

-- 
Jens Axboe
