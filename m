Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEA1F416B
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430877; cv=none; b=TNLlEt1qxqnG53rpwOutFiwWmV6I/LXghMerUIimwjQGUFKVShk6L7r/PFrgYrWhyumzuM6FvPwFL33awV4bX5BGj1uGJqN4lQNOC73e+39tNSAMuw3bR0uZhvqUPs27/XyhDp2jc6uWYs2xHM/6stVVWcyryyqlvhML+bZN164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430877; c=relaxed/simple;
	bh=R6xx7AKdRkEyVQIbD3H9U4Id6oY8IdGTxhgP8Eaxc2M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=FS2Tro6UVdfLOmOjs9+3/OeWYKUnbQMBDZM4DZ+Ede4NkVUEF2Cxz8BdOqvkxLarrA3pDSLGPniVsFzr5XRWk/DIIidOoMUMrF85Y8/C9sZDoeJOFAGcCE1dcFSDuVqovVTrV9J/pL1bGXN6J+M4aur3urqcwZSu4Eas6hO04qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ncJP6QQ4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ncJP6QQ4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24646202152so19506965ad.0
        for <linux-block@vger.kernel.org>; Thu, 28 Aug 2025 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756430875; x=1757035675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUOBidSoXR5Yma9X+peRRGJo5hBZ5voUpK4jTjGddc0=;
        b=ncJP6QQ4q+KnEKNRUZhep1BvjwDdByxlZorhmO4WkzjS00zD5cZFq5AW3Oy8z+n4I2
         X6L3dF/fmNJFS9nStVCyfCTwkLMqovSemTr4aARoltioBw0MHaIfjBCAQP2USE+nrv1g
         y4SAfhg5xSf4Ey9ut21gyZ/9dX9I7ISTJby1p62Chm10i2SeFVn5Kf9uD80aSHueF/or
         7TDOQt+sjZ/APWvONMV/v6/YIfgWW1k86K/y3kAoiev6x3Vhl+0d2Wyrhk1qKy9TWEDs
         UaHYL6b6kqA2oMeVs0c2QTM2nvviQct4GcRbonhzSHEs28mQdGA9YFSrBb//S1HKRRFq
         pcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430875; x=1757035675;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUOBidSoXR5Yma9X+peRRGJo5hBZ5voUpK4jTjGddc0=;
        b=LjuMAOYCuE5ab95397ZxBVqg9ZLTvDfYYFADbq6ItrqVDcrHHPF4zJ/VZfd3m3+jFY
         PaJe5heff8qX4dAXPlNGFtAEmlbkb3+qSNhxTF3/p9DT7tc+/5ecmXWYF3MSKKroJJLw
         b9ufLS08I3V9frm6EwlaBhyRPFNEsRSyhnmg2K+q8rb1YSqCkV7FKcCmONpxs6KUViOc
         qN4+SnedViYWhM6SR9CDSJ7BiUosDbGJJsuf/hkqazBhADbR0oEPnni88cBRAsQ06dKO
         uGqD0lKUKpzENpHQ+HW05ZO3XEHlyUUA6yM2kY3sPmNpW/Qu+LCFdHaJB9Awj1OXF7Bq
         djBg==
X-Gm-Message-State: AOJu0YzCx2AYwj/rd+EtvfYZbpE547EMerGkwS3uszHixixdvSSkczLo
	XKtYhLCNkwG/lP0845LO8zHX/mxBwKCBPZ9Oj3jAULXsrHCFPwjxAGzC/X/wRjTKjDRdP1KuC75
	vR7ak
X-Gm-Gg: ASbGnctjQYITO3YBkASLfC8ptZaLBIK8dYNhUj7aooDionyXFKoC1l3jhIbH3pGXwn+
	s4RZpmVBN7zqDjxwfp+dFKYRGlAGh9KGDB3AK6havjodAAEkphi9RMlK22O0A/P5dSxnYhN9zn8
	tFZZ5BMr7e+zql8xwcIR+wGotHw09f2QTqX9vz4HM5ZTDkOivyVFygKBgOuMjkr9hpKYtHWUsjv
	jgVbI1lDQNmmQs2GC0wy0zT14CE6xtfql19DkAMmq4slyhrgpSU/6QGKz4MPjjovyk8B/U3C86h
	zGjY9AFYHZCwIBfuqashimXnUHiEEQmr8zKFr+l7tXj2MXDJ5LpDFqTIMVRAlhbNcCZCouC+kCS
	7wovxJ/fXKEgOqSD7mzLC
X-Google-Smtp-Source: AGHT+IHAtwYtTvcVnuQtw6l5k/road3opgS9hkuBfO9PNTP+4e2ILsU4SjttvR+QSqS2llJlOIQ87Q==
X-Received: by 2002:a17:902:d2c7:b0:248:9429:3641 with SMTP id d9443c01a7336-24894293aa4mr128335015ad.48.1756430875014;
        Thu, 28 Aug 2025 18:27:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903704060sm8228165ad.20.2025.08.28.18.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 18:27:54 -0700 (PDT)
Message-ID: <42115c00-7422-4c51-9d2b-5296bd462c27@kernel.dk>
Date: Thu, 28 Aug 2025 19:27:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.17-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.17-rc4 kernel release.
This pull request contains:

- Fix a lockdep spotted issue on recursive locking for zoned writes, in
  case of errors.

- Update bcache MAINTAINERS entry address for Coly.

- Fix for a ublk release issue, with selftests.

- Fix for a regression introduced in this cycle, where it assumed
  q->rq_qos was always set if the bio flag indicated that.

- Fix for a regression introduced in this cycle, where loop retrieving
  block device sizes got broken.

Please pull!


The following changes since commit 370ac285f23aecae40600851fb4a1a9e75e50973:

  block: avoid cpu_hotplug_lock depedency on freeze_lock (2025-08-21 07:11:11 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.17-20250828

for you to fetch changes up to 95a7c5000956f939b86d8b00b8e6b8345f4a9b65:

  bcache: change maintainer's email address (2025-08-28 10:05:37 -0600)

----------------------------------------------------------------
block-6.17-20250828

----------------------------------------------------------------
Bart Van Assche (1):
      blk-zoned: Fix a lockdep complaint about recursive locking

Coly Li (1):
      bcache: change maintainer's email address

Ming Lei (2):
      ublk: avoid ublk_io_release() called after ublk char dev is closed
      ublk selftests: add --no_ublk_fixed_fd for not using registered ublk char device

Nilay Shroff (1):
      block: validate QoS before calling __rq_qos_done_bio()

Yu Kuai (1):
      loop: fix zero sized loop for block special file

 MAINTAINERS                                    |  2 +-
 block/blk-rq-qos.h                             | 13 +++--
 block/blk-zoned.c                              | 11 ++--
 drivers/block/loop.c                           | 26 ++++++----
 drivers/block/ublk_drv.c                       | 72 +++++++++++++++++++++++++-
 tools/testing/selftests/ublk/file_backed.c     | 10 ++--
 tools/testing/selftests/ublk/kublk.c           | 38 +++++++++++---
 tools/testing/selftests/ublk/kublk.h           | 45 +++++++++++-----
 tools/testing/selftests/ublk/null.c            |  4 +-
 tools/testing/selftests/ublk/stripe.c          |  4 +-
 tools/testing/selftests/ublk/test_stress_04.sh |  6 +--
 11 files changed, 175 insertions(+), 56 deletions(-)

-- 
Jens Axboe

