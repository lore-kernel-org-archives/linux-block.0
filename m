Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91B273810
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324534; cv=none; b=WydnCT418BU9AoVFA6/vsSwl3p86xBTh5fgKdojGO26Op5PmptuImxd4lpEcMkPjy0zRqRfItw54GPPV/6t3KDXE46DoQAeBJprO8fJ8t0iJySPn2v8FqMbPKqs9gW14poj/ouXMSB72fk6eItJf/9eJB1LhfLoTsNrpM0rYOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324534; c=relaxed/simple;
	bh=N09Lggw+BrEhUebvMDbNZVCFYWU967lqapi7gcfd2XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S8f3/JBEHJTadKxWsgw78cbKmuGSqtpn/TTR1UY9RQ71VGt9q1lLIY25Pvrgw9Ha/lHY8J8MfeGUdx+zLawQhV9yjEOwOaLc5usTYZo2gM21ldHs8UX4RWeaF2ciLMn8eH4KRmnQs57I7bSyqvyryuRk9RqU7uip2WmFZmyDK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=opw7qt1N; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="opw7qt1N"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c1so965485ab.0
        for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756324530; x=1756929330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8MUZaQIYG6BL6uW/+MzW11iO+Nd9sV80O7ktOqXKopk=;
        b=opw7qt1NRQvuclajfZ9250Of9XAJs1f3vCgXtI8j10KdNTDwr4BfDVWMRtYSpEsYkP
         poQ6WN1s7ycRvhTaz9pakzJYcKd1Vm4Yajclrlu6FwZIwDNvktSU11iCBK1/qjCG765i
         zhgvKObK+wPuUr4tPBXLkmuLbPVyQvRY2SRIXPkHZBSks38uxOQ3wEX/AoYS2ItOmDGH
         5IAGfQpBY/3HVXpQI/OfiG0gGb5UgCsbZGkWV0Hu2kFjE5T1SMLUIW+37VRQqEKqL+a6
         qe9zotoiuYnddG7MhRQT4CepUNW+Q+Dvz0369eO74b1ZJIbdkXM96v4FSq8VT6c8ApY9
         Wf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324530; x=1756929330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MUZaQIYG6BL6uW/+MzW11iO+Nd9sV80O7ktOqXKopk=;
        b=LDKf4BOnznOsWNVaqSMMP2PeMNeJ0lLRd0Fo6Ywos8O5AeIYgSil0xSldEnuZg6VC7
         1tMcrir5OO75HW6ENfu3HeS/i3Aan4xyjB5Tx931eCbbp16Ad0HVXUnHVRNAS+0zaskF
         kwKlSdGkccPJAZUdGxN6YYMZvoucmgEVOXi7YfGt8/i/HsDSxX1uo0EdTDcMKldHw124
         SK2Z394edgbPZueA0LAUgpJmy658rTXSgireggKyP7s1/GGvh2zeYdS3htlf2g0nvN4F
         TxIemfVRupEZBQguMUpCF1gjhWG0gUqa0DWTswMECem186hPygP2nnhbusLcQu0HtGWS
         INkA==
X-Forwarded-Encrypted: i=1; AJvYcCXaFVhrjblPbwdglx9p6XweYjzdfu1k1nFLH3mDoLpveHrjA9xQ01o38+Xi5bwzvNpqo7gk35NhrRgwqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVaW8gBqcswMH0/W8fneKoUh5Xo7HCkkeeny7B0u7DHUduuAV
	eDmMnjCr5iPBGzBXdqDnrOreMRUqB463v7OyZ6i1Aa6ZqisfaJU9mB2eTAhOPX2low8=
X-Gm-Gg: ASbGncsd37ppX1QAeFio2cP11IiaCc2BrEBeLg9UY3M36sINT2LIzIksEL161Hkz81D
	Wu729nyA+LVZ4gIMALZaTSLeuLVJ+iYH2dKgPMgDpy7JGyMEmF8JCpDGXOF47kFpKzBBYam3kOI
	GK49JZAB74h2xHyg9di//GGlhcZAmway2H2Ec7+EdhZe5qWp2DkAYDnM6S/gxHOyIuwUCylmqM7
	1ISDrzluG+LM4Va5QvUlojnEIvnWASlXxeZn+4bKVxz3TKxqbWfrq22pcOfbFwf79hlZKiOPY7u
	FsZq8WJR7ZZSXDkM7NEDzl0+iG0EntWysmFndnzbXH+JDFmCKcsDBjlq+7y2IdjQ/qOO6+uXf5q
	iB38vt/nHxK5PL3R5/ALxnUf0jAuYIg==
X-Google-Smtp-Source: AGHT+IEsQmmJ+nFf1MkiGe++IkZlgHN6eqs940thF8/gYFel04yO1dSdjxBZQMNe5eKew3zIP+O6Ug==
X-Received: by 2002:a05:6e02:1a0f:b0:3eb:8e5a:8fd7 with SMTP id e9e14a558f8ab-3eb8e5a9145mr192453505ab.11.1756324529861;
        Wed, 27 Aug 2025 12:55:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c191550sm97846035ab.14.2025.08.27.12.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 12:55:29 -0700 (PDT)
Message-ID: <1182267c-d291-47bc-8e5f-2e11aa93421b@kernel.dk>
Date: Wed, 27 Aug 2025 13:55:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] loopback block device on top of block devices don't
 work anymore
To: Lennart Poettering <mzxreary@0pointer.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rajeev Mishra <rajeevm@hpe.com>
References: <aK9c5jJepHEWIONM@gardel-login>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aK9c5jJepHEWIONM@gardel-login>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 1:30 PM, Lennart Poettering wrote:
> Heya!
> 
> Recent kernels fail if it is attempted to create a loopback block
> device on top of a block device (rather than a regular file), which is a
> feature long supported on Linux kernels, and that systemd relies on
> (specifically, systemd-repart does).
> 
> For example, this used to work:
> 
> losetup --find --show --offset=4096 --sizelimit=409600 /dev/nvme0n1
> 
> But now it doesn't anymore...
> 
> This is on 6.17rc3. My educated guess is that this is caused by
> Rajeev's 8aa5a3b68ad144da49a3d17f165e6561255e3529, which tightened the
> screws on validating the backing file's size, which now fails if the
> backing file isn't actually a file, but a block device.
> 
> (But I didn't spend more time tracking this down.)

Yeah sorry about that, the problem is the followup to the commit
you mentioned, and the fix for that is here:

https://web.git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-6.17&id=d14469ed7c00314fe8957b2841bda329e4eaf4ab

and will land in -rc4.

-- 
Jens Axboe

