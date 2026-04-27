Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F75271456
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303080; cv=none; b=D5O0V7bLK5/9/O4UcZVdH/H1RqB235vDvVt1KQlOlOl4RLJEmx530x6TZJoFrlbSKtfti0+Ik36f321+9IWNZWh6BsEkVH+Ayg+QILlzJjVTu8GVpwvsOquOehDRieF12ybFPnO2vvXiPTJVCuf2iOU+xznCuyhtTN9TTppCRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303080; c=relaxed/simple;
	bh=6D+TEWaN3mkEwQ668PO7zeWRVu4IryQ+5ZG6F3nZ/nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBUauYK+XJu6VREwrAP03fXLxPWDVmPGBM6bTn4BlDBNAWagvWXnxYMviZX1NVAtN31Jp9QEKSnlJA8felKOHgMciww0ycl16pn/y6JolEfgEVr+7Pm9uSt3ytZCTBjVA7z2TLcO76Hnie8zYllUZ4HtE+cxVCwJ+2MutxCuYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+2gf1V+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+2gf1V+"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296dabef74so8585719b3a.1
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777303078; x=1777907878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sCW99wKy9KpKJDh2ElxXQQd9/5nThGNSVsEJ7943P4=;
        b=l+2gf1V+gHkZnZGfxWmITiUk/XyGuC8kU176gmPda3Yf4YU/6eD1UTyXWZIHHVZkmJ
         S3aNtztkbuppqmJdc1R2YKPcjYVBjnb30vXWTUdsGIJuxjs4LoXl5T6spOl64X4/1Sjl
         tTYKLfeZCv4OhywcghpSfsRgQ3jnQfPofW9QGs8bPmxIbGITHplU7le1OmRcn/1dnKU/
         1H0YO5Ik5VjiSyH0Qvl+/gvcjYPjWi4pjeXr3cnU393UKwJP+f+3EXyOu5CdcT1EgDMX
         LwtErO/Jr3kLHhPiBbr4euDhbSV8idDr/bwUZMhUhZWybSTBto4s1wIp/tqz5BA7fV6b
         MXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777303078; x=1777907878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sCW99wKy9KpKJDh2ElxXQQd9/5nThGNSVsEJ7943P4=;
        b=N1qoKQCU+BtS75UxivjseAusmW2tyb1Ar2OQzgl7jSjRbWhU8dx+07MzDWNYaMsC0a
         omSzTiWAsOKXJL07vUcLpVlB7eGHMzMMEXGx9buQhfReoBZQoA3qWYWlhC+y60mSTYQP
         kOhcRPnKJ2gZ4iNh+N1M6CMZONR6B5zYWME3LgUUwN4jttlLKrjYuEjkGVk7BNJaksvO
         aB1hVreoAJlgHPF6UQrVeHfkp5jgphr1+iUQB0AO6Edkb8G+EerrkS85dqg2wECsj1hS
         MySokAArk6hakU3YlVrHyap+9Nu1YmenCMHRBu+OBJPvG6w8f+mY6JkJ33IrCYi5llhv
         +5Sw==
X-Gm-Message-State: AOJu0Yzn7pONc0J1Afpy/8ZQ9D5obefe4e7MyYnXWhBM8BopNX/cbwrK
	CuqR61NiKMBmUA5ev/ag+JgiD4FJka1ehYTLSmmqo1uzL8XWjhNCvig=
X-Gm-Gg: AeBDietM8kb5jWyG4+rPgfm9qW7yyIfKURxmMdRu9HAcRtgdAKglZ+LKca93pKZFKL1
	FYupYiE5AFVgqPq76ML+gtCfKtk1Knt6ZMjIS9tBHQoTl8Sv/CxHrjEKlPS5GWa4mHtB4umTBwZ
	Z6rDR2muULG7s6Kabc4ulBEaggSFpjORQ0CcMIDUJo+YE8DzO1McFZDZZrKPjsqtPpVbqVwzCos
	jWQX1I8BvSDK5QoOKFbl9hE7tQv+3mt3Q/K88NdR+4jgTMDu6o1SbGHqm4F9STgtKpNb7R3r8Hf
	Ngn6KDLH6MPL8BSZpARs9955hrFPX99H0ZP+mnn4v6BonV5lXlq/nXTwx9zaPh/TOzfndl3/IBL
	IGYSLfp4RMVBTI0oDFNS/PuH9Gux40s5p9tj7o9mdXyHyQBCgPz+iGg6AZTJIhnN7l2qLKyRikO
	9hxfgqc+b3tUTeVNBSDv0JwYU6nTZ2v7C+1PN3wgD159S8/0s0u/8KSYgqlm8KeFFqpTZ5gVX3x
	fRUqMkiGfh8
X-Received: by 2002:a05:6a00:e1a:b0:82f:2a78:6302 with SMTP id d2e1a72fcca58-82f8c9027b0mr48648306b3a.26.1777303078097;
        Mon, 27 Apr 2026 08:17:58 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([137.59.92.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb38ddsm31755576b3a.34.2026.04.27.08.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:17:57 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: axboe@kernel.dk,
	gregkh@linuxfoundation.org
Cc: linux-block@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v4] badblocks: fix infinite loop due to incorrect rounding and overflow
Date: Mon, 27 Apr 2026 20:47:42 +0530
Message-ID: <20260427151742.756237-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The roundup() and rounddown() macros return the rounded value but
do not modify the input in place. In _badblocks_set(), _badblocks_clear(),
and badblocks_check(), the return values were being discarded, causing
s and target/next to remain unrounded. This resulted in sectors
being calculated from unrounded values, which could lead to sectors
being way too large (or zero), causing infinite loops in the
re_insert/re_clear/re_check loops.

Additionally, add integer overflow checks (s > ULLONG_MAX - sectors)
before the s + sectors calculation in all three functions to prevent
overflow-related issues. Also add early return when sectors becomes
zero after rounding in badblocks_check().

Root cause: When s and sectors have specific values (e.g., from
syzkaller fuzzing via nvdimm ioctl), the unrounded values cause
sectors to be incorrectly calculated. In _badblocks_clear(), this
could result in needing 2^46 iterations to process 2^55 sectors,
triggering RCU stall warnings and effectively hanging the kernel.

Fix by properly capturing the return values from roundup() and
rounddown(), adding overflow checks before sector arithmetic, and
handling the zero-sectors case in badblocks_check().

Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
Changes in v4:
- Complete rewrite of the fix approach
- Previous v1-v3 incorrectly addressed len==0 as symptoms
- Root cause identified: roundup()/rounddown() return values discarded
- Fixed across all three functions (_badblocks_set, _badblocks_clear, badblocks_check)
- Added ULLONG_MAX overflow checks before sector arithmetic
- Added proper sectors==0 early return after rounding
 block/badblocks.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..a5ffae65a05 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -855,13 +855,21 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 
 	if (bb->shift) {
 		/* round the start down, and the end up */
+		if (s > ULLONG_MAX - sectors)
+			return false;
 		sector_t next = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(next, 1 << bb->shift);
-		sectors = next - s;
+		s = rounddown(s, 1 << bb->shift);
+		next = roundup(next, 1 << bb->shift);
+		if (next < s)
+			sectors = 0;
+		else
+			sectors = next - s;
 	}
 
+	if (sectors == 0)
+		return false;
+
 	write_seqlock_irqsave(&bb->lock, flags);
 
 	bad.ack = acknowledged;
@@ -1070,12 +1078,20 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * However it is better the think a block is bad when it
 		 * isn't than to think a block is not bad when it is.
 		 */
+		if (s > ULLONG_MAX - sectors)
+			return false;
 		target = s + sectors;
-		roundup(s, 1 << bb->shift);
-		rounddown(target, 1 << bb->shift);
-		sectors = target - s;
+		s = roundup(s, 1 << bb->shift);
+		target = rounddown(target, 1 << bb->shift);
+		if (target < s)
+			sectors = 0;
+		else
+			sectors = target - s;
 	}
 
+	if (sectors == 0)
+		return false;
+
 	write_seqlock_irq(&bb->lock);
 
 	bad.ack = true;
@@ -1305,11 +1321,20 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
+		if (s > ULLONG_MAX - sectors) {
+			return -EINVAL;
+		}
 		sector_t target = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(target, 1 << bb->shift);
-		sectors = target - s;
+		s = rounddown(s, 1 << bb->shift);
+		target = roundup(target, 1 << bb->shift);
+		if (target < s)
+			sectors = 0;
+		else
+			sectors = target - s;
+
+		if (sectors == 0)
+			return 0;
 	}
 
 retry:
-- 
2.43.0

