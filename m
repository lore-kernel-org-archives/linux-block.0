Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E8363098
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402588; cv=none; b=bSrto1rSe6/r6ljGgjuYOUE9bpa0WF3k09Ca/+ccmvoNsLlpxcLUuctT87+ZmBuN50JDv2iWOgv1wZ8OsrsDlcT8/flrsGrR+bN+O+1kXwZTwID3cs5sw0XHsxeBNxjv9NcT2W5jbB3bOQ1pJankaqMADP5hK/9Bm0WmHL/oyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402588; c=relaxed/simple;
	bh=LtbU/iv2e4Kg2GdtsiY2bJOKx5molPD2fFbPFnO1g8A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=h5YPuBBS5x5W+Gb7KFM2UoAV016WPU9ylOUnVEQo26wiWrapligfRCiRHM6pThkjlFROTcPD8Z2gjwS0fcX4ag3IruBe9t1Jiqg2AhOKC2mGAexURr6yvnYKZCyg65nXNixMbbx8OlUko7N94uhUIh4AYcC/X9llxh0oQWnS4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UrAidbyo; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UrAidbyo"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-41708f6aa5fso1324567fac.2
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773402586; x=1774007386; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8VAXUd+j6ULovYxRRLxzB+bZXe3RnjMuJH9W1X1J4Q=;
        b=UrAidbyoMls/OW/RD7wEaPklbtfqlEUZoJIB/8LoJkXik6hRh0De5MILUHKh0S6Dqk
         UkEMyv9/MOc+F/7Se5kA4Jo0BEv+nFJnMVIXwOj+G4B5YnM/dqm6UallWuWx3RXr7U6K
         6CV0+ZcxoLtqofmpn+u/LhomV/L78X6w46iXXxsahT93ISpFlKdyOJV8GXrAoWMU25SQ
         ePBfLZqA8bPv9xZdkRId2MTg3gSMwCfiviyxCjr7vY/SyIfNR2Q40gjUzjnBCdvjzez7
         KApCxvSh+PmMf5wd04ke7K0tyLHDDX9Z0TumrZum4zwtf1FWDlnerHtyV9mNSYwN8tP2
         FiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773402586; x=1774007386;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8VAXUd+j6ULovYxRRLxzB+bZXe3RnjMuJH9W1X1J4Q=;
        b=GGnlbbQG9CCZiphc/ZL3KS9E7mRMjquHO1/KR8A+x8NnRROUSjsPHB2pvpR5+wF+D/
         xHEmWOaEEvJAiyMi8tkQWc2/ZR7xuYN87nbUHNQ8IoPrD2ndXSeIGTw8y1+W12IJQ47G
         ksWbjIFh1MINAIWjgmLykSzxiIVBCMapZb0Xxr8NnnDryyFU2zbyyzNOUnhSOnByFJr7
         2QfWTMGUHPLfSf2bc5oQJlf2w+MwREpKFhOthAb+5SL8fugunRqqkxn9aGqDBe1oaBfg
         5qdmatR/oL08jTvG7VK5imu0lU016wSj3gOeRK2pud7kSIQp9Uc/Bka9kRr691OKznKm
         jDew==
X-Gm-Message-State: AOJu0YwBNmIFLxeXjz9aq6QZGhxJ6D2MRJjEfRkQjzPIEygBdqB+TsWK
	9N8QVvJSUvRGJVJBdgKfZqTZvMteYYiN1mtR3QI41tOy/2RiY31cDWQbuRvW6K6d7Qg=
X-Gm-Gg: ATEYQzzDtaY/qN3VXiPkheXQvXnqPb4a1FjNkdEIqnYQ/UZ4M9rHi3CulEG3hjjibHE
	e8OHGmdliOV1fJCjq8OjPTR4ynU1QnsfyD5YuL2dVTKnCQ3qqFwAw13+s0/v4KWPbUhdxaSdFJE
	rumtd+LS+8zp76uM8jmQoPzUBCFPl4se1PUUE9Y3Gyrc89XpGQR1KPSnQzHrnoSlYEgZZd13k5o
	Rs5EAGqJ9aUqw2kQp9gQSJnd7kJF4Hm0Bife85t6jpbOllkFGOMWikBdZMV0ZdIHizKRe7T1hx1
	qrqQZKDlsxCAzPu6WXO7hfzUQ6MNzWHp0gJ8s/nqLl+7RNWXyeXR0ea22W2QsyPu9lIosJhH/Zk
	L3CxgVEo71EJA41qsQc0xitgY+2i2m8FMUFHkX4QZYRU3no9EFm7M9JIGdNvUEuV0Gsh/Pcl3EV
	CC27wrf+tj+gXS62AcSafbRcoFDFRFEo69SMNZZOCf4AeIvDdb32ROt9gCWMtAUnJx6nzv9tqlH
	lVbJaGRnw==
X-Received: by 2002:a05:6870:d183:b0:417:548d:67c2 with SMTP id 586e51a60fabf-417b945f4d7mr1573474fac.44.1773402585951;
        Fri, 13 Mar 2026 04:49:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb6efsm8619752fac.3.2026.03.13.04.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 04:49:45 -0700 (PDT)
Message-ID: <e5ffce8a-1a3b-4c89-8ca0-8178b9046cf1@kernel.dk>
Date: Fri, 13 Mar 2026 05:49:43 -0600
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
Subject: [GIT PULL] Block fixes for 7.0-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of block fixes that should go into the 7.0 kernel release. This pull
request contains:

- NVMe pull request via Keith
	- Fix nvme-pci IRQ race and slab-out-of-bounds access
	- Fix recursive workqueue locking for target async events
	- Various cleanups

- Fix a potential NULL pointer dereference in ublk on size setting.

- ublk automatic partition scanning fix

- Two s390 dasd fixes

Please pull!


The following changes since commit ce8ee8583ed83122405eabaa8fb351be4d9dc65c:

  block: use trylock to avoid lockdep circular dependency in sysfs (2026-03-05 04:01:42 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260312

for you to fetch changes up to 7d0abefec48dfefeec28dc7c3105a88c43747d02:

  Merge tag 'nvme-7.0-2026-03-12' of git://git.infradead.org/nvme into block-7.0 (2026-03-12 15:15:53 -0600)

----------------------------------------------------------------
block-7.0-20260312

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: move async event work off nvmet-wq

Jens Axboe (1):
      Merge tag 'nvme-7.0-2026-03-12' of git://git.infradead.org/nvme into block-7.0

Maurizio Lombardi (1):
      nvme-core: do not pass empty queue_limits to blk_mq_alloc_queue()

Mehul Rao (1):
      ublk: fix NULL pointer dereference in ublk_ctrl_set_size()

Ming Lei (1):
      ublk: don't clear GD_SUPPRESS_PART_SCAN for unprivileged daemons

Stefan Haberland (2):
      s390/dasd: Move quiesce state with pprc swap
      s390/dasd: Copy detected format information to secondary device

Sungwoo Kim (2):
      nvme-pci: Fix slab-out-of-bounds in nvme_dbbuf_set
      nvme-pci: Fix race bug in nvme_poll_irqdisable()

Thorsten Blum (1):
      nvme: Annotate struct nvme_dhchap_key with __counted_by

 drivers/block/ublk_drv.c        | 16 ++++++++++++----
 drivers/nvme/host/core.c        |  3 +--
 drivers/nvme/host/pci.c         |  8 +++++---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      | 14 ++++++++++++--
 drivers/nvme/target/nvmet.h     |  1 +
 drivers/nvme/target/rdma.c      |  1 +
 drivers/s390/block/dasd_eckd.c  | 16 ++++++++++++++++
 include/linux/nvme-auth.h       |  2 +-
 9 files changed, 50 insertions(+), 13 deletions(-)

-- 
Jens Axboe

