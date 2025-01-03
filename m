Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DA1FE45F
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929910; cv=none; b=C36w8pD3F9fvugjsSBxbasImlm6F7Cum6BmuWsYuqMDmRx/FXHk++AUF/4DCBro0EXl39sF5hmTpLN7ZJneuF/oYTc3hsFvTQfegg7PalwDhyj+wnNUhgMBdF2Lp2l1H4plZJ/tl0Mhy3h1PuFIhU7WiAJIOtkm7C4sHrmHJ2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929910; c=relaxed/simple;
	bh=phImQzPieSxMsN96qTX6j+1aER26JfLZFY/yhCysDho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MuMkO1k9GWZtARk1iJB3iOdpP9ybFOAvE4fEqu8LVe/7zQDUEx4JhQ7q4TZvcjGkHDFcn+n36nmSHIeLb3DomHcv/e2hKRG9+/8ueDzuODttH89NUbJ60TWvPoC7JZaqa8i7Dd6030OwCIpZ1ZPdot45wjIE1nt/YHt0opUl0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lLFuW+Hi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lLFuW+Hi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-218c8aca5f1so220245865ad.0
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2025 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735929905; x=1736534705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv2LJFwvzdFekdOiLKdjOBtXm3+icKcXY80cmxqTpUg=;
        b=lLFuW+Hiw/yx+MqAYwh0ZqBvASpuHjRSUOFgppK7mwlfd5Ky+U0iKSfPq9cqmI9Evg
         zeXtEgPP8DOswGFytirmKr7Bn0P35D83ppGbICnKICbTP+grCpT25UreIrJz81XgOLMH
         UFu6ux6nJ9ps4zJyS/RBHuoK1Wxkb46HMn5Cf1+hm7Nyf/c+SFgzl11bpcCuGU/W1jo3
         NKYx+uTz2wh4N+9o6KNCTI72nvE2ttGuwrjksoqb7yoLjdQvTsB5TSOcqoh1BoszqpKj
         gsQ3VCWYROTnSPO1cLFTvn5137ekYHS6ZUc0h1guAAL8hmTeM0p5teXWHgPaNNssPBrL
         rZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735929905; x=1736534705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv2LJFwvzdFekdOiLKdjOBtXm3+icKcXY80cmxqTpUg=;
        b=AeQA9UE5Eif2D29dzo7z0DZ3J2BCtqc+X/q/1CNUvh3TCJvEpxbU11bUzGpI1m9cik
         RBvJhR4Y/Gcl3VFzct74bhAganJ2U0XANBlam4wPLQiVYAin0qPrS+n1oHsNh9ZQUrH4
         VhtSj8bbb12N3c/3bvnCEg6tIeRwOn0bQtjZGlpueeK5Lr9OdryCtDDGqXYz7knlUsBn
         ZWm3k1DtD7dBMNcIe+dyvz+dXKuo96e7BGRVMm2ss9SSUdFeI/9ulsv+8mu4H60ExCll
         guMUSA1Dr0+7+UzlSwniQRDHsZ2C74d5mI7d+GR0hFz2nNaoQfRNzEW4YVS44Rk35Fja
         O27Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYI6q8OoMhL346ff7lC4RCL0ZWQBRHUmCu+OIW9KfjRtqzjDU03aS+HkT0qwO9LPnfTHnCOX6Ldx2W+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwjYow5FnljPGoVry/E/tP7S8FxuH11oxFJ5iRO+HEOV04GHn
	PounKF/ybO0pRsgHTcV5LR+rCSjAOl2Rh3+sKHcAqWcA8f6PZGrCJG0D+FTKpyY=
X-Gm-Gg: ASbGncs2A/RMZeoYUWBUlFbRBbH0VL1gutCpgdZm9qftfOZ2c1PYCcgr/HFZHb2pwO8
	sGwcGHDPwlBIUGPlu7v/xPGQZzrxH+s+Nt5Pg9+iLj+xMldDpiS4oK6Nw8W/kK3oHwzUyCRUkte
	GQ9CXA4BqSar+/dvsGxOBg9jQQqW5ks60K9gJJGdp4+EpG6EfHPaY6FZLWaSEOBimX3E2IH1Upo
	2hOc8ccGZDRPdCpM2oiopcM9pZ3+jFQKGOYDVGoBTpfT2V4
X-Google-Smtp-Source: AGHT+IHsZrBLN1RWhsZeipatK91oybhaWrde5A6yKnYBFUk10SSfl5AYNAtf8Q+Y/yy6wggYtbAnXw==
X-Received: by 2002:a17:902:c407:b0:216:4b5a:998b with SMTP id d9443c01a7336-219e6f14fb0mr631230515ad.45.1735929905333;
        Fri, 03 Jan 2025 10:45:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6951sm248655295ad.171.2025.01.03.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 10:45:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, 
 Philipp Hortmann <philipp.g.hortmann@gmail.com>, 
 Geoff Levand <geoff@infradead.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <06988f959ea6885b8bd7fb3b9059dd54bc6bbad7.1735894216.git.geert+renesas@glider.be>
References: <06988f959ea6885b8bd7fb3b9059dd54bc6bbad7.1735894216.git.geert+renesas@glider.be>
Subject: Re: [PATCH] ps3disk: Do not use dev->bounce_size before it is set
Message-Id: <173592990403.170261.3956098234051434369.b4-ty@kernel.dk>
Date: Fri, 03 Jan 2025 11:45:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 03 Jan 2025 09:51:25 +0100, Geert Uytterhoeven wrote:
> dev->bounce_size is only initialized after it is used to set the queue
> limits.  Fix this by using BOUNCE_SIZE instead.
> 
> 

Applied, thanks!

[1/1] ps3disk: Do not use dev->bounce_size before it is set
      commit: c2398e6d5f16e15598d3a37e17107fea477e3f91

Best regards,
-- 
Jens Axboe



