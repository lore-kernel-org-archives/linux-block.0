Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D9301472
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999731; cv=none; b=HNFPwCDD/bNpw8oKKSe3ZjkiNcEKTfbY6xp7u8/uxVyli0mRDMbS0I3VlDxREqZH41A3tjRVg4zsqNWnmwCKc1lsa/7HxS5H6seTrvBhD4jQZCEkjFu3bu8P0GQfk75fDzQbGoi1xSYqE9xUCgc5Jow6UbuxiM/szhYhFrAE3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999731; c=relaxed/simple;
	bh=8r3Njt8panVzaDyqKXn/pvgpQoA+kH4AbvtZB3YhhYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSkGYB526fWTpQOwwVZ4p2dTgU5LWWAx1MU3AcogqvASIOzRsHE0mveKgFO3e3TUTvJinDB9wi/ium/TV+3V0S9794V8vn3ip4+bGwemzn4Ft7WY7Oj3bzXRTSx8dxYMd8hlD3SuO4ApDlYoTmonecXtVIoOUDdqniFARyln7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haWb59rv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haWb59rv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3697f25d26eso7110888a91.1
        for <linux-block@vger.kernel.org>; Thu, 28 May 2026 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779999729; x=1780604529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvVT0II3dEilSbYrBZE5Ytb4041NB7ZsFn14SAB4u14=;
        b=haWb59rvJjBrnh/KE1CyLwsmwK7M4ximKxm1/arnsKrv709NK+S8XTL0r9sPVIR2bK
         yUGa0ngl5dy4TUeNIWL+PF5vugF+NYq12ehSZoOdS/VWMgutbyylUzvh5DNnbu+GCRwH
         sRLGdgpNodocXvDF/QJLhulhA0c+G+rx1/L26xTdJV74W2j3fOF1vhkDWo/39uUjNqhn
         QczCmBxty9LJ1Bm8XE0n2y/ANxcl/AgoSWj8jY7uefdTIAsudkvLNm8pDUY95Vwti5Yk
         i1ZMbm8VJFopXstkl5XGnJVZ5c3yycJpr/ddYj49lzXIMIx1xA3jTWxxawi9C69CwuLL
         J5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999729; x=1780604529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvVT0II3dEilSbYrBZE5Ytb4041NB7ZsFn14SAB4u14=;
        b=muc35X7/E9AEz42IwCzVPsN53i0S87b3wNSGnR+kTwIB1fW6l/l6VI1TFPj6wRpMPo
         zQTEamynCUdj2FXP1RFTgky7U9FbpWlFkX/cUR9KBpyxfU+1RA3QUeCPA4dAwzdEPwe0
         SP9O80eIc1oNyMsjL/EKhczoVqKQiPZSWxnKtl1bj/xgsIDYHJz1cL4uF629khVn3WLI
         /AJ8a9JrPZC/uDBa87xmt5e9ETsV7EGI5vrVwGFauguU7GYGcp6LpLw/UNhO93P4+9FF
         3HRNPlynb50WKg1Q5eK5IQ4M0IA8SIEMj4ToIeaxa8k4mm/LiIQwgwvUseq4wiihQRs+
         UoZA==
X-Gm-Message-State: AOJu0Yw/aBjYBWo+n3OgVyxxKAHoPlSPkgYWbPcm6JE3er8kKs5FXOzE
	hmfc0gp2HKPReE0BHduaEGzI68ddcYG+rcmL+4fGufN3pMKOEmP+QWSNp5C5JO0j
X-Gm-Gg: Acq92OH571iNowffv6DRlQwID2ZzCOM0U8iSteSZReEfCr0owpIs2p0e1Q6Ro0KT6fM
	C2AN36OrckEGKhL7qVSSlR0o2r2oP12D8ZHdlGFF+QezNiQZbj8fj8MH8HBfCAy8/IPdwGvMToJ
	+QIMJ8NS1k0e/ahOBDhG+xT4c9huQf4lPC0OD0mAJusMa7oOadUZkhT99spVJkn8sGX/ol4z7/J
	FFUxmMk80LElRtVrBtO416i5rHS0EFx96VN/bYGsqkIRuyYRD5di39y6uqez/MgRCBAGyk966hJ
	8lG+4RM53lUb4QoGKSAvgCxDfq1Vho25fL9T3PhIcwTxZtB3LSo4bArMGG4NFuulQ99g3m8l5Vr
	3a1zzqBzNFpA2KPSuKbFTK7f3NA5gZL9hCW1XfzyKrcYwERGOQxLWJeO8w2YFd09XDhoJ4GE0s0
	1giCOHfpNNz9ns6Rcp+rSSogtfoWgjyWhFKefVmQTtI4jaSVRygoTqBcdcL2NbSoW810eJC9W50
	At+PEwKg+/x2X1/5B3LJRXbEMYHoxLzUgGuUit4hdSRig==
X-Received: by 2002:a17:90a:dfcf:b0:35d:a3b4:2f0d with SMTP id 98e67ed59e1d1-36bbcc146f3mr122373a91.6.1779999729076;
        Thu, 28 May 2026 13:22:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908da770sm2334406a91.2.2026.05.28.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:22:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	ceph-devel@vger.kernel.org (open list:RADOS BLOCK DEVICE (RBD)),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] rbd: cast snap_count to size_t to avoid tautological comparison warning
Date: Thu, 28 May 2026 13:21:51 -0700
Message-ID: <20260528202151.136274-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snap_count is u32 but the comparison is against a SIZE_MAX-derived value
(~2^61 on 64-bit), which clang flags as always false with
-Wtautological-constant-out-of-range-compare. Cast to size_t so the
comparison is done in the correct width.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 94709466ad19..b4ba51db9a28 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6079,7 +6079,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
 	 * make sure the computed size of the snapshot context we
 	 * allocate is representable in a size_t.
 	 */
-	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
+	if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
 				 / sizeof (u64)) {
 		ret = -EINVAL;
 		goto out;
-- 
2.54.0

