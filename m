Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819D214A9B
	for <linux-block@vger.kernel.org>; Sun, 28 Dec 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766938076; cv=none; b=jj+4MEdVoex/WBw8GNROB25LSSS6n3ZdIpv0bHf9zKuxDQ8AA8pRuAS9zzkw1uzHFBDgMAQHX228rJY10BE3avIbGkD3m3ULnErF0i6QSQ2rALfJy0v+VpnlIt/GD+LJwSHSMywO9HoApWATG73/faAbaYc/0Mkfjmfc7MkBniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766938076; c=relaxed/simple;
	bh=F2tCKSP4YvGQrNXRGmXd+37cmYKNHnUr0Z8WjkgGb9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nwNrZfQPKGmTYX188iqBRPF7V6uKxOutbuxaOfy3dG9jddU6KGG8bl2YdzskHOwHx4jpvgCz1agIaJJc7p6QV8ETWS0YB554tf/qsaMaHU3XMZzAWTdEJWmaM0DOL1NKJebaWRofBpnEfoM3SESaUtFdYXDfzvriu8mPQ2fC6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u61F1VoB; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u61F1VoB"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-3f551ad50d1so2967446fac.0
        for <linux-block@vger.kernel.org>; Sun, 28 Dec 2025 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766938072; x=1767542872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szKx8AguahzJOPQzAYE7zxY9qDBahnfp9k8YWlf8ulA=;
        b=u61F1VoBUjM58ptmaZGV2/6X6BHiXdRvZZltRF/BMLMXwk7YO9f0A2xvFB44WApO8R
         RDNhslRDnmlt/Z2grgUNNVzrjOFMMhn8cO1UEA9+la1wtuxIu69qX0bsVYXk74kUYn1Q
         4rqsHUECeUXZS5ibcxe1iz8gaXNLuN9HE0CgmWV9oAmOZGURPkdNgdekH/a9+hI1Kdnr
         L2AvObcQKwmK+xsmN3oo0TxQdfpsYNxWByFpGf36lA8joCtBkAtGW0PCGY8sDXMEcaoE
         mfW4dvIDwm+I3jYbaUpR9yfu/48AV/wDjzJM1tY79ZBrgU9TFamkciSzNPwIG/brxwo/
         T/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766938072; x=1767542872;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szKx8AguahzJOPQzAYE7zxY9qDBahnfp9k8YWlf8ulA=;
        b=owMmx3YdrG0LFLIRicG6dgLGG3ZvkhOP0WtBTYQ/XBQi01lI0VJ3Avb8dg5mpQOPkO
         pcxDbXcBztqndf2BJ7VnZee9qUxaChD2+q2eY4DFNhYkCg4ebzEyXYRsHyfkYeD+0y9B
         t102XweA3Qhajyi17mnsmBLm6hYx/iwL5/ExF/x2sasXWsx8hOA84/4TKerOtn/qg6Zp
         NVRcZc88IMAmDDBjmgMkksnh6HTnLGT+a8NDY65u388f9FhlN4pRaAhbsG2GYLQakzaZ
         ENkBv9KvCLbtNRvx1fMgx/M6+e2aWbbHDnMGA4AnU6FS40YkYwyeMzjZlydv3N61Fgq9
         CzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUxzSzXgtHwHAPCTlK3a79bOSX2y7poIG0B4Oa131GlqiVNVcXP5LxQxWmCSSlXok++sata/UTVlm8Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHN2hj8h6kHy49oXtLpN3kQQbUdteO0JSQQa1AwIGF55oYjGOs
	ViLD93raIW15+QaoQoiOnkqQDed8qRO8K8+EQYAThwa+8ZZKvd96B21B/RgBemk4qBtT5gsKMPx
	MMJSl2j0=
X-Gm-Gg: AY/fxX5ljb2TW/jrYG8YPhRklBcXGaz/C2UrKE11se5m7d+iPocGgC3LLaBH5FZLbjW
	Oc7LJwMvzIBGhYEGCcYZ33hnmESz2DWkZxpq24cAPlXx8mIVfbOOgWf607FW7+6FomO5A+sczcj
	JFW/5EG92NlLCNhtdYApoSVI/co9RY1tpPBk6VKCL1A7vpHsmsA/nbrtT025DjiXtg9zAhXN6oP
	8DzqTq4/7pOFGvqlkMWnPnmWKLYXFcDyEdpGEjljFa9jPCPx6z/OSZMGbf0RUZMHAvp7LeEf6iC
	FMtAd5pjCzEcEatpDQuosXRV1hMmoeKZkggWfHmceEYi1eAe1O/lWH22r4eQPj7ITbd1hKuFSe8
	cVRYn8/P1ihDGpnsNhV/8VjpCHEExKMcupUnrlAv6a1SrNgb4A5HHYuYDv47pusEVVgj4Jx0AQl
	0mfZ4=
X-Google-Smtp-Source: AGHT+IFnaTAxARAdtF+X96h9yfgX9gbDfyl9BBErpuilZEbI2PIGfbl1nU+8YgIsKD8rjejXZtcsnQ==
X-Received: by 2002:a05:6820:1691:b0:65c:fa23:2cf9 with SMTP id 006d021491bc7-65d0eb442e1mr11450341eaf.76.1766938072567;
        Sun, 28 Dec 2025 08:07:52 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f6eb26fsm17211956eaf.14.2025.12.28.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 08:07:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai@fnnas.com, shechenglong <shechenglong@xfusion.com>
Cc: cgroups@vger.kernel.org, chenjialong@xfusion.com, josef@toxicpanda.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stone.xulei@xfusion.com, tj@kernel.org
In-Reply-To: <20251228130426.1338-1-shechenglong@xfusion.com>
References: <71df89fb-1766-40d5-8dd5-5d0c6f49519e@fnnas.com>
 <20251228130426.1338-1-shechenglong@xfusion.com>
Subject: Re: [PATCH v2 0/1] block,bfq: fix aux stat accumulation
 destination
Message-Id: <176693807087.193010.13084739282285642085.b4-ty@kernel.dk>
Date: Sun, 28 Dec 2025 09:07:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 28 Dec 2025 21:04:25 +0800, shechenglong wrote:
> > Please change the title and follow existing prefix:
> > block, bfq: fix aux stat accumulation destination
> > Otherwise, feel free to add:
> > Reviewed-by: Yu Kuai <yukuai@fnnas.com>
> 
> Thanks to Yu Kuai for the review and helpful feedback.
> 
> [...]

Applied, thanks!

[1/1] block,bfq: fix aux stat accumulation destination
      commit: 04bdb1a04d8a2a89df504c1e34250cd3c6e31a1c

Best regards,
-- 
Jens Axboe



