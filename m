Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794710814;
	b=0sRNJu2tsJpnphFPVJigGgfuaIXrrRnHI1xUnf7DBZh7LRMV4ZH/j0eILg6jGVFJ77+r
	 C+0uoUHSY2ZZPxY1eSpshBN/PZ/Br3KbVOjIwKtvZGKCpoXsAitRequFSkUy1RACy03Vd
	 rc0+tFR6Smp3ZN8IBkgKZH1Oqd9QJPNJ7ay8eJgbg2TPmzPUO5ICDW9Mv7vRMy2E187Ge
	 iMEcTBVOuq/v09MbewwkSrycLiYkYOcAJz9mCCx4kcecTuAGT/Na0+/x/1M0ni1thVNJN
	 4ekGRj7QUen4HdbfkczUJOK1joslLJA7RpPTzthDDPldmXaw1vGb7U/71MbEcCXhgEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794710814;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=r8xUXS0A9Zx5562ccafC+4FXG6fYzwvM8bL3muSMq8g=;
	b=McwkvXr2Fxyvucfl+kMduyDBYMmSfT5p9vD5BxfnYFTLQLIfV4PBw4OZaOYh7Ml3kLQS
	 n3Eg3H4A3W8DgB/VOk2nYPgdWrNVHR1Fo/t499qN35ceVqyTIQu8GXtfM4pn/ZtTexG4K
	 0IvaV7KOUrRhB5kc0wQSIhijFhLC1YOC+4S9SOBzvEnrtmHM+UfbAqucdQNHuloUhYpB3
	 nXPH6snNWKfLeG2ELZTZm+Xf5yJQl7sjCTkHhe9uUERFS2wQ6Kf4wVjEGZ10jbx4817c2
	 mmiuZiHa4DsYHjDt5QVDRTcjUZd+7hntPydwzXUU/LXTxvWoz7YnyCdM4PRCs3sFJlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="XchkAXl/";
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4D606A323;
	Sun, 15 Nov 2026 02:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D4D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=XchkAXl/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=r8
	xUXS0A9Zx5562ccafC+4FXG6fYzwvM8bL3muSMq8g=; b=XchkAXl/0DuW1oDJeR
	yQyJF1sQql/YPr2uJd3G5R7JbEIOo7jnJ/B+ouEdfu5V/2iiZDLDQvzOoU1v97S2
	pZYQOu36hTxd1eLrICYymhCa53Cg532muNNnLcMBbQlRy1aAUmDLn82VBEFmvrfh
	rsawr31gLZJ+i2IAhGQzgIOQw=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3H_OtHPlq+ob+DQ--.31738S5;
	Sun, 15 Nov 2026 10:45:21 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <baohua@kernel.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	Yosry Ahmed <yosry@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Ying Huang <ying.huang@intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Wajdi K Feghali <wajdi.k.feghali@intel.com>,
	Bala Seshasayee <bala.seshasayee@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Subject: [RFC PATCH v4 3/4] zram: backend_zstd: use multi-page size for zstd parameter setup
Date: Sun, 15 Nov 2026 10:44:50 +0800
Message-ID: <20261115024455.1465726-4-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com>
References: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com>
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
X-CM-TRANSID:PikvCgD3H_OtHPlq+ob+DQ--.31738S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry7XFy8Ww15WrW8Gw4fAFb_yoW8XF4rpF
	yxu34jk3W8KF10vrs5X3yI9F15Can2qFy7W3yxtw48ZrW3tFyDuFnrKw1fZFyUK3yrXF47
	XF9rGF4Fk3y7CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTQ6JUUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsAFQIGr5HMEvLAAA3M

From: Barry Song <baohua@kernel.org>

zstd_setup_params() passes PAGE_SIZE to zstd_get_params() and
zstd_get_cparams() as the source size hint. When multi-page compression
is enabled, compressing 16 KiB blocks with 4 KiB-tuned parameters limits
zstd's match window to a single page and prevents it from finding
cross-page redundancy.

Pass ZCOMP_MULTI_PAGES_SIZE instead of PAGE_SIZE so that zstd configures
its parameters for the multi-page block size.

Signed-off-by: Barry Song <baohua@kernel.org>
Co-developed-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 drivers/block/zram/backend_zstd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index d55615f34300..9438691791ef 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -73,12 +73,12 @@ static int zstd_setup_params(struct zcomp_params *params)
 		goto error;
 	}
 
-	zp->cprm = zstd_get_params(params->level, PAGE_SIZE);
+	zp->cprm = zstd_get_params(params->level, ZCOMP_MULTI_PAGES_SIZE);
 
 	zp->custom_mem.customAlloc = zstd_custom_alloc;
 	zp->custom_mem.customFree = zstd_custom_free;
 
-	prm = zstd_get_cparams(params->level, PAGE_SIZE,
+	prm = zstd_get_cparams(params->level, ZCOMP_MULTI_PAGES_SIZE,
 			       params->dict_sz);
 
 	if (!params->dict || !params->dict_sz)
-- 
2.43.0

