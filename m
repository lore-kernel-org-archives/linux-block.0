Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412874;
	b=1vU8G9N+H55fTxHZtIvOLlNE2g6DpCZZwjTLXxB1QPMSCX+rTCX92QimauTZ64lCUgtX
	 wRRgoZ/csPYp0FVD5Zy9pJ9SVzDpb0ZCZZAcKc8PZZYdL9J0fyYqijf0fVLYQFVJ6f8i3
	 ZiVJqp28iSNskJpqEckyT5tirhH784Y1veW7U8MAhFoV51GbBUBO1Zunl8M2CQPl1CD7S
	 k2rgLcsszgJFxmdvQBtl+Lsa3XpMFx+46igOjUa76c9qLA+bWepj3lb/3gIu3CYcUrbgp
	 zETM/keO31u2qvtglF5unt2kPHYKR3tA3z45Deh25SqZhGjwlP9sfWzm45kMyTUN7yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KVYLN2+U6McWuEiDknSvpcPzmASCRN8tM6SVo97GcMM=;
	b=o+Hg6aLzWbiyxE0d0oQ99JHfiC8DMnmdBnkocGONgEC3sncjJzf8/9ZBch5X7Gs4ppQa
	 qL8AwlkpCKzdDMinQ47lYMk6tJHGw1Ct6hOSJqTwoaHaoVcCpuvS+aEfup75EvSIx3JDb
	 JTeLTpiSqGUc1IpBcYmN0MRaVjzkQJvjZyAVhrDFtddRsK0bgJR3YkxGCTh1Ru83y6R70
	 1zfZZr7UytcOlNjKKLva/w+OPGMl1hEoYSDzLV8rQ2/p32EErCQBHl3D7vCVifBtmt3pX
	 CHJJU9BuMj9uw1ZybWuumn1bXjfsHVCM87IPu2lzrALs46H8EMXwFfZuiSUuf0ERfRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LA1IhQpA;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9C606A31E
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 05:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA9C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LA1IhQpA
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso1778797a12.1
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 21:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795412873; x=1796017673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVYLN2+U6McWuEiDknSvpcPzmASCRN8tM6SVo97GcMM=;
        b=LA1IhQpARwsh3UOKKJFoQ2D1ETT5e2wfLE2nVB013rqS3TPN0DhLAtL5jur/pqoHaM
         I4i03kwpxrw9XCyg+X8WS9n5sJ8gop+Rl6Dau7YLoOWAzmxfLF/3dz9nAb+TV/BWk7Q5
         dIAEKeKKpANajTFwozjCBDBaQo8GTzVvDdVGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412873; x=1796017673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVYLN2+U6McWuEiDknSvpcPzmASCRN8tM6SVo97GcMM=;
        b=ZVnPvB7ivpTYaiJ/nt7azl0M2J+AfIH3EuIVu0CXWTEfmMAHH+kr3ywCA3HH8XdgAT
         Ilbyctu7yX3boM+m3Sq7ktlgLIKCRKvnwGqMdBq3fGfR/w273SQzg7QgfpqrQgb1E36L
         kD1iZTI7B9Kt+H5rPlKTAzcFJhrn94VbTPH/YXGIOKXZzhGdPl46Bk76rrXw7iELeJQl
         RFnp59q1NqrSEWOboiQ5XossedsVMtlWlTpJ7V/AZV1d5+l9oKDKKYwjNidsYRVgO+N0
         xAQwZLNLrpIoRnHha+PXi7QubQo0d+MuxlAXGgzEJ+/9SwAqcFpbe4GQZSWIwfXyaAFn
         ujxg==
X-Forwarded-Encrypted: i=1; AL+hErFuLc4Jsfn6YxsTDlQsNC+Y9U3jCYcTcGChGC+95abcw0GsMN2G7VfKGpVE+SvdE8sLXA+iM7eRIjpJLg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/pvwJnPSYIChCqEesR+hM6ARU26nHPSVXpOOAKU8pRI4wyfQkg
	KT9Slo/8gEMPHs6YR841wM3CY0gzrd1vwjQE6i7aM0wgC58IctLzNByrR1MnUAY7Aw==
X-Gm-Gg: AZFdTZcY6Eb+sBRE6MGfiZXxgnDA4meLcq5BArxbsLFhMplMKQMch6hjIEs2tHIN0I2
	/vFOtOJLziKx39HaCx2Ba2+daYHDYz4ryblZmPgUJCMTRT7GS6FINx+Z0r5LKgemeOAlCpM9GG6
	VJUGZJSUmZXmAl93kU/obYKBePCnDHy8ua7eqoEl11LD076eoiHde1t1Nhic+f83uZotFWZAusB
	ToOqcWPz03a9PHetFSdHMboq2dQlmS+amrnYfcZa8yq+iIuiJrUZL8YHZKhNxqZbUz5QNIJ6+WB
	aBmlljYNRTZIACiNA1rPEBsgGtscApdUt1AH5Lq1UkMigGQkKzic5Rur0VnLG7o0PrUMNYdspE8
	mR3FPVcpkrj38IjwBg/3ZZOZLhc8zwslLi+/3Nb85oOzsXMWNZ6V/VnHZtBKK1tJv1HK9qASTLy
	1tqPgIi7x/NqUExuMDll3vJALqmjnONMcutDPsMcCY/nY72YOzSPOqXaLRwbCBazd3eHU9/xfE+
	ojLqYc8UoXp737JR+GDxN/DmqEoRqiUu2tH4VZkyGiGzUE1rxpm4hTyTc7v8YsfQcLMkRK5Mel+
	ETjzAgqRQ7tXzEEo9LutHcV4mCBg/bwJnLmBAJab50obagchITrKgKlMTNg2EBjVgxSf6Bmxv0H
	eBCVaeUgVRMtS69NsJ70=
X-Received: by 2002:a17:90b:442c:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3b41c92c161mr6622325a91.24.1795412873376;
        Sun, 22 Nov 2026 21:47:53 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:d8fa:c511:e415:e0d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm16240267a91.13.2026.11.22.21.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:47:52 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Hongfeng Chen <hongfengchen@xiaomi.com>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 0/2] zram: zsmalloc: speed up zspage free path
Date: Mon, 23 Nov 2026 14:47:35 +0900
Message-ID: <20261123054746.2579253-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
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

This is a followup on deferred zs_free() discussion [1].  We cannot
do deferred zs_free(), at least not on the zsmalloc side, due to the
fact that object handle is now stored in-place on the client side
(zswap/zram entry).  There is still a possibility for a speed up
tho.  One is batching of zspage's pages free.  The other one is
moving zram stats into per-CPU area (as was suggested by Hongfeng
Chen), which reduces cache lines bouncing in zram slot-free
notification path.

[1] https://lore.kernel.org/all/20261016120927.3191690-1-hongfengchen@xiaomi.com/

v2 -> v3:
- clamp negative stats to 0 (Sashiko).

Sergey Senozhatsky (2):
  zsmalloc: free a zspage's pages in one batch
  zram: keep the hot statistics per CPU

 drivers/block/zram/zram_drv.c | 99 ++++++++++++++++++++++++++---------
 drivers/block/zram/zram_drv.h | 26 ++++++---
 mm/zsmalloc.c                 | 52 +++++++++++++++---
 3 files changed, 139 insertions(+), 38 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog

