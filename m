Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628A48A2C3
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461255; cv=none; b=KnM+YPDi/r93owMfwyNEIaDUwxLQG81ZKtqXM/fd3SG+HCo/rbQJyKfHCXGXg0tubMVn/ooeda1TCMG5FTqKk4hDK6emUaeci9/3zK7kp4aQCkz5bkvXtwlUyU/LrpVp9cCrI+EFDivMMTqAOVeySB2L6uzT+P0r8eKj7LlRasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461255; c=relaxed/simple;
	bh=mMnIRUx9uBCAogbRbbeRXnqqhUuA70DoXdIBREBFHxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lsusStEvDfpjt4QIBTmiT5bo5klPy27KBMxnA8QKcA+XQKHgFHbHD3xIXGFWNHUCCiOdPU7PuyaDFvPpDXcj8Jw21WgjpjW0+QInnrgJpW3ICmQjpcTpDeaurJpkYEi/sz+hRohkwY7fpzmBcdA0hipU61haEjB4FmJVu6XGbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ip5cVX3N; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ip5cVX3N"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f9bso31328015ad.3
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789461252; x=1790066052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwYuAUVTEM1KZY8XIMf3dOzuS7TDv0+6YLYzPNZ/wUM=;
        b=Ip5cVX3N28zPJTWC1Di5w4pkmN0nB5Gto/nBoZ2F5TmhCc3X+QjzbTSx1zVfj1LJa2
         EPDo7sU4SEy0m+Im2nnuMMev124T0D9fBxDAr9btY33qT5929l7HyQS+vOQKRDWOPCos
         PTzr+ziGt4U2maKgE12QLzqZNMDltAeRyOJKlzdB+rikOhfPd0LG89pX5pszsEI1o7WC
         TeP5x79aCxbPMJnln+newI2IAblnQctppRquuroYzzEVnn1RtVvS5IEQw52AvlD6Nzje
         pOXKrzIAWGkrO7OZmM+O+RUX3bNa+4qdVLy97SmJn1r4OmnUCDH/eXUkI4bbAXwIQVxQ
         T2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461252; x=1790066052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwYuAUVTEM1KZY8XIMf3dOzuS7TDv0+6YLYzPNZ/wUM=;
        b=VrhCvKoTgEIbwXCX6oXK/w8+ACkm1wWK2LsstkCtN1uWnWIIC2EeARnVtGRsIvLiBn
         BjrKZhIjw9Jv6GBmZYGSuTNxENSDNrDs1JcsoOijU3xSaXuAUJ1QSw568ihO2ZVHrYW4
         Uw/4NpFi1CwUtSMTZFV2DMy8xwAE1Sota8e+Db9yr6x37uF4BEUI57knK99YPwjy96iU
         7gZhaVOKGAgNcBpZPvHO2d2vUw2okqdxFLvsJuuehjmkiZkshHrdA136zNCFMaMHv95q
         6ZyYdXdpzeE98TVBxxWlFS1xmDHOQ4mYhhP2Nry5lDmmqQmmpQ8OH357VfHefv4XicF5
         PFpA==
X-Gm-Message-State: AFuF++mPALsta+RRR4It1lr32TXg0dRq9A/rJ0UsmBSGyYUC28qdpl6q
	alz+Yj9TjmByIr9aUjqlRb+0dqjDsRo8LWIX/8f63mNtky6pwwCNeWAL90bi5JxCHrS6Mzc+gCW
	x2H1Gmzs=
X-Gm-Gg: AYBFou3r8jt/JKmG3akrWE0/RIUH0JAMYt+0BN+WXCM8X1gwcvCXH2x3GTqW7Aw8W6n
	y5tZrjWISw/ieYYnURzq/sk7IbsTIY92gEz0iO1bMEhYAC5bjkLThAfyDUi/MziFKZiUw4PZG/4
	Jt6XUPnEDP8uWU1oDwqxPhtb5/Wit/k1x2cnb2E9i1882cBdaKLS6mwnGKojpTu5LTC9Ig+yeid
	jTS2lPWK9xS15EW+SdQN230XUeiQKFD1PYh13ZIOTXbLXi1MnvdW3nxoRNXVK3N2Zd5bJXnrDIi
	IWPAUnz05xiBz8RY+qv2BxuKDO2lZizYnXPe4jD7y3MoA2kB/MRn/7qA3algKTuFVOfmE6hQ3Mc
	BCEcxCoypRsQAG0xY+QMZhInnQ1F6oqH16xLXx+Qc5ela1XikCQxv66A87PWebzIB5QaoSWG88x
	qkniIM2T366TGdey8mHhUUZ0Y9y1w8M0J9gRUkmomR5v8NfZUq+4CfKJ3EwOcjLVIvqGbf8s55
X-Received: by 2002:a17:902:fc4c:b0:2d9:123c:8c49 with SMTP id d9443c01a7336-2dd6c6db8b7mr146833195ad.14.1789461251905;
        Tue, 15 Sep 2026 01:34:11 -0700 (PDT)
Received: from localhost ([106.38.226.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca268csm62498695ad.1.2026.09.15.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:34:11 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v5 0/3] memcg,writeback: flush foreign bdev mappings separately
Date: Tue, 15 Sep 2026 16:34:03 +0800
Message-Id: <20260915083406.3471036-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series avoids owner-wide foreign writeback triggered by dirtying
shared bdev inodes. Instead, it tracks bdev targets separately and
schedules writeback of their mappings.

Problem
=======

Bdev inodes are commonly shared by many memcgs. Dirtying their pages
can cause the owner wb to be tracked as foreign, triggering writeback
of the entire wb rather than just the bdev mapping.

In production, almost all the foreign dirtying we traced came from bdev
inodes. Across our observations, a bdev mapping had as little as about
10 MiB of dirty pages, yet foreign flushes targeted the entire owner
wb. On one machine, we observed 599 such works queued on one wb, with
an average request budget of about 43 GiB per work.

Measured impact
===============

The synthetic test used a VM with 4 vCPUs, 8 GiB RAM, ext4 and cgroup
v2, with device write bandwidth capped at 200 MiB/s. Background fio
repeatedly overwrote a 256 MiB file using buffered I/O, while
foreground fio performed sequential direct writes. Four memcgs
generated metadata and buffered writes to trigger foreign flushes.

We measured completed block writes to the background fio file,
including final sync, and foreground fio bandwidth, latency and
completion time.

Across three runs per kernel, mean background file write I/O decreased
by 72.7%, foreground bandwidth increased by 23.0%, and completion time
decreased by 18.8%.

Metric                         Baseline    Patched     Change
Background file write I/O (GiB)    6.154      1.680     -72.7%
Foreground bandwidth (MiB/s)      150.29     184.81     +23.0%
Foreground completion time (s)   109.203     88.652     -18.8%
Foreground mean latency (ms)      212.84     172.74     -18.8%

How it helps
============

Frequent writeback of the file overwritten by background fio reduces
the opportunity to coalesce buffered writes in the page cache.
Several overwrites of the same page can otherwise result in a single
write of its latest contents. Flushing between updates instead writes
the same page repeatedly, generating more device I/O for the same
application writes.

This additional I/O makes the device reach its performance limit
more easily and competes with foreground I/O for device bandwidth.

The benefit is expected to be most pronounced when these conditions
occur together on the same device:

1. Limited device bandwidth, as with an HDD, makes the additional
   writeback I/O more likely to saturate the device.
2. Multiple cgroups perform buffered overwrites. Frequent foreign
   writeback reduces write coalescing and increases device I/O.
3. Concurrent direct I/O bypasses the page cache and competes directly
   with writeback I/O for device bandwidth.

Approach
========

Following Jan's suggestion, this series records foreign bdev targets
separately and flushes their mappings instead of their owner wbs. This
preserves a way for dirty throttling to initiate bdev writeback while
avoiding owner-wide writeback triggered by these records. The existing
foreign-wb mechanism remains unchanged for other inodes.

Tracking is best effort: each memcg keeps a bounded set of device
numbers without persistent device or inode references. Closed devices
and devices with a busy open_mutex are skipped. Device removal and
device-number reuse may race with lookup.

Flushes run asynchronously on a dedicated workqueue to isolate these
frequently triggered tasks from existing workqueue users. If workqueue
allocation fails, the existing foreign-wb mechanism remains in use.

Thanks.

Julian Sun (3):
  block: introduce bdev_flush_by_dev()
  memcg,writeback: flush foreign bdev mappings separately from owner wbs
  writeback: record bdev targets in foreign writeback tracepoints

 block/bdev.c                     |  24 +++++++
 include/linux/blkdev.h           |   1 +
 include/linux/memcontrol.h       |  15 ++++
 include/trace/events/writeback.h |  22 +++---
 mm/memcontrol.c                  | 113 ++++++++++++++++++++++++++++---
 5 files changed, 157 insertions(+), 18 deletions(-)

-- 
2.39.5
