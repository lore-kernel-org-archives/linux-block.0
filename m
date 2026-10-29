Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290340;
	b=X78A5LZfQHHpqPUbnSTDie/ba82HVXiCyFoUcxhg4arAacikzuy9fhKPj7+fXSH/cfD9
	 M6O/eC8T9CO95ZfAWtnYNSQ+tFOSiaiX7Aw9XPM+CoeaIIdGw3Teic6PvYYn6kHEjyTTo
	 tkEn7pa6tDoYX4QLQ8CTXHFepg7eOF5QEwP22Nu13smJApmAAIUZKl+czeWWohdu8bKVq
	 8swJx0HwjeKz4RlwCAf4vAs/5CZKXf5Vi3BdLFlmXIGtp4ylTDULb/yIrBI+6NvRlafEF
	 amRAu/oO4xnaqdcwIJLmLOBwBTUN/hqLYQa1FJ1YdAbm90mLcjQzlJlMrIz/0Zy1kqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=V5Zo+WNsDT76WnWy049PgXmoAyJHI5cRZyORSCEWMuc=;
	b=H/zVNPFbjjWlwop/RuFeYXDbgqv5GcKW6nQU++BYwtIlK4z2iz4/prZX7r+794rC9z13
	 yNO821n7kWOqTd+5G/zTMpylweEvOjmV40PisLaeE7tPiVVTuQnXC+r9zas6dYTn7Zosj
	 6XXyGC/EmWaSE/KRWI48YummOfB2xzVBnXc0Wu87LRKZ5cUmhXoN66aTSkzc+nErWwVxR
	 hUBczc+YmSdbzbKxbiQbOox6c8GAs4j+br3j9SFJ6sChcV7XThgxJu9jXlTfVuXOG6N6+
	 mmd8LN+VD1/doOGgszoZ+nCHyqPdSO3C+JyVSzl3RS9jZBF7124Q7CiEgs0jvuHM7Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qwm96aDC;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026A606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 16:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C026A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qwm96aDC
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6dd7070699eso1811841eaf.3
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793290338; x=1793895138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5Zo+WNsDT76WnWy049PgXmoAyJHI5cRZyORSCEWMuc=;
        b=qwm96aDC0QoYCUbCkbGdmfWul+DqBSaz9QmhehqWj1izZ8CC9KF1XPnwWKRTlPGqk1
         D5cbwRrqIZjqSAHPkLLgRDdAj/xg9+zAGrxNfeWiDfWKMi+Zqf7Pe9gFmuMHnI2ZVNoX
         pIxOfc7XB/dGFizjZBCwzteXweDnuxPz+TM5m41ROXk7wuxjeLvNHDIGAwwnDBcNBmE6
         +9i4NXBLue6eqVtH3Q348hs3hq2vV0lTz6GX4DwSian/RfSs/c+zjw4Ma85nvg5LTP1m
         CqmPYpdZ7EW1Js+RF32BHsMwlNChTTIvX5X/lRI7kl+VcRlaQxe30vG0z6ZM7We8/ABp
         E57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290338; x=1793895138;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5Zo+WNsDT76WnWy049PgXmoAyJHI5cRZyORSCEWMuc=;
        b=d9FdTT96nJMFVWJTmMi/enf3tQkc6qcz8TJREPTOwSv8VYUctxIN5xBfCOLw7XlA7/
         R3AZy0b2xuc6ru91c5I/4AjteXAFltR8NA0JR4Vh9zdsUGrYvoFsBnXls3dVHB9lQUNQ
         Y/EYPrZukEZsOWDaXvO8Fue6L2J3cWIjbmSKEkvZyN2g4L1/6Bo9Q7euaJ1H3NrObz6M
         gs6F57f/GU98c45tNi3u7q7GGzmvAYuXB9TM6J5MP/iPvpQN50t1iW2gS+TUvhkqMhv3
         LIp/hBF8whYmXEjrfnB5WPKoCP8EH16zSuD8YFcte3ru7d5bTry2FZb9Ysj7Gq6umD8r
         XySA==
X-Forwarded-Encrypted: i=1; AKwUvBzHGK6c9RCW2S6IwSFXjEaoAQM48l5cpQ3oOSybN7GKlMVoesiCvVc+VpCbIrL0688Lrpa5/Jx9Snh0Qg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLOs0Wkgo/KbkO82CgPucU45q0aRmkg9nmKMIwJ0ufU6l90LruY
	Z/hi4oQp0te/F0OTrn/I9V9plpmdSBDKzEOoQi0ce8m3D2YrL9Fm2AYct/qXjDqWKDc=
X-Gm-Gg: AYBFou1t6zSeGWM1NLkWCbiL+fdMCNU/hxc8adlXIuOhoFDhJzVmu7woEPzckNtGDa9
	kY4fjlJqITJmo7Q0den6dQzTG2rPN651QfxRYPxjHVFdg8+CYbPOoKy4KRYSyQaofRrmUGEjJzh
	NsMk2odNfVWXTX/s2WQXOAUpneWASs6E7xc3lj8xNK+l9ObvYND8KNh9JXn2mCHppoc9pI8ZSja
	6m7o5gJ22r9hxPx6bxaZi0iCbyuGhEtK5rYhKoRdQRdieWbrf0xTfxusFEnxbozBxjPly3jkyfC
	nep3aT8enq+n7sNctfwCHphDqA7SX3+JNS4vqIvHaaE5eBCGdFAyh6Jk9sIMs85iww6ctQXAMBb
	ii3c59xEsghiGCEgOJCAjFsGI0I8qLdnxyrSMYJrjahft+VXRM2lobwLKEWWEg+71ktJg9lBT7y
	/LBNaS9fIU9Uqjv66yDFhMc3Tbnx0s1r6OCUDrDYqa7o93y9h20NgJvg9CTUSHC8mj1ZL54s6aj
	nBWBNwwUXd3NsjiFpHprH6KXRxvxbmCHseM/LNmkznngQGfQ/gqNHMMcLI+XmDpsDp6DGAHQ1Ee
	2EwyntW9hDVMd+ESawukTY5dBHEEKi974uSYyyz5nT4905UTxyW26veysw1qZfCcQlfssKXbRc8
	JeUVKeHX5tA==
X-Received: by 2002:a05:6820:1c89:b0:6c0:2513:3e99 with SMTP id 006d021491bc7-713eed4890fmr3359044eaf.24.1793290337646;
        Thu, 29 Oct 2026 09:12:17 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d33e36a05sm281587a34.2.2026.10.29.09.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:12:12 -0700 (PDT)
Message-ID: <b51324f4-d694-423e-9899-196f6a0e4f4a@kernel.dk>
Date: Thu, 29 Oct 2026 10:12:11 -0600
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
Subject: Re: [PATCH 18/98] aoe: don't free a device with its work queued
To: Bart Van Assche <bvanassche@acm.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-19-axboe@kernel.dk>
 <20261028234917.3067347-1-bvanassche@acm.org>
 <d9d30ac0-102f-4578-96c9-c7c4b4f05b88@kernel.dk>
 <94c807e7-5854-46a3-8031-8e3fe4fedd52@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <94c807e7-5854-46a3-8031-8e3fe4fedd52@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 10:05 AM, Bart Van Assche wrote:
> On 10/29/26 6:03 AM, Jens Axboe wrote:
>> Great thanks Bart, but can you make it an _actual_ patch? I can't
>> apply this, the commit message is referential to the original patch.
>>
>> Just send me drop-in replacements, and I'll replace whatever gunk
>> is in my tree now.
> 
> Done - see also https://lore.kernel.org/linux-block/5eff518c-f620-4d4b-9e02-1ebf142e67ff@kernel.dk/.
> 
> As mentioned in the description of that patch, it has only been
> compile-tested.

I would strongly believe that was also the extent of testing that
happened on the previous patch it replaces, so not a big deal.
It's not like any of us use aoe...

-- 
Jens Axboe

