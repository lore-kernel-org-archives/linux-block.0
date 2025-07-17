Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF129CB3A
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753716; cv=none; b=m8VWm2IwIsADPyB0t95ykZZubpBiAwnm34BLM42RLfxBfp2l0CsMBXnp4s/4V1oZMCXkoS/NsfYsvQPRyBiioNbEAsqZySpC0nbZyI8haQrMP8vFK/6Ax5UE2XBTDWMkSrr5YwOt6GbrQ2aeABHKvC96svdEFya5KqB2NHPRLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753716; c=relaxed/simple;
	bh=kjEyn7nEjF8oiVB6GgmGedSuLAr7HCIjBycrDFOZBKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fP6e7N/rGjxt4Noq9A5gqdRJWO55NkqXeO8tNiAwp7uQEBWRC5mDHflpVXWiY3R5BEKL7gUNIfh3mG5DoDsnZw3YCWu+MAc/D56NwIIRkMSm2DInwTslSwEA5kwRVrr7Sbwu9ewbtEllVWPqF6QbGbR1gi8kpqeRZgo9+xS28v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gwAgVBlH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gwAgVBlH"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3df3854e622so5715485ab.1
        for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752753713; x=1753358513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61ZOPEc1Npv0N7lkKyvYLgeXrgu1p1u4u8vtKljsiog=;
        b=gwAgVBlHVddGdAXzMkhgmfDRRtYO4Nzb3OGqynGQZjRMPf1DbQUXszMLglgqndBcqZ
         pS2sM7bMkm7PLrpsxjQWkaugLqf1GlUjebeayRFg3IxDnennguEMowzFx0lch5GU5kd0
         H9I6QIpMGkfMOQOWDacz6KGFg5J9Fqz9o8VAsqmFLHofMVSRN49+HKT1UdL2lXIZunSS
         BX1FMRP65Qgist2k0pFGgoGMywgWszSeCwIf69k/r58XuaqyRbPE4wrpeW4hXK4cHxi+
         Noik0kZ5JzRZR4gBI9K+rwqI88I9re8YjPwd0Rlgwz8Cm1haiQjpQAEuc3brSnHlA7W6
         2wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753713; x=1753358513;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61ZOPEc1Npv0N7lkKyvYLgeXrgu1p1u4u8vtKljsiog=;
        b=fpTJ56LKjRikhLiyhr2lIm7GxnNOF87kd7wos1ApACfUKYgYybPFewJHGTTws/k2HE
         xLpJyRMLNrFbq+kmUW+EST5J8w9ud+7LNwQMhpoLyl9PUl8QSx5lKY3RX/UPwq37bAIE
         LXFpZILMQDG5YDAsDVlMxApeFuyqmayb2jR4tOugRNCZO8dWXKMnlYzTosgmETkCVo/5
         T6fO73JakQOXPyLJIMiu+SRSg1yPx8dI1XlupyCfymyycVBfDGbzzn0c9T2cixc2tybe
         Ft9c2YSbWDIozrEftfRxzcg+JUUUjW9lnI1qZJ9vqMHT5yxBv+qbB4z6aOxN/IOjoc4F
         v+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWnYWIg9bE285B1LmuZHHCoGoZR8mFmaMafAW7WVGpsFPVkqNeNJSYC7z+o2tER1M3yNZ97aMW6F6OeKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1Q33AEpQpa/XFEtFvaBMI5U7dnjgYeDM5zsV81wOdmdQz6up
	Rf0XcZz1AEklB9Q8xzFAtmmpxMS11dvUz8CLcceHYmlYLBkw9oEhXCeceNfk5zjsf3w/J8e+foz
	jKOIX
X-Gm-Gg: ASbGncu3uQfg1DRQhYVCbca7X2an/RYOJY63MIY4RgCF+bmVLgsFdrm/aHbZU3HgXbI
	DtaeZy5VVh3fq5ujQmSs9FuKSYNHixDvISbvig2j45FYnYDvm+8vd7ucNZbjUByrZVtpodMn+0d
	natWLIb+qOR7b5SSdm/JFNWYbGM1/hOVV7HeH3yFfWaVJgLmLL+0e1wdZKSc/mwmb0dIY1/21lh
	e2Jjzr4+8u7UReCwe/H6Us6NmYa54NNN8jewrTR3C8XDSi7cjLxprL66IeKCOHRYqNHorWgoF27
	o80hbGaJIseWzs9Rq9CAmgMUweNek+/VfAZ3GVJJVS8nGG/gPUs1oc5qQLaxTw7g6kJl1Nv42NJ
	bytvFCUeh7PWx/g==
X-Google-Smtp-Source: AGHT+IGuqUVz1MlM22DWouaSIEqVc7JUz/swP0ZPOQK4pvQiO3B+o4V938h5qOKiQPbhSq72i+cb3A==
X-Received: by 2002:a05:6e02:4618:b0:3df:e7d:fda8 with SMTP id e9e14a558f8ab-3e28b718bcamr29664265ab.1.1752753712400;
        Thu, 17 Jul 2025 05:01:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24611ce92sm49563745ab.6.2025.07.17.05.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:01:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
 song@kernel.org, yukuai3@huawei.com, hch@lst.de, nilay@linux.ibm.com, 
 cem@kernel.org, John Garry <john.g.garry@oracle.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-raid@vger.kernel.org, linux-block@vger.kernel.org, 
 ojaswin@linux.ibm.com, martin.petersen@oracle.com, 
 akpm@linux-foundation.org, linux-xfs@vger.kernel.org, djwong@kernel.org, 
 dlemoal@kernel.org
In-Reply-To: <20250711105258.3135198-1-john.g.garry@oracle.com>
References: <20250711105258.3135198-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v7 0/6] block/md/dm: set chunk_sectors from stacked dev
 stripe size
Message-Id: <175275371113.371765.7347642796595215334.b4-ty@kernel.dk>
Date: Thu, 17 Jul 2025 06:01:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 11 Jul 2025 10:52:52 +0000, John Garry wrote:
> This value in io_min is used to configure any atomic write limit for the
> stacked device. The idea is that the atomic write unit max is a
> power-of-2 factor of the stripe size, and the stripe size is available
> in io_min.
> 
> Using io_min causes issues, as:
> a. it may be mutated
> b. the check for io_min being set for determining if we are dealing with
> a striped device is hard to get right, as reported in [0].
> 
> [...]

Applied, thanks!

[1/6] ilog2: add max_pow_of_two_factor()
      commit: 6381061d82141909c382811978ccdd7566698bca
[2/6] block: sanitize chunk_sectors for atomic write limits
      commit: 1de67e8e28fc47d71ee06ffa0185da549b378ffb
[3/6] md/raid0: set chunk_sectors limit
      commit: 4b8beba60d324d259f5a1d1923aea2c205d17ebc
[4/6] md/raid10: set chunk_sectors limit
      commit: 7ef50c4c6a9c36fa3ea6f1681a80c0bf9a797345
[5/6] dm-stripe: limit chunk_sectors to the stripe size
      commit: 5fb9d4341b782a80eefa0dc1664d131ac3c8885d
[6/6] block: use chunk_sectors when evaluating stacked atomic write limits
      commit: 63d092d1c1b1f773232c67c87debe557aab5aca0

Best regards,
-- 
Jens Axboe



