Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B061C84D6
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654144; cv=none; b=RJSJSs00BRFREOZTFeFu9k7PcU3Vc1quPkhC+LScHzXMDsv6Q0ETvo4eWrgykEnWUfhq3A7YYLad1Cpf2dYxkHvYaQMOWmG00ZoqCbFVnuxZ6B1zXg/09wllozhLbCsELkLPOi3wkV05ClTlUgE075BghA+uAr8JaYywbliNVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654144; c=relaxed/simple;
	bh=k6236Dt/yPGjo9m2CbNYVS6lkTaV755h5B7f0kC4/wo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O5QE9r2csbpceq3hBOW4SBOsc2jeIkF2Z+nLPpQQIxCnKJ7enW3NVpmvB9J976XJGtevlfVEIFsqKpsH4pDJSifKiMJY9nORS89fJCPo5iw+NEXr5Y7gdk7nRcP/xznDxFbfQ2oy0dkgCieSyrIz9UqrfM+AIO7LjVlctKJTmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FVNjvPwq; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FVNjvPwq"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so278371239f.1
        for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742654140; x=1743258940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVHiOLKjS8gAzD0KhvXUDhux34IGCM/8O5KjdTVINxY=;
        b=FVNjvPwqnjiwM2OG6SQRHuQSDgU/HNE53I2PBrYskPW+iIn49TxyYmwDr69Oep1PkK
         1tM+6iilQGPtyxPxc7mNYVntoBkjJgru9yY0bi7YLUBxap3jKKDwOxQD6Y+eFs083xyt
         zkJpZpmJXMqvO4b/u/qhUsy8EQn997ks78OoeZytYIXpT/SWY3dYclLVnE6gkhyN09gA
         gAn3Lb9VG5EspJh4sqRNdj9LMKaQUgMtwxmuPpvTQaylzoxNV6bJbOzAogURP5OFGzOk
         ecUaAmddzY7kVRDcPh8aN2UhmcIS9KleygmKz1B9mw+CBCc4oIxXi4W79DOxQrYkm3fB
         PT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742654140; x=1743258940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVHiOLKjS8gAzD0KhvXUDhux34IGCM/8O5KjdTVINxY=;
        b=EjmqfOLchX8YNAePzSer04IsJ5K1Rss2eAxU9+2dpAnjn+hMw7D2caqiTDaYk9Ex55
         s6om9YRNZ6clPKcE6LMEZbYVFKbV3fYEkFwJzjJXD/diaC7O0V89HmD7wRi5z7xUq/3Y
         VhBQ7JpbKctKKdOzcikKSd2kcTQNKek2yskwrmhUrsCMeWKHUXlaex18qAK9OYAWWcm6
         0/hl2s8tQ4kdb5U0lh2PnvjiyytCJqOGeMAI2oHBBr2Dq56Ino1RlZh6zrVGEskoXpB8
         JkyMUja0slotXWYk79FII25Q+pFd8JaGlGuImV//CYaMhDyqa8WXK+7Z2EYG8k/6dg0z
         6enQ==
X-Gm-Message-State: AOJu0Yz7kdUNXr7qFn3R770HS3BNbRaNYwGcEuKSEvdt821KnI6JyNk2
	AaG2d24MDJi31QXFsq949NSj0LS8gLY5U5r31Mel3W09zuXxDHpGpHwfWe/MjVjdW6S3pMuoQux
	e
X-Gm-Gg: ASbGncvsoq8MLT+Soix4S/sQpaP7qwMJKZOFa4I0N45iFad65RePIvtFz4Nr/s+3DDu
	DZShPZb+uEhnq5K/8LJ/hit/2qFdGgT0T9ThI20G5yCRClUrc7RD7ZSK7nJ71k1hDO7NnRo15O3
	ZXp77tdBmax6DyqygtPnxZutTediPJimOTbBAIkZvKigiN1J1DF04KRzmeb4TOVs9eloBrxsYaV
	e8/I8YiDR2432KirbD06bp2krSs1lQ33qhJ9pCtaR+mLrAgP32wUlhEI9ONos3KnoyblbSLMbAB
	sokJ0DBLknm3MUxUb6aDMB5r39oWjEEbtlCm
X-Google-Smtp-Source: AGHT+IH0CUYr+ixazksbvYUCETYet76ipw7Qs7DnvenUCPM5LYwd+OgWJYyV7X0ytQD1priAAJb+dg==
X-Received: by 2002:a05:6602:3785:b0:85b:427c:de6d with SMTP id ca18e2360f4ac-85e2ca2d11bmr810413639f.1.1742654140411;
        Sat, 22 Mar 2025 07:35:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc273acsm85798139f.16.2025.03.22.07.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 07:35:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/8] selftests: ublk: cleanup & more tests
Message-Id: <174265413883.771654.586800661826225918.b4-ty@kernel.dk>
Date: Sat, 22 Mar 2025 08:35:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Sat, 22 Mar 2025 17:32:08 +0800, Ming Lei wrote:
> The 1st patch adds generic_01.sh for checking if IO is dispatched in order.
> 
> The 2nd ~ 7th patches clean up and simplify target implementation, add zc
> for for null, which is useful for evaluating/comparing perf.
> 
> The 8th patch adds ublk/stripe target and two tests, which will be useful
> for verifying multiple IOs aiming at same fixed kernel buffer, also can
> be used for verifying vectored fixed kernel buffer in future if this
> feature can be supported.
> 
> [...]

Applied, thanks!

[1/8] selftests: ublk: add generic_01 for verifying sequential IO order
      commit: 723977cab4c0fdcf5ba08da9e30a6ad72efa2464
[2/8] selftests: ublk: add single sqe allocator helper
      commit: f2639ed11e256b957690e241bb04ec9912367d60
[3/8] selftests: ublk: increase max buffer size to 1MB
      commit: 9413c0ca8e455efb16b81f2c99061f6eb3d38281
[4/8] selftests: ublk: move common code into common.c
      commit: 10d962dae2f6b4a7d86579cc6fe9d8987117fa8f
[5/8] selftests: ublk: prepare for supporting stripe target
      commit: 8842b72a821d4cd49281fa096c35f9fa630ec981
[6/8] selftests: ublk: enable zero copy for null target
      commit: 8cb9b971e2b6103c72faf765f64239f86ec9328f
[7/8] selftests: ublk: simplify loop io completion
      commit: 263846eb431f31ca3f38846c374377b732abb26e
[8/8] selftests: ublk: add stripe target
      commit: 0f3ebf2d4bc0296c61543b2a729151d89c60e1ec

Best regards,
-- 
Jens Axboe



