Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F22D662F
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295496; cv=none; b=bbbIZ0G/g8VingdO/Q53jeRo3qsN2bf83C4qnJ9BiLItZaE+u3hkj6OhWY+c2CtCKrC401ReHF3lpP+CArVKXdBKZPIZjzduC5zf29NxOE2uHKJRg9MQYidVErf1d334vmI2clidRPEGG3voDybJzEhcJSgsFPbVI2XLn+eaYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295496; c=relaxed/simple;
	bh=hsYiPnm7Rcvnvtsa7Ytletl4GDQDTTq0grupd0EC1+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwXHeQLjvhjZfdMh2Jsx2dikrE2r8UYnGoxgzJyr2q2qtAaT8+VhXRMNPxU9Ec8H2lJiyZFgkkrwTranba0Bp9+U/m8cwRWYtaFORhZk8vd88V/SzjZZG4b5rchTNXeuAlo9btI7WxaCEylvXQRuKJk+vQM2HNRiDrL0iWAIB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c+sDOH1c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c+sDOH1c"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso8833975ad.2
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295494; x=1792900294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0b/AV3Wg+kLtcKm2wiFJRuBM+/NR2XvgAzeP+zBe6ow=;
        b=c+sDOH1cOtM6j0WYx4ztiFPFB4Ogq7Ho29/gGlZf2b84rUL/dh6wdqRcwoX7NvNIed
         h3gIDDzQB8IWH90VUMadKChkzAalUtNXUUF1WDSDKA6aBWDBNl96KUicxhbnl9UuyR5o
         KgB2Zl+q5HrvZP8mUAAZarl2FrNwki3mwLark=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295494; x=1792900294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0b/AV3Wg+kLtcKm2wiFJRuBM+/NR2XvgAzeP+zBe6ow=;
        b=jVXudqunyDFmiD3QZohvMXULsjJgf1ra2gaHirSiC3t0L0hC2r82wbr7uwBvuMzHnU
         EQmYaLdocwb3LuSGcqviPrh/BK5uyMC3LcEsd9PzW4hxNEEOwssXVTJAfEwd4ZI3k5ZV
         kwTQv6Z4MSCzCqHjkqkrKX2oDI1YwtcCbms5fui0wHRExskQaHk/R82HMxtkQ6mzwBvY
         jGwWjBeSurvp7jDf01NSFTFq0Pxs/smdjDJ6RqDzAIk4JQlgZu0XstPLz6vRFBgsP7j9
         G7QsfpepFDiGEIuj1yNjORgLpynSPSyik/0fpSwKWRA6/lJ0Z5LRgVDA4duxTEedctsL
         hraA==
X-Forwarded-Encrypted: i=1; AKwUvByoF3CsK47VJTW7VfEGUK2H5yLUTUG0L66gdLkyGdMty8moEcnUjTA79vOZxABmbGswktnrPNHUu5L5Kg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKVR0Zvu0vQISqu3d+dZQt+FjR0HjPP9lJlEedWgNWBbLRfxdb7
	8U9qYh0y5MMqh+bNJ7WWd8wESgsWejVEVvhFigICAaQI6xinGEWU1N6phY0W331ijA==
X-Gm-Gg: AYBFou0tKDzetgermGO4730vuTk4o8muYJzylwpfTKU88f9lOz5dVAW/a2bOXIlu0qD
	lNWNupp8dAmbS84qMaxoQ4nYp8HK0l6/pSmdK/uA60Wndwv759FC43K6Ed9Jj888pakFhVKJ32S
	CZhKdQZmZCphzjvGVa+42V8DKd48bRgm1Ko0kMFKAVEGsTRCb8c1ahnFOGAjETDBUuDA55lUc5Z
	MdGZ8jR6sbLMyS3K+Wg4INEv5lAWY9EMXEZQQnoANjW/sbraRMxvw7dn2K9CaElMj+3SbXatgtH
	ChokabkTKOdlEVbDuAQAwpIi/Hp8F56wq1VaxNlhm9sWHu45DZJoj5Y6zpgEl3x5uiVDcsgJRBH
	Hzse85p/dN4AUWBIDn/BTsfbkd6xOZmkb+oR+7E2/7axfEQ+lFTKTxnI/crqbbg9lCp1GOxwGdb
	eXbgkeIqvwWCodz+n7yA0vU724zRw2RH+tCrvIY2BEMYf6vzgyb7wY0hcLpnLQkK0v9IsJ8bn3X
	tW68qbTZ+gnAAT53ip5oYHqsthV+tydMyrSEEbE/vRJmAzcQ7IvbYR0QCU4n7yZeeSVtIdiFgf/
	F8V+pa85z6bpO6l9hwKhDqJhpBDMzg4FbKCOLQ0za+Gt
X-Received: by 2002:a17:90b:28c7:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3acef3c3662mr3992376a91.53.1792295493775;
        Sat, 17 Oct 2026 20:51:33 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:51:32 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 00/13] zram: redesign zcomp and rework backends
Date: Sun, 18 Oct 2026 12:51:02 +0900
Message-ID: <20261018035125.3120704-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series has a number of memory usage optimisations and fixes
that result in savings from double digits KB to triple digits
KB per-context/per-CPU, depending on backend and its configuration.
More details are in the corresponding commit messages.

The zcomp redesign and backend rework happen in the final three
patches.  zcomp part, basically, attempts to address the priority
inversion problem, that is seen on some setups.  In zcomp, we have
always kept Read and Write contexts together in per-CPU streams.
With preemptible zram this becomes a bit of a problem, as a higher
priority Reader can preempt a Writer, which may hold a stream
lock, but since the compression stream is locked by the preempted
Writer, the Reader gets blocked on the very same stream lock.
However, we don't have any reasons to have Read and Write contexts
share and compete for the stream, because Read (decompression) and
Write (compression) paths are completely independent, they never
touch each other's buffers.  Thus, we can split compression streams
into per-CPU Read streams and per-CPU Write streams (Barry Song),
so that Readers and Writers don't block each other anymore.
Decoupling Reads and Writes results in noticeable performance
improvements on synthetic tests.  The Reader vs Reader priority
inversion is still possible.  To attack this problem we introduce
shared decompression stream (Brian Geffon) which can be used when
decompression is stateless.  There, however, stateful backends (zstd,
deflate) that cannot have shared decompression contexts.  For those
backends, we introduce a remote CPU borrowing of idle exclusive
decompression contexts, if an exclusive Reader get preempted on
current CPU.  We also now allocate a per-request (Read) bounce
buffer for linearisation of spanning zsmalloc objects, so stateless
decompression contexts do not block each other.

Reader vs Reader priority inversion tests:

  exclusive zstd (fg reader, average of 3 runs):
  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        391k               1,064k        (+2.7x)
  Read clat avg    49.07 us           9.68 us       (-5.1x)
  Read clat stdev  7,179.16 us        30.64 us      (-234x)
  Read clat max    3,208,867 us       5,880.87 us   (-546x)

  shared lz4 (fg reader, average of 3 runs):
  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        972k               1,466k        (+50.9%)
  Read clat avg    11.56 us           3.29 us       (-3.5x)
  Read clat stdev  2,738.84 us        16.57 us      (-165x)
  Read clat max    2,204,467 us       6,442.50 us   (-342x)

Writer vs Reader priority inversion tests:

  lz4 (fg reader, average of 3 runs):
  Metric           Base               Patched
  ----------------------------------------------------------
  Read IOPS        642k               1,472k        (+2.3x)
  Read clat avg    23.97 us           3.28 us       (-7.3x)
  Read clat stdev  4,303.64 us        14.85 us      (-290x)
  Read clat max    2,393,767 us       5,710.53 us   (-419x)

The final patch builds atop of decoupled Read and Write streams and
reworks the way secondary streams are handled.  Secondary compression
streams are only used from recompression, which is serialized by
device lock, IOW it's single-threaded.  However, we still allocated
secondary streams per-CPU (we needed to permit concurrent Reads
of recompressed objects).  Because we now have dedicated R/W
streams, we can allocate a singleton compression context (for
recompression) yet still have per-CPU decompression contexts.
This saves a notable amount of memory with some backends and
configurations (e.g. zstd, deflate, lz4hc).

v4 - > v5:
-- borrow idle decompression streams in exclusive mode from remote CPUs
   when exclusive reader is preempted.

Sergey Senozhatsky (13):
  zram: prefix backends printk-s
  zram: remove debugfs entry on init failure
  zram: zstd: do not allocate empty C/D-dictionaries
  zram: lz4hc: pre-initialize dictionary stream in setup_params
  zram: lz4: use LZ4_decompress_safe_usingDict()
  zram: lz4hc: use LZ4_decompress_safe_usingDict()
  zram: zstd: do not use kvzalloc() for zstd allocations
  zram: reset writeback state in zram_reset_device()
  zram: split zcomp into separate R/W streams
  zram: introduce shared decompression streams
  zram: allocate bounce buffer for spanning objects
  zram: borrow idle decompression streams in exclusive mode
  zram: use a singleton compression context for recompression

 drivers/block/zram/backend_842.c     |   6 +-
 drivers/block/zram/backend_deflate.c |  98 +++++----
 drivers/block/zram/backend_lz4.c     |  85 ++------
 drivers/block/zram/backend_lz4hc.c   | 105 ++++------
 drivers/block/zram/backend_lzo.c     |   6 +-
 drivers/block/zram/backend_lzorle.c  |   6 +-
 drivers/block/zram/backend_zstd.c    | 133 +++++++-----
 drivers/block/zram/zcomp.c           | 298 +++++++++++++++++++++++----
 drivers/block/zram/zcomp.h           |  53 ++++-
 drivers/block/zram/zram_drv.c        |  55 +++--
 10 files changed, 542 insertions(+), 303 deletions(-)

--
2.56.0.176.g3575e65682-goog

