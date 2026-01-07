Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28B1B4223
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804517; cv=none; b=YSPw5ODdCmvKCdXatvC9JbWcLCFpKx7TjSpeKfpN5QOvcvUqx29uNMDClZKUyiIoOCeML75WorhNTq7iAu2g+qkSJFspoQTUfgewjx/026J9/egUVRGCBh0KL62bbwxIqKG7erqkMOtMw1aMmq52oywFnGCb0IL+WX2TczP7ZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804517; c=relaxed/simple;
	bh=Z1lDrlIoZjRwTOJrnQdRhzb4Z4W2ajUdckPtpSvNd8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMtKzu/iVCVB1XjJ7A4IcYD4bDvt7JysMOF3jdGc1QzpG4xRlKCOjZRWZFAMbvNuV5nK2/83RFTLK980eYEQy7Eqc/wpa5uNgriBg/ZuDLsmbjUN2kaGR1dIpDDZPZ+94/tCjlZGBwz2P0oqJAeeS5eVaFmv4lc/EtAn+ITdJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KhhHQhXp; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KhhHQhXp"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-455bef556a8so1501925b6e.1
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 08:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767804506; x=1768409306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IznB9XRiMWaoc8HvDz9QD9lzYoDuhHiwuPyZDHWSVuw=;
        b=KhhHQhXpLjXU1cyqZAf+00XeACipcCLaKCNBQBcAoQK07/aoiorxOfhqSwh08FAG4L
         lzyE+8IsFXmhIL0lf6OKyH65I/Qw/X04IMgCZO6Lf+qIN4f7LQZjf47pHGaOqYBXUTAX
         TKv0T95fe+7jBvktd4h8DPut7pK7cntmorXPQualb7kewoWt1/Jv23q0GY3rBN4rNYAT
         cC2Aftk1T5TGLgEPpJK5mdWBG/bQp6xhryqOMpW4U4MmvECjuRYlnR3oUu6ciZ+cu5ca
         jqp4trQ+FTuSIiKH2vS7IO9aNMDVrHXUdJnHO2B4JVwn48o8IIbaegITbAFGmtK71W20
         iQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767804506; x=1768409306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IznB9XRiMWaoc8HvDz9QD9lzYoDuhHiwuPyZDHWSVuw=;
        b=xU+3f18glOgrNsz/Glcq1J+I8dy0w+i50Vf8CWYHx9pp/MPQe40pMw3GK3Sb/PsG5A
         YPk8XxKd4v3S/AEU7FHc4VrEUbG+mSASunjxNcJkyL2z5+E5kd6tDI9U60ZqmIC4UCkw
         EE2fsEAxOTdqraHs8NDIUPeAeuebsCifRSq0PROea5Q1L4x0sW7GwY5tXwDIJGFLUpIJ
         sI+yNit3QReeid8lk20I2w/VOLdbfa9lMwmrOytyidoHF/o1HhWYjxll3r5IThf8X3rc
         d3L11Mkd0kI7mzneTZOXzBdhbRnN4Bod5WGvRFA+tXZtUjUPMnue5EQBs9Z196fe+kC6
         Uslw==
X-Forwarded-Encrypted: i=1; AJvYcCWBC75Xw7rrjGyGDI4Xlieyc8eyTt+auqFL0UPUG44fKAlI/SzFyvOkQkQpSnjeVc0vOvGKlAKt3AsuGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUnABD5JUZFkC3ai/PdRj6fKVRLCJfJ1kjSGDoEHwUMbxMPYZ
	G4scYdyJfgXW/I+Afm9+bK3SDMk173Itflc7/+Ld8rmmffeWy6XfndN9NyZBCabgiPFSrHhMrpW
	xuKPJ
X-Gm-Gg: AY/fxX7zlqwbipPrY7yb4TVAvYrYKbYwH1YbEW1+blQ3CCdFMTFDNVLo3r7TX9I8+P1
	ZW1swzOSY1Y99g4J3nHcGNpFeGaUHT57vSpzrwSvvKAex9tbR9DvCsqmdtZA+QZAYYKywWPO0kv
	Oopa2CUBD0Nh1e5fSrrSdUH/6Su8cjWyx+RfVGudIP5J2Ghx1LSVUwAKU7lz1O9LN2sGh9RABcU
	uyeqUDBirnHah6p0OPxMTZAwXkOJSv8faHXmpdgYpVjz4lgEsEsNQw7CPKjZ25pjHq8n9DQZr3D
	+91Ow2SZGNEnJ+j9bBcgE8fo7zl8d1I4fj1HLNJjEtP5g9eXJE4YTC8BSgJ+8/Xm5fMar7jkSXo
	K3+Egt5rv7wvFlwskai36KK6SoyM+QRxAJ/3goXGRCiBFHUdksihw5kVKZNca0u9YJD6bNfaf1m
	fFRbzuv+k=
X-Google-Smtp-Source: AGHT+IHiXrAt9n107gNyJhgrRM/oTBa7LiMQOiWT9pxZj7sqlsfp4i2+A9Ly05JfMZJikxY0AEttzA==
X-Received: by 2002:a05:6808:6787:b0:450:b3ec:c154 with SMTP id 5614622812f47-45a6bd31debmr1332401b6e.25.1767804505852;
        Wed, 07 Jan 2026 08:48:25 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2e903dsm2498754b6e.20.2026.01.07.08.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 08:48:25 -0800 (PST)
Message-ID: <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
Date: Wed, 7 Jan 2026 09:48:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kernel BUG at lib/list_debug.c:32! triggered by
 blktests nvme/049
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 9:39 AM, Yi Zhang wrote:
> Hi
> The following issue[2] was triggered by blktests nvme/059 and it's

nvme/049 presumably?

> 100% reproduced with commit[1]. Please help check it and let me know
> if you need any info/test for it.
> Seems it's one regression, I will try to test with the latest
> linux-block/for-next and also bisect it tomorrow.

Doesn't reproduce for me on the current tree, but nothing since:

> commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
> Merge: 29cefd61e0c6 fcf463b92a08
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Jan 6 05:48:07 2026 -0700
> 
>     Merge branch 'for-7.0/blk-pvec' into for-next

should have impacted that. So please do bisect.

-- 
Jens Axboe

