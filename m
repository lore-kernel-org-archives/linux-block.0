Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DD302756
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044294; cv=none; b=i6Vfm5miSXUv5GQJGOEDw9HSmSWor3BU1iFImjRTipAh8WNhiJZveiPXBd68IHwHQiOmMWzdNkOP5o4rOxrGq7BhMMO7dedFnHhZYZs0UD02AlV3GLxXdHY9wq0GQQv0po9ZcTNRht/wJxQQGNu73qi/oZB5wcADu+29Cy1jhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044294; c=relaxed/simple;
	bh=bDN7HGXKQ64Y7Ou6+jN8gVqC4PSGvWsq5dbj4RTHmR8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=m8wfHjNviqJdNfh1c9scSikNoaqTF66NWzpiMQpbvd0oxrz9DNuIlp/I7yXF8hWYkwudlAXu2JBlnmg/6xoS8/ocZPrQY640RwGz1f/Y00gQJNaBVEoe30xWx/oAlARCe1so6O76gEceuoDJ+7jqw7O9M/qMagj6m4glYLv1Ldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=VcKgzvGp; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="VcKgzvGp"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbcb467f2bso7286298a34.3
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777044291; x=1777649091; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NIIWx1FSOSwocGpghknwQu7ksUTSQ0MrKXotEzCJXs=;
        b=VcKgzvGpQL1MpIjTeUEBGKmuc3oSWkPb0Ehi4naLV+BHK0/FpBbZpTpVKKeoXwf+6Z
         6owKdh6q+Kfi5F4EZtIkCJm1yAaBQVXqfs2xEeJPxusArBizdhjNnJqdk5X5Rv84UM6A
         M5AL66EsGSvWM666W5GUsvs1DwNCp3HgN8VB3yyneRrYYs+XxtLjX/ZBxt/KLHtoqsJs
         3zicVGFj0XGIZtJg4iVWqnP1PRPk2MSvdwUdFmt1YtEasMWJ60x1ynRG8lwO4qkZ/ZPT
         LNQm2rMUIqUoTBWzCGqxYvkUvOJ262lQk8IUeu+7HvcJ4gPLLzGOB6l/iMXmKtam3Gr5
         XCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777044291; x=1777649091;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NIIWx1FSOSwocGpghknwQu7ksUTSQ0MrKXotEzCJXs=;
        b=iGT5GFSTWrnAUFljgE8+8RtO5+8NORz14+LMLrA4TDDpGD86joFMpmvn1/H0/L4Jwc
         KbUsOCoG2KVUON8q/4mfMAR/os1xl0wHeK3tXAlvOhZMQLaOA3GaSpH9G51OlC7Xg3xU
         ZR2lFtrwwwz7OQv/ksOI13UiIfqMYlsmYV5HE90LjaOyp5/iCAjqle11hZSQQHS7cfN+
         Q6InOIRmpEWi6v6Aw79a+Svn4rTCO0qXbyaQ8TgyUe0YZCGHyozfkBVCM6GhaVW1ubwW
         i7K0qGsO4WOk59LCqCm5mGWD//Rz18+dm27gkbo6O8P3LFlr5myJKHEIqikfizP9mk+b
         rdEw==
X-Gm-Message-State: AOJu0YxxfDTYiPhu9itQuNXDh9qwOEQLF/c48Km7XxaNLyhAB4Vc4wkf
	owpbD9kfEPQhatbc9oECgVLQe4j9LGLuazNw+BiA8e3ik+D/saBWX+DsCSEqRCI/HcttSz6pL//
	WK9FY+c0=
X-Gm-Gg: AeBDieuc9voEAiC9wq81BtQF/HwqV5kX2rysAmBF//dkr5QcKBgpStw2wc3aMvSz+4r
	8RcH4vueuN0/l0l9RQm8Lo4pccGPf9mMNg12RT/9xurTWqF9o2AWPGMMX7diewgOMdqLXAB98Mz
	qW32EmCzWAFP2F/boHau9oQg/cMHeYsaOKgwx+KVFidGApmvJaXSpxC4RupU7+UZQxKyA4JpKOb
	i9xfKXxLe9LJqFguHtVa3LTfnuPtfkGTxJmu2wFHaoufgkav0uguIfOdIiODofT621dlBoBL03H
	kP8x8ujExyAtVIkt2tcJtckabFWYt1um1nDDTSE5NnvigtV9fOqklrKM2f+gyFb1Xm6dpiR4/m+
	m2PC0DQxcv+OcnYd4EEWpksujWOeYDwvK0UxGerQ5Q+8hgF0EdT5zcENAzZYQ6wsaJH7xR7OxD5
	NsxFxqfx13IvTNgr44saZ95/O8+TlxzpvL0Y9yorSdgc4S5FNZ+hkDShBtgMVIP5Uoy8q0ATIIx
	HFZif84c8eDruhT1sI=
X-Received: by 2002:a05:6830:6a05:b0:7dc:c7aa:22bd with SMTP id 46e09a7af769-7dcc7aa282dmr8098490a34.6.1777044290285;
        Fri, 24 Apr 2026 08:24:50 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd9a0847esm9683008a34.17.2026.04.24.08.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:24:49 -0700 (PDT)
Message-ID: <f707ffcc-fb6e-4da1-a91f-5ed37e10cc0d@kernel.dk>
Date: Fri, 24 Apr 2026 09:24:49 -0600
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
Subject: [GIT PULL] Block fixes for 7.1-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block, that should go into the 7.1-rc1 kernel release.
Nothing major in here, mostly just some generic fixes or fixes for
issues introduced in this merge window. This pull request contains:

- Series for zloop, fixing a variety of issues.

- t10-pi code cleanup

- Fix for a merge window regression with the bio memory allocation mask.

- Fix for a merge window regression in ublk, caused by an issue with the
  maple tree iteration code at teardown.

- ublk self tests additions.

- Zoned device pgmap fixes.

- Various little cleanups and fixes.

Please pull!


The following changes since commit 5bdb4078e1efba9650c03753616866192d680718:

  Merge tag 'sched_ext-for-7.1' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext (2026-04-15 10:54:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260424

for you to fetch changes up to 895a9b37917d2718ef2240a7ead7458c22f1f011:

  Revert "floppy: fix reference leak on platform_device_register() failure" (2026-04-23 05:07:37 -0600)

----------------------------------------------------------------
block-7.1-20260424

----------------------------------------------------------------
Caleb Sander Mateos (4):
      t10-pi: reduce ref tag code duplication
      selftests: ublk: remove unused argument to _cleanup
      selftests: ublk: enable test_integrity_02.sh on fio 3.42
      selftests: ublk: add ublk auto integrity test

Christoph Hellwig (7):
      zloop: fix write pointer calculation in zloop_forget_cache
      zloop: use vfs_truncate
      zloop: improve the unaligned write pointer warning
      zloop: set RQF_QUIET when completing requests on deleted devices
      zloop: factor out zloop_mark_{full,empty} helpers
      zloop: remove irq-safe locking
      block: only restrict bio allocation gfp mask asked to block

Guangshuo Li (1):
      floppy: fix reference leak on platform_device_register() failure

Jens Axboe (1):
      Revert "floppy: fix reference leak on platform_device_register() failure"

Marco Crivellari (2):
      block: Add WQ_PERCPU to alloc_workqueue users
      block/blk-throttle: Add WQ_PERCPU to alloc_workqueue users

Ming Lei (4):
      ublk: use unchecked copy helpers for bio page data
      ublk: fix maple tree lockdep warning in ublk_buf_cleanup
      ublk: refactor common helper ublk_shmem_remove_ranges()
      ublk: avoid unpinning pages under maple tree spinlock

Naman Jain (2):
      block: add pgmap check to biovec_phys_mergeable
      block: relax pgmap check in bio_add_page for compatible zone device pages

 block/bio-integrity-auto.c                        |   2 +-
 block/bio-integrity.c                             |   6 +-
 block/bio.c                                       |  11 +-
 block/blk-core.c                                  |   2 +-
 block/blk-throttle.c                              |   2 +-
 block/blk.h                                       |  21 ++++
 drivers/block/ublk_drv.c                          | 123 ++++++++++++++--------
 drivers/block/zloop.c                             | 123 +++++++++++-----------
 include/linux/t10-pi.h                            |  25 ++---
 tools/testing/selftests/ublk/Makefile             |   1 +
 tools/testing/selftests/ublk/test_batch_01.sh     |   4 +-
 tools/testing/selftests/ublk/test_batch_02.sh     |   2 +-
 tools/testing/selftests/ublk/test_batch_03.sh     |   2 +-
 tools/testing/selftests/ublk/test_generic_02.sh   |   4 +-
 tools/testing/selftests/ublk/test_generic_03.sh   |   2 +-
 tools/testing/selftests/ublk/test_generic_06.sh   |   2 +-
 tools/testing/selftests/ublk/test_generic_07.sh   |   2 +-
 tools/testing/selftests/ublk/test_generic_08.sh   |   4 +-
 tools/testing/selftests/ublk/test_generic_09.sh   |   2 +-
 tools/testing/selftests/ublk/test_generic_10.sh   |   2 +-
 tools/testing/selftests/ublk/test_generic_12.sh   |   4 +-
 tools/testing/selftests/ublk/test_generic_13.sh   |   2 +-
 tools/testing/selftests/ublk/test_generic_16.sh   |   4 +-
 tools/testing/selftests/ublk/test_generic_17.sh   |   2 +-
 tools/testing/selftests/ublk/test_integrity_02.sh |   5 +-
 tools/testing/selftests/ublk/test_integrity_03.sh | 103 ++++++++++++++++++
 tools/testing/selftests/ublk/test_loop_01.sh      |   2 +-
 tools/testing/selftests/ublk/test_loop_02.sh      |   2 +-
 tools/testing/selftests/ublk/test_loop_03.sh      |   2 +-
 tools/testing/selftests/ublk/test_loop_04.sh      |   2 +-
 tools/testing/selftests/ublk/test_loop_05.sh      |   2 +-
 tools/testing/selftests/ublk/test_loop_06.sh      |   2 +-
 tools/testing/selftests/ublk/test_loop_07.sh      |   2 +-
 tools/testing/selftests/ublk/test_null_01.sh      |   2 +-
 tools/testing/selftests/ublk/test_null_02.sh      |   2 +-
 tools/testing/selftests/ublk/test_null_03.sh      |   2 +-
 tools/testing/selftests/ublk/test_part_01.sh      |   4 +-
 tools/testing/selftests/ublk/test_part_02.sh      |   2 +-
 tools/testing/selftests/ublk/test_recover_01.sh   |   2 +-
 tools/testing/selftests/ublk/test_recover_02.sh   |   2 +-
 tools/testing/selftests/ublk/test_recover_03.sh   |   2 +-
 tools/testing/selftests/ublk/test_recover_04.sh   |   2 +-
 tools/testing/selftests/ublk/test_shmemzc_01.sh   |   2 +-
 tools/testing/selftests/ublk/test_shmemzc_02.sh   |   2 +-
 tools/testing/selftests/ublk/test_shmemzc_03.sh   |   2 +-
 tools/testing/selftests/ublk/test_shmemzc_04.sh   |   2 +-
 tools/testing/selftests/ublk/test_stress_01.sh    |   2 +-
 tools/testing/selftests/ublk/test_stress_02.sh    |   2 +-
 tools/testing/selftests/ublk/test_stress_03.sh    |   2 +-
 tools/testing/selftests/ublk/test_stress_04.sh    |   2 +-
 tools/testing/selftests/ublk/test_stress_05.sh    |   2 +-
 tools/testing/selftests/ublk/test_stress_06.sh    |   2 +-
 tools/testing/selftests/ublk/test_stress_07.sh    |   2 +-
 tools/testing/selftests/ublk/test_stress_08.sh    |   2 +-
 tools/testing/selftests/ublk/test_stress_09.sh    |   2 +-
 tools/testing/selftests/ublk/test_stripe_01.sh    |   2 +-
 tools/testing/selftests/ublk/test_stripe_02.sh    |   2 +-
 tools/testing/selftests/ublk/test_stripe_03.sh    |   2 +-
 tools/testing/selftests/ublk/test_stripe_04.sh    |   2 +-
 tools/testing/selftests/ublk/test_stripe_05.sh    |   2 +-
 tools/testing/selftests/ublk/test_stripe_06.sh    |   2 +-
 61 files changed, 347 insertions(+), 187 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_integrity_03.sh

-- 
Jens Axboe

