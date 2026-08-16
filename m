Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B53FFD
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838520; cv=none; b=tpObgBpXGPdK24kMGj6UQ57kp/n1Pavd0mp+QgPJzcthZYXDXr4/10HklRv7JSU18v5/nzwCk/fuTVTuHn69kqwdZxqZ+phxzEYTwwhk/z1lGZNMl7sOoUit0FLn4oByAc5RlBJ79RS+DxDQchHHLX6B+wAHfEdVP4L92OdmmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838520; c=relaxed/simple;
	bh=qJvaIQ7TTO+3sRqiW6CuA4b8DNtUPBxI8RYDhfY6wB8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ExbVUuJiIqgyp4SIuI/jLixhuIrPPUt0QxFprxzjCCTtb0+EIydHo8LpJMce73RHb890hrELmP9B9+7ehJdupA7MT5nMF+Tb7KzoDzKS+3+9d6uk1WzzoT2cL6bInKm7rqfOtj3lqe1bpVx/aijRkR7EogH0mxPh4qYBBseOX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jXf7OyOH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jXf7OyOH"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb61bbeb25so1859709a34.1
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838518; x=1787443318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHTsRRX8bSbmRAlfcc2KpD2SB+CAagqouGQGdrOK1fI=;
        b=jXf7OyOHWk+55qAlMo1wRUbGkd8QDEj8tmnXoLjB4ZlHIOROvAE8D2Od2pEazJDpaH
         IzE2GAWcd/rNENLY5nxoaLGArxDIWsKwOR2N0jIl+cK/aX4yrrsq2FEWfgE0C8cn/jxz
         96tQYru053aMrOeTRajPBdQoXW3boNtRdM42sslUFZ25470l/8zreSmpgdt5E06GVFX3
         kJ/+X7Yl/4kHPffwUTZhlU/yJZbpyG48E4i5NhwiwblEf+8lKLjowNCmroL69JfFbFcQ
         OtY73sQesKhzulLld92rSO2d8210Hj+Z1V72iwe7INsbbe+5Fux6BlNlkb3JmUP2y7N3
         IvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838518; x=1787443318;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHTsRRX8bSbmRAlfcc2KpD2SB+CAagqouGQGdrOK1fI=;
        b=jFuZuwtymE+i4gdJX+smmd7QlgkMtXgge04pgj8Q71PM+SgdLdatKeHi6J2/vJs6lz
         g9x2DtSf1E6Y5/y9IguSbLDNQpBKMxD4IsF4znFGkj/roEuKYjq+EELEnbtbSE3rJ84S
         28vDslbMQdLiAItSBQ2Ge5kN6M39aCf6Vy8V5Tk/hfd4exaRu4nfN+0IEuz7ygnayEP5
         Wuer0/Ul2tDTInvFrufw8GMJDOhbyeMy4DeHvbzI+hASyVQF80wwTq9zn0QRfN5dx7Hk
         m6U1p6KOEsWNKanFMOw20OzqhMJpfK8jDmLXNX6l02AdptNzpSYWopPtV7vd5yvc18m1
         rgJA==
X-Gm-Message-State: AOJu0Yy9fen5ix8BHRtVV116cPaKxNjs0IZOi6P07uXgEDq3kJ8ucZ8O
	gT9mofGRXk43XVWTcSpe4EFi/AlkXf5dDEQL/DZ+PolHeYUyn3Y62hz0rX8LiK1scRPAo+/Upmm
	VaiYBmGVewQ==
X-Gm-Gg: AR+sD10zE/Il4FeJCfOYDCFFA5GzKlM2bgVQmkiuGpTUDDd7Qs3vU5nbUErsYTguYwS
	oY/AT2XbMQZsKpKr83QHa139pgXSzoInN6w3oFZvC27uPS7WSTxeO3r+WjbknDg/1JsU/1gLYqD
	jg5iP5fJIDGh+q1Xym44d6Y2+I4O7jHBhlbz9aDohVBvU/+vROBvzkiZSxdvZsUuyosQEV71KIb
	j1kL0xOIIdRcAxZRphNeK+j7b9p/KeVnEkULh//Na3S0K8UHnt0HTTced2IleCTXVwPaStaEHMP
	9HcYF4qvfAeXsJ7+BClPepfA5LXTVoV24yCJllxVJlCKqeeU3sR/Tj7j8M3EEjnfS+BUwqN1KVQ
	KIDadqzcjvVHZABwYHjsfHw+mIEoZDwuU+0lS9qHcM14HLhMb9+f1PmoxJ8baWOpdNc16m6UjN2
	yw9e/s/sYXozyuR8Pyl0Id1nJBYK0SY2WDYxRmmQJgspDi5Cd2VAyUdeJxkVbFrxFnqLn9/kdzp
	wkOyLKBBA5d3Yu80DO14mFmPiu++jFbykZy9Wn50g==
X-Received: by 2002:a05:6808:1814:b0:4a4:82b:2a36 with SMTP id 5614622812f47-4b241bc2652mr14859059b6e.11.1786838518045;
        Sat, 15 Aug 2026 17:01:58 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260811-swim3-module-description-v1-1-28398c5a0e32@kernel.org>
References: <20260811-swim3-module-description-v1-1-28398c5a0e32@kernel.org>
Subject: Re: [PATCH] swim3: Add missing MODULE_DESCRIPTION
Message-Id: <178683851353.1984298.10530987122040135003.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 11 Aug 2026 14:03:20 -0700, Nathan Chancellor wrote:
> Since commit 6c6c1fc09de3 ("modpost: require a MODULE_DESCRIPTION()"),
> modpost complains that swim3.ko is missing a module description.
> 
>   WARNING: modpost: drivers/block/swim3.ko: missing MODULE_DESCRIPTION()
> 
> Add one to clear up the warning.
> 
> [...]

Applied, thanks!

[1/1] swim3: Add missing MODULE_DESCRIPTION
      commit: f9820056e40ccea2919fcac0d27d13eb59548274

Best regards,
-- 
Jens Axboe



