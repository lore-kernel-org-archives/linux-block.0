Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122EA31355C
	for <linux-block@vger.kernel.org>; Sat,  4 Apr 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311864; cv=none; b=cbDvhPaXG2zz1iiIq/GftbJ7Up50PTdw7yCxVp+I7JzdI7xfA5prEJlLhr+yRH6kBn1g/OmmtZs7ZQ4brRmBR+lb2cXJCk/w76zunepIGatpvluyJijWByplukimBv+2fxzvHgWdtbRYyS73yJSFbGUjoGpX3ymzuWDdc5iQRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311864; c=relaxed/simple;
	bh=spz72TNyVzuARz1v7/8+WimEzFSAVemGRU6xEybVZoM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CYVvBRPEGSI4Q13baP+wFIla5ahVCoU8bsw454RPV765OV/93WmAoSJsvsksIICwnLUvIu/sy/mqOZWhsHX4B+CiTBMGy0/HboRYqF8W86dBE+F7BzVJcAU+YtZ8cXVLJcjMG0fZwMVfcd4rjg01BkZIa6V5CHrCDhx4fDCLuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=wSfdZd3U; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="wSfdZd3U"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-41576c5c01cso1591235fac.3
        for <linux-block@vger.kernel.org>; Sat, 04 Apr 2026 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775311861; x=1775916661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMpqATzeWlymwazTHSINSS3VWIrM0cUtbgSM45lgODg=;
        b=wSfdZd3U1WNWjFJ+QkruzEyFZtS1VmyYBh/lq44InI/aO4+AGogFDMiNx3Xz+QkTBB
         mc+Az42gZQ0bCz0tHDA3Ly5ePRak+wR5TZ+Sp6tEvSKU/Maf7eWpHGppyhpiuvymwCrD
         ff1r5+mYa/4CcrdPENcJ3s9iOd+Xogl5ADtdLq1VW7ESgfoceT+dAv/UoKP7ZSNowNBc
         aBrJAlMgVd74pyix0k/DIvYZCaIkiqsMB66HHrv8Wupw2WzE4p12TgvgeqHIiIedOL0S
         yjCkYxmwg5hEciMBXcSQ2J7rFD4mbeVZ1yVE20vN37v+Au+tQn7p0zI+1tZVvpOsQZ34
         iJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775311861; x=1775916661;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMpqATzeWlymwazTHSINSS3VWIrM0cUtbgSM45lgODg=;
        b=QLyH4dkIc0dfGec773EEAMJbdloc1PnKFFkA5XJ8hpRADpe8JGak0THWgLMobWW2Y4
         CRV+317+4P50eVNYOByWBB4Yc4Mu3ZG93JIKu+njD1N33IESEFIOMJK5Bz94Lr9WQXJs
         1R6zJxbiRx/iH+dkLBi4X9BjgUNC3JAHnvDIKnwl+6NuRMKu9977X5UniyXDB1v5FqPJ
         YUFibL+Uh7gCfhjLS31mAS/jsWIt+lvzbVsXNhVVsh7art6LZ6KFHA4GWzdC7sT5LpTf
         ElXAfnE+NK6BH62EYG+Y2pqhpJIefq56xInt14cIC6/KjSTxnIzZIjRKaxE2hyHjh3xs
         WxmA==
X-Gm-Message-State: AOJu0Yzf5AgM14Wk/1aL3AKAYB/fdqOPDpJ/v53xyss5/qAVJ5Zvt7yh
	gEge+jRVq9KBfNP2QlZ5E3LLqbOe92SKHcU5epxyeEEzntCAjGxQ2g1Zz84PZvBsef4=
X-Gm-Gg: AeBDieu8njOzMGnlofeJxo4U3t06+j18WyDSJYXL0OoamDIuhFvAhP8Asxhe8QqFk3X
	PWTl/PwrCiXdJQkSHFXOlkj6UvyjjXID0kbePEfw3BrGbfeKeVLVh45D7T18HWhWiYSTmkxlGF2
	+pJyr1sOMe9Lz+g3959XhRtNEtzEmzspSdG2xQar8cdmOS/DZ1HvnS92OJOg7C94feOFW5bQmkP
	qTO33Dfa6suDmt0EMi6S6lc6FBdE/EZ4QKNOiKm1pmNJA5DS93DtltyIXhxawVdYepaXR+uUUP3
	bz53yL0pn7NUb3VxOinpOp2CETmBP4lnqVLPtkxKCRFyqiV/OPfApoQdEhtah5JFJHrXGG4y5ny
	kvhiw9DQEapy524rR/Ab35vqBcKArhRQozW97ckf5YEuHDjoOezCmhFZXyaPbnG780NBncHxzmD
	UPZIeSDl/PxbAn0dkTdsiuFW3L/aAWQ6OKxRlRb3PhAHWPdVLTE+U5fR2s2SuY/Gc9LEO4FycxL
	tjt
X-Received: by 2002:a05:6870:294:b0:417:7b1d:19c with SMTP id 586e51a60fabf-423100ab2c0mr3513815fac.37.1775311860794;
        Sat, 04 Apr 2026 07:11:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c6abesm6844452fac.14.2026.04.04.07.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 07:10:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260403184852.2140919-1-csander@purestorage.com>
References: <20260403184852.2140919-1-csander@purestorage.com>
Subject: Re: [PATCH] bdev: remove unused BVEC_ITER_ALL_INIT
Message-Id: <177531185948.25414.4499001276542898401.b4-ty@b4>
Date: Sat, 04 Apr 2026 08:10:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Fri, 03 Apr 2026 12:48:51 -0600, Caleb Sander Mateos wrote:
> This macro no longer has any users, so remove it.

Applied, thanks!

[1/1] bdev: remove unused BVEC_ITER_ALL_INIT
      commit: 8b155f2e4a91f3507951e6ace4b413688ac28b96

Best regards,
-- 
Jens Axboe



