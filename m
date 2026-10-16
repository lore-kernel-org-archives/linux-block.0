Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B260383C96
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125883; cv=none; b=KHgWRv+YuxeojDqwt0NhgavqQss/vU/5dsJ86gEeOVn+qO5H1dmCyeMIGso03k2qwqCiGvV8R3PYlgUVjI/h1YHArlyoYOiA6huwFGDWnB0/wTrwcqLL9yOcYw7jO9el7l2CEzabwNainhvWIt4NaTmwCrC46UYzHZoYav2Mk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125883; c=relaxed/simple;
	bh=oup3/Nyj6xj77m7I8em0NMpusQ7mg2GpioVp9Gew6ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKHGcHBWeST1N4O2uJpVnUttmc/XFTiqe0TRGsU03SAYrBuC940lBkGuglnfDVepWfbmzTfEVL2+TLhbVyZxgvtz1c3TNPHIODXQOO1nty8aSw/yJKxZq8ZYP2WS7HklJAKTTG8SQr5ZTGNfse6X4iydlnmuf4Nf+n1nCG9IJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YXN/3To3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YXN/3To3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2dd9cbb661bso43872455ad.3
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792125876; x=1792730676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBrnIo3XSNA4XGYMofOPHvvSVBtQNBIdSVaE9YyG9CE=;
        b=YXN/3To3blV/tz22gvAssI1DnRiLmL2j0ugSyo5opEjyZwNpStQDbb9cDK1SrGvCqe
         UUa9bJDskyGikuM1bu7A0hxPsRAoCHj1bDvVuwHEj08t8la4a2jCMCvoYxJVZUr9wgDJ
         KKa39zP5IfXIwJK19NZh4rPqCCgzfwuA9CvoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125876; x=1792730676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GBrnIo3XSNA4XGYMofOPHvvSVBtQNBIdSVaE9YyG9CE=;
        b=VBkS4/pxyNHfBn/dfTCuhEdFncWtP4tuaDY2PF0GOvmWWDl7kN5al5jc0TAFv2O82c
         ARMbI9eyaXVBMRCkU25o2yqARhs0itXtIKxP1/P4BxM0nbxM/jlJdWomy+jnDWV+WUyq
         uGYaC/5e5N6+NrcbKlZlaKDPpmvZczQ4uZftT21pSa1EN6JaoG/vKUuAAzCLHZSVs+tE
         3+p65pI5J4PgLi9cIcZbRk6ppR6CVl0dgOmBCAIQZ+Dc7okKYldJoOLgqdeHKyohLkhb
         +UKYo9uXUGUdb6wgVCt902twq6eksKuoaPEmn6aVDH7EfLNQNgM8xhzVbfkr/RbUdh+C
         w1kg==
X-Forwarded-Encrypted: i=1; AKwUvBzOk/z9Y+tWxwQ+EEkFgpQOjysbMK5ihh3fIxCp+lvdIjjyW5exy8xKkYKm2FHd13RZIHhWVJrKRnk6Ng==@vger.kernel.org
X-Gm-Message-State: AFq9FYJrzhbnvE1FxmM20DTwUPiFZMjzi06kocSUN3YRIfNkVu4R0WZc
	HR/3wN6hAE1hxVHLUp82Q4vFWjqYeQhVzyXcWZXHunmvY6tF5kJoEJLscGBOO0k5SQ==
X-Gm-Gg: AYBFou2AdpSJCGyulIfbu0xKfp3mvNmu7crXvc+UZampw3YmlC+VTADkoxdTY2oZDaL
	hiXgmGD7BhlM2ZA/8Hcoczlk4ovWI3UEW2JV+vVrbuKic2vcOzzVQSofvkn9IrE+p2Q5NjgKEsU
	C+vr7TIRp2XKEG5cWylLbaJJtY4eUh4vX3/ZggIYlzoaLjmUN3p8h4WV6FkEW3xelPLDOvqBatz
	CAd4vRDKtGwviX3vn5zLulmgSETJR+3mgl6b/8nYmYw76UZiUOnVDcrKeEfzLLr1bP3WEviDNKD
	TbcVzIm80pAPaLpbnM2Lv7NEWiQ/kA3bowY/8oSW0JwEKxNK/4lR+A2iqeigD2ADFDghxZdw8BJ
	ue+TdzII/JLFS0DEwmFEBT3YtefAXK7xb938y0LUtBFnQvua/cjeUV2M+DLj+d26RqXX7OsxmwU
	BgrnYpBMoFN3tvb7nSfFor9btTCcJX1bYzFigKe4uUcM0BePrVD+HL87RwZHrpbAYXBDopHA4lA
	jYb3vWOZH5JZGWgPNv/VVSKCpUST1tVgO5Tey4P/HEvL4sxdGN46oFho4c0lMq2
X-Received: by 2002:a17:903:1a0e:b0:2e8:4066:d247 with SMTP id d9443c01a7336-2e842ab27c7mr190565875ad.33.1792125876506;
        Thu, 15 Oct 2026 21:44:36 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1b5esm4137235ad.67.2026.10.15.21.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:44:35 -0700 (PDT)
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
Subject: [PATCH v4 00/12] zram: redesign zcomp and rework backends
Date: Fri, 16 Oct 2026 13:44:05 +0900
Message-ID: <20261016044429.1304561-1-senozhatsky@chromium.org>
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
decompression is stateless.  We also now allocate a per-request
(Read) bounce buffer for linearisation of spanning zsmalloc objects,
so stateless decompression contexts do not block each other.

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

v3 -> v4:
-- use a temp bounce buffer for read requests

Sergey Senozhatsky (12):
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
  zram: use a singleton compression context for recompression

 drivers/block/zram/backend_842.c     |   6 +-
 drivers/block/zram/backend_deflate.c |  98 ++++++----
 drivers/block/zram/backend_lz4.c     |  85 ++-------
 drivers/block/zram/backend_lz4hc.c   | 105 ++++-------
 drivers/block/zram/backend_lzo.c     |   6 +-
 drivers/block/zram/backend_lzorle.c  |   6 +-
 drivers/block/zram/backend_zstd.c    | 133 +++++++++-----
 drivers/block/zram/zcomp.c           | 265 ++++++++++++++++++++++-----
 drivers/block/zram/zcomp.h           |  50 ++++-
 drivers/block/zram/zram_drv.c        |  55 +++---
 10 files changed, 506 insertions(+), 303 deletions(-)

--
2.56.0.176.g3575e65682-goog

