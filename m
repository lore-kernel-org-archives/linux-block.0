Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6C3750B1
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911829; cv=none; b=lvZdXK6+JEa4J93RE3L02UvdW1M/CsLEpFRoAcXYlyIeNpQAcqWPeJLoaMCjanECcCWGN0+piq6dO5hgODVSqkbytCpnVYRsWLz9N4j7H5f3VpQlUdIpWvGLALK6dPJm2F9MM8xzLipPozWwlgiqxx3UsyR2SpiZd5N68CERBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911829; c=relaxed/simple;
	bh=58Y3MgzcWVqssUvgjLqAF5hQOHL/SA5OJelNCB0y6IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYhqF2ASqJka1H9Dz3ytYHRAui1tqXb2Y/KGzq/KCO2UgPd9vVvDWPiNhcrdHifkeGlqjr6t9nhOqlxBxuy1BGsiiRgpnwpQb4WIdOZ8txSY2J7ObcPfi+2yxg3y5VkBfIF515YKPDfl0hh5X5eZSx53JaY89lhyeb20NoNUT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64f48a5c3d8so8085962d50.1
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 16:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774911827; x=1775516627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAf2oXhrArWRQHuBF1UUaD/CmTI4JKEJyktvpmLV08o=;
        b=cFrmbR+m/xEMn8o3JfTOdsrTCCn0XODtr+ulcqbVUmFBUc7IvQZu+/xxwi5v/xXywK
         fP4v2ctoDVAzqcUnw66/ytVarmWENywFmW8v4nEz0MHkW/7UZ/1HeWwSOddY2/tTYkdT
         0M/Uj8JvY7bbyhzDh+30pK6nuAvk7W3WRf2ZZQRA54OzMJh1vHlZHxZEgTgTxmq/sgEM
         svl/UAh/tbmtpWwT2zYm3Z1Vaqf/4JtWnBT8d+qxhvkXj15O9h+dVXdrIT9frpdRjElp
         DD2dVE6arZ6fZKPYDaDtDKX2BgE4f57PipbICyS2j+jBH0k4/qI1PNv86VBydzYAreG7
         fDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXorOCaGbeVQO4FGdfCsRBfVHhWN12/nHEPyQrYonDjDdaLlu6RZsB0SZxmmWe4lm6Qb2dKbDEBP8uHaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdH5JuZUjf1FmgOyqcVt/5hp/CFjCJoVnFUnG9Eu42mX1XUfKA
	VP8uKK/EYctvYwBWjiSN+FdVlyAM82UwwAkrPrfSTcJjHOP/ludsSyrj5iRLolrF
X-Gm-Gg: ATEYQzzHc6RnPaoFALFeVJSpy2dVxKRoFjlQltmwihAR054f7K2uSHEv+HOubPe6hhW
	ItTXQXM3j2/gHl+/1MEHnLF9EykMWn9sh3WMd+IYmhrZDIr8o4OMnV9oMSGw5Ogaju21pWETDum
	uXxTlDNPqEb2hjn9nJ/VF1A9g5XrmTlZtd4y0dp6GMBkGY6E7HjjGaGmZR2N6XBkGgOH3PSQnXU
	TACJCUg3+bJ4z8iHuDo5+8CUpwNuUEeQDHGslIGywTXGMo6u5a9VcyqZlqVfM+FrRao0apox1lC
	yfBQeH4KJ0/X0BCfw/+cOWebjXqJrE0FWDd3vZuOAPCwICPujpI94wFT/3UyKWnFbEeV1VBaHfd
	xNeXKBX2RYdcX0p5CUrKLok1OR5gZuEpTjuQJgNBfT3wCneh5in6747g0YHd1aIYgIuryvZjUk/
	dGkH+gQ2jkYCMnk123RCjW
X-Received: by 2002:a05:690c:74ca:b0:79a:4b22:5e35 with SMTP id 00721157ae682-79bde22821amr141067577b3.58.1774911827600;
        Mon, 30 Mar 2026 16:03:47 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-79cba47147bsm42052177b3.41.2026.03.30.16.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 16:03:47 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: Fix general protection fault in bio_integrity_map_user()
Date: Mon, 30 Mar 2026 19:02:56 -0400
Message-ID: <20260330230256.4160820-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pin_user_pages_fast() can partially succeed and return the number of
pages that were actually pinned. However, the bio_integrity_map_user()
does not handle this partial pinning. This leads to a general protection
fault since bvec_from_pages() dereferences an unpinned page address,
which is 0.

To fix this, add a check to verify that all requested memory is pinned.

KASAN splat:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
RIP: 0010:_compound_head home/wukong/fuzznvme/linux/./include/linux/page-flags.h:240 [inline]
RIP: 0010:bvec_from_pages home/wukong/fuzznvme/linux/block/bio-integrity.c:290 [inline]

Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
Acked-by: Chao Shi <cshi008@fiu.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
V1: https://lore.kernel.org/linux-block/20260308001358.1675543-2-iam@sung-woo.kim/T/#u
V1->V2:
- v1 incorrectly assumed pin_user_pages_fast() returns bytes. Fixed.

 block/bio-integrity.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 20f5d301d32d..992ce39e8ab9 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -338,6 +338,15 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 					extraction_flags, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
+	if (unlikely(ret != nr_vecs)) {
+		for (int i = 0; i < ret; i++)
+			unpin_user_page(pages[i]);
+
+		if (pages != stack_pages)
+			kvfree(pages);
+		ret = -EFAULT;
+		goto free_bvec;
+	}
 
 	nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
 				   &is_p2p);
-- 
2.47.3

