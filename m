Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F589385D9F
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854832; cv=none; b=Gjy+1dgk5g2tXfaqatDTEHUnUDPl51Oa+/0rFj/cVfTauGtWF851tU8nrpZLNm8O/uhfyqysBweIOzq399HV7vOyvgh/0I7i2QjCBKxksiYbjjrNEiYPZBQBgsUthmCu2Cvo7fbQtxK/cyC2fSOVnw9JY/MkesPfn4yObZby+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854832; c=relaxed/simple;
	bh=Ht0uKyA6yLQZS9eMpBz6YFqkmroDgGXC0ZuYrbjoRi4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=E0XTw2WIlCVPpPKCoB46Fp3MjbePzwipcoesoZ0Sktrkk45MlqS8gNJySUWpD24blHeywW9jEiQtKDzef0ZU4h2N06RjkhkewE3R0JjATm4Ehv6PXydwi4YyDql1NMwkeMkEnU/6lUMXsSZ6+Aj2K6DLsD01HJzBnPXn1/MoqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=rIt5C0Kp; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="rIt5C0Kp"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dcdd1b492eso1298435a34.1
        for <linux-block@vger.kernel.org>; Fri, 15 May 2026 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778854829; x=1779459629; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+Xtnv+Y9sMgHg1T6tLitnC/biyvHiAzs7l0KTUTDTU=;
        b=rIt5C0KprSSQGG9xZ2H1WOLP1xFjLBmE26JsKW6/RIJkwpj8F1tcCCfmoo6vsUgTje
         mQlFp+F7Lp0iGdDt9GgD4rvX9qLStgp3or/8qcZ5bfJJ03W7Q+0ctM2jVoKkkF3D/+BA
         8c3RmCZwqVPW2dWmn5yk5SC1ZNqRCOtQXvBTdZ9ZvB5M4mJLzNj3Z/H+aIw9ORT2g7uR
         qlabaj+FMwbNiBEGY8ohPzgZud01rfj8DcV+z+KoDCZEeeKpkLpbYJlYBrDHromXGwjy
         9mS6tJzHxc+BVhA2MhKwkfeEYPYmbsSwkxkqF00C73+HEbZxliBuF+qbi+gHsn9VJ8OO
         dcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854829; x=1779459629;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+Xtnv+Y9sMgHg1T6tLitnC/biyvHiAzs7l0KTUTDTU=;
        b=lV1Bh3YjbtZJMdod6Luqe0AtLbQutt7SaCe6vpvAjynKBGv0qod8sv4fFuX/1JuXbk
         GEc9nY35Mulh8K6HRhyddz8SkHqnj8CVy27/5kB2cNLqeWn5Xeqhc/DFxQADrZ1faUfe
         MZhy5H4nYVJ+lZxUx43BfK5JblnZTnJOXZmN/va/qkzSR8Uk+7ZW4vU+pfUoxPzOLpsc
         N96wRQ8QV6CrBvuu4jXw1tcVh6n6hfbzY7Nm1H72iH7YHeR4Fvh36E4Dk4pqd53me99C
         XlXI/N/NRLLiiBeafztqiO2jkn+TpKihABBMVCtkwZ5XubW/BD4JgW3Aog9hjSyS5rC0
         90sQ==
X-Gm-Message-State: AOJu0YzML0KlgJL2yAwVRavPVFKs4WPtmH4vQNcNekBrG8oEcW6eJyMK
	MpwGlrhizoEzbx0REFgUUZQQ3up8SqK3GW8vOrpBH/QAgDaWhDtFyNQ8fw62n5tlSuK+NHy+Tsy
	SFB3i
X-Gm-Gg: Acq92OFPAFXcbNE+Z+Fa7H1zDbClo0Y71htump8wGEpHhUxIBbkfflfiJjuRA3nX2vh
	gUYaQili1m6UX0SRfXYaqMQV4kg+k2Xfn1YgcWzPUAU+pBqjakW+DvWnQpJo4/H0cQcMcdr/8Rm
	3n/qcuqa7El1jKt6AiW9a1KVMQEW26GEuv2zGmap4Fm2Yc0TaQHvgmoTpkMXnYb6vydfjs5SGqQ
	sLJV3S72DTyypsp0gtGTaY1PrMuuJRBva8gJL1aOiu0i+GUONTkNYi8kC+6OXV5ETtaaJUePnN6
	N0ZXn8byTk71GaGbkQdv6ZCY6kzr6frHkrS58oO09Mk/0hj+qn+99JdJFCnhKhPZVJZ/n43lgc/
	to3c7WhMi6xo8coK7xtpXvT4HQM6uLtYt2POhDPxHtyC6dkZXe3eqXSo0NEye5muzHvY1Mbf2+T
	hTa/YY0aep4SyjCreg4wM4harBOWijm/wd8/47wSsc3PtL9l72kBtT7RakGoSG9bsVW0bcuhxi2
	zELTURi
X-Received: by 2002:a05:6830:4412:b0:7dc:c501:afbd with SMTP id 46e09a7af769-7e3f14becc7mr4747117a34.10.1778854829156;
        Fri, 15 May 2026 07:20:29 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b507cbesm1395124a34.0.2026.05.15.07.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 07:20:28 -0700 (PDT)
Message-ID: <093dc3c7-5030-4400-9b38-727c41c5f511@kernel.dk>
Date: Fri, 15 May 2026 08:20:27 -0600
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
Subject: [GIT PULL] Block fixes for 7.1-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for the block area, which should go into the 7.1 kernel
release. This pull request contains:

- NVMe merge request via Keith
	- Fix memory leak on a passthrough integrity mapping failure
	  (Keith)
	- Hide secrets behind debug option (Hannes)
	- Fix pci use-after-free for host memory buffer (Chia-Lin Kao)
	- Fix tcp taregt use-after-free for data digest  (Sagi)
	- Revert a mistaken quirk (Alan Cui)
	- Fix uevent and controller state race condition (Maurizio)
	- Fix apple submission queue re-initialization (Nick Chan)

- Three fixes for blk-integrity, fixing an issue with the user data
  mapping and two problems with recomputing number of segments.

- Two fixes for the iov_iter bounce buffering.

- Fix for the handling of dead zoned write plugs.

- ublk max_sectors validation fix, with associated selftest addition.

Please pull!


The following changes since commit f7700a4415afb3ac1767a556094e4ef8bd440e41:

  ublk: fix use-after-free in ublk_cancel_cmd() (2026-05-08 06:44:42 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260515

for you to fetch changes up to 4141f46daa4cf1f8caa14129f8b6db86f17452f5:

  Merge tag 'nvme-7.1-2026-05-14' of git://git.infradead.org/nvme into block-7.1 (2026-05-14 19:14:33 -0600)

----------------------------------------------------------------
block-7.1-20260515

----------------------------------------------------------------
AlanCui4080 (1):
      Revert "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808"

Casey Chen (1):
      block: recompute nr_integrity_segments in blk_insert_cloned_request

Chia-Lin Kao (AceLan) (1):
      nvme-pci: fix use-after-free in nvme_free_host_mem()

Christoph Hellwig (2):
      block: pass a minsize argument to bio_iov_iter_bounce
      block: align down bounces bios

Damien Le Moal (1):
      block: fix handling of dead zone write plugs

David Carlier (1):
      block: don't overwrite bip_vcnt in bio_integrity_copy_user()

Hannes Reinecke (1):
      nvmet-auth: Do not print DH-HMAC-CHAP secrets

Jens Axboe (1):
      Merge tag 'nvme-7.1-2026-05-14' of git://git.infradead.org/nvme into block-7.1

Keith Busch (2):
      nvme: make prp passthrough usage less scary
      nvme: fix bio leak on mapping failure

Maurizio Lombardi (1):
      nvme: fix race condition between connected uevent and STARTED_ONCE flag

Ming Lei (2):
      ublk: reject max_sectors smaller than PAGE_SECTORS in parameter validation
      selftests: ublk: cap nthreads to kernel's actual nr_hw_queues

Nick Chan (1):
      nvme-apple: Reset q->sq_tail during queue init

Sagi Grimberg (1):
      nvmet-tcp: Fix potential UAF when ddgst mismatch

Sungwoo Kim (1):
      block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()

 block/bio-integrity.c                | 19 ++++++++++++++++++-
 block/bio.c                          | 27 +++++++++++++++------------
 block/blk-mq.c                       | 19 +++++++++++++++++++
 block/blk-zoned.c                    | 32 +++++++++++++++++++++++++++-----
 drivers/block/ublk_drv.c             |  3 +++
 drivers/nvme/host/apple.c            |  1 +
 drivers/nvme/host/core.c             |  6 +++++-
 drivers/nvme/host/ioctl.c            | 18 ++++--------------
 drivers/nvme/host/pci.c              |  8 ++++----
 drivers/nvme/target/Kconfig          |  9 +++++++++
 drivers/nvme/target/auth.c           | 13 ++++++++-----
 drivers/nvme/target/tcp.c            |  4 +++-
 fs/iomap/direct-io.c                 |  2 +-
 include/linux/bio.h                  |  3 ++-
 tools/testing/selftests/ublk/kublk.c | 11 +++++++++++
 15 files changed, 130 insertions(+), 45 deletions(-)

-- 
Jens Axboe

