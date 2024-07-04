Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83E10A35
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080507; cv=none; b=cstj9ewErHn6muMoJXFBqFrui0GtesfxZlmAxMFtLeKqg77eZvsaLFkH6ZgD5OThNQWOe1Zj+B7Cbegwx+7GUtqmyxglNGkEA2XGkKOOVzA/k2f/UZzlkU9HtEhNpCnrnfiJEqyYERl4L8zOPUfmJyNWcdI0mWJJvu6hq67vwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080507; c=relaxed/simple;
	bh=BshQcbntkNXYGIK1LcKAFc8gWaLsTD55X9vgYrchokI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aTmaemLf0BUtM4avPOWvG/9T8Vjiff7MUI0mbL1GFQT1rQKsTMvIc5wU9334g94jVS/Ge81dJ8cLd6ksRnM4LH9Y4FyVbhSFfVRQr0C6ac1hJP11ssvcJjOw9fxJif7ACrYxnMojEY3ehj0oR3yndYFJ5XQALH3Gs2q2OFK2Ebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DvilG2rt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DvilG2rt"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ca9e52d5dso16363e87.1
        for <linux-block@vger.kernel.org>; Thu, 04 Jul 2024 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720080503; x=1720685303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTHosFLazGettRHv3qdXpEs7kGPmNppu3rNrlNRRK4Q=;
        b=DvilG2rtzcm/oLJ6L0fAFFsxZonadxc8zy5TObDMkxPCynEPivyHBmmrl1KEA2xtFE
         n+q6027KsKZ8HFh9Byh1KXGGPHOuGDLtNqlmkTunnsdYtrQEq7hBlilC9QEVV02cwkTo
         a+ljiHlAj0Uwn1sCshl383wdtETM0fTl3y3E/3g4Z+2ADJF08p5u0ynlKiKocS+UPfTq
         Wg5V/hL61NNmGxfn6BqYTDvtNTAgU0ye5frkuruiuHdPWXOw4najHPUlXsTyte3cNuth
         f9dggKUZMJkxnjqI4KQxr7LF09tQHuKqkn+HJxSoYPFysmuP1iRpzyE+rlZOOEFpBPRK
         lEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080503; x=1720685303;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTHosFLazGettRHv3qdXpEs7kGPmNppu3rNrlNRRK4Q=;
        b=pLBfmIZgb0PgWzACDdKPHrBaZN5lxW5Vmu/T1AMnCf4PD13UuFQNI++DFtXfDUSaRR
         UDND6uitW5HIm/wx20th0rDLaewDdW3ZvUjF0I176AXp97ZSk3mjt0Z6VDb4eP1qsxAJ
         kDvFKkwSamZCxzavjLjS1j0lK1YrnboH6PKWlL4OQU2heV2Zhb35N/HCmIvO60ZPEFey
         Pg7FGIvcvab8G//j7lrz+h1settel4AKTnpTZQHAoqnDDp/WgbudvvHSKVfwVS8rUyAB
         ykbh+fcN/q3RuEcTcLdrWF+XWl+LaFEEaeZ+B8CqlOkNFApP9yE5DEzbuOnWthW28Rz3
         ZDJw==
X-Gm-Message-State: AOJu0Yx87EjCiji6Ypyp6aqh21HJQeuOvhm1D3ausmjbRKoKsfc9UgGI
	SC1oW4i46vIFgK010sK0pH2jpKNyL0+6oQRLHq/R+M5YrFpcnBOA+Bu0dOZkQ9M=
X-Google-Smtp-Source: AGHT+IG4NaeJUE4vulrAWNhBsEtWPA/M3mrykfR/zQDU7wAu5eLQfeLOKBkdgLNbvn1OKdnP11X17g==
X-Received: by 2002:ac2:4ec9:0:b0:52c:d5a5:bf7 with SMTP id 2adb3069b0e04-52ea073559amr514041e87.4.1720080503131;
        Thu, 04 Jul 2024 01:08:23 -0700 (PDT)
Received: from [127.0.0.1] ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58ebce189d0sm136568a12.97.2024.07.04.01.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 01:08:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, martin.petersen@oracle.com, joshi.k@samsung.com, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240702100753.2168-1-anuj20.g@samsung.com>
References: <CGME20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82@epcas5p3.samsung.com>
 <20240702100753.2168-1-anuj20.g@samsung.com>
Subject: Re: [PATCH] block: reuse original bio_vec array for integrity
 during clone
Message-Id: <172008050214.235840.17221556301175180464.b4-ty@kernel.dk>
Date: Thu, 04 Jul 2024 02:08:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 02 Jul 2024 15:37:53 +0530, Anuj Gupta wrote:
> Modify bio_integrity_clone to reuse the original bvec array instead of
> allocating and copying it, similar to how bio data path is cloned.
> 
> 

Applied, thanks!

[1/1] block: reuse original bio_vec array for integrity during clone
      commit: ba942238056584efd3adc278a76592258d500918

Best regards,
-- 
Jens Axboe



