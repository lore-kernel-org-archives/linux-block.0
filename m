Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5B40DFA4
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741445; cv=none; b=Gn8a+IK0mFfFzgHPFtiKH+6wVnPbDNQ/xR0mBriB+VzV5jof1tkOIs62cttayUUD+mNcEFb2i/M6BS9v0oaXhmAFh+hVXW/GCDMqpWRTaicI8lr9ZVf/6zooOwptAIs0W2hsQlKcorYdj7Jdi7eF6zYRqBifQ2Qfviy43ec+sN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741445; c=relaxed/simple;
	bh=bgzKs6mbLQhLGavu0hwKVH6mLdIrXI6uzhfcWZta3hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cir9nAGWbS7trDKi8FjpC0hQ+ofYfw2/gfI/34FoDO0y99vDzbqfOgrF6/vMvnBmqKpXadBBByAAHlOwah2sDxXDK7ggEVWPFUuTkYG8CqqAECQO6+vbR/TnJJhetTE+G9nLYlJSfQXNpqbuMLrPUHQRgKN8GUR92sco9RoWtAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE4KWwU7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE4KWwU7"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35691a231a7so668471a91.3
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741444; x=1776346244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MelbjYoWc1d9uyNY8B2BpPObxBTBrZhkXDjyAQtB4wI=;
        b=KE4KWwU74mpA2qMgHrYeJuQm+5r8T9rFaV8PIS5VmeLXG6h5ztaKoxJ04cVW4mrRZr
         4GTdNyUDlwYSdlp9f4IhdMijCCKBg/Pyg3tZnBwZ85e+mW/agjPGAk4KytqPdpJgJ5vX
         XbYpuF/0qvsCM9fH/d9Xol5xiwe+DudT1IJtxyUhq0BFB3Bv6NLsShs165VLcmwG2CkE
         +gQFxOs8zUqbtUno+vNvd1S68i49f3ql0404slryiv/5mAPpqsIVPNXBN71rltwSyJ9z
         yST9dX0PuB9jFRZx8O/EsgCu2gfblm0pLQ9U92He5bIjjdOlkMAPv4y64Nkinl3LRqG4
         uZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741444; x=1776346244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MelbjYoWc1d9uyNY8B2BpPObxBTBrZhkXDjyAQtB4wI=;
        b=S0Fmqpg37gkpMy81+JjwDk0nFi37OxDr/qeBtrHrOs/401uei7IEYZMtACSFoY8mWB
         kwQHMJQultzqLO6yFKvcBh1IVd/pdj8HStMVmFhOQQJZ3B+CSsUtj37DcjNH0so1/mLp
         14Mhn8YHbGKnJesw2t7x0LAbnPqnseTFCiRG/S/SSzUac3Wunme0cj6rq2rlqoTkvu4y
         xEYx1aXg/5AgjNvQ6Sgxs+2OMcHkgi4mDHM1DADXPpWnGG2u9Zqwzy6oofZXcbHtpL/L
         Dcex22jG4Wj6i1zgHRV3RYs/o3ovZ7Ix5bWU4HU08iPfa4eiJJAp/7eUfRjbZWtYXSOZ
         p7QA==
X-Forwarded-Encrypted: i=1; AJvYcCVTyiKHjLxTE+oDSmaGValc3Jzbw1fsM964r9TWfJjSACKV6U8GD1DKlv29nNBgr1G13EwS+Df3g/zU+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPnPUD3VlGlpTQqTzCsRCkJHXBzjsEFiNczmFkRHNqCv8uYNH
	uVeHme04I36ydmhnOToilUd+r9FZu5gF7EHj2TBuyZzj5J+cw9ibJa4Y
X-Gm-Gg: AeBDiesCbZ7lhj6nRs23Lvev80c/q5aHX/2RvDEGNfzaZE6/2+64pApjaEaqPpriPk9
	Wf7TlFdh+SECKV0k16lPbI1MAtuQD56pwDnsE8c0mf16LMtdNpy2QAsTLOLr4ZCFdtxbKS32itD
	lma3jXUtoBpbb/E45SpbXhVj5E7okaEgtg6KqkIvW8EkZ2pm/srvfH6Jng+SsBLL2lxXeDgrJDV
	nIc/Vc5UuMmiVxjWoZP0o7nxZD4pg9bUmQka1fU0Vi+zJ2dnEwgbei08CGn8nYQFVJkmljIHqDy
	wYVScYtY1A3ZWJEOSHyJmm9kcm96Q3NLz3ESsxN9NMDDaTKvMtVRX9xKEwf9ZLRplclSU0h7N30
	rEryWTTufc6OM/8eUvDg6iy3qLruu5QQ4WmpJTzUa0WdRDK8/PzZBp8wNp47nVJRUut1eAc4y/e
	xkVZ/WqPBUnmSCT9MfqvV5q1RkfD8cNpIgwmvWZudVY6C/jaxhUeyCtmO2/Z2WqAIPSQ==
X-Received: by 2002:a05:6a20:72a9:b0:39c:241:65a3 with SMTP id adf61e73a8af0-39f2eda9e74mr25822268637.1.1775741442345;
        Thu, 09 Apr 2026 06:30:42 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm21021166a12.24.2026.04.09.06.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:30:41 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 2/7] ublk: verify all pages in multi-page bvec fall within registered range
Date: Thu,  9 Apr 2026 21:30:14 +0800
Message-ID: <20260409133020.3780098-3-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133020.3780098-1-tom.leiming@gmail.com>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rq_for_each_bvec() yields multi-page bvecs where bv_page is only the
first page. ublk_try_buf_match() only validated the start PFN against
the maple tree, but a bvec can span multiple pages past the end of a
registered range.

Use mas_walk() instead of mtree_load() to obtain the range boundaries
stored in the maple tree, and check that the bvec's end PFN does not
exceed the range. Also remove base_pfn from struct ublk_buf_range
since mas.index already provides the range start PFN.

Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ada9a2e32ea9..f990c10e963a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -304,7 +304,6 @@ struct ublk_buf {
 
 /* Maple tree value: maps a PFN range to buffer location */
 struct ublk_buf_range {
-	unsigned long base_pfn;
 	unsigned short buf_index;
 	unsigned short flags;
 	unsigned int base_offset;	/* byte offset within buffer */
@@ -5306,7 +5305,6 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
 		}
 		range->buf_index = index;
 		range->flags = flags;
-		range->base_pfn = pfn;
 		range->base_offset = start << PAGE_SHIFT;
 
 		ret = mtree_insert_range(&ub->buf_tree, pfn,
@@ -5451,8 +5449,8 @@ static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
 		if (range->buf_index != buf_index)
 			continue;
 
-		base = range->base_pfn;
-		nr = mas.last - mas.index + 1;
+		base = mas.index;
+		nr = mas.last - base + 1;
 		mas_erase(&mas);
 
 		for (off = 0; off < nr; ) {
@@ -5531,15 +5529,22 @@ static bool ublk_try_buf_match(struct ublk_device *ub,
 
 	rq_for_each_bvec(bv, rq, iter) {
 		unsigned long pfn = page_to_pfn(bv.bv_page);
+		unsigned long end_pfn = pfn +
+			((bv.bv_offset + bv.bv_len - 1) >> PAGE_SHIFT);
 		struct ublk_buf_range *range;
 		unsigned long off;
+		MA_STATE(mas, &ub->buf_tree, pfn, pfn);
 
-		range = mtree_load(&ub->buf_tree, pfn);
+		range = mas_walk(&mas);
 		if (!range)
 			return false;
 
+		/* verify all pages in this bvec fall within the range */
+		if (end_pfn > mas.last)
+			return false;
+
 		off = range->base_offset +
-			(pfn - range->base_pfn) * PAGE_SIZE + bv.bv_offset;
+			(pfn - mas.index) * PAGE_SIZE + bv.bv_offset;
 
 		if (first) {
 			/* Read-only buffer can't serve READ (kernel writes) */
-- 
2.53.0

