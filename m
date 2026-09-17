Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF4524B17
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651801; cv=none; b=J/hGaGEq7nl4xxkf1fIysY8+7FMWBM6ZNWzaiat7Owplv/7lUSc07NZ2tiOcoi83TSmzMDsUt974Y56yfCI5ziA230kVbRQ3awumtCBw2e9hd+liQ+Gj9/sLPV/XnKfCF7WZWm0BYCBfv8+sy9pB6NuEfQUy1Hj59KL0zDid9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651801; c=relaxed/simple;
	bh=dXnLeOc9+ZJIVZID1P8Qpbq024iE85sRajVA+G6bckA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxaCGg+DYUj/oU5yr51UTQqlxw+9AMJdti+I9eCWI0Sa3g5WFHrkPsI40Y/EPA/RpEtXRmj0K9p0+OczBhB4OOrcsjemsPNiiDn21ZZ8uz68hdjATJGwZLeorba0K5arzJO1r34ICAUgjP+V/DY4WhG7uxa3Vetv8ZU2TYPrfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=0GpUkFTJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="0GpUkFTJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so5111945e9.1
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651793; x=1790256593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kc8SSZKaYeSDYTduIzKtgY7SY2vSIslvd8ziXmdFBEs=;
        b=0GpUkFTJ1DzSFvpaCcNcrf1B3dKDAuuztdNJ0x80FEwlnEsOeALHBcMKTM+KKK93ys
         96iFRHCFoy9slyl5POGPVU5f+kITrRrEVO0QKFfJqiJKt008upMW52trd7nGn9B9h45L
         VonzcCpLLCKrFMeZUVxCRs11Nx/If2g4BRfnpBd25SmJIn6RQgHbFdwskvINnJ43aW0S
         p5L5E2S+UtpEZBdB6Cgm0ORNTIE+H6ZfggBHrpye41dB1SKU//9fZBY7Tr/svCJ1LiMh
         jg5VKHjbNh+k7V58asMTv1FqkLJyYF7AR2UBkrSVLyK7wZXMuvZQOLUnNk73ogHxlz82
         V7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651793; x=1790256593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kc8SSZKaYeSDYTduIzKtgY7SY2vSIslvd8ziXmdFBEs=;
        b=tk0ggPFH7c+31oJf7YNCGfoTvZg055a94di6izvi+UIqhUd+jEo/6UIb38SOfJveVr
         WnHSfiuRvm+b6IU43z/2bW5qfR45f2iECBbImZ6am/lN5F1d3AuQPI1Hb4Dvkx6QDdAn
         cwV7o9oa0cSqK5VG3l0LeBDh/cjj/SZZUsHGFeZ7uQUQ/j5K51J9MV/bdQ2qvmeC4IRd
         5xvrrEYAmZJSpKrg21Ax75FwWrSLEDKQDvK9sxzyRf4na/lInP/G5q8fE0pT/YqvUJHq
         xV6pNwdmK4HcXGbhKM8o3D56lROtVN7aWkuyMblZCuxpjyzpoMnedPc9w1mKWij8EjJk
         0MGw==
X-Forwarded-Encrypted: i=1; AKwUvByQkomXNRKjK/AsuKP+3XnTFJu1n6hhMrfvXkxmJkAtLbxHbJCz3mgpn/vSQkSYwrnrqblIQCP+Ea+Pog==@vger.kernel.org
X-Gm-Message-State: AFuF++mkjoniTc07KMgcBrNYbYtn0SzCmocOhhxlfMzkTWxdnHee7aD5
	lPURXfDEeYYBp7YwHQ+G4clKSbCXkSHDXzf+Ao4WtaVZ0aOz14uxznl7To+xWW8b6Q==
X-Gm-Gg: AYBFou1MKEQec+EkXy/LhRJDdhillHpWRjZEze0WHXp2GR06l3FDaQnMSHrX8Z+kj/f
	RuhzANQILA8/awukKD+MsfEU+0b39YRJoT8cfyT/Y/jK/OlyE4r+GFa76rbw4VlWSaMjuubH0eZ
	Dro6OYuIR8OOAITfyBFqC8/wgjdNiHAjSkODS8qu/Q7shYbv4BSxh8os1njcR8fIdudHdYpXJbf
	soSDZwg8GK8fwEd4rO5Si79PQgG5zOPcDngZzwoXXtm1uTcY3doAVvZTs3/AgLB7PlqhUQDoj1F
	mjbjY2d7zyp+oXf4FlOJDHXLHCX/T7eaAPHnFIMgH6+adolvJLnpSBY3xXE60KwlOXPWv5pfqML
	//gtpbNXtQ+qa8rDat/zFVh8XdWp44xJMoxeL638lgXx+FcKAkhiD/WIWhD8iDl9qpdTShdVCNp
	/qfKhV+eX11FJc2+vNABnCEjLEE2Pg871Qr/PSz1NNdycHV9Zom556ZODCvHacQnppwl9crL5H0
	OsY+ZFFvfwib+KmwtNTS6YcGHQ=
X-Received: by 2002:a05:600c:46ce:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49eb7339895mr154172245e9.13.1789651793298;
        Thu, 17 Sep 2026 06:29:53 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd2356d1sm97548275e9.6.2026.09.17.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:29:52 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Evan Green <evgreen@chromium.org>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Subject: [PATCH v3 RESEND 0/4] PM: hibernate: encrypted snapshots under lockdown
Date: Thu, 17 Sep 2026 14:29:46 +0100
Message-ID: <cover.1789651778.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdown disables hibernation because resume restores kernel memory from an
image userspace can modify. This also prevents a TPM-backed uswsusp
implementation from using /dev/snapshot under lockdown.

This series encrypts and authenticates the snapshot in the kernel. The kernel
generates the image key and wraps it with a seed supplied by trusted early
userspace. TPM policy and unsealing remain outside the PM code.

The seed interface is first-writer-wins and does not provide freshness.
Trusted early userspace must provision it before untrusted privileged code
runs and enforce the required TPM policy, rollback protection and recovery
handling.

Tested on StarFighter MTL with Secure Boot disabled, integrity lockdown
selected manually and a TPM-sealed seed. Keyless and user-key S4 cycles
resumed the same process and boot ID with the swap header restored. Corrupted
wrapped data, invalid magic, a corrupted complete-chunk tag and a wrong user
key were rejected. On exact v3, the user-key cycle and the allocation, free
and reallocation path used by swap-write confinement also passed.

Previous version as it was updated whist waiting review:
https://lore.kernel.org/all/cover.1785838445.git.sean@starlabs.systems/

Changes in v3:
- Rebase on current upstream master.
- Preserve and validate the saved encrypted metadata boundary on resume.
- Drain buffered metadata before a late user-key transition.
- Reserve enough encrypted image space if userspace adds a user key after
  querying the image size.
- Apply swap-write confinement before enabling the lockdown exception, while
  preserving the ordinary availability check which routes lockdown writes to
  the confined path.
- Account the pages actually allocated through the snapshot API instead of
  assuming a userspace swap-map format.
- Document the first-writer, anti-replay and userspace I/O requirements.
- Remove an unused swap reverse-mapping helper and tighten local naming.

Changes in v2:
- Keep raw writes to active swap blocked under lockdown.
- Track encrypted snapshot bytes and header writes before allowing
  lockdown-time image writes.
- Split the encrypted stream at the metadata boundary only when a user-key
  transition is used.
- Return -EFAULT for userspace copy failures.
- Document resume meta_size handling.

Evan Green (1):
  PM: hibernate: add seed-wrapped encrypted snapshots

Sean Rhodes (3):
  PM: hibernate: confine encrypted snapshot writes
  PM: hibernate: permit encrypted snapshot device under lockdown
  PM: hibernate: document encrypted snapshot seed ABI

 Documentation/ABI/testing/sysfs-power   |  18 +
 Documentation/power/userland-swsusp.rst |  33 +
 block/fops.c                            |  58 +-
 include/linux/suspend.h                 |  24 +
 include/linux/swap.h                    |   9 +
 include/uapi/linux/suspend_ioctls.h     |  31 +-
 kernel/power/Kconfig                    |  15 +
 kernel/power/Makefile                   |   1 +
 kernel/power/hibernate.c                |  32 +
 kernel/power/power.h                    |   3 +
 kernel/power/snapenc.c                  | 952 ++++++++++++++++++++++++
 kernel/power/snapshot.c                 |   5 +
 kernel/power/swap.c                     |  87 +++
 kernel/power/user.c                     | 272 ++++++-
 kernel/power/user.h                     | 150 ++++
 mm/swapfile.c                           |  25 +
 16 files changed, 1683 insertions(+), 32 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

