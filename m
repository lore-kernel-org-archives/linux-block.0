Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757376;
	b=Ps0ApcxvytH8vrExXVPa75/lHzSKjzGc+JW3bX9CQi5q/Jz7juFcq1+/YzVbACU/J237
	 0Oxjgf41MgNCxbZ4HAcenQn/uDhHw6dbf0eyjjPwW2Jc8Wc79RB6cr9CJ+mTlLJkNrnhi
	 j2mEolZ+OjtmSEMaNVvLINvFkVy+VmSUG7LKRZ1kBpMtqePytW1iQuIqjMoZt08nRC4oX
	 Ymye+NvLs+Sy68zaKW4V6mQbX8dtNljLJ9vuk3nWAJ49fwsQgTnpQBFs+2ki6vCxBjKQ8
	 DnOP6Zs6ZKVW9O9tyVeC5XXjVWG3EJfGKCEtr136dUSlTRm4s9hHDF1eAmAZ/MTtqUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=aqeGITPxpcHpkId0HH9peiiOdA9mpAaQxrSJsRn67Ek=;
	b=YdweYWhigbvTXcqv1A1M9LQVZpoThYId1IdOT+fFxtObWCe/ojt8Tb6sJCfouAVfOcDh
	 4YugMzSkccGJx9Rq8dHasK6ZyvM3dKVMwg+gCmVqMNyLYIdY377vsNcnM5pdPmviW+TRs
	 VQON3OwGt08Upalmi2FB3BZoeeWvBUDGlYZOjNSVe1h4vnt8S2ENx5af8xj9Iu9RBRu68
	 j06NLAfwf/Pogpfz63Bwnv5ZhDzMZHa3KFw7uew6LT6PzJpQeHI4+yYqV7EyojNPuqYWG
	 f7EB7O/PbRUpEfjx3InfOUmaqwYLdpVF12SJTlVMZWLV91YMiIc1tnJSxOjr723R8EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RVZ4xz7V;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10592606A31E
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 15:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10592606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RVZ4xz7V
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3791619605cso5243790eec.0
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794757374; x=1795362174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aqeGITPxpcHpkId0HH9peiiOdA9mpAaQxrSJsRn67Ek=;
        b=RVZ4xz7VwgdjyDQ7h+ObpA+VorY79ve6v1/hnkcVvxC/D/6sEwHi/zQWbH24Egg+gL
         GaK151jv9jIB9fhsITqc/V37B3oBgHFvq9/vaVey2FsJJh+bqyMIsJIt1NR/WWw46uRc
         teQ52j63Z8B0irzlyv3UA+f8qLe7fBQVzL+ElKrutmZnbvAIZkUkXzQTrzIqq/4hCrj9
         L7Y3CsP6qS4KK33mlaXFbBiuf+dHcwOD2Lp7RXc7XrMYmNNJBi2pdesYP3w7FksbDpIQ
         wb7atQYCEhvaOumKBjv88Ywlop+8zAy0hhFyn9CkLGC4bhg4oJylsZtb5KztMn5lqK8Z
         /TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794757374; x=1795362174;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aqeGITPxpcHpkId0HH9peiiOdA9mpAaQxrSJsRn67Ek=;
        b=evKjyjvgfHWDcOvf1qYPHHqQTDEtp8qsa+ZNroqc7Op3+3MtRkOEiBPgyf09OfKkU+
         PZYzzbUaYsXsDVNMCp7dQp0QCMWCgs3sdpDh9vh6MOU1Km4jabwKxxe24oDFIRbgvOST
         TgnOItr7/44Yk9X+M8z40EVZ9MRhgQYi5/IzPJMskXg2K5D0CZjSCXFdQ1uNeLXPEivH
         3lMKv3AQq0W8AUcdyo/lmymsSdljVtFSCCR0R/lTrKWwE49LBqh4dWnhKcoXK+lGbjNZ
         fFy+iIcG2gDKVNN+lyvcf8ILwGCxt2nsX7ST9qchbHIIzzOqCQPciJOyWFVqx9Y6zzly
         TCvw==
X-Forwarded-Encrypted: i=1; AL+hErHLsZjFzBR/HKKj1MX1PJayuf6licZMMN+SQKPY/MoyRzkLRG+4aqL0VCDFpmjRUniYuApYtkONvdTO9w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QQVgD4JQRyKts1WT4aqAMtlBCXG3Pq4XtO2abmOfg0UEIt7mw
	KwM2L/VoxP8qieYN1wnpmNUt6McgLXznH9mqfDA+Z4hRr1NALtdGnpZrNai7HsI+e/qOhYrFywN
	Vh8wh+Mw=
X-Gm-Gg: AYBFou0dzKg+VNUN5QPd5mb5DFFQlKxmd2JgshLrhugVcITNGHTQI0eD2sVlwlS1gW6
	xJQIDo6dHsbrShX5bpGWnRYfKGMoQ6CUDZ6L1jYPBaf9ItSaFm8C9vkSoxHHAS0yPd7eM05Z6vE
	Shy7v/nfAAGuUCbpvi+1Xn63Pjf8IHXlIUdfNP/Sd7klybOInPh+Gjb2KKYQ2F1BUDjNxWzxCrD
	pf6iEpvbOvSr7lf3nQAUkjlA7DNYpZTCYWdpPf6GCmHcPfup9jvwwNLMZwEOXpB5BCka52hLhcj
	sfpnhYqCH7VllQ2ksti1SipP7O6vwTuyFZq9SaLqnkEBAyC+RsrTyCB0+6prFEKT/B55/r5+5nb
	6K6dlGVbcZntuj2le26SV5dBULTWz8SME92jQYZZDKyWr/g3l3HEZpCKTi1p58VvkqjIbFcPC9v
	nOCZH+63q2RQO2Po9Yc6e/i0Zo6E5EYfP3oM8GJ+KK7pcuceHghCOD9o6pemMR7Q+eICK31Db0o
	t/24jFVQbg43Mqx2/YCCwsS3zGYKH9g9YtLI2nO7PgOsytnSFpz6qxAuWDFCLDR//4d/rg/+NGb
	SzCAxs1uv2AMwNJZk2eewUGHeLqTwWG+domwZ6k8jbtI5DDHIZsC5CRNXbw93u/m+S6YESXvblW
	3jCA233d6RVWsB/TvSYRLUqrOtXXKyP5LbA==
X-Received: by 2002:a05:7300:6da8:b0:36f:14ef:ad08 with SMTP id 5a478bee46e88-37965abb5bbmr10280527eec.9.1794757373805;
        Sun, 15 Nov 2026 07:42:53 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm25665134eec.12.2026.11.15.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:42:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tom.leiming@gmail.com, linux-block@vger.kernel.org, 
 shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261115003349683IFDCSTYhPzQtBozUiO8qN@zte.com.cn>
References: <20261115003349683IFDCSTYhPzQtBozUiO8qN@zte.com.cn>
Subject: Re: [PATCH] ublk: validate all parameters for zoned devices
Message-Id: <179475737299.32615.7778013887179668898.b4-ty@b4>
Date: Sun, 15 Nov 2026 08:42:52 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 15 Nov 2026 00:33:49 +0800, shao.mingyin@zte.com.cn wrote:
> ublk_validate_params() returns as soon as zoned parameters are valid,
> skipping the subsequent DMA alignment, segment and integrity checks.
> SET_PARAMS therefore accepts combinations that it rejects for a
> non-zoned device, including integrity parameters without UBLK_F_INTEGRITY.
> Invalid parameters may reach disk creation or advertise an integrity
> format that the server cannot access.
> 
> [...]

Applied, thanks!

[1/1] ublk: validate all parameters for zoned devices
      commit: 78c4f290e2637f8039e2124a174a24a341b38b1e

Best regards,
-- 
Jens Axboe



