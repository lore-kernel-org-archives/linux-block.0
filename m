Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A51D7E42
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974225; cv=none; b=W2k0ufdNC15Pxu6GIGxpzCx+PnjHIK3Uln0l2P2ArBG/OUFQnTpYQV/NIMWBEQGC7aw7VSTE1a4+OLlw5wicTa0zkIYT4fvUzv55dDhfpmllRz02f6h5SqMPu3P0wtT70bDjlCpRhFeSslLhmcHWPeR4wFqbH5woVv2UbDkcQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974225; c=relaxed/simple;
	bh=aaupxIS6hcNYxjFP/pFer/sVt7G0k5nZHIyuY6B6Ee4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ftScfgUGwCWS7bjROL17Z3sprLgtjE9QoUnUnX+GW6TS531l6pPYJ7neR2j2+eHdywI5wpAyBIl1G7pewhtrjw0UToGNej1Tl6q17HRsQCnaun08DBsXl0fwR2T+3fRx6j98SPq1eQmiP/8+HaTXibCD5zg2naqLebCZCpa3xLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgFufQ28; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgFufQ28"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so628568a12.1
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 02:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730974223; x=1731579023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqSciqGrLuQyxU4xH9TemoiTzJ7tkyQcA2uJjcQBeIc=;
        b=cgFufQ28rumcjc9BWKfkePJbp8B22qJNdx7qzFXNOfYx93gsOWeacE9dAUbkE8WC66
         t7Cyjsc5vfSw0mZKJRUdvN4hmxUmfjy+D99K8HknNktgNR+u0MX27eziHHLEtBq0Riom
         Nt+VOI6wnxLATL+pkPqafitjnNyh93KT4FWtzDNBitCcRGdmknizLxXR04EAmguYvv1J
         sl3fIhO9OGGw2eBagpubPtk5593RJbWC5E2jnG3MJNtXrpqiNy4ijlf9wvzeFEffrETx
         kKBh63m4AhcPS3fdZHNTfbraCXX8ZMnGGwM7G5v9DY95AEiN1347WAhI0sRZgNj9f7Vz
         MFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974223; x=1731579023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqSciqGrLuQyxU4xH9TemoiTzJ7tkyQcA2uJjcQBeIc=;
        b=rhdrlpX339jsLfVly0Tl2Qz+wo0xMJ0FQ0lwgi1JbBjQlf9ILWogdZ9+CQ3nc/ByMY
         t6JTxNtNHCwufn3GxRdZN+mPBKu+Vv2aoWzf/LQ5Fy1g8tLLCg3TPN4zV2ebfw4bWdJk
         4qs5ulXggZILBda+WNkHr1ysXWmS6LkcRFSHdiTtumVWeET4jbpk3tH4WI+WNkJzSMEZ
         YhilbLR0WAZQVA6QZm8aHQBTabnqNi4hzVnGigbrKw34HQr5LQ8WeqQyet/LY9Fe94o8
         V82xFpH6xRIrbmbpFP2zjMusm8Q6vcbUZIcyE5Zp2NII46tgnJt79hzwTlwM7TB4rBL5
         ruOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF/KToALQpNoEA9Uep+2CeMvtLX4WS3sNpXG1tXSBicFCZqNum2qX3x623k9lA9tvGKGu3Ts3t8DfPqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ynNI7h+IW0pkRQ6+jwFYr1vOhmmP8cZV6hJyAB37U983EQDC
	TIQrbKs3N6Mp4v+cv+NPHrNvBaTEsTrZiiPjlWQbLvmQwluA/iPC
X-Google-Smtp-Source: AGHT+IG9cfAqYpD7oV3wGqHXj83bXLMRqLrxqFQqjPNciVAMOc7HbN//yf4c1MKCQ6sIU/b0vRZbOQ==
X-Received: by 2002:a17:90b:17c1:b0:2e2:bd34:f23b with SMTP id 98e67ed59e1d1-2e94c50d195mr30843934a91.32.1730974223184;
        Thu, 07 Nov 2024 02:10:23 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:507e:2219:6f85:3a5f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5fd6b0sm3076415a91.34.2024.11.07.02.10.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Nov 2024 02:10:22 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bala.seshasayee@linux.intel.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kanchana.p.sridhar@intel.com,
	kasong@tencent.com,
	linux-block@vger.kernel.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	senozhatsky@chromium.org,
	surenb@google.com,
	terrelln@fb.com,
	v-songbaohua@oppo.com,
	wajdi.k.feghali@intel.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	zhengtangquan@oppo.com,
	zhouchengming@bytedance.com,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com
Subject: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram based on multi-pages
Date: Thu,  7 Nov 2024 23:10:02 +1300
Message-Id: <20241107101005.69121-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When large folios are compressed at a larger granularity, we observe
a notable reduction in CPU usage and a significant improvement in
compression ratios.

mTHP's ability to be swapped out without splitting and swapped back in
as a whole allows compression and decompression at larger granularities.

This patchset enhances zsmalloc and zram by adding support for dividing
large folios into multi-page blocks, typically configured with a
2-order granularity. Without this patchset, a large folio is always
divided into `nr_pages` 4KiB blocks.

The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
setting, where the default of 2 allows all anonymous THP to benefit.

Examples include:
* A 16KiB large folio will be compressed and stored as a single 16KiB
  block.
* A 64KiB large folio will be compressed and stored as four 16KiB
  blocks.

For example, swapping out and swapping in 100MiB of typical anonymous
data 100 times (with 16KB mTHP enabled) using zstd yields the following
results:

                        w/o patches        w/ patches
swap-out time(ms)       68711              49908
swap-in time(ms)        30687              20685
compression ratio       20.49%             16.9%

-v2:
 While it is not mature yet, I know some people are waiting for
 an update :-)
 * Fixed some stability issues.
 * rebase againest the latest mm-unstable.
 * Set default order to 2 which benefits all anon mTHP.
 * multipages ZsPageMovable is not supported yet.

Tangquan Zheng (2):
  mm: zsmalloc: support objects compressed based on multiple pages
  zram: support compression at the granularity of multi-pages

 drivers/block/zram/Kconfig    |   9 +
 drivers/block/zram/zcomp.c    |  17 +-
 drivers/block/zram/zcomp.h    |  12 +-
 drivers/block/zram/zram_drv.c | 450 +++++++++++++++++++++++++++++++---
 drivers/block/zram/zram_drv.h |  45 ++++
 include/linux/zsmalloc.h      |  10 +-
 mm/Kconfig                    |  18 ++
 mm/zsmalloc.c                 | 232 +++++++++++++-----
 8 files changed, 699 insertions(+), 94 deletions(-)

-- 
2.39.3 (Apple Git-146)

