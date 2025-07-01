Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081894502F
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751338867; cv=none; b=BCBg6F8rj0viLPy2t0iiUKrd/uT0drP6ra6R6ATlokC+/GHcksAECFp/SIjwU6XrlenTWueTDEhxb7e1Q8iYIDqJkkjU0W5ZPpMqGYVSzDEOySlVkPaWTst3WTGxNsQLIl5h5752EQ/A2ctiNMvJUZdFw+FgK+/Na7mEwCUJvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751338867; c=relaxed/simple;
	bh=lrh6GydZHS2KelZDBisrC75MBOjmu9SiEIrty6g5yW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHTpv4ylS7VjTeklZ0u4lHgxgLy2CR2whlp7H7DBz3hSldLReSlR70hW7aljhO+AkTw1YmARzsxxTXn47qWNFu/t5wSo/+odn6brNGjQC2WJXmAZFddVITv8z3ttiNL+SDeFd0hc8n7BJe2A85zwLtmRsKsmaKoHQxIGUR0nPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lvmVJ6yv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lvmVJ6yv"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86d0c598433so77317039f.3
        for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 20:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751338860; x=1751943660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5BV5J90GBuq79fEtEaJ4Lc8GonetLryBRSTpf1en0o=;
        b=lvmVJ6yvslYyCL54XZ6BMRgr+SKjcMoUuWi0kib/s3jaVZqXVf1y2xBdf5yFUxROiq
         AYSLodibNTyWtJAsMCeENaoDFIaMtHhJzBOXDbwXwe14aJP+mZ2c5qBpLdNgnnlKbMLb
         7Ni6rlqtjAfzRTw7yh7w3RXZb3mDRQv/azZce46NSkYPRGIkTAbjsviQrPYILPkTyFPp
         mp39NWtIdACwjcXJ3XtPrW+VWK28KLOT1FZRGXULZwZZnTynIeKXTdheBqjSr0VnZxp4
         /5GxZCePDO6B5tCUcY1s1XPtq22RG9UClvv1yGmj6a6w16r1OdIfKqXaja8aL9mvd3a0
         nm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751338860; x=1751943660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5BV5J90GBuq79fEtEaJ4Lc8GonetLryBRSTpf1en0o=;
        b=xKVSD3HUB+2LRxhjSzWW55U6X2iQHBOtk2/Q1dQF8Vwg0kix/hIBx72WizLJ+TaHRc
         FtNEmDi/wwsWdEvnUAKueleMLUB7whcAmqSEBSIdZh1J2jJeb9y8Hveq+/m6o5Izyw4l
         lyhfUBCtAyBu6mInbINhQy9KD/1qt5FBlENhOh/eODTI5/7VBxr7nVa4tTXfyg3PUEu9
         H7JkkIsGLkbb9UxX6sQ4yIRD0C+vawA44qQXC3KgBTHXDewhKxyHraiAGExemjFo2cH8
         LG/j9nbb1vsKA1iS4YHGU6Mw59wvyc8tjqvyZ+i9T0/HCucUHejUS8KYA15IC/bel4HH
         8fZw==
X-Forwarded-Encrypted: i=1; AJvYcCVZXX6gfzBepxRO3TKmcfCVb0JhbmE3Cj0LJBch9/qGVma5O/F1qQ9s3mCQJMLUQORX0SyZoCDCK6etHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNh5NnNwHJdLRX69U0RRzaSz5fwgrrFDWCe7lr0VaDRtUNXSAo
	dtBIBVmsS0/p5CSkidWZxJYnStPs3OgGuxHrri0EnlGBKyou1GjF8zdCXqONEZeQSKQ=
X-Gm-Gg: ASbGncvMo+co/J9qhc+V8J9CmvEPLtTDoVmk7sKFmLQePavGdN1geCjBT1DLfJuc9Jh
	nPXQwEeHZVblomrMixLAfXa3UhZWN7hMljnIR5aoy8Rrjt0BY4RuB/Sj+oJkHzWJN2yyywxTuoA
	e060zXD2Q9guzq6JYaEh0xLGNnT3stsyNkUC2Xbr4ajqJhTGC7KTBGXFjlyJlWn7+K9EG3oPTng
	XVPu0rZSVhDMbW0cNCt5Il2VZrs+uVSuIN3JI8ib8QVBu2tCHEBJ5iNnCg9cLfklbcwBPLvu4va
	QDK0gS9qAHeA+iPp9L39i9q8nJPIBxujd/n0TUIV4LVz+xBHAI5FXl7CXlE=
X-Google-Smtp-Source: AGHT+IECMoVni9yu+MrxxjMKqo4MuNDTM8fwrQriJ/C0gHDwrb4/VZzzTlf4RbL98n8J27on+QBTzQ==
X-Received: by 2002:a05:6e02:1a46:b0:3df:3154:2e90 with SMTP id e9e14a558f8ab-3df4abb9898mr192181025ab.19.1751338859860;
        Mon, 30 Jun 2025 20:00:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50204ab5dcfsm2269225173.123.2025.06.30.20.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 20:00:59 -0700 (PDT)
Message-ID: <c28dd90a-3777-49fa-a662-32c61da22860@kernel.dk>
Date: Mon, 30 Jun 2025 21:00:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brd: fix sleeping function called from invalid context
 in brd_insert_page()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250630112828.421219-1-yukuai1@huaweicloud.com>
 <eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk>
 <a2dc2566-44e1-4460-bbff-bb813f4655d9@kernel.dk>
 <773a49cf-3908-85d2-5693-5cbd6530a933@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <773a49cf-3908-85d2-5693-5cbd6530a933@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 7:28 PM, Yu Kuai wrote:
> Hi,
> 
> ? 2025/06/30 23:28, Jens Axboe ??:
>> On 6/30/25 9:24 AM, Jens Axboe wrote:
>>> On 6/30/25 5:28 AM, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> __xa_cmpxchg() is called with rcu_read_lock(), and it will allocate
>>>> memory if necessary.
>>>>
>>>> Fix the problem by moving rcu_read_lock() after __xa_cmpxchg(), meanwhile,
>>>> it still should be held before xa_unlock(), prevent returned page to be
>>>> freed by concurrent discard.
>>>
>>> The rcu locking in there is a bit of a mess, imho. What _exactly_ is the
>>> rcu read side locking protecting? Is it only needed around the lookup
>>> and insert? We even hold it over the kmap and copy, which seems very
>>> heavy handed.
>>
>> Gah it's holding the page alive too. Can't we just grab a ref to the
>> page when inserting it, and drop that at free time? It would be a lot
>> better to have only the lookup be RCU protected, having the full
>> copies under it seems kind of crazy.
> 
> In this case, we must grab a ref to the page for each read/write as
> well, I choose RCU because I think it has less performance overhead than
> page ref, which is atomic. BTW, I thought copy at most one page is
> lightweight, if this is not true, I agree page ref is better.

Right, you'd need to grab a ref. I do think that is (by far) the better
solution. Yes if you microbenchmark I'm sure the current approach will
look fine, but it's a heavy section inside an rcu read lock and will
hold off the grace period.

So yeah, I do think it'd be a lot better to do proper page references on
lookup+free, and have just the lookup be behind rcu.

-- 
Jens Axboe
