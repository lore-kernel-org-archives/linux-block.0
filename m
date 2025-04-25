Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D81C5D44
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599866; cv=none; b=eXUN3VihplO+cBH/NDWu6tF+2jlXMYOni52sb/RNbBQk9x06No7F8+HwxQMCOXD4/4vgLudOgJhit+N0RS6PeRbhFVPT0vRjcxafv1Q5iIgMDf52SVYqgqyU6U0wMR1T3Zq1Ri8IZE/dZ7jLu+RE9YORIfIX2V76uXD40DPjLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599866; c=relaxed/simple;
	bh=hp4LMtMt4NNJ3KzXuRuCcEaD8LGvWoh08vS2qaC4gPs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VgbmYv3uDfAlFeHhuoadrMVM2/q0supXHKGvGupsvseXppmaStzI4EmHtUmUjVGTPUyahTPEsblhGI2hCOIrGz/vI34r0znGRPcD3V6H8llcHe9ENCdt/mBsBAVesk428rBDkLuilsmQE7D2AhbSLlEwSu9G0OiLjYTKn9XMp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PjK2MH3O; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PjK2MH3O"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8644aa73dfcso87707939f.0
        for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745599862; x=1746204662; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CilvDteVvgbX68Q+b26gfS2F2r3PzeLuznn06QzGy60=;
        b=PjK2MH3OTd60rS16vgiEkHLOOPO8zSem+4ag0xIGFiqzmJmjiJBP4RfvW5KpGPMDRg
         Nv7z7BJ1ZjTt4CZ5PGoD76CMCkwraseNIjw5YbAd3r4QYZmysL0hv/wl+Citnd8ZQcPM
         PoPmRHqJ7BhvsPA7LY0iKh6l+hu2OXQ0lVog3tfJdIKPkJNkvfWJa53EtWuOmM/QhgzI
         NuMuU3O7sFxh//ILXFKAnc6/4n2WV+viLCWdhnvJ3wx05XjGgZ5zWtVZ59W5200oVigo
         voqFBUlqE8/q2GZYySwYq0ASdhYjkpYPzN6vGs1CY9t8A6wkELhnnl9gpmSimB1jBe1s
         7O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599862; x=1746204662;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CilvDteVvgbX68Q+b26gfS2F2r3PzeLuznn06QzGy60=;
        b=BapmSbv85y6QrlRdnRfz3aiVly9tld99iYzsK4dkz/ooAG6ILH1i15x3iG7uvrzfzd
         VvD0UHqrWKdW4zusbD4NRFf/my2uVPJwaibMd8WxBZDHjTfuofGmxecRl+dg7x00HyWz
         ftTtfcjRwIN7uOkQMncGvSl0xGhH6j1OeuKbwUEMl8fSy99jtjZn9PRNePHVa5FQv1yP
         55NQSF1kZ6O8SlV2XaSw1heIa6/nzsZGTpfNH4w9X29k3Mjf+7sAADIwxjFvj7/qNuCz
         eybQhv1nl/EyLdueg30F89nyBTNkjL0SYy5OFlNdIQw6w4Amv5iDZeY0BxM66StNoDBk
         ctog==
X-Gm-Message-State: AOJu0YzgF1C0Vx3DQ/soH71LATw6KbS5HWfT1iO3bWvGf3iz3ONUHnUT
	yv4g0fgoWcwegFcBQK6PkGyQK3yQpIrs26Qh9m0fD0LytwAD55U5/gJWE4Re6XdMquuBvFCxxiw
	u
X-Gm-Gg: ASbGncsE33vY8V4nPqACMMRX/aiovoqdrOoSZRxzRRemPfpsE7Np+RKbPLWUSIZpums
	Hcw3rXawz5gHKeHHKdM9v8zm8tHQBEtoz3PuED7HhL9yMojzMJRAEzQ4KYL/Lgvh7Ykvvg1QuGW
	G/zFABownpkRqWDnvi6W50dr8ewtWiScxq4jm5tcB/rw0hcAIHrpKp63bXoJ7lwqDwt7ErWc36i
	uRdEDxHlsL7WX4rzbOmJkRPO7i2AW3RJyQPoLez8Jr68Cj9tZ0W16wKJqHj+dC8Dzp2Z0TDAwaF
	c1i0XGzmJxK6RjBsjQ==
X-Google-Smtp-Source: AGHT+IGY1ik3t9swPDQmdn7x0j5yaYVg/VkOzWGHtEndDUM/CDF+yqsOfqIMhV1QCtIY2akm7GZo+Q==
X-Received: by 2002:a05:6602:13c3:b0:85b:3763:9551 with SMTP id ca18e2360f4ac-8645ccd5f87mr391797439f.7.1745599862487;
        Fri, 25 Apr 2025 09:51:02 -0700 (PDT)
Received: from [172.19.0.90] ([99.196.129.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a3bab1sm854916173.36.2025.04.25.09.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 09:51:01 -0700 (PDT)
Message-ID: <011eb55a-9a9e-4d59-8efc-8b51037fc306@kernel.dk>
Date: Fri, 25 Apr 2025 10:50:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.15-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.15 release. This pull
request contains:

- Fix autoloading of drivers from stat*(2)

- Fix losing read-ahead setting one suspend/resume, when a device is
  re-probed.

- Fix race between setting the block size and page cache updates.
  Includes a helper that a coming XFS fix will use as well.

- ublk cancelation fixes.

- ublk selftest additions and fixes.

- NVMe pull via Christoph
	- fix an out-of-bounds access in nvmet_enable_port
	  (Richard Weinberger) 

Please pull!


The following changes since commit 81dd1feb19c7a812e51fa6e2f988f4def5e6ae39:

  Merge tag 'nvme-6.15-2025-04-17' of git://git.infradead.org/nvme into block-6.15 (2025-04-17 06:18:49 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250424

for you to fetch changes up to f40139fde5278d81af3227444fd6e76a76b9506d:

  ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd (2025-04-24 19:52:20 -0600)

----------------------------------------------------------------
block-6.15-20250424

----------------------------------------------------------------
Christoph Hellwig (5):
      block: never reduce ra_pages in blk_apply_bdi_limits
      block: move blkdev_{get,put} _no_open prototypes out of blkdev.h
      block: remove the backing_inode variable in bdev_statx
      block: don't autoload drivers on stat
      block: don't autoload drivers on blk-cgroup configuration

Darrick J. Wong (2):
      block: fix race between set_blocksize and read paths
      block: hoist block size validation code to a separate function

Jens Axboe (1):
      Merge tag 'nvme-6.15-2025-04-24' of git://git.infradead.org/nvme into block-6.15

Ming Lei (4):
      selftests: ublk: fix recover test
      selftests: ublk: remove useless 'delay_us' from 'struct dev_ctx'
      ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
      ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd

Richard Weinberger (1):
      nvmet: fix out-of-bounds access in nvmet_enable_port

Uday Shankar (1):
      selftests: ublk: common: fix _get_disk_dev_t for pre-9.0 coreutils

 block/bdev.c                                    | 67 +++++++++++++++++++------
 block/blk-cgroup.c                              |  2 +-
 block/blk-settings.c                            |  8 ++-
 block/blk-zoned.c                               |  5 +-
 block/blk.h                                     |  3 ++
 block/fops.c                                    | 18 ++++++-
 block/ioctl.c                                   |  6 +++
 drivers/block/ublk_drv.c                        | 41 ++++++++-------
 drivers/nvme/target/core.c                      |  3 ++
 include/linux/blkdev.h                          |  5 +-
 tools/testing/selftests/ublk/kublk.c            |  1 +
 tools/testing/selftests/ublk/kublk.h            |  3 --
 tools/testing/selftests/ublk/test_common.sh     |  4 +-
 tools/testing/selftests/ublk/test_generic_05.sh |  2 +-
 14 files changed, 121 insertions(+), 47 deletions(-)

-- 
Jens Axboe

