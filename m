Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA234388A
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487233; cv=none; b=gLazaIRYv0gHuHUWKjS/qszCoTrZUpiIxnBE1kBqQB1+g/aAufvT/QFjeucqNN2OK/8zdw2Rc1k3rDzPGNOYQs24T49cKhwSnIRxHnSAvVOlD74PY0FK5G2QjpWWtr3dEeLeZsDbOXkwR8qejyQlQiK1uQYv+swpDCeKZTAB19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487233; c=relaxed/simple;
	bh=1x9ywyVrh7uZCSRgauiK8pD0FtPRQ68pgvijqVPekKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNkPc3BHMM3G5OpMQmi/z8mwJqRW9YCxpR7TdjrEXeqzEvn0gRSLJNBFl/XLsQySBge85wOc51Ro8RIwiy4j6zaoIgjBkSRJKvXvjDMkNC2nIQ2Hexpd8KBFH3/qZKJ6N1kelNdk5uJmEKLaSZisepAAZnUO+MesjoKJj0F5m9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHAZH3zR; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHAZH3zR"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-636970cf66cso5997309137.1
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779487230; x=1780092030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ftv7qUW3GQKarcWelUk5mazFgUp2QWWE6TkRhUcbZA=;
        b=MHAZH3zRcDjTpCkyf2EmUqDzMliKJldKnMxbn5lyrc6SB3SAa9AM77p7fJSuRhQwho
         3QTYmXsBIHp+oitDwK9cd2VyxTXkE+KnFQBM2AoATME+355BxLtQ89ApNYz7xSKk2BZN
         LeGJxW0qmoMRTqs5fN6SjDcQIB2c14kqvotuVrL1Zkw88rw1yz0D4O3P6MJqs3YkkzFR
         36IumhWRul+hclgHfqzdlJY/5CdMldxK8iGZrD59lVNSxLNNbSIlTLdqE8uE05D9jHe5
         ev/XMsxlm4Gi1R0IlxXPo+pNYfvWWLt6aZGCRmBs5MgMF5HvDUAn4Y3sLsz1yhO5ALGa
         pLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487230; x=1780092030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ftv7qUW3GQKarcWelUk5mazFgUp2QWWE6TkRhUcbZA=;
        b=CwpHw3FFMYFS4DG0HKFKUu2d0THHpoLUfvaFUKSxsJaosdWsAsvzq4Ubr7JUAeqDYe
         tMydCZRCKLt9BvMZWbN8BjAqPLZGj2ZzMRHxac1HyLBI0FjRI/At0ZGYH9fAULmdgHN5
         0tumn4xDzD+J2nVUuX6+kC+2/n71mvioxrukarYrQ93beLelqftcFvvMLerJ2lE/lQyF
         2uAwdVS+fmr9d4GUx7JLmNb++urUIb/FqJ5zIdiQzZZIG+CdrQpgYsDGDcXw7VJHvMz7
         2lLqglr3ovp10Sr+XMGnt2GKsFEAOD2iYukuzGVVuB33FVaPLTuuIXxyreDpLKcMK08X
         c1iA==
X-Forwarded-Encrypted: i=1; AFNElJ+gkTg7muBlDmtCn2KXTtixgpbingC6mu03YDGIrfifvIYSr/uOINka6hdisPerEwBM7UGDCDs2s17Tfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvATknMMc6o5RKWBpTUoWCwfWib6B2TEBnzgAWwuVlOqvmO/9C
	C1H3AdUYm2QTwk3JMn6HxYDj8wOFdL0sTdUdB+WppFqviNCv2zC+ZC1l
X-Gm-Gg: Acq92OEBWyKUT574HxC2MXSgk2PVR6POFlMAmI5OGDbhePlVgELmkM6TOOJTB9moGQG
	vyvsJNZ6UYSv50rftjD3ein+/3qmrrnkK3MPHd5DKcbvoZJU4A0LgiD35bRaBv4ZfybXRTNks3O
	wRjQHSSSjmGuGBmTgaFxZuneSTZGL/8OOLtormgMN9C4mhYidmZUSrK1j2xjBa635i+X2y2hu8c
	qWxqTbd1kHOuW7hAJX9KynaRQLKSouq5DJSc+XLeVIE58fXCCorWBQ6Jv+55hwWs77Qzk/mNoO3
	V5MuQ3EuXpDNTRm6t0srH88QpF7Axt9nm6cIrJfW3K3dZuHKdslbBSxKpR15V+wFZSa90TpUNjG
	iAqRC09U+IDAhl3GvsYoRbZXyoPDegbN38Dl/CkzGFLROPNXL8i100WIxdT0ukcSxicX9/5S6CY
	PPx5hqOx+o1DqNFrLpg0DYgpzYhNls5HzkYvOaw/OUSpEvDIkGl8qa
X-Received: by 2002:a05:6102:304d:b0:631:ba82:e80 with SMTP id ada2fe7eead31-67c8e2bf3a1mr2339524137.11.1779487230323;
        Fri, 22 May 2026 15:00:30 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-67fd8851f5bsm2957284137.3.2026.05.22.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:00:29 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH] block: skip sync_blockdev() on surprise removal in bdev_mark_dead()
Date: Fri, 22 May 2026 18:00:25 -0400
Message-ID: <20260522220025.1770388-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bdev_mark_dead()'s @surprise == true means the device is already gone.
The filesystem callback fs_bdev_mark_dead() honours this and skips
sync_filesystem(), but the bare block device path (no ->mark_dead op)
lost its !surprise guard when the holder ->mark_dead callback was wired
up (see Fixes), and now calls sync_blockdev() unconditionally, which can
hang forever waiting on writeback that can no longer complete.

syzkaller hit this via nvme_reset_work()'s "I/O queues lost" path:
nvme_mark_namespaces_dead() -> blk_mark_disk_dead() ->
bdev_mark_dead(bdev, true) -> sync_blockdev() blocks in
folio_wait_writeback(), wedging the reset worker and every task waiting
on it.

Skip the sync on surprise removal, matching fs_bdev_mark_dead();
invalidate_bdev() still runs. Orderly removal (surprise == false) is
unchanged.

Fixes: d8530de5a6e8 ("block: call into the file system for bdev_mark_dead")
Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).
Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 block/bdev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index b8fbb9576110..7fc3f5ba22a3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1259,7 +1259,13 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
 		bdev->bd_holder_ops->mark_dead(bdev, surprise);
 	else {
 		mutex_unlock(&bdev->bd_holder_lock);
-		sync_blockdev(bdev);
+		/*
+		 * On surprise removal the device is already gone; syncing is
+		 * futile and can hang forever waiting on I/O that will never
+		 * complete.  Match fs_bdev_mark_dead(), which also skips it.
+		 */
+		if (!surprise)
+			sync_blockdev(bdev);
 	}
 
 	invalidate_bdev(bdev);
-- 
2.43.0

