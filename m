Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236B448BB7
	for <linux-block@vger.kernel.org>; Mon,  5 Oct 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202854; cv=none; b=LsuTMMOAjZj0ECz7knMsbwV+NNDhY8OXqI6gcCQXMy6/KBqR9wI5CvNvkcTQIO0UTKeIrAlD1nB/uBNB0gnJiS0TcL7vkf2FCxtA82YV+u0NumC2GGqvj9s/k/1MnWJj+KwEH19yuAB1CuIAP9hMLeiQLYUskZ+iyyVsQeqfHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202854; c=relaxed/simple;
	bh=zFTvQAxkM3SuPhSa2uIrosbgACuuPg4vv+RgSgCkJ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krnFvrepO+2h+ANNq9Ovr35j2EPk6p0r1tiMUWGKTaT0s43rpopfywZhSG7iZIoVGNYULNOcSyTaxQ6DL0JhbddIFTMXo04wdF1BS+5IuPqMTWK3+9Z2BWcXBy7RhMh0pl6dqeOjQUT3Md5BwWMm2dijwO3rTNFguCEsjK8fgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=obCpUzPS; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="obCpUzPS"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79a5bdf9fso340407a12.1
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791202852; x=1791807652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kr2/73o+y15EzbO0RQo9G5wswmWW+XAsy0BXTjIVojc=;
        b=obCpUzPSCnYo8NvWMz8Jz551lkVmSXqKv9uFEPOCrFFD0MQ8R9T8Qsg4XJINS6bcCf
         UlZeEcPVH81OO3I5frgn2kii5RaB50jBWB1MELVDnCTVvwetfMMBavLHW0EEBgvlyfFm
         0XykiFNOmnsEsGHCcPbodI9g4wfUqfgJD7jO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202852; x=1791807652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kr2/73o+y15EzbO0RQo9G5wswmWW+XAsy0BXTjIVojc=;
        b=sw0YUa4yEWOJjn3T0of/lwmSTIrdzWyMFk0FZeiqGzpt2Y2ZPTUktcjeNbVCkeQ3kP
         Zwe2F91uAWZRMWeBIWSSMuuZJxRmeLiO/zrIkgeuvl7vncZhB6c86lapv1wjTtY2miqj
         3wnA5bLdcX/+lXmb8Vbi0UieVIPdbOUGMrtRSjKeDEvIzu3y3i3QnXJit57XHNeedLIS
         hRKAndruYpHCMrjC2XudfZL+MZQpub3hptVdMoB2wubVbf0R+e6u446SkrNmdKGZhqpr
         U2at7/A3Q1v3DGEpyZqixznJyfzmjZMCO/6igzyDvhpFeSGz3VHYOI9zYbIRWP6RtU9c
         4edQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjytRCwRosMuLhjBzw25Zy4Ia0RXDiVRBlNT6H5sTbMI2aUpZC6x8gmoK2gPMozGjM9pu8FPcKSFVzIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIxLh0ymG0PHCNnWfhHzJvE+G2JXqmIFpSv21MTgYHuV9xa47ov
	DrCclSoWNLMXgCWZbqtkCNFtvBDo9SYv+VVB67Q4lgZhyt2CIkvKh/7Ax2xvL9pijQ==
X-Gm-Gg: AYBFou3z8wpv6MySEb7OFiKj9TC71y810BuY9+pQuRDvgXrTo6KPuMUT5E5FtaNbFvv
	Fm6EU205fhGgdj8I09jRw5HN/uNTcNbznn6FZk6C2tkkn/fzCXnwXPPwAbkSjTS51TE8cjJqjMA
	kMWX3JBlGbEeiUVDYJKnvennf8Hs8N3CWTc67QXgeBb7PSmY6YvPHaarstcNz9ed3gHkLXkMNJ5
	jFJaTG4VK/oVtDQXZtOJi5G0r1M4YIRsvLq90UngDgYC2FPRzuSG1V30U929G6H5KBJUVGHQ3iP
	uU7oN6wjh0P4vr0a2UXP4C31fKKVtVJdkKdfl0ikxgdKci1LkPxSOEbwaDrJkhFa189IgAH/1OL
	ttuHXV/eLvN+moLKgKgvE1yRb+tyKgTdGoX3WVU6654VBZt5HQpjicFRsw5nXrCvK5RYLC3xMpV
	AyC9FCGh4oN/i176DKAj/WfxS0Pt3IdsPbIZwalrkXk3HDA4hF2VWfZdIHzQgk8nfkMjNjJs9Io
	P6dwdoFNndxPfgklBhr5rHIRARDM3aVgK5uBYBmulME2avm8PcHotpWVxsCcTUv
X-Received: by 2002:a17:90b:3ec7:b0:3a0:2900:f55e with SMTP id 98e67ed59e1d1-3a6cec20416mr6577046a91.29.1791202851545;
        Mon, 05 Oct 2026 05:20:51 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9211:ddf0:3c6a:bf9e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7e4b00de6sm3342997a91.1.2026.10.05.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:20:50 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 00/10] zram: redesign zcomp and rework backends
Date: Mon,  5 Oct 2026 21:20:15 +0900
Message-ID: <20261005122036.718976-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
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

The zcomp redesign and backend rework happen in the final two
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
into per-CPU Read streams and per-CPU Write streams, so that Readers
and Writers don't block each other anymore.  Kudos to Barry Song
for the idea.  Decoupling Reads and Writes results in noticeable
performance improvements on synthetic tests.

The last patch in the series builds atop of decoupled Read and
Write streams and reworks the way secondary streams are
handled.  Secondary compression streams are only used from
recompression, which is serialized by device lock, IOW it's
single-threaded.  However, we still allocated secondary streams
per-CPU (we needed to permit concurrent Reads of recompressed
objects).  Because we now have dedicated R/W streams, we can
allocate a singleton compression context (for recompression) yet
still have per-CPU decompression contexts.  This saves a notable
amount of memory with some backends and configurations (e.g. zstd,
deflate, lz4hc).

Sergey Senozhatsky (10):
  zram: prefix backends printk-s
  zram: remove debugfs entry on init failure
  zram: zstd: do not allocate empty C/D-dictionaries
  zram: lz4hc: pre-initialize dictionary stream in setup_params
  zram: lz4: use LZ4_decompress_safe_usingDict()
  zram: lz4hc: use LZ4_decompress_safe_usingDict()
  zram: zstd: do not use kvzalloc() for zstd allocations
  zram: reset writeback state in zram_reset_device()
  zram: split zcomp into separate R/W streams
  zram: use a singleton compression context for recompression

 drivers/block/zram/backend_842.c     |   6 +-
 drivers/block/zram/backend_deflate.c |  98 ++++++++------
 drivers/block/zram/backend_lz4.c     |  85 +++---------
 drivers/block/zram/backend_lz4hc.c   | 105 ++++++---------
 drivers/block/zram/backend_lzo.c     |   6 +-
 drivers/block/zram/backend_lzorle.c  |   6 +-
 drivers/block/zram/backend_zstd.c    | 133 ++++++++++++-------
 drivers/block/zram/zcomp.c           | 189 ++++++++++++++++++++++-----
 drivers/block/zram/zcomp.h           |  35 +++--
 drivers/block/zram/zram_drv.c        |  51 +++++---
 10 files changed, 421 insertions(+), 293 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

