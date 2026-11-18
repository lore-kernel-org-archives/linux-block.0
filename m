Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018063;
	b=rhKO8tmIWi+/VGcuebItSRLF9V/8Pk3/CqouZSnISGlvrXVSeEdwMHLCNcEybKch/uRm
	 VBV6bPoY2P4bDI0KP9JRc9djTPULfjo0S8sDCuprgmWTWxJ3gHQqiVDQ7qpzTRq7OfNZs
	 Y9RhwHRsnbs+XWAf3vv68UYgrCcWie2a2eVGIko/jICe4wi0fN/YnT1HQctSvmd+0qDZZ
	 rqxZFbLllk0WZXtIJXYU7AaPauy3z2j1tWvzgkbV3/WJe3gAlS3+kckPXgCe6AGvQs25y
	 BlJ/TEeCP+dWPXsz6Jyae1hwRUQJw51MzLK3kFNK6LlqYAvPXHeyKQmIXjsWiIHsn9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=JmaZ/n9FsASCYINSVjYeJtINexMMe1X6XnCohCT4mSs=;
	b=FF+CoGq3lh5E0o6JYxmEzdaGn78PxUntsf8krZTH7jmK02A29584jBtP37ggdtPsSg+r
	 zunZHLyea48s3k1+gXES5d+j9p7mJdWNTHuSnS9EdwSQOcrgR9FJUN20+SNlSyvW36nPZ
	 bDd5quBvoGQH7fTaZx7rRcCFOdZUcXsBy9ttdNyNr+x/2ZyVlihnEafzjKh/6Xnht3z5S
	 ZYRihvYLunLW0uNsZTa0Bu7tBMjV6t6+2bqirbXvko/ARYquOeN0x1SHJqFFpzBJFCHlV
	 KdZi9xlBIjKHBZ7wMs81rT1qmQn+uFZfE+tftwKJoVRswzc9QATE4BQ/Ko2NOapURKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YIGUfzF4;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DE60A2617
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB6DE60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YIGUfzF4
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-571eb508e44so397906b6e.3
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018062; x=1795622862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JmaZ/n9FsASCYINSVjYeJtINexMMe1X6XnCohCT4mSs=;
        b=YIGUfzF4YnoSIglmvHhpupDq72wlS4QGZnvMOEHjBAiofpTfvXUr9l69ZgY5KW9v37
         BebnR6s4m+EJuuRwS1MIoehf1B1szHGaFvybAFk/6Y67mWgEwe8Z1j2yNgyUbPpmq+Qw
         uB0lALKqu0H19jXyksW90i8+XVHdbLYnn9AQZDE3vmQhy6Kw/Z7vihQ4fQ+RtCLB6QLX
         UQrpjYpz90AZg4LIeflbmQvQAZSJOpX9QQzrIdZqIUG1i1FQi2ajKubFOllnTD1ABKPl
         zzUfkW/UQPqAxI/BJnq/h/YKqJkem64f0sGOoXqJQohx4xM62iNWD+mdjup01f4EsJBZ
         0nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018062; x=1795622862;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JmaZ/n9FsASCYINSVjYeJtINexMMe1X6XnCohCT4mSs=;
        b=FwlLGDB2yqu1+azxd0dgrnoSMTvcpWLuIEoW3GQgFw9b+wqE6Se6NXbZY7kv+H84/e
         hFimAW+Got/k2pa8EE2AiYpk+qghgcR5c2YhEpOwNyfIg5hcY9LUDZB/3bAXYqNw6R4h
         Qbp138BGhPwE4794eSf8BdvOwbR41QVGM8UyJjY4ekgZlNOsNUtDKXKAAcotfa1GPhvV
         nlrAkSiN1NVoMiygSUE9cIkVapDg+qFbUqmxrvS2TlRQiwsPW+lHTQxx8G57/3krxguc
         LHF1WF/lEyjS/i8XQumCai41UlW1SBZiOlj39QcsRgwsbyIyt7ds/zxSI3xwDDE9UQQB
         pMsA==
X-Gm-Message-State: APuU4Z+5vflxe8Jr/1kQ85p467EFDp7GV4IfsuHnE7sZs3NYRVOJxkI8
	DBTMxgxiHFYC/kme68nWQ58jozE6Q7cOr5q1OvUZXnHU/dAhG0Vus/1oagDl77xQ7TM=
X-Gm-Gg: AYBFou2+MDcnA9m3SAVrX6gK4LcGiL9IbMwLXL0juVFUfVspeD+2myUQgXz4oZKh1V6
	8OQwwXsHRF1tPh2RhmPAJGu+zMCNpwLH/+izJ5bsN9pG/gpjBsDum7t9YqTmIpWUpprElPTsT2U
	1aht4X1TFFbdHOIfmACYWL+M5fuyvbfddjsfajxGyfzxl79b4BkKZ3eK5vVp5qwCKoRSocAzUN8
	Plm03MIstFNoiCRS9p6u0kZLCUz7Iyob1uBpLv+bRrK/Kws97mEBH027bNgS09S443rBmHV9IU1
	Xb3f+xXtTyFgePw9Az274Ov+wgNnwfSDqRlpNDGl4PeW0A0qYcHA2NrYKxUyjmRc/YnhekoRPJL
	SGdflh80xS46QOuoDXOUcmuofxfPCxwpyqX6iAvWD5uQUzB/mllH9k59DpdrseLZ0S4sKdYSor9
	r+jYArHQvGyILYTOEd2XVT+0Ura7NWpEfDppFm3JrFP3Bs6JrWD8zL5+cgSurDuHq5bvDbceI6K
	5NCVrZrggH3cXjzCVFYi4tdsuWKZoHIqddmJ8BKvTZYjd3bxHDbRE3Rj5Ij0BIztjy1RNp1t88x
	iDou1LJupu3DdINGvpo+tW/yBY/Fl6MkKO/w0W3H6F/UsHM0R41AjbyDtra2nH0DdYyqmInD57u
	Q0uML853KsVzLhNsXrUVkWGPiLQJiQG95sKwdmCdXncMaSw+mWDI=
X-Received: by 2002:a05:6808:2220:b0:4f6:a430:1822 with SMTP id 5614622812f47-5773c52fedamr3373325b6e.7.1795018061884;
        Wed, 18 Nov 2026 08:07:41 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261115003345297PJDJduSwIS5uDYxPFRxKJ@zte.com.cn>
References: <20261115003345297PJDJduSwIS5uDYxPFRxKJ@zte.com.cn>
Subject: Re: [PATCH] partitions: aix: validate the physical partition size
 exponent
Message-Id: <179501806057.17649.7759332240241480233.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:40 -0700
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


On Sun, 15 Nov 2026 00:33:45 +0800, shao.mingyin@zte.com.cn wrote:
> The physical partition size exponent is read as an unvalidated 16-bit
> value from the LVM record and used as the shift count of an int. Values
> of 32 or more cause an out-of-range shift and can produce an unrelated
> partition size. Exponents below SECTOR_SHIFT produce a zero sector count.
> 
> Reject sizes that cannot be represented by the parser's u32 byte count
> or do not cover a whole sector before doing the shift. Use an unsigned
> operand to express the representable byte count directly.
> 
> [...]

Applied, thanks!

[1/1] partitions: aix: validate the physical partition size exponent
      commit: 9ce4cf1ad3392b2945bf1d49f1fd305364020a1b

Best regards,
-- 
Jens Axboe



