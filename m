Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E41F181F
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182986; cv=none; b=Ip8qVFGEO1ulbYk/sZUvAywbiAh7SFMISFeu75pHbl4VsNHiBy0H5QOkTyvYN6yVmp2xg5Ev9J94YqglH7iS4qDvZKC9Y4g6FoB7Sk8YMNQKAc0ucKbb+odkqdAYmVrYX3P2OrKCYWpqbuEPaEfl7ffTJneoOE9gdEGzNv1uSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182986; c=relaxed/simple;
	bh=uZ6Xidk2wofrrLGL5yO0fX4qOEWi3KgiJ4NEzuIRHmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q5XCt+OB+WTETYCB1aY2586lzANRxHk4lEwQVBoPVDDyxtepfEsz3I52gU9PNIW4Q4oLqH+V0zAZHg7rPkO8oQocEzxVucMKIxA1bkHyvsKX9P1wzibnCx5r64/LT4I8ToQi0vz4ewAP6Y9skvtKIYLT8iJ1qCuxSRNjcTxW7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p0rKVsVA; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p0rKVsVA"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4331d3eea61so24047255ab.2
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762182982; x=1762787782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2VP5eHd4whSzt4tHMCcMt8UV6SGTODxfAS8gkq2xxo=;
        b=p0rKVsVA6tMM2Wcco74mup1BaHvdN7wZSflCnXPXGnFhq+TjFsFu+AC/AGxVIjtZKz
         3QSPsczErdCvk1NVTewuoNi6q1ttVVlmnVt4md4IhhMU6TqZQDvWNHBiO2ONJo02/PMm
         Wofw4/fpaIzblEHpuVNysIDev4BlmXdtb7UYLCYvU9HU9gJAz6pjHlqVOdygxMh3uQiK
         vC7Zm2qEHEnarcIQQVYqevRRZqSx4oL5mARHxykyqKyAB16FRkUeZ2NEBHybf3Vh6Gt1
         cwokRonR3de97fvOHXAjiOAArOvvPAbs8huMukDCM6LLMp4PwK1i9/id9Hc6RGwxjDk2
         nU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182982; x=1762787782;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2VP5eHd4whSzt4tHMCcMt8UV6SGTODxfAS8gkq2xxo=;
        b=WN0cb7JUELBiFWOqr2TUmvbGUTMLldkrJZsJXnNaqM3I3y0GcNjOBCt4xmzysy3ZMp
         d89bRQ0KPMrZaJlF9tG2GfOIMKbEuG98DMZs/HV/dxDWB7fJyQWpv38XIpoE5rc4obdo
         GeQPpuV38u+Sw3Bm2b5L6HyygtTa99ePf7rTx8cPX6NaftqgnVVU8xw1f+xZti+nKeqO
         aMZ9Nz8Vl8uuwL75aBkep0/TjdisA29m6aJX/aGeQbIUqSfs9cMNlub9W6ZO9F9+IV2q
         yc/CG0bYRAEV5IMR9teYi9K6Z6M4dBNp2y8wzOWSqOasrqkW8UZqDfysm36n8NaITq2g
         jPwg==
X-Forwarded-Encrypted: i=1; AJvYcCUVuO/ClQVC8U3+gYKIaDOFbF06vE4HvgHOSekECyfpmYOY4x8FpOjVqXiPfg80IZhYBtdUqLTrKKmd6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoaBOR00QRXvtfcbr4mnE5qiQ9cf4oTnkkfLn0eRa8RdhG9Ziz
	Ss8a0p8ePr1KTh9e+py1JP9gKco8t2tDwzlMqX/nNf3SE4nN1EKQd0kdND0dprf1X9c=
X-Gm-Gg: ASbGnctzOMh7TlB7xCRpMzFhtg57NJ1E1kl4laI5oNvZ6u5mhfQm5bGut01HIQVEvo3
	fyvrQ8jPOd2WzTQSn/EKLDgD02ZsVwaZSjUbtSe5sNglAU5hk0G3glIQfu5dV6+WmtFov+ZtGWM
	4wLnCNzrxKxXUlvSobjz4kzrNxYjzqRuy1V7VT6Fj3TYB8xWztSl20LwdrgXAoBTYmNtEryjVLX
	WTAnUzNcdWXlqxNaGMtplQ3Drhvv5U1rbS7Guds9RBLP8VRLKpifDtPxt3vC1KHXd9NLEaYslQ6
	O4N2Lhox9iFGNzWpqgs4oqz9IW1DFCzDwDDst4pWIOOEMYtZ7Fjd1oIvX9qu426INPK/IXRxbr3
	Z4iVxHmmNWejLPVQlwsiG+8zSEBD29OmMSId9ff2xSekU3qfB95AqCdFh4ZPLinFQVxI=
X-Google-Smtp-Source: AGHT+IEiDN1o+PM/1Z7sT1acon36b1aVtRVhw4Y/i/XVotDAKRdH4bIM1pLS9oCqfCdsagASs5k2KQ==
X-Received: by 2002:a92:ca0c:0:b0:433:3192:4aa with SMTP id e9e14a558f8ab-433319206abmr40241605ab.4.1762182982356;
        Mon, 03 Nov 2025 07:16:22 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d620sm261819173.8.2025.11.03.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:16:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, Shi Hao <i.shihao.999@gmail.com>
Cc: lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251101054422.17045-1-i.shihao.999@gmail.com>
References: <20251101054422.17045-1-i.shihao.999@gmail.com>
Subject: Re: [PATCH] drbd: replace kmap() with kmap_local_page() in
 receiver path
Message-Id: <176218298119.720460.5302997686043809131.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:16:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 01 Nov 2025 11:14:22 +0530, Shi Hao wrote:
> Use kmap_local_page() instead of kmap() to avoid
> CPU contention.
> 
> kmap() uses a global set of mapping slots that can cause contention
> between multiple CPUs, while kmap_local_page() uses per-CPU slots
> eliminating this contention. It also ensures non-sleeping operation
> and provides better cache locality.
> 
> [...]

Applied, thanks!

[1/1] drbd: replace kmap() with kmap_local_page() in receiver path
      commit: 77220f6d18a22b0b5d73b5d2156609b0aa21a7c5

Best regards,
-- 
Jens Axboe



