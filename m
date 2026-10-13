Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1F3B71C8
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863531; cv=none; b=bkMH1GcFsS5TF6kJiqxfUfQQZum9orIaSCamE5MOd0GWlQZg0sY6ksaEDEa3hZUqNCTanCwkgwdTk67KdhH5RLpT2G7vjeQb/NGKCgY6n9hFd6JeWAE53N9koEJAw8XJIEjS+O/qjzBsS54SQm4N7kZfsd2rdTC2XBH7v1IMq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863531; c=relaxed/simple;
	bh=FS5NbUz96kqEKd9onXqdt/fGw9h9fS/rjq2i4m92jtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZGTR2csWuiNvtpAo6PoTrPyLbvgFF/NAaPNzhKpYmDGNWkCBl2xE0gtwRu0IVo7BtAU80ZD0x2xDZTqfj8Re0KCJxXmnnW22aqRPUzsG5wXFDxTJm6zTwldlvUD+B3pwSlHs7A50t42M/EC0p7olhBmKFwGt3IF/Wo3B9pteso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m92PJcjH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m92PJcjH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-85377c8bc96so926891b3a.3
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863529; x=1792468329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+RirkidvU39UtoRFdOSmmCxiKM73vm7nm9nipwtgQMA=;
        b=m92PJcjHGKAeDqWiDrohqn6Ppxu5boIhpof48y4wIPl+tDx8rIxEAIosHmeN08cC6o
         ukDAjp+vuVhcrjwRB9F5godGEpvqc2uVsN4Ec0e13WSaQsf0vVvPOq7HV8+TqUbtlwKJ
         h8gNYZz6Y1Kdx9gPL7iOI3zhzNby87yRHKHlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863529; x=1792468329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+RirkidvU39UtoRFdOSmmCxiKM73vm7nm9nipwtgQMA=;
        b=a+BWSX838PKxRNhMqtHB4QET4DLONS1Gqux1ON7bYZvuPIwBB3U+3+hj4swbCKcXV8
         /k4SKmmUrUAqVhqe6u6jRxnbQhIdrI25Iu4bYMK1++fnHvGa8kKAgH45D8lYVa2Xkx2r
         vk8Wz670DYorAcXawKmcXlUq2QhQWNWVznXp4dnxydpXRxYfflGdKTJrwPQVtfXjkl9S
         KFfIivvhqc8eX81CUkNcRUlKWxPDAyfOf25wmIdj8ihg/ozAAuTXVsToJDPfhsmGwgpk
         YKO8eI2ZWBPgqTYLuqvuHlJZty8t99AvD8NXl/l2MB6K06eqZWxwlRDXKShaaBuLe60x
         rVDQ==
X-Forwarded-Encrypted: i=1; AKwUvBytePak1XAl7P0qirEX7Sc7PXAOG0pmhoJxPfKJlmRaDe6ELFonv75VZYhWjZed50MEs9+w9wSW0F2tHQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+k2RFNZUgtC2s4Lu9EeZ7bNg4yLHnKYQqK/X+pjX6DOhNHYXg
	F4fzE4O8cmIgVO1ebH32oeFR9wwtQ6wzmvLh9IBPGPIAAyD9fQsjw3JZqn4d7CaxCw==
X-Gm-Gg: AYBFou2y6kwJ7Nd84Kdy/x527lB6TQs4QlnHV+5mrWxMtfzBBtP721ZikeJDyUNqg6d
	Qa7/HNidyM0vdWdgA5Kq0eSuDg3kq5j97naayLkGdlbkf4WfkvRoIAUl/1scnxx4r8PbRA+0HS2
	qnhi1P9J/hs0i9iN5t1e4LFs5VwN+W9X4zR7w8fnwUn94TjuDldoNXgjBL7KzMsgcaVgxAQaERl
	msyL4W63dlQq/eFmRy4lNeQr8QelztHUlgc8eNZ3T3Tccwy19dOBDf8NoMY2elooVOSbIUYB8XF
	4jlLbGbZEVChwCzMkyBb0kOyCsQ/bxe7XbEIuPBqLGnzdb0UJ9HULw/4gcacTME5ZXWFqmap5Ou
	+JJ9wt25h7Qk+S33achfwGYM582Egm7munl8wqeOlatx7upRMVvadJcDcLeSw3EQHeeEEYVkbw0
	DwHW/S6gG9R/uwa/0ZT+GNKihVvJQOVbRfOdoUf7EKLUb1/VpxbsLe7S1ElXuOWRTuT7eDuFuP4
	8BaHsl9ABIQqLRiA6Vn8EmUUzV1ShROQhCao43xZFouahniGRLjUrBrebPIXA==
X-Received: by 2002:a05:6a20:9d97:b0:3e0:d508:59a6 with SMTP id adf61e73a8af0-3e16bdaa122mr9096795637.13.1791863528987;
        Mon, 12 Oct 2026 20:52:08 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:08 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 00/11] zram: redesign zcomp and rework backends
Date: Tue, 13 Oct 2026 12:50:47 +0900
Message-ID: <20261013035201.2809924-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
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
decompression is stateless.

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

v2 -> v3:
-- reworked shared dstrm patch: new internal zcomp API for shared/excl
   dstrm and a mutex to protect ->local_copy bounce buffer and ->ctx
-- updated commit messages
-- reshuffled patches

Sergey Senozhatsky (11):
  zram: prefix backends printk-s
  zram: remove debugfs entry on init failure
  zram: zstd: do not allocate empty C/D-dictionaries
  zram: lz4hc: pre-initialize dictionary stream in setup_params
  zram: lz4: use LZ4_decompress_safe_usingDict()
  zram: lz4hc: use LZ4_decompress_safe_usingDict()
  zram: zstd: do not use kvzalloc() for zstd allocations
  zram: reset writeback state in zram_reset_device()
  zram: split zcomp into separate R/W streams
  zram: use rw_semaphore for decompression streams
  zram: use a singleton compression context for recompression

 drivers/block/zram/backend_842.c     |   6 +-
 drivers/block/zram/backend_deflate.c |  98 +++++++-----
 drivers/block/zram/backend_lz4.c     |  85 +++-------
 drivers/block/zram/backend_lz4hc.c   | 105 +++++-------
 drivers/block/zram/backend_lzo.c     |   6 +-
 drivers/block/zram/backend_lzorle.c  |   6 +-
 drivers/block/zram/backend_zstd.c    | 133 ++++++++++------
 drivers/block/zram/zcomp.c           | 228 ++++++++++++++++++++++-----
 drivers/block/zram/zcomp.h           |  50 ++++--
 drivers/block/zram/zram_drv.c        |  55 ++++---
 10 files changed, 477 insertions(+), 295 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

