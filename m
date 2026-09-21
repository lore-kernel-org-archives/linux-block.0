Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B336E492505
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991738; cv=none; b=jwAYV6uXHcFGmAzdFDlvazt+rZ84wprDxXo84UTwOBReTYkb2o60LwEbKHh398MWO67Xi87IF5Q/MR1IhpzsIIP2O45oVf6642jGbtDzz7ebi+H/ly4rk+3vlC7jKjJGCljZBti6k+cRbgCexZYlhAUoA2i2J84M+Ckvou+Ijkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991738; c=relaxed/simple;
	bh=DdTVPz1QfbBgtnVhbDH8nDBRYlMIKdCe0cBp7p+nEA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyFRCH2w2+qd9ZuwsfoMHNuCAPCh7vdooSHeWS/kjP1fBA4ICdM24A3M35PC98+loLvTxjiLabuqEMDCrhytyrDsAOsGEll7GPJeHtq6BzyDhTY/96Mew8sAgDRLr1QA1WLShFPxoJ76Z8Y8gqVqz2XvOyp/VpEC5MIgdwzyYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cSt71z95; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cSt71z95"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c6so2427375b3a.1
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789991734; x=1790596534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4yFs7aKADwEnqQrd+7DVxwZtTJDiMzxWaAyfpMFtjl0=;
        b=cSt71z95Pwwd+tl8Zw2fR+SC3BkLWDggRiKFaPPr0J3g2IP+7dHY6POnl0ShDX7sdG
         1f+uI7s9An7OY0SNe5YDID7gaG0rrWtjrjebL7hnfFe7fpBm2BUc1CWleaT9GMUgVw45
         CdKGqj44SeBfuUcsdnlh65N0nVUb+ttOKtkbrmbrdZrPEr/BuL4sh7GwWb4RpbkBcCgR
         urgqhzKnGoYt0k/91UGasM+39x6GtwR+0N7/C3KbKbGaVC8pM6Po+UPaW6Kn3zEdVmrB
         idikAN8BbRxf6WXAGkVE05O+fsuyFCnvrAvRni8YolBBeBAKBTTc0lGQz8tZqJFvwZhv
         vXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991734; x=1790596534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4yFs7aKADwEnqQrd+7DVxwZtTJDiMzxWaAyfpMFtjl0=;
        b=zyPWVf5ysVW4687EPI5K93/Cwu1fBoBON7ixwVhM9MclWo3FW3MaQ9c7mvzTgvRe/V
         HKZhmsoWpot02UlK+FJqVZgNcHn9iLk+jbgp0qWA3PC2xD/IWS4Mc6gGUsWmbJ4SipZ0
         Pqkrau/7mEAiYigNbH/VbNIJ63t50Rp/X59BlsbrMLGGl3GZIZKMxHWEmtvCj5lT5bXW
         1Z604KrXsal+yLJ80BuPGFMgAEBN46Q0oWHM7hO+/p5eYH4C8l9SbpKPA5oNd2M1XZGN
         Y5PotwMatFUpT58JXKWuEdaZPpal8AIPnRmTDZacl5XqQzzDbWs3QwGzPgaYXxCzGDgn
         45BA==
X-Gm-Message-State: AFuF++l5lzGMEH5IpVdFsbO79SH+O/u8/50gl/rAhLhPN2Xgb79sWeA8
	jTe98WhepzQ4ZnHbxTzUxTqvIVRnm5lQPa5eGRwjq1Ixrbl03LsKloBY82O6tZg3Twmkprf3TaS
	BXlP8irA=
X-Gm-Gg: AYBFou0FT1fJYSU2C1zgj4rCfRvJJdkFj3UZil127wIMyTgYtmE2Mc8X0SFqTLEtaJg
	eH6gstir5bKK+z2NXw09OIegqqNQxCsgv+fwaLsvr64mAmQMMeNSIcNN5/uGUhxG118iptWVeKq
	LzK+N6JKmTsfcn2LQODqUe8FTYWt5gssNLtFzW2tA5dMw5IXVYjPBMGtUWfmBNrrefqppXLjfUS
	TqAexwxn4kUgzGNj15EgvgZZWLC3l4bUK2rO1vQE+9bd4IG65m7b1VprRyv8NE4qt2E6bhtv0FC
	y+XDI97Ott0er6aHQMy3pby9p0N1S8EZYbjpP2G8r4YQ6UnzBOfp6l05xaCcGWaItBtQyo7jmYa
	uoCInw8JwuzrcjNqzsb2qCRHngQYbJMY5AxlqTAtDpNtgzKWi+yMeYQgqDVao3hzQCyQtc0EzLr
	04giCUp9EjJsfJppHhKL/2HBUS/20ULYJhu/9T33YFNxQKYdnGuuPiD4yG7wPYrMlDZQB9RqWD2
	0c=
X-Received: by 2002:a05:6a00:2e2a:b0:878:34d7:6a26 with SMTP id d2e1a72fcca58-87834d76ddfmr7083089b3a.40.1789991733620;
        Mon, 21 Sep 2026 04:55:33 -0700 (PDT)
Received: from localhost ([106.38.226.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a95f915csm3093687b3a.29.2026.09.21.04.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:55:33 -0700 (PDT)
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
Subject: [PATCH v7 0/3] memcg,writeback: flush foreign bdev mappings separately
Date: Mon, 21 Sep 2026 19:55:27 +0800
Message-Id: <20260921115530.1613717-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260917065759.2643940-1-sunjunchao@bytedance.com>
References: <20260917065759.2643940-1-sunjunchao@bytedance.com>
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
slots on a shared workqueue and delay unrelated work. If allocation
fails, the existing foreign-wb mechanism remains in use.

This primarily affects filesystems that keep metadata in the bdev page
cache, such as ext4 and other buffer_head users, rather than the usual
metadata writeback paths of XFS and Btrfs. The decision still does not
account for how much of the memcg's dirty memory belongs to the bdev:
even a single dirty bitmap block can trigger writeback of the entire
bdev mapping when the memcg enters dirty throttling.

Changes since v6:
- Drop open_mutex and the openers check from bdev_flush_by_dev(), and
  add a !CONFIG_BLOCK stub.
- Follow the existing foreign-wb tracking policy: use timestamps for
  oldest-first replacement and expiry, and allow dirtying during an
  in-flight flush to re-arm the record.
- Replace frn_lock with an atomic in-flight flag.
- Drop WQ_MEM_RECLAIM and explain the separate max_active budget.
- Guard bdev work submission when workqueue allocation has failed.
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

 block/bdev.c                     |  18 +++++
 include/linux/blkdev.h           |   4 +
 include/linux/memcontrol.h       |  12 +++
 include/trace/events/writeback.h |  22 ++++--
 mm/memcontrol.c                  | 124 ++++++++++++++++++++++++++++---
 5 files changed, 160 insertions(+), 20 deletions(-)

-- 
2.39.5
