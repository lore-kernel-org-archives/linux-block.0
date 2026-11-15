Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794710819;
	b=vIK2SmzMOhaNT/GeC82zYKlqkt8JgyH1n0TiWAxYI2faXiA9ARVBvZLFQowecnCO3bvv
	 Hs7Q7H4CMq0CfRDOQKXv8+bs4I8i48kpNpYgqhFg0be9fhM7loSJnWgZTAOJzw4/ip/EN
	 xjmIxhNkHTKAGeF9VoujDlm5FopiiQstceliJHDlQyMPq+vGQERpmIN0Pk6Vr8rZwvGNu
	 tHh64skC81i41sVQbnwHszS31Hta9+4T6FqH7/0xxrEHc6vO31qa5p4mULPqlGIs7rLS0
	 F9kfIi9QyegqgykwyPTLO8at5nmo73Ok07tORV0rOxIc5a1dfOq5Nw1PYPLNE8aW85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794710819;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=1A6ILGYMHRkFiraGoEIBeJ2vKZxeuMJlFrT2mhzR1hs=;
	b=tsSmumMqh+mbwxPQhyRlsPbbePP7vgyLx0fPqYPYRK1NY2hsj8kayujFJSHW+oYKsMy+
	 FH838x6CGfj4ALiivn6kYzIZ3qXDnmfHQtOYJ10JwqKidyjdQrkjRHsK7ZNBy3qChIDGM
	 1fwckaGrgG75b6CNfoto0M/530itELrwo2wtUvj2TSI7QE5No7FToVCF3lcEFRKQZd0fN
	 92vnsPDCkGktXSUY0EomQLZZL/OmoW+yfXY6T3Zf6ZRaRC6wVXLkOjIuFPxTgYq9nEMCe
	 kYyPMVEIxJZWCfBhLhjJujJqN3gRT7FenQU/lLZbdRgmVJh/EjXmrcQHWQs0Wih/sXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=IkKyId5K;
	arc=none smtp.remote-ip=220.197.31.8
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451F606A33D;
	Sun, 15 Nov 2026 02:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5451F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=IkKyId5K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1A
	6ILGYMHRkFiraGoEIBeJ2vKZxeuMJlFrT2mhzR1hs=; b=IkKyId5KkdnMA3672Y
	PVjCUCyHB3RR1aw58IxumKwA/mJK27MMzwB5x6H8SdIYd5saj49nr5LFLXtUMPmJ
	1rBvAVqzrZOyK3zD/ZM8gHMEx501J3T6HFgRIwG4LI+gHyPB0CHHgv96YZYACu5Z
	rO2S8Ml+f935s2hvQ8r1Q745Y=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3H_OtHPlq+ob+DQ--.31738S6;
	Sun, 15 Nov 2026 10:45:23 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
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
	Bo Zhang <zhangbo56@xiaomi.com>
Subject: [RFC PATCH v4 4/4] mm: swap: allow direct reclaim for synchronous multi-page swapin
Date: Sun, 15 Nov 2026 10:44:51 +0800
Message-ID: <20261115024455.1465726-5-zhaonanzhe@xiaomi.com>
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
X-CM-TRANSID:PikvCgD3H_OtHPlq+ob+DQ--.31738S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyxWrWDAF48XFWrAw4fZrb_yoW8GrW3pF
	ZFg3s3GFy8Wr17GwsrW3WjkFyUG3ykWF15Ja9Fgr12v3W3Wr1xuryDtw18XFWUGr93Aa4k
	Zw4DAF4xuFs0vF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2VbkUUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowNQIGr5HMNkbQAA3V

Synchronous swap devices such as zram complete swap I/O in the faulting
context. With multi-page compression enabled, a 16 KiB block is
stored and decompressed as a single object.

The swapin allocation inherits the VMA's THP gfp mask, which drops
__GFP_DIRECT_RECLAIM for VMAs without MADV_HUGEPAGE. Under memory
pressure, the order-2 allocation fails and falls back to order-0,
requiring the entire 16 KiB block to be decompressed just to swap in
an order-0 page.

Allow direct reclaim for order-2 swapin allocation to improve the
allocation success rate and avoid partial reads.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 mm/swap_state.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index da65d75ceead..912b0e21a781 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -462,6 +462,13 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	if (mpol || !vmf) {
 		folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id());
 	} else {
+		/*
+		 * zsmalloc uses order-2 pages to store compressed data.
+		 * Allow direct reclaim to improve allocation success and
+		 * avoid partial reads.
+		 */
+		if (order == 2)
+			gfp |= __GFP_RECLAIM;
 		address = round_down(vmf->address, PAGE_SIZE << order);
 		folio = vma_alloc_folio(gfp, order, vmf->vma, address);
 	}
-- 
2.43.0

