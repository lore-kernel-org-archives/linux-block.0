Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D471327E8
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739581; cv=none; b=ZojZgu05SY3zdO323a10B5VIDRNKDCSfl6FrJ/9f1Ar1gIPwClmQ6G8XtBNtgRoH5L0GZ0ZyoswcwhWvCYLT5bMtRb08QwUzWUAgbPYJG4dKDTS2k7X1DSbdFlkCC6KA6xaIHVf9t65yrzKjiXFVmn//n3HM51658smuwrrLWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739581; c=relaxed/simple;
	bh=hkDPtZAj4mEBH+E2ODm/oYL9vxFp6ZkJdLxiGUQwOf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHfR11GpdGWNRrg6ew75YJqdPGn3dRXDuVsl4I67f6H/ghVWMbXvikrVzUAlWduWsEpvNc8jD/oPoVwsVqYw93oqDuBzh1cUEF31Rb7KF7OYLRrUUpDxNtpXbtnBxBzH3wfQNi9CgUKZ5DhxI1g/YgXBxSAsgw+YHqqjzAUaNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zVLXaclt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zVLXaclt"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e694337fffso459370b3a.1
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711739578; x=1712344378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VBNKvDbVSXWscDx2hlPOat6rwmlhFUpp4tFOtD03l0=;
        b=zVLXacltvY79RZB0AiZ2AWaSCTOJvw4mLG/Vi4nVOMt+q6bOnvvZEJd+/HDf8yS/pm
         QfPNtlOSqHda0W6iaXAxccRmtJXsEcfd9cKpkthVomlls2kLTPZ64Ee2nkfChu81A3hp
         eRi1546q9wPaywzBa5OjisqOKkvD8bfK4A/ECC3B/T03pz6kN74zHlMf/9DxuAUmL2zD
         iLRONFuFq5xXWFR8YfAKL3Kk0n2EmqYwQMpc3eSPxq9WIEetn0uSaUdd2ANtNBgbiFO2
         mFGYNdlUgZRNXul4j9uyp1U0dDkRfoMfEPB0WNMbzdC6ViKOVppr3SBhUHVk7QlaE9S+
         gPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739578; x=1712344378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VBNKvDbVSXWscDx2hlPOat6rwmlhFUpp4tFOtD03l0=;
        b=KGG6P5XDq0vlXlYarKkObzaugVzMG4pOBcf/jSO4lYMOHUR4LFShf7tjAsiMXI+wwT
         6NQ62hqUHZkd5y9q3I+Lijd+e3aeS3PLauLMzfmYrChOO0vsbjZG0mnAmqCcdJmFTwJh
         UY00eNr+ckbDm78QM4osKoRrhOHNG4/iNYYzKOfXV015AHQaStA6aCTCfNK2Nt7SWU5a
         Fjd24lPULg90ta91QbMW8xjtZr0yRvMiV8BNpos85WgEjwPJ+BieYjWel3DcOHuxQ+rc
         Om5xMuNvjg0/CGKxB8fvwkgFlcPuq2RgEl9GDBJz73DlsMttzmuv/OgT4N5K38gUjWtt
         Stxg==
X-Forwarded-Encrypted: i=1; AJvYcCXim7XJzTQYUt1yIx3k88AWY56BhvdgLDTNJbl/sff+GQ5wayh1dp4k0nKjMRKffkAtSfIuLEbbG/6zuWRp5cEy5ulH2XJS8pbfnUQ=
X-Gm-Message-State: AOJu0YzND6mQ+Idq1oV6iZCnGMuQYgCVRBhbKaLH+3ZZ6kZUIRk28QoJ
	m57NlMwRsOaVPR/sWLSG7Q93efQshA+43nKU1LNXhCvUY9g88PEzlaas9JZxqiw=
X-Google-Smtp-Source: AGHT+IHzrTpKVu3zpcysw/Cf0jw8pV9XJkpAzWgws7EQo9UlGHeDEs00hxVoRGiuAfLZi4CwVuuaIA==
X-Received: by 2002:a17:902:ed46:b0:1dd:7c4c:c6b6 with SMTP id y6-20020a170902ed4600b001dd7c4cc6b6mr3221673plb.5.1711739577898;
        Fri, 29 Mar 2024 12:12:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a5ff])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001e0a7e5a34dsm3806504plf.81.2024.03.29.12.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:12:57 -0700 (PDT)
Message-ID: <be8e14ec-3d46-4d67-88b0-f3dbf7ff22b2@kernel.dk>
Date: Fri, 29 Mar 2024 13:12:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-wbt: Speed up integer square root in rwb_arm_timer
To: Bart Van Assche <bvanassche@acm.org>,
 I Hsin Cheng <richard120310@gmail.com>
Cc: akpm@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329091245.135216-1-richard120310@gmail.com>
 <848d1259-ff6e-4732-b840-a02a5e5fe2cb@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <848d1259-ff6e-4732-b840-a02a5e5fe2cb@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 12:15 PM, Bart Van Assche wrote:
> On 3/29/24 2:12 AM, I Hsin Cheng wrote:
>> As the result shown, the origin version of integer square root, which is
>> "int_sqrt" takes 35.37 msec task-clock, 1,2181,3348 cycles, 1,6095,3665
>> instructions, 2551,2990 branches and causes 1,0616 branch-misses.
>>
>> At the same time, the variant version of integer square root, which is
>> "int_fastsqrt" takes 33.96 msec task-clock, 1,1645,7487 cyclces,
>> 5621,0086 instructions, 321,0409 branches and causes 2407 branch-misses.
>> We can clearly see that "int_fastsqrt" performs faster and better result
>> so it's indeed a faster invariant of integer square root.
> 
> I'm not sure that a 4% performance improvement is sufficient to
> replace the int_sqrt() implementation. Additionally, why to add a
> second implementation of int_sqrt() instead of replacing the
> int_sqrt() implementation in lib/math/int_sqrt.c?

That's the real question imho - if provides the same numbers and is
faster, why have two?

I ran a quick test because I was curious, and the precision is
definitely worse. The claim that it is floor(sqrt(val)) is not true.
Trivial example:

1005117225
	sqrt()		31703.58
	int_sqrt()	30703
	int_fastsqrt()	30821

whether this matters, probably not, but then again it's hard to care
about a slow path sqrt calculation. I'd certainly err on the side of
precision for that.

-- 
Jens Axboe

