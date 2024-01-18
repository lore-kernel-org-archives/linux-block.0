Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D72DF9F
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603908; cv=none; b=rJYhk06v3E3g8G+ssDd9arZE9LreRAx21AGx5cDIRWZDTTrGxWXzY/cTdi56AgEJoGxShUh7TXGEUz5JjBbooqA63qKZsHGjIwQ5GZzT6ziBniW9o1fTMrg7ZSq0xiQWbzQhxEYP8ebGMl+ogAA8jr0qnhn0k68OPKq1b0LJ1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603908; c=relaxed/simple;
	bh=FUrQmKQiw2zYM9x7s676ZrC+Ph1j7UqzNdI3mdfiaP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LcIDZVaM0k11/wOo14BgmrLQ9WEBl5h+e4+mOZjzdmvlti1J1a7eay7/H0bhoA8BVwzxQ1CQmg3YCckIOx4CSFJIyraCmFd6e0uaUH3MVEO22F+cFnHHnwkraLi4qTYHU8oUsxUfgjD5qBj7CNOxGQBn7jZR5YulcHYYiPoYdU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d542701796so74320775ad.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603906; x=1706208706;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhZpiJQ/KrYxllaTx6u1HIQgqHDVv21xKO0Wke3dM78=;
        b=Uri6ZxxUun/fX+MVWmmspmXPAQA60A9Kg6WArfr3SCAlYdcS54gP+JD1h6fRr2OIbN
         AV9oBJGad1TnZKxshZwGV7MEBLwxOS4vWnm0pqv7k5fRq8td2W33j908X+9FmMsSWXeh
         ZIjfPCqRbqYUcav2uAhsah0AApeIQ8KmQppILrf2zy9Z+yFxyQt5f75JBDvv6Vfh5LX7
         miTSTEmvibvYULvZD5V1/f2j23uWta91B/tclk/BqhY+TGNsgQifx54SwTo4HZlE2QuP
         ZzEnj8OBvFUFY5tk7ptPnaY/oyxtCiSPwxE9hCJNU2yDEhmT5UGoda5R5nn1JNrmPzmJ
         16Fg==
X-Gm-Message-State: AOJu0YzHdPJ/7OcNN9eHY47o/01+Bj0GXlD2COt+Xrsq6ddLY8PmD3x3
	EAVHokb7em7DoBOxtg9sC5dH1BJntQoon9AMv0h/nI7kEUlx7IqrJuFBysV4
X-Google-Smtp-Source: AGHT+IF/U5oxqudO3W+5hkL8mb48LhOPoL++AenKeyNlQieULrxBirTHjisYccrs5jtrogJItRyUrQ==
X-Received: by 2002:a17:902:c94f:b0:1d2:eb13:5cd5 with SMTP id i15-20020a170902c94f00b001d2eb135cd5mr1509752pla.42.1705603905668;
        Thu, 18 Jan 2024 10:51:45 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:718b:ab80:1dc2:cbee? ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id mf12-20020a170902fc8c00b001d39af62b1fsm1704172plb.232.2024.01.18.10.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:51:45 -0800 (PST)
Message-ID: <5f1e2bd2-b376-4272-93ce-a77c9b0c81ca@acm.org>
Date: Thu, 18 Jan 2024 10:51:44 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/mq-deadline: serialize request dispatching
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-2-axboe@kernel.dk>
 <d8485e78-5cf5-47c1-89d4-89f52ba7149f@acm.org>
 <3910157f-dbb7-4048-ac52-a2b354048be6@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3910157f-dbb7-4048-ac52-a2b354048be6@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 10:45, Jens Axboe wrote:
> Do you read the replies to the emails, from the other thread?

Yes.
  > And secondly, this avoids a RMW if it's already set.
 From the spinlock implementation (something I looked up before I wrote
my previous reply):

static __always_inline int queued_spin_trylock(struct qspinlock *lock)
{
	int val = atomic_read(&lock->val);

	if (unlikely(val))
		return 0;

	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val,
                                                  _Q_LOCKED_VAL));
}

I think this implementation does not perform a RMW if the spinlock is
already locked.

Thanks,

Bart.
