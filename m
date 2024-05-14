Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD351448C0
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702902; cv=none; b=kvD6HF8ZejyFzu8L87x5c91lyRI2PFt8CGFqwT2rwYAi+XhCane/RI5TaOVeZWbyt4JGQ1IMUsj2m0pjlapAazoo85ScNQbtgYySuRGvRq7sZ9PX6/6+69/qb++UjYJKTk4PVz0C1z7vOedJEFwvVBH81CaCbNh1ARhAR64ObNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702902; c=relaxed/simple;
	bh=TALiqw+2bRnrQzNIioqE2dReB/lq0tUTzpan2VON0GE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AosUqCLAMl+SG/cBv0AJ/K1xCuYaNLy39InSbkX54635nnRl/dmvgsOc1sUt8JzZE1EoE+inDJ+dj7jmfhYfLBBGx+A5q/KJWcy29QbrMw4ODI8MW+0auI+dlbWHRkJklb3FMRzxAkjE6fYpaqyfDDjvSGYSvHD7rQjd5zU3HXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f44b296e02so3357190b3a.2
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 09:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702900; x=1716307700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNP5n42nn9nZu6GVCQLpvtO7ZgtE6a5A4oDtv9l67/E=;
        b=IrcXcZnH69u//8R0MADPgFRaUJwWouk1dOeanP1HAsYmm1ZnwUL4vJ0EKlpNMTupJd
         usFyJfL0CthM9VllpFzCtMlu1W/eMLsWQEgYxNBTn2E+JDBRFxgN9QNr1ndHKAc31eSm
         8Ihfa/4EaFD02QQ9dB5b7FntLHQ/N4yuk2BgemRe3hCovWEzoWz9RqY68dMr6Y1ia7/c
         pTlHycG+BtmNbHPW2Dmn46xn91DqcPhGJ6d5Va3aLNq01ZDhr538P65iS5p5bUIErxV2
         518FrDylvzPbkwgPIbzsBnIE75vbtRoVGWGtoPlZoOfjUV1Y4WnQvXq6095BXhvhg2G+
         r5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnWSxxnEQYFxlgNFTSvZaNiQvYLqpmgjUxK//+HuJTbf4wzkhVXYXU87ABEceNKKTRhHgW4We8qdQDSLwONzpzJfAStjBEMNSwrbg=
X-Gm-Message-State: AOJu0YzxvLk22yqsWHvVENfu3pdcdhG9orQuae7zn2wxktCzkEJ4O4fn
	vQcz0rg8uzBKZSGbuY9FWmjHdTGtzyj3ZiqToFUllrTA3EGKpMdjSP81jOAhpNc=
X-Google-Smtp-Source: AGHT+IGISwphAxSeBGW6eIoRZvoxDajLXY5C9QYe2vWn2FJFRUScFThli9hJhEif/xY0XERfyE3W1w==
X-Received: by 2002:a05:6a20:d70b:b0:1af:d9a3:f38d with SMTP id adf61e73a8af0-1afde202083mr12223986637.62.1715702900535;
        Tue, 14 May 2024 09:08:20 -0700 (PDT)
Received: from localhost ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449e0esm9649907a12.13.2024.05.14.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 09:08:19 -0700 (PDT)
Date: Tue, 14 May 2024 12:08:19 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Joel Colledge <joel.colledge@linbit.com>,
	yangerkun <yangerkun@huawei.com>
Subject: [git pull] device mapper changes for 6.10
Message-ID: <ZkOMczEgGuPBOCrr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 48ef0ba12e6b77a1ce5d09c580c38855b090ae7c:

  dm: restore synchronous close of device mapper block device (2024-04-16 11:32:07 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.10/dm-changes

for you to fetch changes up to 8b21ac87d550acc4f6207764fed0cf6f0e3966cd:

  dm-delay: remove timer_lock (2024-05-09 09:10:58 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Add a dm-crypt optional "high_priority" flag that enables the crypt
  workqueues to use WQ_HIGHPRI.

- Export dm-crypt workqueues via sysfs (by enabling WQ_SYSFS) to allow
  for improved visibility and controls over IO and crypt workqueues.

- Fix dm-crypt to no longer constrain max_segment_size to PAGE_SIZE.
  This limit isn't needed given that the block core provides late bio
  splitting if bio exceeds underlying limits (e.g. max_segment_size).

- Fix dm-crypt crypt_queue's use of WQ_UNBOUND to not use
  WQ_CPU_INTENSIVE because it is meaningless with WQ_UNBOUND.

- Fix various issues with dm-delay target (ranging from a resource
  teardown fix, a fix for hung task when using kthread mode, and other
  improvements that followed from code inspection).
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmZDiggACgkQxSPxCi2d
A1oQrwf7BUHy7ehwCjRrVlFTteIlx0ULTpPxictakN/S+xZfcZUcbE20OjNVzdk9
m5dx4Gn557rlMkiC4NDlHazVEVM5BbTpih27rvUgvX2nchUUdfHIT1OvU0isT4Yi
h9g/o7i9DnBPjvyNjpXjP9YE7Xg8u2X9mxpv8DyU5M+QpFuofwzsfkCP7g14B0g2
btGxT3AZ5Bo8A/csKeSqHq13Nbq/dcAZZ3IvjIg1xSXjm6CoQ04rfO0TN6SKfsFJ
GXteBS2JT1MMcXf3oKweAeQduTE+psVFea7gt/8haKFldnV+DpPNg1gU/7rza5Os
eL1+L1iPY5fuEJIkaqPjBVRGkxQqHg==
=+OhH
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Benjamin Marzinski (4):
      dm-delay: fix workqueue delay_timer race
      dm-delay: fix max_delay calculations
      dm-delay: change locking to avoid contention
      dm-delay: remove timer_lock

Christoph Hellwig (1):
      dm: use queue_limits_set

Joel Colledge (1):
      dm-delay: fix hung task introduced by kthread mode

Mike Snitzer (2):
      dm-crypt: stop constraining max_segment_size to PAGE_SIZE
      dm-crypt: don't set WQ_CPU_INTENSIVE for WQ_UNBOUND crypt_queue

Mikulas Patocka (1):
      dm-crypt: add the optional "high_priority" flag

yangerkun (1):
      dm-crypt: export sysfs of all workqueues

 .../admin-guide/device-mapper/dm-crypt.rst         |  5 ++
 drivers/md/dm-crypt.c                              | 73 +++++++++++++++-------
 drivers/md/dm-delay.c                              | 60 +++++++++---------
 drivers/md/dm-table.c                              | 27 ++++----
 4 files changed, 97 insertions(+), 68 deletions(-)
