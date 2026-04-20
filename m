Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16C40DFC7
	for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776650719; cv=none; b=ucRBXmtL3g1QtMpIe6nxml6I5xlhKuB64fbVJlP+RB0DQ5/Sa27uFDeRudK/BoUWdQTGRjsGorB3AGgRei/wE9KOHJ7uXEOKpKlWGCMENbtUtfJ1BLW+ZKnS7sujxupWQIMdAwkSUBIlrp7nIJNyjOYEnFSa8lEAENWJRQmr1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776650719; c=relaxed/simple;
	bh=jQBR9CkQWQd7EuOKvr6gloNXng7hI1A6WAA1mkPzRsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMcuR7NPw+nAZVFDx/eMUMabEfOTJcX1+rm2f1xVbGbL2DUaROub0jKLtSt7BZoxJrFXcd4A9UT7/7P7tI8iDrrT0QIqh+oZi7XOnbsJZC6yNFE0x2IGeqLQA1lsPSBvHlEQy+gGQE6iX2mlwRvhpzCyC4h8mHXwTNFrPibAfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7b186dfc1d0so33134707b3.1
        for <linux-block@vger.kernel.org>; Sun, 19 Apr 2026 19:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776650717; x=1777255517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxw07dZGozsSlHhhVNHLtxH0zskFbDiC5pVnF35l/f4=;
        b=LEngx1m7KtbjR3xhmPFpB3+vbk6wPbpM/8no3G8I7/S444GQ+cKp2rA8GYx282q8HF
         gNLZ7rHAnv2hF2IBSMrd0kehbvROiG4Mjz5gbaBw/wsFzIDu3tAXoqV/LqK3bnpyvHzK
         mYmp1PPumFbrEsHPwBSkbm8vc6B/lCMdOffD3KS2D0ZKA6+ggmjaDbHzK6wkmQms/RbR
         8m0eqBz9rt3yBAYzncTzop/iHPhYnLoC5i5JTSqEfLVtNeBNUxUrgc3yfEKvedvKc6FY
         DHCsAz1dgSj7lq+NacMZ6k0FuaZu+xWnrOr/kCUAJHUpXciaqPguUGl/vTUJi2p0P05x
         N+7g==
X-Forwarded-Encrypted: i=1; AFNElJ9TSQoF3lMQQ1dJoBC/9DAeb96DuXIQb1atKHryg6dbo8KQgw7Klj7d77RuLf9IXNQgkIef7HM5EoYMww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLGquk8r3B5Pin8qdAbCt//6JWeI/n5v4FHtLc8djwpz+9a/V
	WK41uCvWljd49/Aa6f2RPvmu5qiabQE0Ug9SjQ4VURyXUpTjovjj/7P4
X-Gm-Gg: AeBDies0bV0KkV6ObwM/OIxFBt/8rUjpsBFmBzpnwOzoeyLGT7J9a/p+/4gZAlYsq5R
	mywiINv7BJlAwWAE71L2/n2G/6LTzDzNyQJKXju0FGq2W6NfzbUiOgzy/Ic0ZKoRbmz1d+M6YQP
	EV/aSUqAWTsOPMspzZo375pVTOUOw8r5rtSx5qMOi1SbpEhI39qCXDx9x/RHNWGinEeR5Yt9Z7z
	4r1GR8UoUg35RykoD08gTc8g/jB2A+ZI4WvzWJ4IOgDZHxCEYKHFRHMTV2B57Tj8lWsERMWTpwT
	mFDDhTEMf3bnJvRycRo1oco8i1ho6hN7q+h1qgkYXCjGVRP8LMMQ3GKIEEIgpc76vFRdHfPmIWF
	SngNvLPFx7xQ8FFHMg7Ubf2sJn7lx7VDKiT39XikktzsFbPiXAZC21eEGLQv7HPp92V0zKXK59N
	dsPW/9tCQIMTWnv8NR/Zy0UozgzTYEFRY=
X-Received: by 2002:a05:690e:480c:b0:651:b61a:4b5f with SMTP id 956f58d0204a3-65311989a3amr5415786d50.17.1776650716836;
        Sun, 19 Apr 2026 19:05:16 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-65314b5faf0sm4518980d50.5.2026.04.19.19.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:05:16 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Fix null-ptr-deref in bio_integrity_map_user()
Date: Sun, 19 Apr 2026 22:03:28 -0400
Message-ID: <20260420020327.1667156-3-iam@sung-woo.kim>
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
V2: https://lore.kernel.org/linux-block/20260330230256.4160820-2-iam@sung-woo.kim/
V2->V3
- Added a reproducer
- V2 incorrectly assumed pin_user_pages_fast() returns pages.

 block/bio-integrity.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index e79eaf047794..c8cfd15fb589 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -402,6 +402,20 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 					extraction_flags, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
+	/* Handle partial pinning. This can happen when pin_user_pages_fast()
+	 * returns fewer pages than requested
+	 */
+	if (unlikely(ret != bytes)) {
+		int npinned = DIV_ROUND_UP(offset + ret, PAGE_SIZE);
+		int i;
+
+		for (i = 0; i < npinned; i++)
+			unpin_user_page(pages[i]);
+		if (pages != stack_pages)
+			kvfree(pages);
+		ret = -EFAULT;
+		goto free_bvec;
+	}
 
 	nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
 				   &is_p2p);
-- 
2.47.3

