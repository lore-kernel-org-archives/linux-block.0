Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509213F7869
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440410; cv=none; b=Lpzm3EDCGP3HRjCHjjnKIYAfJPGU511e9DpzM6KVQbDra7JhwoiEsoUKCF6Y6r4ZlPMaLYP44aDZ2/NUi37Pc9blARxz1MfaC3/e8mJ7ViIzTCHSKIEPciB5rhCeo2XHp93ZxNHAStKQ3gRhlrR6Ff8aC3WFTc0rQ1WMjJUxtJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440410; c=relaxed/simple;
	bh=4+P9nneWcuishzT1eaSG3vRCHDAcoPq8z8fmuq4UY7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI4X3bCbJTBbkc8kc1F+51+f9Z5Gz1GsuAeM0YG72MyPp5WA+NFIWVOosVoUEgGzHqOyYy/MB03d/BlZ6IAtS96Hai4YLtxpHW0loG8dc0g3xziZWRBCv5D6PG8c1NaO+iwe0wV1b5JpZMltJPhOhy5gbAn8KMpHto1Fl60UBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic9xycFh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic9xycFh"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e27035206so2102723b3a.3
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788440403; x=1789045203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ySykvbIWmO4Te6vIVwftEuMOLYpDg3lGaudbSYAL6eg=;
        b=Ic9xycFh/kSMjnqE+WaTrqY9u8NkqH+XPdI3NZG1Yym2kShoVf7zJmxZ7XJXR9zdsU
         uLymiEB/j/v7T35j3RoE78eQCveH1+YfL/w0+hWbuYBDrxu8YLek+9i7jRMKzmXzAIjV
         MYM6ucI/MT3UzjskseGapCDz7p0ZkkJLohMWMg3UIn9kzgUVEt+wPPw1SSoz/SntbeJC
         vq03oCvU7VrQqaC4ZmnhO/5x7DUlDsUoDzlXfQjnoWH+F7EynOeD/pB78Rbt+Ma9I3Bu
         Fq+FTEj+Gp+isv3GQyJzAkeVrc6Fj4RXG0rAPK1ZDuDQ1qcNhhHW46BuOHDJ2435XkkA
         d0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440403; x=1789045203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ySykvbIWmO4Te6vIVwftEuMOLYpDg3lGaudbSYAL6eg=;
        b=l5AnrsmqGR+HI0gQKwZ337a6i53r2nn0/mJVfT6DG72gOLuSXYdAaNlSCVU32lkmvS
         DI5ctReBNJQT2w03YdqFvYUmUCg5l+Y6Rr6ODrMcbLuH0p+chKKZTmzF0iZBhseKlAJm
         NXDVZyUh+8wjpY+vCvYESRwDB5l1AhdOWq36PwBGFjAKFwBf7y/wVK8Y1SAR9T3h5dbp
         rMfkJK0Sc+nIvMUvtpLNj1wDxeLytvedA/9uu36IR7g/3vJXBhWSVG6WzlTaLC1i+JKE
         srhkbWLh0BsmYt+xJkzJ7oiWjnIo80kY46vwr65LOW2UKl0O1D0od3iFagrNiPczdIRN
         gOyA==
X-Forwarded-Encrypted: i=1; AKwUvBz7TmORbsSIqIzKMEJBXEbrdf2hNvUHszQZquedooptqk2OF9/ytjv18EbuF9TrssPkbmMitowc9afKYw==@vger.kernel.org
X-Gm-Message-State: AFuF++lfQpgeDvAHIIrN07408vGM9tGKIzDxHYLMPhm80R8eGpuGQply
	VRfO7zoi3UUz3G9a3VjgxX0jAFwqbFX2GIKJEWNxR01xeLWFnxkJAq4j
X-Gm-Gg: AYBFou32KTU2mUrwHWROxhFntAe00U0MxA3kY42ZTpv+s0NUvMEJAEQORcnKFqHu9Xj
	up3XjVR+F86qI3FXiCqubKUR1+iJE3nzfnpmuWs0fQmLS0A9Lbm58P3CzEG6WVgLUV1oiesTEFB
	JEhBcrM30hh5GKT+EdMefjoGFrbFJr0iwve2S4zTmU2F/g72rmXkj3vO3Ka/L43HTk7u9L3R4uE
	WD1RAvBcBNceLWSBGL03ArEplgneYXExxffsisWI0F9Lin7EeIb7rJwTAoccA21aLH6RFFkXRvs
	j8Br5BxOROzU+3wt+pBN5OW4t5ni/cOR3GjBJjL9KGJN68XQIb9ruCFdoC6AfKDxs47AUD32E7o
	qbNprCb61leM8hMuEH49fIP/QfKyGTHUNNTjxAZaU10eKv+fAsDDP9MAsAg+wOscd/Hcw8egnSe
	Vu8KiR3UKTjK2YQkF8TZ/vJjnAdbcfg0bQU+/0DJmrYFGvIan4ih+Vc7Dt/7JVKMeHjyAHWCPiC
	Xyoz9hEkLkbIuY//QEJa5RA
X-Received: by 2002:a05:6a00:189c:b0:848:4754:28e4 with SMTP id d2e1a72fcca58-85ed3895332mr17366905b3a.15.1788440403103;
        Thu, 03 Sep 2026 06:00:03 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db23f7bccsm2980946b3a.10.2026.09.03.05.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:00:01 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v4 0/2] f2fs: enable buffered RWF_DONTCACHE
Date: Thu,  3 Sep 2026 20:59:51 +0800
Message-ID: <cover.1788438786.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables buffered RWF_DONTCACHE on F2FS for sustained one-pass
streaming writes, where retaining the written data can displace more useful
cache.

Patch 1 marks dropbehind write bios with BIO_COMPLETE_IN_TASK and uses the
same flag to keep normal and dropbehind folios separate in the IPU and OPU
paths.  The block layer owns deferral from unsafe completion contexts.

Patch 2 passes FGP_DONTCACHE to the F2FS buffered write folio lookup and
advertises FOP_DONTCACHE.

Tests were run on a Xiaomi phone with 10.7 GiB of kernel-visible memory,
running Android 16 and Linux 6.12.69 with 4 KiB pages.  /data used F2FS.

The performance test wrote exactly 64 GiB per run at 4 KiB,
8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, and 1 MiB.
Two counterbalanced rounds ran ascending normal-first and descending
dontcache-first.  Values below are equal-weight means of both runs; N=2.
The pwritev2() writer models the streaming workload; it does not show that
an unchanged Android application already issues RWF_DONTCACHE.

Android remained active with displays off.  Each run started after a cache
reset and at least 120 seconds of cooldown.  Throughput and one-second
kswapd0/global-memory samples cover the write loop.

Write-loop throughput was:

          normal MiB/s              dontcache MiB/s
 I/O      r1       r2      mean      r1       r2      mean     change
 4K      946.28   935.74   941.01   291.36   309.31   300.33   -68.08%
 8K     1077.05  1105.84  1091.45   477.79   479.79   478.79   -56.13%
 16K    1126.84  1118.49  1122.67   643.40   652.06   647.73   -42.30%
 32K    1150.62  1036.33  1093.48   762.24   751.45   756.84   -30.79%
 64K    1144.80  1163.82  1154.31   852.11   851.19   851.65   -26.22%
 128K   1166.29  1162.84  1164.57   867.47   865.05   866.26   -25.61%
 256K   1153.61  1172.78  1163.19   895.53   885.33   890.43   -23.45%
 512K   1173.61  1197.34  1185.48   903.09   903.01   903.05   -23.82%
 1M     1126.22  1154.59  1140.41   850.74   894.60   872.67   -23.48%

Average kswapd0 CPU and average global Cached were:

 I/O      kswapd0 CPU, normal/DC        Cached MiB, normal/DC
 4K             18.45% / 0%                 4830.15 / 686.56
 8K             21.60% / 0%                 4862.35 / 591.48
 16K            22.75% / 0%                 4905.47 / 625.07
 32K            22.05% / 0%                 4945.82 / 561.59
 64K            23.46% / 0%                 4920.77 / 639.78
 128K           23.16% / 0%                 4971.37 / 693.26
 256K           23.68% / 0%                 4956.93 / 668.60
 512K           24.25% / 0%                 4972.22 / 663.92
 1M             22.01% / 0%                 5001.09 / 705.30

Other global memory means were:

          MemAvailable MiB       Dirty MiB          Writeback MiB
 I/O       normal / DC          normal / DC          normal / DC
 4K      6513.08 / 6382.31     640.48 / 33.93       37.94 / 0.09
 8K      6560.77 / 6529.33     690.89 / 43.57       40.84 / 0.54
 16K     6587.46 / 6519.94     789.16 / 62.67       61.58 / 4.64
 32K     6571.95 / 6566.74     850.48 / 69.14       67.69 / 9.24
 64K     6600.64 / 6559.89    856.97 / 134.28      59.60 / 16.19
 128K    6627.03 / 6465.10    873.68 / 137.57      60.57 / 41.50
 256K    6615.58 / 6541.09    885.98 / 158.15      61.25 / 29.57
 512K    6625.52 / 6534.41    900.65 / 139.07      63.65 / 30.35
 1M      6677.09 / 6539.89    909.70 / 187.56      51.58 / 33.46

          Active(file) MiB      Inactive(file) MiB
 I/O       normal / DC             normal / DC
 4K       279.57 / 264.13         4426.38 / 183.12
 8K       262.32 / 260.97         4472.62 / 182.19
 16K      392.09 / 252.95         4392.78 / 195.82
 32K      254.30 / 248.44         4554.18 / 187.34
 64K      252.73 / 244.94         4545.40 / 267.28
 128K     322.02 / 243.95         4530.63 / 298.91
 256K     245.47 / 240.02         4586.64 / 303.92
 512K     254.75 / 232.05         4591.17 / 288.27
 1M       238.88 / 233.64         4638.81 / 341.00

Dontcache left zero target-file pages resident at every size.  Normal
retained about 1.19--1.24 million pages.  Normal runs incurred roughly
15.6 million kswapd page scans and steals per run, while dontcache recorded
zero.  Direct scan and allocation-stall deltas were zero in both modes.

A controlled explicit-dontcache model issued 64 KiB writes for 120 seconds
at 64, 128, and 256 MiB/s.  Both modes sustained all three rates in both
rounds with no final schedule overrun.  Between 0.02% and 0.41% of writes
completed late, with a maximum schedule lag of 3.3--6.0 ms.  Dontcache left
zero target pages resident.  This was a controlled model, not an unchanged
Xiaomi application.

Buffered read throughput was:

 I/O       normal MiB/s   dontcache MiB/s   change
 4K          1825.50          1695.10        -7.14%
 8K          1901.46          1847.96        -2.81%
 16K         1941.60          1872.55        -3.56%
 32K         1960.95          1905.92        -2.81%
 64K         1951.35          1886.54        -3.32%
 128K        1960.03          1915.82        -2.26%
 256K        1976.01          1900.41        -3.83%
 512K        1973.31          1911.24        -3.15%
 1M          2230.91          2007.82       -10.00%

Dontcache left zero source pages resident in all measured read runs.

The normal-I/O control showed read-throughput differences of +0.67%,
-0.90%, and -2.58%, and write-throughput differences of -1.75%, +0.33%,
and +2.33%, at 4 KiB, 64 KiB, and 1 MiB respectively.

Changes since v3:

- use the common block task-context completion infrastructure;
- rebase onto the current F2FS development branch based on v7.3-rc1.

Wenjie Qi (2):
  f2fs: complete dropbehind write bios in task context
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 27 +++++++++++++++++++++------
 fs/f2fs/file.c |  2 +-
 2 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.43.0
