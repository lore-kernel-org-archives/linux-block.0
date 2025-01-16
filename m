Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6222ACEF
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036819; cv=none; b=JFaLCRzLfv0FW28HKm/XMtXmGm49vD+S2ipaZM8ir/4XVts88F3m5Cl4y/7Hi7KbZXuhN/jivogLphOpDp26Nq2zpBf7Rp+BfWMAnljLcXqe9S5qhwKQ4Y+jcFMKNgOJ4OFEtkeOG4Y4QTPi4py/58eKYNT+wZq83XqqJVghpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036819; c=relaxed/simple;
	bh=gX8GP2PT41IzW7O6biBPIEvCMWkVfbVdWdv6YRQXWU0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MO4fqBsR4HbQuCkr7STZFWu//uEZ/lybvV/gqhNf1+d1vEwNqtcjngxFz9czt5G25lACL+mFJ+f/k5qFDPFuGOoxHls+vnnRGT8qW+07iP3FAN7ulWeKW81LHernQd75pyv9fzOAoL25NKeZTVs8lO7FsAgCwEDwB8TgElX8vOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SGqxeLaY; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SGqxeLaY"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844eb33827eso29251639f.2
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737036816; x=1737641616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTsqQBcR8nikRY1mHRlAq11hBDBCDSStNgwzcFfh57c=;
        b=SGqxeLaYKXaYz7VSnLGmLKiVW8DCcmArmV9mL+v4C97YHWNALEVBFosAJblrffr+Y3
         mm2JqdcxzeprcWvTxE1ibRzoIG89Ib52BRbPn2z9UcH934+p0fp8CfVS+JxomNJSxQ0j
         7/YRaOQJEmHg1XpS7u7R+oi5Ml0QGV0M5tanaAS457Nl6xilOYHJZVf4NibWQQnt/VN2
         KRz8fVGsdJA3gvnf1gZ+I49mXEb9x1q0/9WtTRYug8M/Bz5YXaVbzeutB+nhAtNWKxKJ
         ZvRHvDHEFYmmw5CAgPtbKKsSY3ehBP94qdJnNTs2fHXm5htnAs2rFhi771qWx2T2U0pO
         PAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737036816; x=1737641616;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTsqQBcR8nikRY1mHRlAq11hBDBCDSStNgwzcFfh57c=;
        b=GQQNo9lK0Lkg1i6GQ5V9zaU0DoKG7BfWurbWc5UNN/Z58WGF0XhtV4fi/NoDxudcUP
         /phB6ekd8uWGdKpiqxAwiyCLA0Nvv+9UsRYwyLRfymJfJf8Ckx38V8PC5LIet9/ZGt/i
         PWrfHUCQdzj6qEB8yz2yEsLVfoQiYmvZVCFFfuz1xi4xRC4fBAs54DZau+CXmTl7PZwL
         rOD/6rq8k2SDWzawVnEHqggfJj8CR6iHt1i09MrvEC46v9Z7CJ6MtvZXXbULCu93ZewP
         NuJXzZiSVfDPp/TZnDpf98RN125FqC2mKxqJST5Ax0i85ZT+7F6glgfbgOkkHsq5WdcY
         /fGw==
X-Gm-Message-State: AOJu0YzTqBRd7+6E+P7HAxzw6xbMfNW019x/LKn9DfcC//udtRebLt+v
	tch8IRVXwEWXheENn9tZpU8u40UNfN6Wgi1mz+HIzO1R/mOLV0B5sDeFP0Zqkxw=
X-Gm-Gg: ASbGnct7LOfXfhGn8K0jUE7F8FFbcaiFfuzIdTm3RryqHd3prbjL/IErRAEMaAeJ+50
	C1919rFRGLzcDOxcQxV4aXY1nypvRfdQ28t0qe0swI55b1i+pay1xD7fNdg0SM9ysMasES8hQZk
	trMMp3P0Ui3w56lwMNdRkd030gKGGvuUYrLzHTR4sN7WV+hjmCQxQNoOSsTIERiJipk4aMKDaQz
	s7Soan+YGbWkvu5GQyNpsAisS0dX3r1/HxvE0VD3Obv/OQ=
X-Google-Smtp-Source: AGHT+IGANY8niyLF3uWa+S2iTfC6oasfW1qBS4d76l855fE+sIT/SX6M88SviEF0wM6UKp/gDW5gmA==
X-Received: by 2002:a05:6e02:198d:b0:3cf:6d33:d410 with SMTP id e9e14a558f8ab-3cf6d33d5femr10711675ab.7.1737036816642;
        Thu, 16 Jan 2025 06:13:36 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea756bae75sm36808173.132.2025.01.16.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:13:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20250115092648.1104452-1-ming.lei@redhat.com>
References: <20250115092648.1104452-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: limit disk max sectors to (LLONG_MAX >> 9)
Message-Id: <173703681553.10865.2377147280762674021.b4-ty@kernel.dk>
Date: Thu, 16 Jan 2025 07:13:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Wed, 15 Jan 2025 17:26:48 +0800, Ming Lei wrote:
> Kernel `loff_t` is defined as `long long int`, so we can't support disk
> which size is > LLONG_MAX.
> 
> There are many virtual block drivers, and hardware may report bad capacity
> too, so limit max sectors to (LLONG_MAX >> 9) for avoiding potential
> trouble.
> 
> [...]

Applied, thanks!

[1/1] block: limit disk max sectors to (LLONG_MAX >> 9)
      commit: 3d9a9e9a77c5ebecda43b514f2b9659644b904d0

Best regards,
-- 
Jens Axboe



