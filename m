Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854081;
	b=3Dj5X9Q4cdaEHLmyDqlqJIhjZvcul3yZKSEPZD+jpiBByb41nzkea/KkudxN+e5oeSvJ
	 1lcLtYMUGeUu+x5NkAblqJtgcLXRRFOo8G+/wnIkl2gFr3ug6i5mryiQQCvct5KRR8OI3
	 ynL1Ay8C8z3CWe9FLC4CkMvSc9wd+S8IGLBaGOqLEVNs++LRHPNMg6T00F32HLEpkxdom
	 hYRebvDGzbWeykxQx3v54tsk7c78TwETNRZrFNSCLnHBLwqb094HRZJyUS7Saxc0DKUhv
	 1OvZJ6pXHz+BhpTGRsOlR/hBwuV6YSjJy8Ok1n1Y+P9idIO0bjZoJqRQG0Q6w3GyWFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lZ/laB7EjjzlJibu0SL3xlybjiUy40ADVZ8qce7qfBM=;
	b=fLmLYIA+1mTjb7kQ48IHU1aya9B+rbw3cjElJYMw3d3InsfyWdz6tRj11DwUUdZqcDLW
	 MgdimG5BikEzjSPvkSTIjlWIn86D5+rcPsY/QuXRkUAyyYDFd/wF+8nvt/0qBYTljK3Ms
	 eC9Q2APOoNKjzejptjl/9j+AKNaMRYojT7LUte1XTum3lItosXEDhUJzALprxhUHbeuGa
	 8PMCcfQxRmL4ou9WRNroZW25SMkaCe4vCK+0CNYfBxLjnJhuYRZ9SFIBej6/H6imvrv1Q
	 lV+Mmx8xTJURvyUjEIwJR24sjoQuAkWt3D0cxS2K9q6kFbUeUNuN5mT9x/xE4IfC22A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RENQGIw2;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74E606A328
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 04:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE74E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RENQGIw2
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1adbf62dd31so2042983c88.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 20:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793854080; x=1794458880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZ/laB7EjjzlJibu0SL3xlybjiUy40ADVZ8qce7qfBM=;
        b=RENQGIw2fXdz6cwkqBmrWSEx1sJ+69oy4zRqKse3yHtWwoIvjbpFfUkE/9rfqe8J2C
         Ez5XEsLPw1/JNyZBNDhMstsxWTsKdyFk5iEAMqB7NSQzZ6lK5AKWOLOxS5+1krdU2VYj
         ++OEvP2me0A64Gi8r4CB8KTwyTd0RdueKyPZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854080; x=1794458880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZ/laB7EjjzlJibu0SL3xlybjiUy40ADVZ8qce7qfBM=;
        b=et/ivgRo13KYAwI4gq+GKdc0JDf1g8IgGG5yv6ezraLzHQNH1bxzmeXZKjwjEELDRs
         MhvG3Ksk5DCKIZgfu2N7VHmy2rP3rZP6F9eh0ZVgIkkc6EQ0+Kzdw7zMh8fW2o6dLP/U
         lmqVkg+DUqIGkZs4aMMy7oyuEbl487N9VnNL0vUW3QlfLQYivuKhvhYMSWCVrrC/dj3a
         Ia0PQVmpGE0rYAMDpPp9zrCsI5yAF5ECW1BGfogrzUfPAk8Ts5RA2JjJhja8WLQola+N
         BBu4k5CIwiogYK+euEeXcYhq+F/FbmOor8NPrjLufFCQYHkZFeRIWoYM+wO7Q5BgTgwp
         zaWg==
X-Forwarded-Encrypted: i=1; AKwUvBweQDtl6e3Huq5dtS0XvchZaqZ+RmaVtek/YuCqiFWKQQV0gguOA6csvUxxNheP62c+KD9NFi794aWzLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9EK5Jgy29sIhjwIfvu77mLrzPGbBonj3iCVpDnwLtv9wVeZuTa
	fVDJBYzl9ZTeqhPGSYpti8kWrmK/zfW45tSzS12qB76wlwK/GmaLFndGLSUpREqXHQ==
X-Gm-Gg: AYBFou1zgmKgIeYe0QHj2jmd3F/dLWbVUJUA4SDkCGRkI23isCrxX4+fv1quMAjgNXF
	/tmgCQ4K+VycB8l2W4FwzKLiEPTN1amTowm5SMKbHqPK8p1HYFJ5/DaTSSf4vSevIYuDWhysTb0
	prA84tjzyiPWHfYiznCnitS5PvffzajKuTxLF5y3xPL46UQDdPOlzOzw4zbjX24uF7/71JStolJ
	GWki8HYfQrHTA7lWOfm7ub/An75IENp8weg+/oXAUiIXxpfVtRsqudU/N8MKRCLpmhGcDFnZedC
	zN0x0ulq5stwPgBXmX7x1paly1B01bIFBsWBDyAEL+9pEr8GOJiuFcVWPQYJE8tpaxtqa94Uo10
	yLv+FvNIq7ZyEfi2Wic0LqpFmIqaw3RISkLbPDbQkYP5uQQakbOzQJqkYfH/fBy+8MVblHnd3fW
	5s6iB8LdCTC9q+W1X88Dlog/+nJzVW6h2FHYzNjgV4idX7Ozoa6n1oUvL776Vtbdyr9w7+jB6xq
	Ekur+V/kVO1gxNrU45wAR6cDBv9e47RV+p7dso3DZH1q0Vh4K/oFF+5j6G5gVRzbyMs3rEETyq1
	qaD9QTl6DYaVMeFLOhvcNAFcBJSeEIb9+hVdb90lScs6QhnpYFhx9t+ctX7k5GZDJC9rnDTfOkk
	+P/36nrSvTJXUsYG/VA==
X-Received: by 2002:a05:701b:4192:10b0:1a3:8d5f:6f93 with SMTP id a92af1059eb24-1ac5c8369cbmr26358050c88.17.1793854079724;
        Wed, 04 Nov 2026 20:47:59 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:37bc:b763:7ec7:65b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm17142927c88.21.2026.11.04.20.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:47:59 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/7] zsmalloc: redesign object alloc API
Date: Thu,  5 Nov 2026 13:47:30 +0900
Message-ID: <20261105044752.1997895-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both zram and zswap already have per-entry structures that store zsmalloc
handles, so allocating a separate handle_cachep object per stored page is
redundant.  This series embeds struct zs_handle directly into zram and
zswap entries and drops handle_cachep, saving 8 bytes and a slab
alloc/free per stored object (2MB per 1GB of swapped out 4K pages).

It also folds zs_malloc() and zs_obj_write() into zs_store() so we don't
take pool->lock and look up object location again right after allocation.

A simple zram test on a 24-vCPU VM
==================================
165 fewer kernel instructions and 0.7-1.8% fewer kernel cycles per write;
lz4 single writer +2.3% IOPS / -2.6% average latency;
24 writers +0.9-+1.0% IOPS; no regressions.
Memory: 8 bytes less per stored page.

Sergey Senozhatsky (7):
  zram: drop stale comment in write_incompressible_page()
  zram: drop get_slot_handle() and set_slot_handle()
  zsmalloc: switch handle type to struct zs_handle
  zram: allocate zsmalloc object under slot lock
  zsmalloc: embed struct zs_handle into zram and zswap entries
  zsmalloc: fold zs_obj_write() into zs_store()
  zsmalloc: constify struct zs_handle pointer in read-only functions

 Documentation/admin-guide/mm/slab.rst        |   2 +-
 Documentation/core-api/memory-allocation.rst |   2 +-
 Documentation/mm/zsmalloc.rst                |   8 +-
 drivers/block/zram/Kconfig                   |   1 +
 drivers/block/zram/zram_drv.c                | 130 +++++-------
 drivers/block/zram/zram_drv.h                |  10 +-
 include/linux/zsmalloc.h                     |  37 +++-
 mm/Kconfig                                   |   3 +
 mm/zsmalloc.c                                | 204 +++++++++++--------
 mm/zswap.c                                   |  21 +-
 10 files changed, 229 insertions(+), 189 deletions(-)

-- 
2.56.0.398.g882cbad275-goog

