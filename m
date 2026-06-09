Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DB44B666
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017533; cv=none; b=AiszI6/9KObRA3+fyv8vJxOMWlCUTa41yY+Be4A6q+lx5r43du40bTcKe64fZH6qmcxed9xkHTsKKBMJoQpxfwoCf13Nrsd4ePvJcyQsmLJih0/zCCiLmgFg3KGKsMJZSt+moA6nRD5GtmGLiZ9poAWynmz5Y6japaBD8i2PgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017533; c=relaxed/simple;
	bh=J6xr6hQjMPqZ15jNGtmoGr4MI51kAa9A+B0VSXNVazw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAQyIY03bZDvCinSbiodjmT4pMjQVOUu/cTuawkrg05X4J9R87LpuxQg4xAdA0Gvq+YAQ/B/2O0sGSx4Y4ucbZHMx/9zky7WbjLZNOGYaMJgPaT8VA4HktG5eVBxjkiM3MGLXUqNvOQ69BeQP6LFxNgScxvyVQTdlK2opmmDY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=zc/W5tZd; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="zc/W5tZd"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43d34292872so2675763fac.0
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781017531; x=1781622331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lagboJHSs25ChzuYkvLlxQjyW9/PAyU2SUmQJq5dsk=;
        b=zc/W5tZd5g3gBF9Lr967i0nn48NecAmzk4L9GUin8dbEvFSG+Z/ivtkVZ+T8MmDjli
         AD/eNDDQ415MazVJBd/qRetiSA1pcBRk5sVjs8KRrYGA8SQM3XVoOB0auM++AmHy3wxU
         KZqOFup1Em5jWD2iVPdLe1BzYAzIbdSLHxaQfZtIZyj4NC9pMGKom8STnl6H9Y/P3KiT
         VRvzHVaMMjUla4+8t9kBDaZ1FhZo6O4VFbMXn5zjJNyqalo5ULTSiPSzxtAAdRccvcpV
         AXkN6RLg2Zvztrfk9gS41RpGqP/bwe7oNqfYp52U/+VVUCklnoHQ9niSpysT7FCAZRko
         gIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017531; x=1781622331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lagboJHSs25ChzuYkvLlxQjyW9/PAyU2SUmQJq5dsk=;
        b=kFlCV6N76z8ruB7UKA0XPzFbGIztQXCMFr5LCpNLPge70OMYLREyXufEoNwd2nbxA5
         gZ3im4pGw8k0bj2AmLUAGfN5onHU2xU91K8OhFvNwSEnynu/sVkqkkgTpFysVIIBw5XR
         C2FJeT3vM1kkd/6yeZbEV/fUN4YIngZ3RdlhbsRMoLkvAKOX0Nc1uLaJHJ5L01nf+2Cd
         bn3GJAS74DoIU0crcuFmNAsEmPdkVEIxZfCucR4rG1jkw0LVLW96cMGIGEa5TyzI/D1a
         02o3RqVOA0WQu1/tRJAOxSNN/Tk582b8PHH73+PRjQrUhDOcJ31M5x9bNHPHOguv800a
         zc6g==
X-Gm-Message-State: AOJu0YxAIPqfic/BTYgrjiEXlNpgQX5FsCNdyZ87OFaDGcYy2OSVYOMD
	k/Qr2Ogfue2CFJ3dHoN9fLgm8xx/eR/Xy8bVDp5oiLdORj1mwfH/QSD9K/vqbW6hi8k=
X-Gm-Gg: Acq92OGwXFXXYA8HlPeF/sFOe8dlW+v9+yO5kxmkcTpyrAvzM85mxeEpFeCG6DcDamC
	ZLSXIQDVQ6Q3xX220NGUvnwj1CzucNKK7/ilCeMbWXUnl72+4czyCZPSvWpcUWqtnr6yTldMMSZ
	ItBr5pa7RSmXP6jnMrre+QCwkQsaD+dlokD2RCrT4Qyku8PUaSWoR1qvNn6Y8qfYk/rTqE7/1NX
	BMsapQHhp3CDBaIa3zRafSzPft2qOnXwthFw8ZGUoHt+FRCTqwz1IUhTHECodGpYiBuPbnUVP2C
	+gYZ9AY7YVVvwUh173Oajou1muLuKIHE31eMcR9E+jLs5Y+/D28VJeawI3Gy5GJ4d/NfGHv1le1
	CPP6QPNItJ7s6capzwGT5XSU6ykLpYIxYdXzd4jwA3sVfxMSYWfrNi8+CdOam+u1F3LKDfq7gOX
	dDdcnKy4eBegi/iouesTtd0E2Klbv6Bz+v1neQmVMOLZfqWLg2e4uYSXcrSXOtb82LxSRmNtN5i
	hawcEe+rt9LdMxGe24=
X-Received: by 2002:a05:6870:5486:b0:42f:d09d:1fc9 with SMTP id 586e51a60fabf-4413dcfbb82mr11317469fac.32.1781017530504;
        Tue, 09 Jun 2026 08:05:30 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7263efcsm19450933fac.0.2026.06.09.08.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 08:05:29 -0700 (PDT)
Message-ID: <8572a148-3b73-4de0-ac98-74b66e3d7ffe@kernel.dk>
Date: Tue, 9 Jun 2026 09:05:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix arg type in `blk_mq_update_nr_hw_queues`
To: Andreas Hindborg <a.hindborg@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260608-update-hw-nodes-arg-v1-1-19aba440b32e@kernel.org>
 <FOXAofrAzzcIqRTKeSNiGa5f3W0WLfFdudQ09DTURWykttcqFAbE1iXzN8OH5qslsMlcMGxfxRcxIzaiUvLqkg==@protonmail.internalid>
 <5353c4b0-fc3b-4fa7-bcd6-c8cc490699ea@acm.org> <87qzmggn43.fsf@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87qzmggn43.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 1:59 AM, Andreas Hindborg wrote:
>> If this patch does not change the behavior of the code for any practical
>> use case that would be good to mention.
> 
> The patch does not change behavior of the code as long as no overflows
> occur, and they are not likely to occur. I will be sure to add that to
> the commit message.
> 
> I came across this while designing the Rust API for these functions.
> Rust is kind of particular about integer types, so it gave me some
> checks/casts on the Rust side that really should no be required. I was
> thinking we might as well change the type on the C side to unsigned when
> the data it carries really should be unsigned.

The change itself is fine imho, but I agree with Bart that the commit
messages should be phrased very differently. It's not a fix, it's a
cleanup that makes your life simpler on the rust side.

-- 
Jens Axboe
