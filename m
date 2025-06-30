Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B27245033
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297313; cv=none; b=fcHrMEr0uGm7EoshiFzUF+mBKa8PNFwjD/LDcwKbS6uRNZXnlbjW3TPk/prJ3LlP5HQWPSvi5H8+933hoizLlqID8ZwipGNeMxfVxeuNU+I1tQ+wIDmz2WR4dlnWu3HMn2OoyEIpx8V6m2l1b5NHf6PF80skUM0o46U8uhT1UwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297313; c=relaxed/simple;
	bh=D7U0pnvVS2+iu7MH6rh8y9K5RjFJxIkQr+hESRb3c8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KMoZ8pq9XQHbPY3Ap1tQlkHoNiyUyoS1Tv+y7o6do270Zit3iSrDnRomU/T8DKpKVqZj8Whc9/zsJkBMcGcL/CVL0m5alPP7m5pH7JvinwM0Yzol6tEkKSTbUn9eRrF1i1l7dGJC5Z9udlLDiruBlY4CWmHEsbi5XmQNdJBGOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SRKsIjp6; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SRKsIjp6"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-874a68f6516so404052939f.2
        for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751297310; x=1751902110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9VuEu1YaPE4JQdW7TK82bSLbxpMab3+HcLUGcU2VsrY=;
        b=SRKsIjp6DTjOPmztfsvxEl0AiEMKtyVXwlOMmH/M4m4N5YEz1vnBHH4VqpWi4+OiH2
         JOr5yH/6b66U+0yPXLzMxGPOmGzeT6xbu8gR6aPbXg8b4h5BZy2yLW9HcLsct7borjxg
         zyyMQ97ZqSyBpwuvwX0i4SdaxzJDs36DEDA2Pd+ZUs7crTeFk9TWheDefAoxIp3J35yW
         JGcDVJcTlPBapw4t5fsU8bMEPrzFegH9U3twSHwRUG118C0glLHeqYxg5ue1MZxoDRBI
         3nhu7BnynQQ5ey8CxIMSh2So/QYEivWYxsjftxcl8aDDXVraheJ1+ppEZwp2NqRM6xsP
         b6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297310; x=1751902110;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VuEu1YaPE4JQdW7TK82bSLbxpMab3+HcLUGcU2VsrY=;
        b=bXOrcoqznpOOdv2iqrE4yKQ1YMcjQT9tAUpje+RGedD1IRjaQBqKH3lUoN1UU3gT+A
         2CrpWnScSzph9995QFo6tmdLE2fPpWuFXj3WhcHWI0wi/kVdkv7DZhwAzIIM5i8UxtvC
         blV5yIeddyFXS/xGjKOx9EdlQ0XGLXXpbetvO3xGoT5rtkv6COFmpd6+FcNuCpDC2HLM
         5JNsykTA3Brh4zHPucncc0SVZs/gBfmpCZPrdPiYqjfLKp7/q6V5NkTQHGZ93bBi9ikX
         u6K2sYvZJ4TpfbWN/kjsGCsunpNymWtcq6vhlDD/+ITjqL3iLvZ84BTcaHT0hFZ7q24B
         izPA==
X-Forwarded-Encrypted: i=1; AJvYcCU6bKrPWPJYu80yzhz8l5+KB5NBtUoTZFtRHV9i1CmOSF2ZWkkHDYLXHyJfcx2cdJtuKyMFfDxuddCr8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxpd9OgoTf0Vm0dMo9nP7r3eUqtQtfBe0/fi0JRqsoybqvPw3O
	mEUuwhY2EOBuMYDO/GFCPXZCph2SXNEjJ3Spsqn/Ynz/sr/bifSNdUOPAJBrOyenuBA=
X-Gm-Gg: ASbGncsz/sI/o79qWRI3HEKdtTHmRdqbpe8FwHErDyJSAsoDPQmBjyr3XxF8IkhXvEb
	Qo6N32vVpdrSdUm7s2n++637kGW+6WdXkvgau1QGuD5tyjEISE28Y8uz2J49/+My6QTad4S3S8W
	b8Ujj7yCCENXgCa2incZ8HRY2AvYCXEGYCP7eqU8MbTdrUtkY56DNcldeBkx26sRXzq/9HaJnlj
	kQUFDXlBQKHs5AH2o86dzuNsSMjQkKoepC6KF8O2/jUHGGGoPvy+vMocL1grYal6BYLNaHtTKHN
	NGUYMUKLrcLZZaKWDnA6OmnacIhk41ZXavcWjn87+SUGZ9rredZ4dF9OyU4=
X-Google-Smtp-Source: AGHT+IEdD4UsdePsKXvWlz70RuEmw35/ChkJ1zJScXKk3wog8psWRo+HSC0roNqa5XbmTtjua+ZWsw==
X-Received: by 2002:a05:6e02:a:b0:3dd:f3e1:2899 with SMTP id e9e14a558f8ab-3df4ab4f22dmr148535265ab.2.1751297310466;
        Mon, 30 Jun 2025 08:28:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df4a091b58sm24046835ab.33.2025.06.30.08.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 08:28:29 -0700 (PDT)
Message-ID: <a2dc2566-44e1-4460-bbff-bb813f4655d9@kernel.dk>
Date: Mon, 30 Jun 2025 09:28:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brd: fix sleeping function called from invalid context
 in brd_insert_page()
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, yukuai3@huawei.com
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250630112828.421219-1-yukuai1@huaweicloud.com>
 <eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk>
Content-Language: en-US
In-Reply-To: <eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 9:24 AM, Jens Axboe wrote:
> On 6/30/25 5:28 AM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> __xa_cmpxchg() is called with rcu_read_lock(), and it will allocate
>> memory if necessary.
>>
>> Fix the problem by moving rcu_read_lock() after __xa_cmpxchg(), meanwhile,
>> it still should be held before xa_unlock(), prevent returned page to be
>> freed by concurrent discard.
> 
> The rcu locking in there is a bit of a mess, imho. What _exactly_ is the
> rcu read side locking protecting? Is it only needed around the lookup
> and insert? We even hold it over the kmap and copy, which seems very
> heavy handed.

Gah it's holding the page alive too. Can't we just grab a ref to the
page when inserting it, and drop that at free time? It would be a lot
better to have only the lookup be RCU protected, having the full
copies under it seems kind of crazy.

IOW, I think there's room for some good cleanups here.

-- 
Jens Axboe

