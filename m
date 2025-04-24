Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8E43146
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501555; cv=none; b=WkGh5tJe5NwqZFy2gBlL0rqetgnGLgxP8OKgn7M0OAF5mDfvYJN+A19+C2DRnKFiqg9A35QVXwKHZzUGBvxmL3QHnGSyPkK7zg3MWAzeufBu9MfS65qm7C88dT/h+oGgGsF6rwO93yOvHxpRJFo2oIePyzVkxQZK+nLTwnJP5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501555; c=relaxed/simple;
	bh=9Pes+HFfjTx+aWeU3Ug+lxiJazTJM7vd6I5bpka3f/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AKMyds1mMRWJOXugWoXZYiTjSQt7E7LXP8EZNPAWiZwS1GTtbWpqPdGngJZ24JDJ4kS5UMNIwcbOJI8Y/Sh7YH8nKmgCmPWJm3NNGFR8xnnurxDEM6F6jFyaPAwxw8Bur49Ga3sdAuxbgzam0oM+YE0qCyxMfkt/bB5TZDXzd1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=igPUAr6i; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="igPUAr6i"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85e15dc8035so35192739f.0
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745501551; x=1746106351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChPc153/Ue0vh+ZUNhFsJPP4Dkg3KNnQf39LzkHyXJI=;
        b=igPUAr6iVxCQtRPd5U32Zrryj3VLV8z1VkE3Wnh2eZER8vCPv2suUn1pMmE66zmTks
         r1vzKxfmSOq49ituIxEeiF8eoGEye8TL5J8aCIezc2YU6mUX+OegK6wsdBc8EmTaLa4Q
         LS6eDiOXEkBSZHz+s/wHSifANkzNfT77kXav3vXaiQIPqXGsRDk3pyTpIIfQQHpXjrSl
         PsOfltkJxeghP2om2OqSwD1So4s72724p7Cq0TqxSGC6KaIFHorq1O3aqpZWZ4mmg1z+
         MFkJPCxcdvnXc+K43Z7GY+0pWQH6I5QuqxS4ebJlpv7ZDvSA65Iudvpu3zsAaqo+/8Qa
         d1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501551; x=1746106351;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChPc153/Ue0vh+ZUNhFsJPP4Dkg3KNnQf39LzkHyXJI=;
        b=otifchHWpuFqFwwxfqQUmYs8nRKvEvP/vWwCvwXCSRPHLxHnrksPS3XD0/9DDIzjuZ
         n3lVIUAO49YgMl6fwCZWpXVQtlR9cViKE97hBtt4o8Rj5UKvOfZOvrb81fr3GYnklysl
         gpiasJsGH4eDdyNgo3XbTIv1/5FPUFdu+C0M92x6eneE5mTfdIw9yMPQKxZ7Z6IEktcg
         0m/y/euR7TvFlyMW7J2ghMNbdYpKtO13haN/C0xkqZQd97G8oVFAUCgU7tLr3votg4FJ
         AlnWsGJLE/RZoQVpi5kMgYHqqdXAnJ+8UgAERPyKNlECTTYm4tTLorPBxhkWYhcDFKuf
         Yuzg==
X-Gm-Message-State: AOJu0YyeFOgq3WxgK34pCeth2J/YKBK2dEXMz+NzApNr6HOj12rd0Zfg
	xA7QwrG6vNoLFxWhn0uuVpRWaBz3k/0IwqxKYUkhdG+ndtgprSHJCricoCpE0Lh20vhyLqJRkC0
	l
X-Gm-Gg: ASbGnctnJlAMxz+ys7TPiM5LU2HQl7yKqpl7VHyLIWz0xWyPZi+1tWkLUCNOg4ahOmD
	0M3DAbCanedhlBc4QqUt8EWpgXkAEuJqhvwEojmwGE62CRvKXCylo3PCKIEXe6yuxeKVY0Vg4t0
	dgEMYERpQjHyuWxePe+58E8KDye7iOxz9T9w7yz6+zS40lZUKGU8g20a3om4loe4TqCPbb7pIA3
	OgNkQkWm8Kpc1c5ApgMarbpDz5txLArgZG/aQvksrRgcvFWAYnkqQs5voV3jdxlJXWqKUyXCvCl
	lfOBLp5RkSpqz53ot/S05AYc1uqJNU0=
X-Google-Smtp-Source: AGHT+IFvxy18rgWsXoEf6L02qIK3qlKJRZvDGAoM+Z5s69C0Q5lNtzzn39YRy6V3EDiD1F7r8+pzcg==
X-Received: by 2002:a05:6602:6414:b0:85e:a8db:fa10 with SMTP id ca18e2360f4ac-8644f973f37mr282545739f.1.1745501550704;
        Thu, 24 Apr 2025 06:32:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a3bab1sm274941173.36.2025.04.24.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:32:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, 
 =?utf-8?q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
In-Reply-To: <20250424082521.1967286-1-hch@lst.de>
References: <20250424082521.1967286-1-hch@lst.de>
Subject: Re: [PATCH] block: never reduce ra_pages in blk_apply_bdi_limits
Message-Id: <174550154991.655590.32611122624973762.b4-ty@kernel.dk>
Date: Thu, 24 Apr 2025 07:32:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 24 Apr 2025 10:25:21 +0200, Christoph Hellwig wrote:
> When the user increased the read-ahead size through sysfs this value
> currently get lost if the device is reprobe, including on a resume
> from suspend.
> 
> As there is no hardware limitation for the read-ahead size there is
> no real need to reset it or track a separate hardware limitation
> like for max_sectors.
> 
> [...]

Applied, thanks!

[1/1] block: never reduce ra_pages in blk_apply_bdi_limits
      commit: 7b720c720253e2070459420b2628a7b9ee6733b3

Best regards,
-- 
Jens Axboe



