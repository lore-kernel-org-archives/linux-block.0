Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768152;
	b=VCCkTARp3jAvrP6NAoubCybnkttPT3SAy6ZdNZ9OdVWulTn5x+qDx79CGGzlhMI4StjR
	 udO2RktYtssut1hXhXVNUAVExhE5IQtr5FoQ6PndBKbeKjZ5RK+W3cIDDIPKNgc6NnAO5
	 3+11bGMoq1h3NLFMb6PGGbo05VLe1+I+bT6xc+OM22qxYGBeuG4ujeUBYGY5pMFYGqzXq
	 zuMIDmxxDv90x9wp1ImMKk+Jr4Mr16iFDaq0RC/1KqH66ii/M/HCin4IZJiIEfBWBxCQP
	 Ixk6tbhwoufDq0c1ifZ9dqyTaCgXBaVm3j+lTzxsyj8ThpGeN1bNVe1M6CRtdgmre1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768152;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=FelsLGm3OIsJMRghgdPAN/WSMG0jTZ6UF/BA+N/J5Dw=;
	b=34DAY/noWkQn6hJj8VZlHrYDIhi0mJ6soGLakZ3WL7zv/pDVW3Vwtq6V3He4Veh2cCbz
	 wU7aJH8rjNPpjZPDV5rfxFYUWn7wYoGySmo1eh+eAg92F2kULt5SV+bIxNbggtZBJ1r4E
	 ciJqC/7OMT+T/mMgk9mvbkXinmdtb6AnQcTI52ThYIFWitLANvau/NN2KlwYzk6Vi9xJb
	 08T3TD9vAmfuS5//ZTmPiSA3k8t71/U7l9BwsKAu9NLboKZMSk7+Xo2W68LQk5Im8Bh48
	 yIXwIGZWZFUoXjRoH6IXK61B3fbluwGIhTmfe9VH04uhoNye3/R56ur3DbAD3iltVqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=MH3wMfsr;
	arc=none smtp.remote-ip=220.197.31.6
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD66606A31E;
	Fri, 27 Nov 2026 08:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD66606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=MH3wMfsr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Fe
	lsLGm3OIsJMRghgdPAN/WSMG0jTZ6UF/BA+N/J5Dw=; b=MH3wMfsr+91tP98ioa
	WxBSin2xEDbztiQxdRz/prROR1Dw4i8vM7x1NWXqssBG+jWcgbtAp5MFkkBGw5Nx
	KCRFeSdcA9i3apbeBtoofVHU+OH/i9JcmQwWWL4hNrpKyEvRBDM0XvGUnag2c6TP
	R8WSLPQjsndIKo3PDLI3JcyW4=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3V+v5Pglr3S9kEA--.12822S2;
	Fri, 27 Nov 2026 16:27:38 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Barry Song <baohua@kernel.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	sashiko-reviews@lists.linux.dev
Subject: Re: [RFC PATCH v4 4/4] mm: swap: allow direct reclaim for synchronous multi-page swapin
Date: Fri, 27 Nov 2026 16:27:36 +0800
Message-ID: <20261127082737.3625032-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-216091@kernel.org>
References: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com> <20261115024455.1465726-5-zhaonanzhe@xiaomi.com> <sashiko-outbox-216091@kernel.org>
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
X-CM-TRANSID:_____wD3V+v5Pglr3S9kEA--.12822S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW5WF48Aw4DtFy7trW5Jrb_yoW8GF4rpF
	yxWFW3KFs5Xr10yFZ7ua1kGFZ8Ca93XayfGry3Wry8u345Za48ZFZ0kr1Uu3WDCwn3tanY
	qrsIkFW7X3WqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UkfHUUUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoxvqumsJPvvtvwAA3d

> [Severity: High]
> Can setting __GFP_RECLAIM without __GFP_NORETRY or __GFP_RETRY_MAYFAIL
> trigger premature OOM kills on order-2 swapin faults instead of falling
> back to order 0?

Agreed.

> [Severity: Medium]
> Should __swap_cache_alloc() unconditionally override the GFP mask for
> order 2 here?
>
> __swap_cache_alloc() is shared by all swap devices even when zram or
> CONFIG_ZRAM_MULTI_PAGES is not used, and when multi-page compression is
> enabled its order is configured via CONFIG_ZSMALLOC_MULTI_PAGES_ORDER
> (1..9) rather than hardcoded to 2.  Or'ing __GFP_RECLAIM after
> thp_shmem_limit_gfp_mask(vma_thp_gfp_mask(vma), gfp) also overrides
> defrag=never/defer and caller GFP restrictions, and placing it only in the
> else branch leaves out the mpol path while causing shmem_fault() swapins
> to behave differently between CONFIG_NUMA=y (where
> shmem_get_pgoff_policy() returns a non-NULL policy) and CONFIG_NUMA=n
> (where it returns NULL).

This patch was an RFC-stage exploration specifically targeting synchronous
in-memory swap devices (zram) at order 2 (16 KiB mTHP, the primary
compression granularity), to evaluate whether allowing direct reclaim could
avoid the partial read caused by order-0 fallback.

I wanted to raise this point for discussion first in the RFC, and will explore
more generic approaches going forward.

