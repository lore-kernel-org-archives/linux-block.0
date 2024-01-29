Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066F152DE4
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539496; cv=none; b=jC6FV5JNkpeIh4xfUH0cZ3ZbfS4fcfAXYzKkX7N5yR5evDtV5tA3EOgb8p39CHrbqJ7l02ysmgghPE6ittMk95F1uPmRVpYxMnxpQoZTmCNuEAD3rBSlcyHPqm/7OgTfLNkxXmPoJnGWLrdVO8AJ0k2SCInjAFnY1tJCBZrKolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539496; c=relaxed/simple;
	bh=aZIwgzxxB/OisIld34sDLQONfxahwDkAaosDhi0sX1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRmR5g/YqycAJI/G62k5vTlZzHzTQdtZFkhzRXDqOtYz9fwQm4dDeB3qhH/TOKWxGbXKMBmaVOEHjSX/4dDwy0F+jTkBkDkswvslBXvHj3I9jZ3gGKUm7e032ASNJ1pt80VihdO+hj0dqcAee6E2vuRwCJ+0iTgSFUYbLkkCODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8AzD9SO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8AzD9SO"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so941377f8f.0
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706539493; x=1707144293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzvU+NpCwH+CcHA4xiRguCtI1G7Z2s7f1I8j5XhKlN0=;
        b=T8AzD9SOKyj8/cPE46WyvuX15BTuvF3luT8XR1SEsdx51EeFJQnW57EzDojPpRG5fV
         XYZes6f8VlmODyic3Wws5lMuEhr+I9bgNRPJ56ag2IS782binhbRL1TJFwAEaNnk0IQa
         LcBW00PAzbs4Bcdbnk3GTVdWl1aX1Z/pwddIi9Bk8i0Ds+pWgyCQCbExwpvGW8UzL/Fp
         xyRwJZB/1qBKtj++qvvRMR/r1gxyHY7V+R9CKnRj+isn4xMIHrUYyGMVQ+hB+E74k4Gp
         LJJP1RJHsRbYGg4v5e8kOUDZw0+s8kUOl99rD6gAfFr4jVm5jFEQqmo6c+e8A6dQowvL
         K37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706539493; x=1707144293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzvU+NpCwH+CcHA4xiRguCtI1G7Z2s7f1I8j5XhKlN0=;
        b=m7RMGiE+z74SOgggXS0MdhKoeraSnW+AOwTjr6dWnM218CnFIWRqozP9kzsJC0xOJZ
         2pzQ/AaC9HvS6o6hBYrdU7XzVJIOdpTNcJnuns2qCTn9wr+dvzjqxqUMliND29rN/4C3
         msA8HCav//f106/Z4XjVQ2uBcWE59+D8NBuXLurIZjBJ0m2MTFePZ8+yIGLT6dSYO7+t
         tX4xW8yhYJADNYPVvEsbVHCU453Bgqq+JFjfvTQfSGjFVpsAtbqZTA6qehidDWpBS9hb
         KZXHzSAqAinA93Tg5w8d4gubsuGjYTAL2QM81Mtvs++SXsoAmroTMHVqgb3vVRXkyWGa
         xKmA==
X-Gm-Message-State: AOJu0Yywn0ty2ZmlWigjmdWMKWcVoQ1Rq9+tnKs8QOfbEhpXGYy02wfN
	YX9DG3z8R3FvCoYMBP/SYZzwN3G7b0JqakfFm43I0oLPGYkR0eaHhm6AbEEE
X-Google-Smtp-Source: AGHT+IGuDLbHiF1ZPnQSr12J+KiUIHeeOr1dMyqm6Zr20VrEAtSTxfpu1oen0oc9RtsLE9cS7Twn5g==
X-Received: by 2002:a05:6000:400c:b0:33a:e2d8:aceb with SMTP id cp12-20020a056000400c00b0033ae2d8acebmr4377134wrb.9.1706539493100;
        Mon, 29 Jan 2024 06:44:53 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.211])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm1386064wrb.109.2024.01.29.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 06:44:52 -0800 (PST)
Message-ID: <ef594ed3-e9b2-46de-a729-b0de03b92c28@gmail.com>
Date: Mon, 29 Jan 2024 14:36:57 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: optimise in irq bio put caching
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <dc78cadc0a057509dfb0f7fb2ce31affaefeb0c7.1705627291.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <dc78cadc0a057509dfb0f7fb2ce31affaefeb0c7.1705627291.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 01:23, Pavel Begunkov wrote:
> The put side of the percpu bio caching is mainly targeting completions
> in the hard irq context, but the context is not guaranteed so we guard
> against those cases by switching interrupts off.
> 
> Disabling interrupts while they're already disabled is supposed to be
> fast, but profiling shows it's far from perfect. Instead, we can infer
> the interrupt state from in_hardirq(), which is just a fast var read,
> and fall back to the normal bio_free() otherwise. With that, the caching
> doesn't cover in softirq/task completions anymore, but that should be
> just fine, we have never measured if caching brings anything in those
> scenarios.
> 
> Profiling indicates that the bio_put() cost is reduced by ~3.5 times
> (1.76% -> 0.49%), and and throughput of CPU bound benchmarks improve
> by around 1% (t/io_uring with high QD and several drives).

Let me know if there are any concerns with the patch

-- 
Pavel Begunkov
