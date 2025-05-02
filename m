Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33E28E7
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205454; cv=none; b=Omh5ipIPolz1pfA4U9MVGjkRC+9hqQz5vMBe+V7YCFR+CVvZqGECpTTzimqpMma1EJb4UkTGeP8hbMeaA5WbarR63oSLKFV7NYo1QkB6I6oZKQnjNIh8VlVQCBzDF9S0HLFoVmSQKIuIosFW3n6H4ET2ZO+q05QLRVZlNj7gBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205454; c=relaxed/simple;
	bh=8bEvVGZtbKub6lRx6g2rQcqd04+IvzoKp4Pm1LrGBMc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=G7tM3o78fKAmKcpJX7unjDV7ssjJZhylgV6dKCm+wXnza/Dl4lHjDaAQZGkGR7XwLptSeihJXptd0ZiUcR9BFKzIqUvuODfGPElhVbEpKMi3lOID0lat8c3PuCq9DA92pN4Ip1Dmet06r+UbK+NwuOa3RteDscpJV7wL/uD+5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H4PTCSi2; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H4PTCSi2"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so7790515ab.0
        for <linux-block@vger.kernel.org>; Fri, 02 May 2025 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746205449; x=1746810249; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56k/yo+h3UKdeuspTM8hEJk3WG1rNtkyCtpzoXto+wU=;
        b=H4PTCSi20vnt9BRq53Js4tr1qb5XQOgk/y+fDOL6r3CqEHpzi/L0UQq6Cs4l9hDFOk
         JyN4e6cA+AtYxRMvra4xZxOqIDvN1wXV5D5t3KddnuwSay+ly9E1mlXu5BcofwtoMCDf
         NlF9SytjO0tYYPCt4C7G7LcIxpnNZmIdZXNGVtCSOyjbvXnPF7+EHs7l3qmTrcO6C4pE
         aNpldmKK4nWTCIkoboU/KfDJkbQzGokvj8t+5s1l3fOUJDiLglU79gZvSxWM/7mtZMB6
         NYz/G2hXjb5pTRzkWYJ0s3Nu7N5YFmdL1ZkTtqEa1poavuZKE7VfkFE9qh+ZeXiFK9wz
         tYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746205449; x=1746810249;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=56k/yo+h3UKdeuspTM8hEJk3WG1rNtkyCtpzoXto+wU=;
        b=g4U5owojrnyxJP3wC3J9Pxunfr+rQ6pdobUsqKfEs3L70cM7Qh/SgStm67di2OCrRF
         meMi85tq1a/w4KN+Fdxw3FXF7R0sOkoj0FplYgSWJUIjvysiw2mAnQJjMDRjR6P/Iq67
         UmasVm7kn5qnhv9qBaRobVqiCgNCTVEMCgozpvZl/B/y7Hg83anLOom+7jaLx1ybR0c5
         dxERBUWGZqjBnPw2gCelnFeBl5dfuyMRDayIUVGDEcUkjS1YJzC8Wcec5NOdvqufrbIT
         L9AbI69mSkl1XyZd38gK73vlpapKggsKAsSjBmPWTkpiA1hE/caszE332BAGnWgtZ19g
         ihZg==
X-Gm-Message-State: AOJu0YwGRwCXYdIo5JE4dalD+qqgRci1VCtYgLgvTlE8GAMkzXBMuwJB
	z7plalCP6VHAip3R/Nd5mNGmiHbHxH6MpufjnBk6RNE8yHcGKX+ry8YO9PY5zLs=
X-Gm-Gg: ASbGncuTl/eveUXxsjelOiXCNBd1HrQweYRz7G/v3QrdXgWSc9/mRkAKu3bUuDpE3ly
	iZT+rEAjvP1xBpxnuOztkvPS3SIShbrJN0S56VZkYcHKIW53ObYFPrSZTUsVYXg7KWUeq6GtCht
	8inTZKvXniIGXLdBu4pIemKNVRoBmWmQivI7G4FUQX/srS0xBnywJ6bcsp65q2Uz0s7NaSPXDOd
	ZB0bQpvhUG+tz8jMbsbI3v2VQ++thN3kwf/iRO7BSWYSRIbmFgAlr+AIUvx9DzSQMNOLoPggmWv
	P6JIg6LsQ8C3WDd1532J+VnnBuTFeoPbmd04
X-Google-Smtp-Source: AGHT+IF+CQ+B7DrHkU+wcTi0cGH3bIH2V7Ol5IafyGkwsSfGjAnXI2xxdxtwcljSFofom8p7p66csw==
X-Received: by 2002:a05:6e02:1fcf:b0:3d4:36da:19a9 with SMTP id e9e14a558f8ab-3d97c28831cmr42994215ab.15.1746205449196;
        Fri, 02 May 2025 10:04:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975ec4266sm6986755ab.31.2025.05.02.10.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 10:04:08 -0700 (PDT)
Message-ID: <8f571ccb-f9ea-4bdd-8cbc-b87c158eac41@kernel.dk>
Date: Fri, 2 May 2025 11:04:07 -0600
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
Subject: [GIT PULL] Block fixes for 6.15-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Block fixes that should go into the 6.15-rc5 kernel release. This pull
request contains:

- NVMe pull request via Christoph
	- fix queue unquiesce check on PCI slot_reset (Keith Busch)
	- fix premature queue removal and I/O failover in nvme-tcp
	  (Michael Liang)
	- don't restore null sk_state_change (Alistair Francis)
	- select CONFIG_TLS where needed (Alistair Francis)
	- always free derived key data (Hannes Reinecke)
	- more quirks (Wentao Guan)

- ublk zero copy fix

- ublk selftest fix for UBLK_F_NEED_GET_DATA

Please pull!


The following changes since commit f40139fde5278d81af3227444fd6e76a76b9506d:

  ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd (2025-04-24 19:52:20 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250502

for you to fetch changes up to 6d732e8d1e6ddc27bbdebbee48fa5825203fb4a9:

  Merge tag 'nvme-6.15-2025-05-01' of git://git.infradead.org/nvme into block-6.15 (2025-05-01 07:56:02 -0600)

----------------------------------------------------------------
block-6.15-20250502

----------------------------------------------------------------
Alistair Francis (3):
      nvme-tcp: select CONFIG_TLS from CONFIG_NVME_TCP_TLS
      nvmet-tcp: select CONFIG_TLS from CONFIG_NVME_TARGET_TCP_TLS
      nvmet-tcp: don't restore null sk_state_change

Hannes Reinecke (1):
      nvmet-auth: always free derived key data

Jens Axboe (1):
      Merge tag 'nvme-6.15-2025-05-01' of git://git.infradead.org/nvme into block-6.15

Keith Busch (1):
      nvme-pci: fix queue unquiesce check on slot_reset

Michael Liang (1):
      nvme-tcp: fix premature queue removal and I/O failover

Ming Lei (4):
      selftests: ublk: fix UBLK_F_NEED_GET_DATA
      ublk: decouple zero copy from user copy
      ublk: enhance check for register/unregister io buffer command
      ublk: remove the check of ublk_need_req_ref() from __ublk_check_and_get_req

Wentao Guan (2):
      nvme-pci: add quirks for device 126f:1001
      nvme-pci: add quirks for WDC Blue SN550 15b7:5009

 drivers/block/ublk_drv.c                        | 62 +++++++++++++++++--------
 drivers/nvme/host/Kconfig                       |  1 +
 drivers/nvme/host/pci.c                         |  8 +++-
 drivers/nvme/host/tcp.c                         | 31 ++++++++++++-
 drivers/nvme/target/Kconfig                     |  1 +
 drivers/nvme/target/auth.c                      |  3 +-
 drivers/nvme/target/tcp.c                       |  3 ++
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/kublk.c            | 22 +++++----
 tools/testing/selftests/ublk/kublk.h            |  1 +
 tools/testing/selftests/ublk/test_generic_07.sh | 28 +++++++++++
 tools/testing/selftests/ublk/test_stress_05.sh  |  8 ++--
 12 files changed, 133 insertions(+), 36 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_07.sh

-- 
Jens Axboe

