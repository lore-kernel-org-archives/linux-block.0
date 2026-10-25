Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792897764;
	b=bhYv61XXZWk8F0BLV1rm5GJEEK3YOWmO3A6+dWx2/uAE0f0Dx91ryB3rol8LAlf18HNg
	 uSaOvH1N7gzw5Zg3p/kTa27XAFp9BjLBWDi9Yq71Y4qDZ6D9VsRbgd6NA9Fmra8WUuUet
	 SAuLVqT/jBN6iHWM9iRkCoivOTNs0P2d+dWe8vZfJOYM+O/SmyjE1aRn3Xh3PnJ8ElA+t
	 J2PIFaND+YBzVRh+7GMaTDcf44uhkelBrv1JS1RBbTG0EYGgiSWzO2fx4k9xh7Nd24dCJ
	 xBnkWxsVMwMZ6UFoZeynVSpT8LIFMMeCDwYlkS9uMGrFeaIaZyoC/DRFz9N1yvu532Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792897764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zxAI2/bzDmWUdnexxhVM6ch/dJvnGADbn1oa+AeS06k=;
	b=w9IqO3k6RjCe5u7H0w4jrxpDw3P/30/DhfF8zwEYMGk6nqDg68NiEYmsCxgnVlvgu5dn
	 uR4Pf+f1JSeeb87v2nRcDAVBpCY71gggBYgsxdqQ8pDrLLQ3/n9tx1cEn+PIteojYZh2w
	 KwkLCNTA+BNZ+HsjjsN0L/7YHJsxNcwdMVNFJx0FCZSj1izVuf0GweNOZ5IcXDeIrVUYn
	 7kOhkLESWmZyLMPfcXlsBpK1inEBfMo2L1/Rbxmba9P32qqoMyxIpIwZ0qX112YMpKeE+
	 iczqOHddSDzUb30TeAz0KDzsZHUh/9M0h9NFVU2WDozJ6qGRG0Y/iAZpsjyCdIcvgpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=y984Mhl5;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB538606A31A
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 03:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB538606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=y984Mhl5
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35b2c599f43so1238330eec.0
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 20:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792897763; x=1793502563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxAI2/bzDmWUdnexxhVM6ch/dJvnGADbn1oa+AeS06k=;
        b=y984Mhl5Cnsjkt1cz2u+gmA9f4kBd/oHpiQkChveqoyxlZHxmghE/XkHNhDJFvTaDR
         BQpSFokV2ba3M5j3JX8EhZngw100VChEEL5phVln7PTt0Lw87yWC4QsqKtPnK/4b0HsB
         QnLJCxfv6uMz8vZflrJS+DgQxjXKPeVu8B3anUA5Frk3e4bELtmUQnmPLDEU/cYKYRB1
         VZ8jA4RDpW8qIzZsJ6xp6mB7yfUdQfzb+l0dvkZuFhy5Rvy0Zr4r5kWF0MMbHqXXYzDs
         yciPeVta4rtZm3A2c96za9diPORm5wey5BjsLXoWcr/BNEyuX14tT1RpAlaW4Ui31Bhc
         8ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792897763; x=1793502563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxAI2/bzDmWUdnexxhVM6ch/dJvnGADbn1oa+AeS06k=;
        b=rvKVbbHI6eFgN5fYwLSCZuzEo7JZiXQGkh1/XkbmYbsWVXW4X7OjSLj1dl+nncvSgF
         AtJIa4Eb9pBins2K8SJlFeFz7iyV+bYO/QogPwC8Y6XxB2FKk3SUplDMVk48/qMG3hw8
         x9u0neIBdU2+z0tWceQkRnU61VwVkKYTYwYcKoUHv18myPkydoVNGdsA2zUuqOJOzBg8
         EtqMLCvS2Z5023ks0swrPfTPyB0WgTO6CkhWGDgzUjiT8rZULCbaO2SZMa4HRiTZhpv/
         E7XfcSsVX2Xab0Wk8hK2DriUz44Aldd9AltX4jKVExzR5Ekf1v4w7AkDfUen3qhRblHs
         AsEg==
X-Gm-Message-State: AFq9FYJUkdDYPrLIBAU32IhXJh5tIShVHM/5ceqmIxATzNPPWpDm17lN
	hiN3JTQMMx7i4Aj2gqVcT4JNq3fZaxlcR2iAYSKl1wJBWNp/EW1Fo3QmSrp4ZFg3mpc=
X-Gm-Gg: AYBFou0a/7o8ia0OHDFfw2u90P732tz87Ioc3rWM6/UzjtkBL+bNGzDyDLnxDCL4uS6
	aFWABI5V/mpiIiNzQFVRV3anOMjlWm+adiqnh50FNrM7oxYyniWSjwEoCeIg21J+/+QNToa/grW
	M1WlO3+REUwWxObVjJKvPZP/COo95IhzuT9oBFjfExyYUlYL6nydBtv1WO/GP9Lczuw2Sd3g+JI
	FMF/binro1Qn3KKGLmj1v4hwAL5y+op5cOeFzVjJP4D9Q1q2SC09dgDri+UG8AsjC0mTqb3tn5T
	sYl4RMVPMOzPfsmGSMHJ3xHhPYYUT/SU/kuRWV8BVYwGyHo/lVpmlFhmGIfYNy55RqPDNrXmuuK
	l0g1fWUL6NkZekql82yr4fX7AbKa9l87J3kt6MMl29vNgxIRr/nB2zXAnXSL5o/LWoXDalvdq08
	aRkBxIoChJnMwr0+h7x0Lx3Oqw0mpAjNf6YJS26hLz4LMlrSAOBxg9cwNM4E52yJxDVfK3YBdnW
	jKsRnbunXOmjTPcLjMe+If4jDIw597q5OpSScGYgmBFAqY4El7lUoAAJbifNunvC0+MWlq895A3
	gqORCI7ywudmTKwEjT63yy8QBCkfonzyFqAbslWx3LSJBpO0L6DVqNmBYlTL
X-Received: by 2002:a05:7301:c083:b0:369:eee6:ee2c with SMTP id 5a478bee46e88-369eee6f2bamr3597909eec.5.1792897762640;
        Sat, 24 Oct 2026 20:09:22 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d9307bsm14570292eec.14.2026.10.24.20.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 20:09:22 -0700 (PDT)
Message-ID: <9e552c09-f0df-4123-9fee-60541177a986@kernel.dk>
Date: Sat, 24 Oct 2026 21:09:21 -0600
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
Subject: Re: [GIT PULL] Block updates for 7.4-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <3b7e92f1-77a7-4bf7-a942-83de345bfd1a@kernel.dk>
 <efe0abd7-edf4-4d2e-a8e8-be4203d7ac3b@kernel.dk>
 <CAHk-=whdThHmhxSuh2dWw8-+v5caYBdb3AwLyx4YY67_P0qufQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whdThHmhxSuh2dWw8-+v5caYBdb3AwLyx4YY67_P0qufQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/26 6:18 PM, Linus Torvalds wrote:
> On Wed, 21 Oct 2026 at 05:11, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/21/26 8:43 AM, Jens Axboe wrote:
>>> Hi Linus,
>>>
>>> Here are the block updates and fixes queued up for the 7.4 merge
>>> window. This pull request contains:
>>
>> Completely forgot to mention that this merge will throw conflicts. Both
>> block/bio.c and block/blk-zoned.c will need resolving. Details:
> 
> Bah. My resolution ended up being different. But I think mine isn't
> actively wrong, and keeps some of the warnings.
> 
> Holler if you hate it. Or if I just plain screwed up.

Looks fine to me - bio one is the same, and the blk-zoned.c looks OK to
me - you kept the pr_warn() and a check that blk_zstate_set() covers,
but that's fine. Thanks!

-- 
Jens Axboe
