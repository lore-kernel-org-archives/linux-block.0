Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD4152160
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818469; cv=none; b=YLBgW90YV95QkG43cvDB2RPX86mn9oFRSuXmfq/3BIeRU8Ty6Fq2M9wQWiP6zYxH/UUcDk7ak81W/kh2QO8odqPsHcuh4gRL3zrj1jHdaX4uz1tnBCjfE0t9vS+HTKegv4l25or5dZyjBQJN+Nd+1iv1OheFmBi9ldvj5C3oxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818469; c=relaxed/simple;
	bh=gH3oGfMqS4kzu7B67Mvqr/4UBQoAPWhsBQ6/w+YZYcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+i7ocQRRSP/3ueirRjeYskBo6N9ncMX1vlvNWjpYSuJ9fyqQyJmBEMxreeO8/yXm8mcCPCGEi4BJDlCH++S/Hwf7neDhmHXQ8tt0m6utITEJRwXRe7KozF2TPm7JwhjGY8DYhx0RpgwzoiAGOoGcSVVDvl0QhDwAti6iQ4bwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h3tsHZXm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h3tsHZXm"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-64ecc2f111dso2908a12.2
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718818465; x=1719423265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZ4zwIDnnKIalzS0ZDDoJ0VyYnGS2z3S1zxJBVJg9NA=;
        b=h3tsHZXmh7uB/oDJUcz1vk0MNrMm8WL3vRQzF4m678YyCE1vyqTCHjW3xkcCyGBnOn
         5BMq3rjrkr7zIYfScvAdsamcghu3adci5IoB1Ai7tjsZkkJ7syOwW6heB3AKcVLM7H3T
         ELSS1d7PB1Z3LlY9qIsDtZKL7adLo4Wpc2tkttskJwUcD+jgsAc39ULo+AKhGkS5mmWs
         NGuoTFOtkJpoRe/8HoHS6b9Zx6L/TOvbnk3a/a1ANkfN9UmN7wiG+bF74ICDPx4G8tVg
         fJfBtTer0LrrFcycEO5d8cBpIWCSeNtUZdIvLonBzAIZK92Fv8ovjjeGPul+joX1qTNw
         BJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718818465; x=1719423265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ4zwIDnnKIalzS0ZDDoJ0VyYnGS2z3S1zxJBVJg9NA=;
        b=t2vkEDGVlmZfDKrencC9vG/BSxksBkRMRRDgqnfvpUhT6AGzIWt83659fIIPNwP+Kn
         4nhxGPleKNqsaMIlm07vczfYZXNG7QnPuQ1ODgucZGiYA2OZpAIeQL11xaoKg1tpQ1RT
         zoUURSxxtCOVkPkhDEuG0+PpnATah0x7wGxWsGepvxuMvwSINWdIONs2xO6eb40IKSsb
         OXxA4FBqQrvnLHFc1ghbvbAKPjNGznem0uO9ftK3sW/kloCs9qo2oNgka6dzYslY6xUD
         bww5bs7nhST6wUMAkChg923KNpJyt7qkG7lYoxGiaVJyl9dMhzc01jjHoSSTfu8YEgBd
         031Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxhvaOO7HAwagMnaOGgD6K7ie1/6Q+7f+UIAWVdLmkMpJ6Ip40QGXzQqaAzdUOM06FkmWWfQ7RyCC68iCn9FLEDWTc4gXaqYWbuys=
X-Gm-Message-State: AOJu0YxCY9irdChixTzQC5FC4lYlulNjjluIN2Yhqm0sUlC/vmaFhq6p
	gVMM+H2JTg3Rc0Oopq3HylVKEySqtxQKotmkIcCSBPA6AURkMuuI1eUGB2kqDMM=
X-Google-Smtp-Source: AGHT+IE5pBl2myAzW23kPeuMrQgGPYpwRUhThsgUATrzEh52SnuolheqaKQqp15bUsCeHOnsZg2dZA==
X-Received: by 2002:a17:902:ea07:b0:1f7:2046:a8ae with SMTP id d9443c01a7336-1f9aa263810mr33560165ad.0.1718818465295;
        Wed, 19 Jun 2024 10:34:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9b17f9bcasm17222755ad.161.2024.06.19.10.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 10:34:24 -0700 (PDT)
Message-ID: <51f64ee9-35fb-482e-aa50-e2a446dcd972@kernel.dk>
Date: Wed, 19 Jun 2024 11:34:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Replace bit spinlocks with spinlock_t for
 PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240619150814.BRAvaziM@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240619150814.BRAvaziM@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 9:08 AM, Sebastian Andrzej Siewior wrote:
> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
> lock on PREEMPT_RT and it can not be acquired in this context. In this locked
> section, zs_free() acquires a zs_pool::lock, and there is access to
> zram::wb_limit_lock.
> 
> Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
> the lock has been acquired/ dropped.

The conditional code depending on CONFIG_PREEMPT_RT is nasty. Why not
just get rid of that and use the CONFIG_PREEMPT_RT variants for
everything? They are either good enough to work well in general, or it
should be redone such that it is.

-- 
Jens Axboe

