Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C32544D44
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081423; cv=none; b=GO0scnAr11AiMDhlVhLmWbBJoYU3UK/hj3qIx27r1EoiCknh+dvbTKMFYcwKB2BQDjvhtZhzXmYUTRw/6C2XGxT2rC1+vgfuqRLh3B8t6CnxSVx2OQqLU2eXwuZRd3cc6phctr6znVv6DxThljFBfQTxNlFUtaIKysQ7PMLBo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081423; c=relaxed/simple;
	bh=sfT0ReNI6GyVvGi6FnZ/iXBQMqAlHEwH/dc2Hs7IQHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WcdwbrZiF/yyW41E/ETPzkMO3t4QxyKqA6avJC4yBsLAq/40jvVXwEDIhtYceO0QoLqMDu1rYUUdIGdnhUlp8mr8ps9VzMuNqPg4mutB/snbTtMjeBwJIENNOoz3IGoFq6HW4i1leyFIPP73gsmWrk3lTvNJ+ryWO8hNiNFIzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WGRhndBl; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WGRhndBl"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso887533a12.2
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790081420; x=1790686220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2IeG2Mx3Kg57XaeZod52dBSPgeiNTM4UZ90mALN/kFk=;
        b=WGRhndBlIXJQAj63tLNqw4hqwMgGYT/mtc1hEzePIQoOuu3WF8V7/o+zSZQUFE6n2n
         3Q6m0pLz4KsKCE0XNS4C2JJ1ie8r0A4U1/BoxqDHyuua7rwWwzzjGKSHeCCxetSO8EN/
         P2qDjDdW46GNoPxvXkhD1QUB56v8LHHWXDA3i1uNobVniuyCIxKx2LGraepg0SozBqXE
         0h98Zt2RC3wJ805Rkq8j/RUnv5QDpoSAgH5p7/KtKr/ONQEt9clbcXcRgagf1E4iU0rt
         rwq42uc0WeuGBVVCa1lZM6za0oS8f/zBFLtQesVEuevQHoPkrNwMFZCO3VlJ0nPY4PoQ
         GcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081420; x=1790686220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IeG2Mx3Kg57XaeZod52dBSPgeiNTM4UZ90mALN/kFk=;
        b=njDMWHPY1rwyHxmDYAebRv+zxOUWjXSfvu229ys5EEvWZYHMTmpm/k1+z6a/BeVA3B
         51qEkUPCLU4YX33ksN0Ccm8HksQahqa3TDUgIwUFRzqDcZ3N6WubZNSqrI/7F1kXz8nU
         pubRJrwMf2RT8rB38Hkoy/MVikPHpzJJxHtWlsgH9Htbr1dV76xXes231J0mnSjxIQuT
         1s3npAei3JWBCp/FHf5IzWGCjieQeG0BWA/BkWJczehwdYDRWW+WgLrzmcuZzG1B9JRv
         NFv2BZnZoo2Cz0b3eXbdgb5K6Pu3XXx5gAnlkrxDYKp3rJcZfS9mc48LXNXNpgY+obxB
         iGrQ==
X-Gm-Message-State: AFuF++mFqN0QwVu42v9+P/yOzrX8Mav7l2OlIar2xq5lT3hpRAoiFtK5
	zd80VP7JFh3zLJghHVEj41H0/S4712x+gnNSK/WlppRDbXrp0vQRIF1S8ITnkq8Y/u+8mHYtOmi
	xMh6d
X-Gm-Gg: AYBFou0BEyoLIAxWuP8lTzjiKTobB5aIDNsnbKVmyQAKzsiuTVlRdHNDH/H++583xJW
	zNYl1BQ2JXmMdjevW0WxdqS4E4her2Lp2SjF+MjiDZLgQYx1OqQDbYSxJD4+q5W0T9oyWydbRfO
	+dfyv3dZHE7St9cM/RC1MAtaLW4eg8kzul4dyUQG3LP8jD9ID2pabhk9j8jR4s0hkWd8rTrtEaV
	itL+rbnsk/cNFcHpI6EynxZY0HtvFiQCcgRDKQccoxRJ09MrEwOj6fEeLFyT7oDf2NowO8mcmLn
	a7+lIX5QTf/F53yVmYaYYyevkvIpRQtWJ3PFTaIBX3KZ6FDuCkEtbupzFivf1j/dK4kWwDg+J/f
	c7FCLvDyJsfOLyihkJaClhkNpr2KuhGjMGEVMAyMUcj/5Wdpnsas/W/s0l7NHsVsS6nVQXqiykU
	HGTIsfXmQSdC3tfD6tFiytzI1NDfKYfvctwH0/21yyykuI+u8TzA6VQuNOIBjevfR9f2M5JzVq7
	c8=
X-Received: by 2002:a17:902:f60c:b0:2dd:ad74:ac83 with SMTP id d9443c01a7336-2df60b2eb9emr14839105ad.30.1790081419763;
        Tue, 22 Sep 2026 05:50:19 -0700 (PDT)
Received: from localhost ([106.38.226.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d02f448sm9488505ad.34.2026.09.22.05.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:50:19 -0700 (PDT)
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
Subject: [PATCH v8 0/3] memcg,writeback: flush foreign bdev mappings separately
Date: Tue, 22 Sep 2026 20:50:12 +0800
Message-Id: <20260922125015.3435215-1-sunjunchao@bytedance.com>
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

Tracking uses oldest-first replacement and expiry after
dirty_expire_interval. Further dirtying during an ongoing flush can
trigger another flush after it finishes.

Tracking is best effort: each memcg keeps a bounded set of device
numbers without persistent device or inode references. Recording runs
under mapping->i_pages with IRQs disabled, while dropping a device
reference can sleep. A memcg that never enters dirty throttling could
also retain an unused record and pin the device object indefinitely.
Recording only dev_t avoids these lifetime constraints. Device removal
and device-number reuse may cause an unintended best-effort flush,
which is an accepted trade-off.

Writeback submission may block for a long time, with up to four work
items outstanding per memcg. A dedicated unbound workqueue provides
a separate max_active budget so these flushes do not exhaust active
slots on a shared workqueue and delay unrelated work. If the workqueue
cannot be allocated at boot, bdev inodes continue to use the existing
foreign-wb path.

This primarily affects filesystems that keep metadata in the bdev page
cache, such as ext4 and other buffer_head users, rather than the usual
metadata writeback paths of XFS and Btrfs. This also covers buffered
writes to raw block devices. The decision still does not account for
how much of the memcg's dirty memory belongs to the bdev: even a single
dirty bitmap block can trigger writeback of the entire bdev mapping
when the memcg enters dirty throttling.

Changes since v7:
- Update comments and commit messages as suggested by Tejun Heo.

Changes since v6:
- Drop open_mutex and the openers check from bdev_flush_by_dev(), and
  add a !CONFIG_BLOCK stub.
- Follow the existing foreign-wb tracking policy: use timestamps for
  oldest-first replacement and expiry, and allow dirtying during an
  in-flight flush to re-arm the record.
- Replace frn_lock with an atomic in-flight flag.
- Drop WQ_MEM_RECLAIM and explain the separate max_active budget.
- Expand the dev_t lifetime rationale and filesystem scope, update
  the foreign-dirty overview, and drop the Fixes tag.

Changes since v5:
- Fix repeated overwriting of slot 0 in patch 2 and add comments.

Changes since v4:
- Add before-and-after performance comparisons to the cover letter.

Changes since v3:
- Flush foreign-dirtied bdev inode mappings separately, as suggested
  by Jan.

Thanks.

Julian Sun (3):
  block: introduce bdev_flush_by_dev()
  memcg,writeback: flush foreign bdev mappings separately from owner wbs
  writeback: record bdev targets in foreign writeback tracepoints

 block/bdev.c                     |  18 ++++++
 include/linux/blkdev.h           |   4 ++
 include/linux/memcontrol.h       |  12 ++++
 include/trace/events/writeback.h |  22 ++++---
 mm/memcontrol.c                  | 123 +++++++++++++++++++++++++++++++++++----
 5 files changed, 160 insertions(+), 19 deletions(-)

-- 
2.39.5
