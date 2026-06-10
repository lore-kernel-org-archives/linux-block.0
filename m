Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9B40683F
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094543; cv=none; b=tHziSWV3bfYSJ9E0MRTchJxwa0V4/+Es7OCssvE/0SarbXN72wUhI5QUnLg+rzSJFAtLyC4bJGu6pEVrbiw8/MB4k4OunY/kJG6gy0Nf8TASLqs/fw/LKbj3cYK2lZRIm8iJCMIT22AHH+MZuTzc0vCjFtjFSXc7sjpFn6NMkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094543; c=relaxed/simple;
	bh=JoveUkI+WKEwQ/8vCqen9LFnrXZeoQY8Z9FDkkM1FD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nK67aI+gFCA/3h9dS6v2mzUz/07b1RVwWcJ3qI1WJZwTrIBECc+F9+aEiPQEBN2/kFm69DmdJ4MCuxHMh/78wh1UcGIeRUEZ8Vx45RP1/Et0QIo9RFBIwqTQP3oT2sYzkxoEek06ZX7het/EcR9CNbmyEt0w/xX8zxuwPNXfqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=TpUDbs5Q; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="TpUDbs5Q"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6f27619e7so5444389a34.2
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781094540; x=1781699340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HbS5xJ+zEKVGkIwXNCxI+D4pex6gm+V8nskCVgqWvY=;
        b=TpUDbs5QG3SCazJBwajjCMQgHikh1RGStvzwTMdK0R9fwYTv6gOQvUsOCzlOZmQzfu
         L1IyKiDqwpKlW4981+VzVqCplewJE7cFwJcXAoTC6eMBjbpEJyf/vKa4GVBwxATdTkgV
         ADgM06QSPMx+IStuBDH1xbaks36uB7+AHTJsKVdQS6MYCm2zeQGTBdPxnJ/IrzxmK4fp
         ufOez1yF7l1PrlFABmMVaERq2nOmRNV0F90vfGiZYKkxKRFpXRHEZ6F/zuQY+dylyNQK
         HwkUP4gH27TwxQrBuArg9w6eW+s6YmnK+CAk1kqfa64TjIZ5fn1/X12BHSX9IUDKVmnm
         LKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094540; x=1781699340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HbS5xJ+zEKVGkIwXNCxI+D4pex6gm+V8nskCVgqWvY=;
        b=c0GmPGhs7plsX+ll0u2Nh02HJ3A/nxtI92YelQhSExmM6mdfTre5yjwpXnENwEqDVs
         AJ6yDyVpga7IbSnjyNOg6qt6kWguVEu7ZV7ZLm3KxpzOzYR3YaUSlAtEchNFUC1KYOek
         2BjoXvKk7dbW/AyisaS17AbO0Rj53uTS/LYQgYLmMbA2K+UK8IVgEnqiGBDu2QQ9woF1
         f+hOjsPMwBvtG+5uFz2AMpd7LXSaJdI5MMcWgksQ9YV9+g7NGGfQwBJxmbJypHL7DvtD
         KqmcDxMbeKqzdJo3UzMj+mFbMkst5bd3BJcqPU6NCbUW3Ck8rZE54XVSLOmClu782+Yi
         iP2g==
X-Gm-Message-State: AOJu0Yx+kiziH90Y5wjwUAt64FAHsI5AhmyKhZVIPRa8Q2v5Ck2NwJMA
	dD3PupWgzLAy8D3l/ymkRiDPM3gUVGt1uEn4IItIHE7rF6adlAKgh1ssYHBvPXJeN7jDmjWqOzW
	rGa0f
X-Gm-Gg: Acq92OFa/4vBBNCSvn+usl0E/0696R/ddKT+2Qk/EhWX9Xv1G1qBUuC/WMGFYeM9B5V
	SGGzypu31yVaEgm+4hhZSunS3KRMKoZWpnMis9T0paOGyiAHpFoJI3KHqE4l7crkz/SGJjzWyhG
	GHqLiUBtmWl28sEdqUgsseyJ9aM8HFBY6YLsri9KJp8QQspXUIM774ZWR0ejia+U8rHBd1sHrF1
	ms3a+e3IfGtC1py+ppwZUjA2pvUR1YHeBdQsTK7XMCYqXreMxN2AKlNrHbD14J2lTPWnmxOZaaT
	QrqWQUxFLLS537Ho1gNBawRiAgNm+AFjBWUpTKmzSee44fstc7zFfsDJ4Da9ISdKgUt6brhzLMt
	SL2rawO9SecWgaMaro+6UfBYZ+/ez9H2x76ji4LenHmbqTZAtHMmXdcpoWUYXC1d6N1PM+/eqz7
	GpVVNsdyiATmKzBB5v738Jtu8AFcQXTSh0D3stEllCxaAipilcmmOGbmRhpBGpyHfG+2CKIDvKB
	p10r9J+BmpKUF8=
X-Received: by 2002:a05:6830:4425:b0:7e6:ff83:4b46 with SMTP id 46e09a7af769-7e70ca5c621mr18185246a34.23.1781094539891;
        Wed, 10 Jun 2026 05:28:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7468f8fsm16754420a34.6.2026.06.10.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:28:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <99dbf851ffb99229ea1dcfd8f58e9ee6a1f05349.1781075967.git.u.kleine-koenig@baylibre.com>
References: <99dbf851ffb99229ea1dcfd8f58e9ee6a1f05349.1781075967.git.u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1] floppy: Drop unused pnp driver data
Message-Id: <178109453910.1314590.5313361314352740217.b4-ty@b4>
Date: Wed, 10 Jun 2026 06:28:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 10 Jun 2026 09:27:55 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The pnp_device_id array is only used for module data to support
> auto-loading the floppy module. So the .driver_data member is unused and
> this assignment can be dropped.
> 
> While touching that array, align the coding style to what is used most
> for these.
> 
> [...]

Applied, thanks!

[1/1] floppy: Drop unused pnp driver data
      commit: 64e335790272d9b0468af3a70e34f377924b156f

Best regards,
-- 
Jens Axboe



