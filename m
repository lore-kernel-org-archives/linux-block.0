Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BB1D223B
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633089; cv=none; b=Se+DdKWi/zL/3X2ZRs+1EylGv1/T+KZKJInZP8kDLJNlGj1NRnQ2pf/zCwJfbzwqVpHsgelC5E8vVW1KT8v0mhCYmbBlUnfM9EA7um4nv7/34biBcd28SH8CeW8wxnW8H1tzofqDVowTaQYM87hWp56h13qrRBoCzweOX1v1qng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633089; c=relaxed/simple;
	bh=YE/0rnSl4ZrAzn5Z2ufG5g8z+UdgXqEia3Kn68UiSx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgYy+KRqJvxmlfpsZVcvRu/WE2+cfrP0sVs5wMeyLU3nMDo0xw1DxBbJq7amxUc6ryehtt1VzOJiyo9h4nqXx6LWyeLZ8SrYj7mIsjSYAZAu/m8AAHlvCRSw/8C3n8Dqwk37i6KYuwpN9WJ4w8X8+wETWYZwdMMV2pymsF1gxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=drww67Qj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="drww67Qj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2053a0bd0a6so22408775ad.3
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2024 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725633086; x=1726237886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7U0n4Pc54X9wROP7p7GrRRTyFQ6kR6FXGp+66jt8aEE=;
        b=drww67QjEi1g68UC6WyFWDKZZShaUBr2rpdDl5aQ51GAjYb+2kVSgOvJpuwAbzZ8t4
         XM+W5EjkDeTkblTjVoOvR2OS2Eoj2m5rSh8BCZWQTeC3Pal5mj9GXbLW5uVsdsuMdv8p
         1banzbnpzPKVKlD3EyABiP6lX3EcBoBIiqTK5+qQypsWT9s8xwlLagT1YD7+K2NJT9ML
         54OL9s/HZT4Bh9hlpMj6dqmwkP7ee6OjqhkYexQceQBRNFznMUBF2gwj0467kK5ygYVW
         zoXgcOKSw1Coe4jugXol4/yTQj0V2vl0q/9nX8ioUF9SpyBzTbmnVwZ5fU7sddTRmMS9
         bIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633086; x=1726237886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7U0n4Pc54X9wROP7p7GrRRTyFQ6kR6FXGp+66jt8aEE=;
        b=B79e+oAeXPWGvtX97MMQ6HpruBrgnJCRlsK8/3Wk/MB30o0WEOuXbA0kzBBZ3Qrg+f
         5F+Vkr0QL6c8j8pWZ+LuYzSuQgIIFgTFwFVfm/Ly7Za1HA1n//y9BbBcrc4q9fqUYklV
         PeVGKNZX3lw6dBvPhO9t4/fAApxYPo/WbeGqof6BUF1qmJdeVmO18G8dmEzVw3DwWFKB
         BRxDfzA9RXPrkTwS8V3mANUFcAl9JFmAOvA6dlCoOLq8zuR6pN1TCSNDQhYYg5O8y/cC
         UcjxiJkLWpapYy9ltMMrHcVB9qOpPLKNRuFai4Jov8V3RTwehboeguh7gH3vuckoEny8
         hLiw==
X-Forwarded-Encrypted: i=1; AJvYcCUcpP7yxDKIuu0bfgj+uTTWlsbbUKPKd/xDN/6YDgqgEU8tECnaIkQF2ywWJvIFw6HiPk3aN8zggDlD0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0c7tSnFg04SykuW6Iatv93Y78aR4jyLjE/k5zd502hdAERJ/
	yMUIOwHBHEh4juJSw3xi8dnAMBQELim/y6YdEvbuVBFLs/2V74ICHDTxJ4wt3UY=
X-Google-Smtp-Source: AGHT+IEPfdmdEsv8HUYFO8clIbkuI6Sz6ThdFkSoyqPyPHneUf+Q1tqC+WbfE6fv2a9x6soILPKu8Q==
X-Received: by 2002:a17:902:f682:b0:205:4721:1a7 with SMTP id d9443c01a7336-206f05428d6mr26833875ad.31.1725633086449;
        Fri, 06 Sep 2024 07:31:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206b7ce6c47sm40861855ad.32.2024.09.06.07.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:31:25 -0700 (PDT)
Message-ID: <feb77bdc-512a-4f59-8a9e-1dc7751a2fa7@kernel.dk>
Date: Fri, 6 Sep 2024 08:31:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] zram: Replace bit spinlocks with a spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240906141520.730009-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 8:14 AM, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> this is follow up to the previous posting, making the lock
> unconditionally. The original problem with bit spinlock is that it
> disabled preemption and the following operations (within the atomic
> section) perform operations that may sleep on PREEMPT_RT. Mike expressed
> that he would like to keep using zram on PREEMPT_RT.

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


