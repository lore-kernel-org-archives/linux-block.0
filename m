Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5621256C
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831383; cv=none; b=u/Pxhj1UcUPIcxR7ADAqXPQBNZ8xne5sYNcmnshGinH325qH2v+EmYRDuXWnXdNCFBG12fnb2+OaZEuwY0MO01FZ3bmCllNkM4QUBKNHaLFHvz41nzWV0BBkXfjxYU5FDX5M3FCbgSO6TuKohwM+az2GHW+ejaXnE/uLgwcJESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831383; c=relaxed/simple;
	bh=vxUo/TnwA1v8QJqzBwDw4dsJyqsy4OyFVl+y4KtNlvA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b9rglf8+c1kiu5bHcTGc/4riwRQTmCcJYYFmvJhHNDADhTTJL4n7eQoNRr9MrTCRra3GbhByeUZKt/xh+SljiZyUpFaaG9i/oiwAYgMC5+pGX3GYFkCASprw4jLVjm4wlEpL6JCJO7FZaR6k17hLwdzmxo+9ceoasjol4krFkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mPrP6t4v; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mPrP6t4v"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d19bfe1190so1909167a34.1
        for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770831381; x=1771436181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rr/w2c7EIo7OZJZ+OxFGePVTYG5jzNDKtZOfHNEMKQ=;
        b=mPrP6t4viA+K6kKIbVQosWo0sdn07hBqXckM36muS4GoE8rXstAozWJhCHWntpUAFo
         iTf3C2hHGJsg+2E/zQptE+u6UjO0rk1Su65fuU+aUjYQPSfJ+Ois7BI4mwHcfA+0BU0P
         EGchpF1bN8It2zV9ZZjjaqvWemEWpN/5fLDbe6uAu1xCrFIjKNAMqGuV026PqdmhxKOO
         DeLr/w92JFhmwrcVnwGvEXJb569zUs94/sTAE6lwcg3oegLJ1HoYUgh06bStnCBblrPp
         g5TpAjGIci+YdbWnn5BIt7RM+3tuZ99zLNLUVDs3clG3v6UTGxe7B2xEboGjZQtfwAvR
         5NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831381; x=1771436181;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rr/w2c7EIo7OZJZ+OxFGePVTYG5jzNDKtZOfHNEMKQ=;
        b=mr9kl45mpoL71R1Z/3XEmW66EfTB1FZ+J616NSWOEEn8rZnZlpbO3NXBbAxY4o6+ie
         Zb1vG+HSWSrtnTDzzeQg03Cdc44RomL7wvDmBq4CgE/tT+spcweDhbLM4VFiv2cqLF61
         Iyv5E8g77hvrmAYN+Pm7QS0uTXq5z0I3IXZX0ibSzgN8Ig/2reNylTdF+z2ZU05zN0OK
         Llnz04E9+EOWy/9RvzKvrGmHsgxM2fxLJhw6s6OBQ7vGSlyXvAM8FFqtW+8jFBGSj1Ui
         KWs2RFrk/aqar+H606YXAga10ZkUBgqJ90LHZs6G3YLKDRFkTBRSi4IBFbPGV8jNM8ET
         gi3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwhb85P9Q67Ge95kVwDoCVWxghrD99rI4uM1I8wVfOM6cPZDapu2/oE4HrEaVSuodemoWtpzchCHjv6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBfwPbWbH2lqMdRThfZV35yauZz1hovNpkGqwHR5GaqETM7T1
	XGOK85dFz0uBJAeVY1C9m9xIsIV/er/3opZ3LUJXiBxheo3T7cjlO5qOgvz67LsvYiw=
X-Gm-Gg: AZuq6aIGYg7HPgCPHIHDcyNgnLLv3gl8I6EW70DY7Mqb24ry3a0MFctpBkuaNXF52mh
	9F6Y7MvBrXerYGrQ+FPVtwBIUHCaejrFuPngNksndcbLs9wg8o+WJDQYExFBiIoSZ8P++Es5NTa
	lfeGIG4rfDcbJ/zwjpA4QWvkv6f1YWJpAtTDLoFCHk4vlqtQUFzlxiyMz2r881zEWOuO01BX3gE
	q7hmzfLnmZxsjz4+klaRGkk01JamqdOWyYVDrTaOjSpZzCdB/ku5c+yFLqjlJUIVNSbUS+Mgpwl
	t8GyrUp0qcIQSjibo0tvWLyeRPJEi8YKcUMqYEzzklwLbRnd1QBQY8lMLVAQ6/6+zd7bKMk8CPj
	vD5l1gBeLRpC9XS0qP6vuR7QKOBflAf3U2FT8SPjVRwClop2gY6Q/vIQ8achDA7i83RFd1+Pi6K
	GydUp1W7JBceZnVN5kJJ4VCiqEXgvdRH3soRH5fVLzMmpEwqgOCs0DaCHjSJXHyEEA56Fp0R1Sw
	JVofU/zonBAGg==
X-Received: by 2002:a05:6830:4389:b0:7c7:6043:dd93 with SMTP id 46e09a7af769-7d46440c084mr11369980a34.13.1770831381098;
        Wed, 11 Feb 2026 09:36:21 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76e1b0csm1640690a34.14.2026.02.11.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:36:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
In-Reply-To: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
References: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
Message-Id: <177083138009.157276.14024749739595076725.b4-ty@kernel.dk>
Date: Wed, 11 Feb 2026 10:36:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Thu, 05 Feb 2026 18:39:29 +0100, Christoph Böhmwalder wrote:
> DRBD requires stable pages because it may read the same bio data
> multiple times for local disk I/O and network transmission, and in
> some cases for calculating checksums.
> 
> The BLK_FEAT_STABLE_WRITES flag is set when the device is first
> created, but blk_set_stacking_limits() clears it whenever a
> backing device is attached. In some cases the flag may be
> inherited from the backing device, but we want it to be enabled
> at all times.
> 
> [...]

Applied, thanks!

[1/1] drbd: always set BLK_FEAT_STABLE_WRITES
      commit: 2ebc8d600fb907fa6b1e7095c0b6d84fc47e91ea

Best regards,
-- 
Jens Axboe



