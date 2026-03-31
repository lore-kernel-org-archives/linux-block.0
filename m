Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793B331203
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987020; cv=none; b=NYmrSngNuKqjMQ9/0KFQ1GlkMTLmOGKu77+QLtnHE2xR8eptqOCxsWxH+Dw0GblbK3FPRAoQeOwUYGZ9CqE3zeZyUCvfd9CDQBb4btNbTp9Rz6cIjz6+727XX+tFcyDVNt8Lce9iy4aNThCc3LoA7/WCrGI1HNOgES9x/7GR7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987020; c=relaxed/simple;
	bh=VTzvTtXw9O3a7Ncm00wfZnRJmSE/UFChHeLAcBxav1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GKXsdMZPOq/dKrozlcPm8e8ZPQZkJY3W3DveTwnwM7yVS3waMKFAO0staj8DlgOtriSifJcVV5/3uejNCEqslbbIHWfj5ZMzZPZKNN5Db0DE3wy8jjb1v8MfB2gnNBAnfRxGriDU1AUSXOEUvO25x4cd+hp+WxBeprTsD9nCLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H3ZjUOQZ; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H3ZjUOQZ"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so2561614fac.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774987017; x=1775591817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rDDb+e5vufvBziWDb34wMohzuO8IwsVxGEyjZ/xAZk=;
        b=H3ZjUOQZDJ70k+VfVcJH/3fJVGKv+lDY0dG+zCfFuFSN0CqzniVZfYb9jbG+Y4PGlM
         lhcTJ4eOvIyN1p3roJvDNOnEirhB4JRx6H76nIX4ENHPB93tCJ+Q+C2lGLomjg9tZ1ry
         A8Ulw6M1g9ENH6YDXgpxDDHiu7qEDW5GrlEK8X1Y3OmcTUoldIdRcWM5ROIsvsbNq6VQ
         NmUVwcO3M0iXa+nuaDYRG4cbX3FCZFCHqjeDBdXmAoYSuFd7g3o+9aBjXUBk9IA/J1W6
         sOuYRqRFeQDxRkk6RzhbPv3SCflAIWw5FOZKxbd228r4sVmhb5mc+T7lazFwrpDJM1wX
         vf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987017; x=1775591817;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9rDDb+e5vufvBziWDb34wMohzuO8IwsVxGEyjZ/xAZk=;
        b=adi9OlWojXCv+r7UdEaeDOuOv1+AMhev6fPjIrkuBiAajaHM35wcaYtVQEXg7iQFei
         yi7TmcGfCLf03Pc0C5Vm2LlGHWJEcC2zUQU44u0wctdzwQar+Oj3RmVaIrxtml6Xhqky
         6wFYIaMIh3YHZZdtaCD3CzhSQwYA9uU1Fu8KF5ACtZIYX3NEmibKJ3XOQzVmWoX5Xe9a
         luiq83yVgxP4U7kVOR6OD9sSEEIFX9BAFfts5PGG1wNvrXEwkLL7Gtn8mTMbVH3TVhkr
         Met/F3M2xihEqup13XsrdbQE9QaNqxrgjb8cDKBQTR7pNTGRgF849ySOXZFDRAalQNOZ
         Wufw==
X-Forwarded-Encrypted: i=1; AJvYcCWab+aHlRHmMtJqT7mz5VW1QYg94OOsW92R98XMhRyiV6XaG5pSXHLc9b/GlXL5jk4D6jbO+MBMBRdM9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOiQF1f84jjSMyb3o381x3q7AJJ+eCutyoHd5JcnyUAp1Rx03
	qx2FF8Ja4v0Sb3/uni7deHPo1wAuk6g3P9ix98qCWicJvM+vjSkbEh3B5gD2jfYZNws=
X-Gm-Gg: ATEYQzxoIVXBkVQtBtVUNkEzu0CGqFe0koG9j8FRaKrq2m8dqn7h3pFNlPwJuVgRyEI
	4EYF9lUROrOdZyylyRajtBNpfbj16kfxjDXZaGgK7wO0TDmJIyacmiMzZFzNr4VeNxgC39Gfot/
	41fF3qbeRz4HsLrdF8hpmBfS8x0bzYo2q3jNx9hkYNE9dBZIgpbg5rLMt2YX4SaCX7qP09v4zeS
	tsBoKEuelAmdNu4h9+OCE+1kCCEC2lPs+03aOfLxpII2fJpsaaAH3q/rKXVc02UyOV9MSzuIxU3
	c/ChmizMI9JCxOF1o1SitaqfWHMx3wJtdaYCUm2CT5Q3n3LIL1cJM/WyfdF+Nytt4qy9+K/d1DT
	b6cidxBv9MUHnPpgAIbPAnPCHZFwow3zunk2lIIVKYl+64WQr3j29hdmiOUgTBK4twLodpcEVu0
	zfba5iRooXrdoU7sacmRmzBDGyODqTTQ24Nxtd5KGGWiY8Jjy8J2bMtBnktsvmpCGMspsKSORWk
	Kw=
X-Received: by 2002:a05:6870:350d:b0:41c:c022:c180 with SMTP id 586e51a60fabf-422d0001018mr597860fac.47.1774987017392;
        Tue, 31 Mar 2026 12:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04c87973sm7780779fac.10.2026.03.31.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 12:56:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jialin Wang <wjl.linux@gmail.com>
Cc: cgroups@vger.kernel.org, josef@toxicpanda.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org
In-Reply-To: <20260331100509.182882-1-wjl.linux@gmail.com>
References: <20260331100509.182882-1-wjl.linux@gmail.com>
Subject: Re: [PATCH v3] blk-iocost: fix busy_level reset when no IOs
 complete
Message-Id: <177498701654.21640.6294974532543984458.b4-ty@b4>
Date: Tue, 31 Mar 2026 13:56:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Tue, 31 Mar 2026 10:05:09 +0000, Jialin Wang wrote:
> When a disk is saturated, it is common for no IOs to complete within a
> timer period. Currently, in this case, rq_wait_pct and missed_ppm are
> calculated as 0, the iocost incorrectly interprets this as meeting QoS
> targets and resets busy_level to 0.
> 
> This reset prevents busy_level from reaching the threshold (4) needed
> to reduce vrate. On certain cloud storage, such as Azure Premium SSD,
> we observed that iocost may fail to reduce vrate for tens of seconds
> during saturation, failing to mitigate noisy neighbor issues.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: fix busy_level reset when no IOs complete
      commit: f91ffe89b2016d280995a9c28d73288b02d83615

Best regards,
-- 
Jens Axboe



