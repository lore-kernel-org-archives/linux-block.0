Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F433F588
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 03:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839761; cv=none; b=I0seQsGiKxrIGlC6dXb+TLW506ZS7VOH62GEzO1JVHnj5+O6GBw4BIVViRH/FQEiMLzyaxgn82TK+ZUZYrWUjEon8BzeGUBOdvwr2F3by9jzKY1MXIfzcHlh3f0pYklXUPZwTxyMGzx6XTsJArnLTMpLWhZUJUE+uf7vU47GIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839761; c=relaxed/simple;
	bh=UpwULMAQfCTXXueNplwRdhKskZCu2AP4fUjs6O0OI6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ9Mzg71NPXtJyfMhd95fqA3C8W5LoQCqFniNqHK7607vyNmeFp+/vcy0eKfXV72H5zr6zcZsFE+VVlfJAnoEjW1FdCtYMxtcjloR5j2VKYgSPARPLkolPCainqyKS5/siDKS44/zTR5avrwqNdPbIg6+v/uK201v/L8WhUsPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APC513oH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APC513oH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so30910245ad.1
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 20:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788839752; x=1789444552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PPQzWxuhw7pZTs+zszzFmSn4KI/x61XrCe5D1SPsyZk=;
        b=APC513oHcMgoG0pBd4QQdjGIchbs8RGCghmNylhuUzJlP7e5v3a0IJ3kch+cMwDVbt
         G2R7UbM5KeWhaqnCL+JGVWCWwCKJDcDcQaB+f0Jb/OmRrx+eT5kJTpYJ0SDwL3xd2K0v
         DT6VduHgnY7L12mpYj5kxeVGRb0gCHcIMVDGrVb9fjTF8/DEXBGvJgNR6pB0rcz2GXh1
         hYKZR4bfaojpbeiMWWu+HEMmy+ol0OvvN387QVgzXVfw/URh9SnzAHPSmkQXJpo5zRPs
         ZM615mNj8BkAs1tAGj1Ne97MXlFtJDKLW6Ln2vtKEb/XA83+U2C7jvJnaK5+cA+DRVg/
         /Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788839752; x=1789444552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PPQzWxuhw7pZTs+zszzFmSn4KI/x61XrCe5D1SPsyZk=;
        b=JBxcLiyGMwEciVNHKAcsYX1wSizyRuKiYiib67phs5M1YnAEUU7n0/FlckT5wGvEKz
         0QbOq6UICz+ZFc33Yc66FMrDmn9B3s0oJ4CVFLIgFv4o9VbNCmc9Lsy6QBWsC5n94Ea5
         LNkemDhIZgO5ELck1EBs2HrpKDnXFco9OetZJ29M91B60OK9HslY8MyeKYsN/T7+97f2
         a3VY+nwijILsL9PfqHI8o/Sdn+4IDf3LrVefGiWYEFH6Bdq7moUxy5x1CSgWGz7P1s/V
         DqciODKW/dAQ+gG0XZfzD7jR8PTXUFyzHhwr2+mM2c1hSLQ+fvGXFVmPwQKrXJ5zZHiG
         aTUQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7C1hI7iKrfbAdITBzEEbNMZ0cERwpWT6DjVo1Vea8EFQxaFtx4vSkPJ8SdornOcVN0v2+9mvtnII4Ig==@vger.kernel.org
X-Gm-Message-State: AFuF++lsi1NlN5XU+C2NcVEYX/oHlt7EdhOYiuSBkt4nzezmNlSht4iv
	62Z+y/JhIDgYpNstT6MVmvxD0zs/gXGCofrWEOnONkbSbAdZZUerN5gC
X-Gm-Gg: AYBFou19fEemPlPySH66WbFF8PVKA2x9OKoMOfEwB6IMydbYSzk15VbwzmkJzjf7Wjv
	kGCWW1/GWq3XS3q/86G6/LxdCZNkq7hFgHH5WUNzluHyoepUuFSsfWvO71N/KvifmAfQdbegIHA
	iN7d13hYa1P/ZuCiXb8MRK3MU7gEz6l/fwjAk0K0Tbqs0+VPzgxs8xKY+NhpqjRSYvBSo+IVD5h
	2G8P5p/x2xDHOADFDcJlOHcMc458HTwuiu6+5C0E3Hj0/ntqRjnvstn4baEha10RntZkI+qWJRB
	3uDs3DtSXZvZE0j33TlcJuw6L4OK/5QAoh5wj5OwPwX1UkhBdmydD0vBT9H17FIG/QEPZwHOjj0
	OTnWDO6n+fO6bMptJ3Cq9HhIhgOkQ1oCGmjo6hMn5QyIJwEoVbY8S9mbbMnuPCuPev5jZZh9V3H
	pN5jnmLGaUuoz4byriHh/uBAXPDLeo137XAbc51Uv/Q7a2QMk6J6j4XzaH+T4GJoNu+oej3YJs8
	jyYhLVm3jtJtLay/oPkAhEQ
X-Received: by 2002:a17:902:fdab:b0:2d9:599e:df95 with SMTP id d9443c01a7336-2db122edaa3mr386816705ad.3.1788839752025;
        Mon, 07 Sep 2026 20:55:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14aeaf74sm51899295ad.81.2026.09.07.20.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 20:55:51 -0700 (PDT)
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
Subject: [PATCH v5 0/2] f2fs: enable buffered RWF_DONTCACHE
Date: Tue,  8 Sep 2026 11:55:41 +0800
Message-ID: <cover.1788795700.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788438786.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
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

Patch 1 marks dropbehind write bios with BIO_COMPLETE_IN_TASK. Normal and
dropbehind folios may share otherwise mergeable IPU and OPU bios; the flag
is set monotonically when a dropbehind folio joins an existing bio. The
block layer owns deferral from unsafe completion contexts.

Patch 2 passes FGP_DONTCACHE to the F2FS buffered write folio lookup,
advertises FOP_DONTCACHE, and handles internal write_begin callers that
pass a NULL kiocb.

Tests were run on a Xiaomi phone with 10.7 GiB of kernel-visible memory,
running Android 16 and Linux 6.12.69 with 4 KiB pages. /data used F2FS.

The performance test wrote exactly 64 GiB per run at 4 KiB,
8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, and 1 MiB.
Two counterbalanced rounds ran ascending normal-first and descending
dontcache-first. Values below are equal-weight means of both runs; N=2.
The pwritev2() writer models the streaming workload; it does not show that
an unchanged Android application already issues RWF_DONTCACHE.

Android remained active with displays off. Each run started after a cache
reset and at least 120 seconds of cooldown. Throughput and one-second
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

Dontcache left zero target-file pages resident at every size. Normal
retained about 1.19--1.24 million pages. Normal runs incurred roughly
15.6 million kswapd page scans and steals per run, while dontcache recorded
zero. Direct scan and allocation-stall deltas were zero in both modes.

A controlled explicit-dontcache model issued 64 KiB writes for 120 seconds
at 64, 128, and 256 MiB/s. Both modes sustained all three rates in both
rounds with no final schedule overrun. Between 0.02% and 0.41% of writes
completed late, with a maximum schedule lag of 3.3--6.0 ms. Dontcache left
zero target pages resident. This was a controlled model, not an unchanged
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

As a separate memory-pressure supplement, I tested F2FS on x86-64 QEMU
with the F2FS images backed by the host NVMe. Each run issued a 1-GiB
homogeneous sequential write using 8-KiB or 1-MiB I/O. Normal and
dontcache each ran in three counterbalanced rounds with
memory.max=255852544, memory.swap.max=0, and formal tracing was disabled.
Values below are medians of three completed runs.

 I/O    N done  D done   MiB/s N/D        memcg MiB N/D
 8 KiB  3/3    3/3      236.259/227.634  160.867/2.075
 1 MiB  3/3    3/3      222.232/859.805  155.178/9.098

 I/O    scan N/D            steal N/D
 8 KiB  270,821/0           201,227/0
 1 MiB  344,267/0           201,013/0

Scan is the number of pages examined by reclaim, while steal is the number
of pages successfully reclaimed. memcg MiB is average memory.current.

At 8 KiB, dontcache throughput was 3.65% lower. The paired changes were
-12.7%, +65.8%, and -3.65%, so the direction was not stable. At 1 MiB,
dontcache throughput was 286.90% higher, and all three paired changes were
positive: +96.1%, +257.8%, and +295.8%. Average memory.current decreased by
98.71% at 8 KiB and 94.14% at 1 MiB. Dontcache recorded zero scan and steal
in both profiles.

Changes since v4:

- allow normal and dropbehind folios to share write bios, following iomap,
  and set BIO_COMPLETE_IN_TASK when a dropbehind folio joins an existing
  bio;
- handle internal write_begin callers that pass a NULL kiocb;
- add QEMU memory-pressure and mixed-bio measurements.

Wenjie Qi (2):
  f2fs: complete dropbehind write bios in task context
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 15 ++++++++++++---
 fs/f2fs/file.c |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.43.0
