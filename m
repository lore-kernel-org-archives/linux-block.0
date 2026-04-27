Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094D2737F8
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777263015; cv=none; b=ngYAkw87Hr+JTB5ymRzxFVUwoNlJE0LVXrVy3958Depm9tXb2b9OEmZAvG4SMafxBHsq6nTY+MzRc2LmzqqQ7Whv6YOScJDAYMPnWkHzoHXy3zVUqdB91aP3QuFXVbhr5u0D/1fNeHgS4lK+Qzlh/4Zb8z81nfNnUVq0uE8fRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777263015; c=relaxed/simple;
	bh=hD1dIg0Pn8kTzh7W/SVqNi4Q4KZaffb3XL6M8RlhPHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLHzq0/bVBije69BrpdFFzFUxoD385gfY9DPXPeAXirhCLcjO9A9m3OHvGHw6lHjU0un9+3JweaNhVKNRU6NpwJbXhstYnsZGGaEfRUMCKvWWCjXtHFLqKtk5hZdSuFzBC6cCq/WVLIL/hGF1M22PsN6p/eT2crSfI2JSx4SDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a7109f568so115422927b3.1
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 21:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777263013; x=1777867813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl0WAnQ535tE4CWpSeGGP4i6YyUr6DuMKmnrzyCP4e0=;
        b=IkyrA12oOeg9+BCOmzbVnfXx8btYaPjqAt/24V4tZv+gnv87GXbWxDkDU+abFlzyx/
         Pcfceq5mXWH8dt3Bc5+Whx16J8aIV2bFTh7jWCKgAyV4t+LBbQVzz+RpdekUMT6Q9WUd
         gfHUzjbwsGouAsCdlnIwzY9LXIgB96vXcOWV2hDnbDOhoS27hOj/Bjz+bQ0oPyuDqVU5
         uTnNMsfKRF7foeAMvfo+WSkr0rVLuOAmmmeNBHSsMWTTx9+Aw2IsurVAECTDHjWHpwEX
         R2JOGGBjGSMJTaZh5c8mQcqPEb2zKMYDNzHqqqsDSDST6X5b+IvtR94zVtL6UF51nPIG
         PwoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mwpRgnLLz4ZCs1SFdhcQX+AcWM8rct69aLy9QUXSW9DeiB2Dw2S3z5hDFWrKQvI+qDYSv9GCOXnXUfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzTELemJyHKAZdeDOvwEB+GYbYDmvP8fyP/lmKrOSCdsDTCGu
	4DUIz6gGhj2E6q0z0mhspj5QJJPcU75wWIe8fm+CIvHhScIxo0XhXKLa
X-Gm-Gg: AeBDiev5Zycvajwnw0TYtRtv63UOl1qE2nqAzcRuZdGNnZyF+zeyClDhb5t1UD5eLSa
	7c2UTFViSgoLytWKuE/OCYp9vaLYfT+bUyKUoHqkDhs0kq5VJht3O9AX01O1bu9lQTtOZAQ64WC
	VJuZvvWMRA7a5yWF3J9aO8jnbTHTbKmpAOdN9swJ0GMu9Upo5+oqje2Q1vCX/9Ket5NAK6hHvVQ
	mrYvgcD7aSjye47B0X1ethmor7WPp+HjN9T/HmnkOYfLPPdLOjF2dtHAMn5Ru8xZKbnMkEYY79L
	WCE9rwl90NhY+iktBRKez4x2APRBGDnGBNy6QRoMWqFHny8I23kEKpNZzvYrK78JF6toqiITydU
	YG/ZKbyPMNNfBofsF0D4YRwGCIG8ZNFN86TQfBvpEo1byWW71LGqrNFila6wkDWq4luUC4FRzWC
	VVH+ngqcXw6T+1Ew63SxPu
X-Received: by 2002:a05:690c:6e86:b0:7a2:f14d:5a1 with SMTP id 00721157ae682-7b9ed06a19emr407417907b3.49.1777263012862;
        Sun, 26 Apr 2026 21:10:12 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-7b9ee8e2bb7sm120822077b3.22.2026.04.26.21.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 21:10:12 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()
Date: Mon, 27 Apr 2026 00:09:26 -0400
Message-ID: <20260427040926.987166-3-iam@sung-woo.kim>
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
If partial pinning occurs, unpin the memory and return -EFAULT.

Reproducer in blktest: https://github.com/linux-blktests/blktests/pull/244

Kernel Oops:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 1061 Comm: nvme-passthroug Not tainted 7.0.0-11783-g90957f9314e8-dirty #16 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
RIP: 0010:bio_integrity_map_user.cold+0x1b0/0x9d6

Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
Acked-by: Chao Shi <cshi008@fiu.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
V3: https://lore.kernel.org/linux-block/20260420020327.1667156-3-iam@sung-woo.kim/

V3->V4
- Addressed a sashiko's comments [1], if it makes sense.
- V3 wrongly assumed that iov_iter_extract_pages() always pins user
  memory.
- V3 insufficiently handled the return value range.

[1] https://sashiko.dev/#/patchset/20260420020327.1667156-3-iam%40sung-woo.kim

 block/bio-integrity.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e54c6e06e1cb..766cc2d1d51c 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -403,6 +403,23 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	if (unlikely(ret < 0))
 		goto free_bvec;
 
+	/* Handle partial pinning. This can happen when pin_user_pages_fast()
+	 * returns fewer pages than requested
+	 */
+	if (user_backed_iter(iter) && unlikely(ret != bytes)) {
+		if (0 < ret) {
+			int npinned = DIV_ROUND_UP(offset + ret, PAGE_SIZE);
+			int i;
+
+			for (i = 0; i < npinned; i++)
+				unpin_user_page(pages[i]);
+		}
+		if (pages != stack_pages)
+				kvfree(pages);
+		ret = -EFAULT;
+		goto free_bvec;
+	}
+
 	nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
 				   &is_p2p);
 	if (pages != stack_pages)
-- 
2.47.3

