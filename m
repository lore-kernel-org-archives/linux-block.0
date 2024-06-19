Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC31156F21
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820092; cv=none; b=NzbbsTpHzj9vOrf05t4976xJQ4yMz94DIX8A1T0KKHvlo1rsrw0vasRgneKFQUqRPo8RV2dAjyytY+dvZJVMNioIjJwBwp+juK4WIP9AKA8QeUwf481UdRulQphGtGRguQpr+d5XuMcGkq55bD4zEBOeRdS7epxmq/J18d34mOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820092; c=relaxed/simple;
	bh=U7C+pEi6igoYFQSptMMj84YTWs+bTPzv+WEqwzj88d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIkR+SpIQppatq6s59Xq77l2Mv7eGSKAAmTRhHmpaoSUG421aKGPe68D/XF5weEJ5yPQQ1jsmU3yY4PSUoLeZCYfQb6+KwyFziBEoCkSt297mfKWVaU5uhQC8x8+6FPTNRaGZL5c+VlW1pxWvzBZ3zt5pgkhAEhwyA6lZaoxm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q87rSGWu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q87rSGWu"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7059cf3e575so1628b3a.1
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718820090; x=1719424890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DR6ol/ebrMQTMKANWVsnvB318yzdm+hPLWyKxrfZLM4=;
        b=q87rSGWuEbzUX0bWUlq80v6eOae1T0/bHSHM35gt0OusR1q2fKH96SQAUvdXznsyKv
         zk8hFBuSqc7bghCVSd5vXzT+jlwfnPM5Q+msgRaWsDIaqAvjFC0dig5VpKtFYgxlIfZa
         fxh2zgUqqTmo1Y4mRqhz2oyf8TiIoZFgA1jbAm+Ww/VhcGBfrx8NfENb8gKo1VaL7rN9
         BfvYBQNl9FqLrKrJCetlwD3SQifBZnpzUT2zZF69IAgvG/2MKaDiyUDAcaCzVhkjdVja
         n6rQkcjaY/nqTcULqG0lyv7LLLcX9nAT1GtStjGOcQg/BcgI7S5ESZoGkOjfdvw6+1Nm
         SP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718820090; x=1719424890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DR6ol/ebrMQTMKANWVsnvB318yzdm+hPLWyKxrfZLM4=;
        b=dq4HVsIDhHOEmLXFSIZ5GUFA04kBTxqsKCnyPRKwd1g5lvLIPrwaJnNBf1tDdd/nsK
         43ULDs64VUxpe6S2twfP60MnuCBp3CF7xYX4iavmohQlekn1KRO+49noANf0kWF44Uq2
         Zl7e2IIr5B45zDDMjhZbsqUyIdkClyAPg72GiQC5LcQRoVcqBZ/ke/71+wb00M7D1n5d
         Vyrg1IYwAdNqKHeSuhzb9plJg1SF4Gb8vMM4YOU/WdNBJhNFRmjE3ggynicpXbVbbuON
         mfRejXIyTfHsiuCNwmmryOLc9DmxV6CfCSwHqi1wMPzifFnBJQeuaHFQmcRZHA84znr2
         h17Q==
X-Gm-Message-State: AOJu0Yw2/hAl5s1Ggt2mLP4SyIS/6ayr15qc7JF0L+IIv2CReEPhlAw3
	M/4k0d3Ypbr+D/NLEUsE9qzY6nL8eIKFJdh2fHM6A/Kww7UMyYrfALHgSZz7k/0=
X-Google-Smtp-Source: AGHT+IHcDic2Ne3X7+KX0Ua1mWJJW8TdCvFwCTN53gWfKbBnaUDJDqn5D3CPdvrf3jUHKbtBAwA4Zw==
X-Received: by 2002:a05:6a00:1782:b0:704:23c3:5f8a with SMTP id d2e1a72fcca58-70629c13833mr3474862b3a.1.1718820089130;
        Wed, 19 Jun 2024 11:01:29 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70dbae52920sm3251833a12.42.2024.06.19.11.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 11:01:28 -0700 (PDT)
Message-ID: <3d984bc3-71d0-4ee6-843f-8cc47a90de2b@kernel.dk>
Date: Wed, 19 Jun 2024 12:01:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Replace bit spinlocks with spinlock_t for
 PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Galbraith <umgwanakikbuti@gmail.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240619150814.BRAvaziM@linutronix.de>
 <51f64ee9-35fb-482e-aa50-e2a446dcd972@kernel.dk>
 <20240619175249.lK51lGOx@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240619175249.lK51lGOx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 11:52 AM, Sebastian Andrzej Siewior wrote:
> On 2024-06-19 11:34:23 [-0600], Jens Axboe wrote:
>> On 6/19/24 9:08 AM, Sebastian Andrzej Siewior wrote:
>>> From: Mike Galbraith <umgwanakikbuti@gmail.com>
>>>
>>> The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
>>> lock on PREEMPT_RT and it can not be acquired in this context. In this locked
>>> section, zs_free() acquires a zs_pool::lock, and there is access to
>>> zram::wb_limit_lock.
>>>
>>> Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
>>> the lock has been acquired/ dropped.
>>
>> The conditional code depending on CONFIG_PREEMPT_RT is nasty. Why not
>> just get rid of that and use the CONFIG_PREEMPT_RT variants for
>> everything? They are either good enough to work well in general, or it
>> should be redone such that it is.
> 
> That would increase the struct size with lockdep for !RT. But it is
> probably not a concern. Also other bits (besides ZRAM_LOCK) can not be
> added but that wasn't needed in the last few years.

Yeah I really don't think anyone cares about the struct size when
PROVE_LOCKING is on...

-- 
Jens Axboe

