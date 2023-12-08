Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ImhvOgH9"
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F0D54
	for <linux-block@vger.kernel.org>; Fri,  8 Dec 2023 09:48:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b7117ca63eso6205839f.1
        for <linux-block@vger.kernel.org>; Fri, 08 Dec 2023 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702057738; x=1702662538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXcDADDwJhPsBsZgMsEmtu1xTvcSDMQwKEzXL7OTirE=;
        b=ImhvOgH920hZABD4ZgVstOXQbwCARxbnxSHTxqA5v3LwVCTGfpAgidBEeoj7ihoLlq
         noPoLURvHVckpZWVsZVMNC0TMFYV7K9eaVtX6e/1gRMeNRCG9x3LndGMetyEjwfL6JjJ
         2O6pkumKdVfpNhfYlub+Lt90H0+1vgDnZ1Bkw7wmy7D/KbpIzNvwmlyfUfQ39Po++5NI
         IOvXGAKRzsP9yY2inRu4WI3HIWy3VJQRIn2COvjC9GLW1VYHczmJLbvMwO0NHj3BjewJ
         NzCfJ92yZYdfWaNozrb2sQP+ml8CjORDJFMspwlOC/XPs/iFjYsIilgNZKkl+aLuyzzU
         3ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057738; x=1702662538;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QXcDADDwJhPsBsZgMsEmtu1xTvcSDMQwKEzXL7OTirE=;
        b=d0ejqkC3iGoYKk10Wx5lMVEYaISGpg1macCf8gsrLZ9kgyRHQMBkqOQLs5KK16D3YO
         0kjeZzU4TOVJUoz+ZNtokFZA6cBizHr8Tg8bdk7P3R717f7dDPmDBsNhPLe+4ib1iiqg
         Sl9CqS8qwssI+BnwfFSa8u2EUgZrUjj5BtTyC00i0AW2saNg8Uk2H+DfR8Y5X9RZ9igj
         wKNJpp9aNwufzIXb/1FP/5rJ+xdF0D3m329uAiWlXmGI+Z9kHZIMEFsahsm1EWflvsqF
         +xko2suDsSF24RE4Zy4MGfTucFrK77KttWj1HPKA0Lw8PIJFi0+efZY9z2vruXA0WA8X
         u7ig==
X-Gm-Message-State: AOJu0YyhuMtUte0KY0OOWJfLjpPjTFe6SvIPHAZVuVWSoWdtRpAtQ6Mo
	Ui7EKaxCWqqbWiXv9/pNZ1/VRD1+GhEhD1Zr/eZ57Q==
X-Google-Smtp-Source: AGHT+IHXi4FeGELR3MyBDyiJj1iy9fDvId184BmnCL74mTBFNnHcSZsEifeb2LOWySCju5pS4n8jQw==
X-Received: by 2002:a6b:e70c:0:b0:7b7:fe4:3dfa with SMTP id b12-20020a6be70c000000b007b70fe43dfamr1064790ioh.2.1702057738627;
        Fri, 08 Dec 2023 09:48:58 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l12-20020a02cd8c000000b0045458b7b4fcsm538082jap.171.2023.12.08.09.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 09:48:57 -0800 (PST)
Message-ID: <10082935-2c7f-4f88-b318-b8543583987a@kernel.dk>
Date: Fri, 8 Dec 2023 10:48:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.7-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Nothing major in here, just miscellanous fixes for MD and NVMe:

- NVMe pull request via Keith
	- Proper nvme ctrl state setting (Keith)
	- Passthrough command optimization (Keith)
	- Spectre fix (Nitesh)
	- Kconfig clarifications (Shin'ichiro)
	- Frozen state deadlock fix (Bitao)
	- Power setting quirk (Georg)

- MD pull requests via Song
	- 6.7 regresisons with recovery/sync (Yu)
	- Reshape fix (David)

Please pull!


The following changes since commit 8ad3ac92f0760fdd8537857ee1adfde849ab0268:

  Merge tag 'nvme-6.7-2023-12-01' of git://git.infradead.org/nvme into block-6.7 (2023-12-01 09:09:16 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.7-2023-12-08

for you to fetch changes up to c6d3ab9e76dc01011392cf8309f7e684b94ec464:

  Merge tag 'md-fixes-20231207-1' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7 (2023-12-07 12:15:18 -0700)

----------------------------------------------------------------
block-6.7-2023-12-08

----------------------------------------------------------------
Bitao Hu (1):
      nvme: fix deadlock between reset and scan

David Jeffery (1):
      md/raid6: use valid sector values to determine if an I/O should wait on the reshape

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Kingston drives

Jens Axboe (4):
      Merge tag 'md-fixes-20231201-1' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7
      Merge tag 'md-fixes-20231206' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7
      Merge tag 'nvme-6.7-2023-12-7' of git://git.infradead.org/nvme into block-6.7
      Merge tag 'md-fixes-20231207-1' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7

Keith Busch (3):
      nvme: introduce helper function to get ctrl state
      nvme: ensure reset state check ordering
      nvme-ioctl: move capable() admin check to the end

Nitesh Shetty (1):
      nvme: prevent potential spectre v1 gadget

Shin'ichiro Kawasaki (1):
      nvme: improve NVME_HOST_AUTH and NVME_TARGET_AUTH config descriptions

Yu Kuai (4):
      md: fix missing flush of sync_work
      md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly()
      md: fix stopping sync thread
      md: split MD_RECOVERY_NEEDED out of mddev_resume

 drivers/md/md.c                | 144 ++++++++++++++++++++++-------------------
 drivers/md/raid5.c             |   4 +-
 drivers/nvme/host/Kconfig      |   5 +-
 drivers/nvme/host/core.c       |  52 +++++++++------
 drivers/nvme/host/fc.c         |   6 +-
 drivers/nvme/host/ioctl.c      |  21 +++---
 drivers/nvme/host/nvme.h       |  11 ++++
 drivers/nvme/host/pci.c        |  30 ++++++---
 drivers/nvme/host/rdma.c       |  23 ++++---
 drivers/nvme/host/tcp.c        |  27 +++++---
 drivers/nvme/target/Kconfig    |   5 +-
 drivers/nvme/target/configfs.c |   3 +
 12 files changed, 197 insertions(+), 134 deletions(-)

-- 
Jens Axboe

