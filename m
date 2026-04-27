Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20C3264D7
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302674; cv=none; b=KBCj8618c33orYMfTo8KT/xtSkmhY3ZS/i48qZrP7dZQPU/6RQ2eJR/6Tyu6F6Lhx1nQ5v+qWQMXTiqiGNh/7Sdb2LIjoyM3Kma0f/H8KP21tLGviyuI7pqKxZbvSJk5eaZOaIJytI2hdmEzOEMsd1oWCPK0Af2wzjL6388P90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302674; c=relaxed/simple;
	bh=cPDsC3UGhKsyQGx2Z3m3qHx8H0VbDsik3AwsqeSOrRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyNGxPFoJtEJbgAahCQqtj9LweqmfH34cxQxFol0EQPBgkby8qfyNsRW1TsvYCNDcDiSm421O1EyTq8uva/E4mLocryX3asnmVwuNb5gDrlZCT2NqTJVQIflIN3PZId/JsjQ1oX6jhtpYZ7yJEyX2uQ9neRsaciogdN+IuA/osU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2qiaCaJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2qiaCaJ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f69a286dbso7779440b3a.2
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777302673; x=1777907473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwdcHhWkIWf7saFPJuPYSpIlBoYbYnebxGTwKShIhmk=;
        b=K2qiaCaJafRdDmdHJhw72zIi+OqCCvTpGAjxU9m28EFNOvo93JBp1Lv064LCKFbN+z
         4o0P6pn2rpBijW8TuuA6XXMmV/wGaJZZaIao1/g/2q0mlWupRSv7f+f4AO2bVvpcKWJI
         f2Xn5TY3stfOJAzs5nm7s+o3SCGDrgTN/SxWaiK8IxEGrbWjZI3JqmQyoqPpEyWWURLj
         yGlcKOGKNVe7M86G7uOyuhOJ7Q0B6VCrmeJkxcq0MhhTU1V7WsyR4l9JX/TtOWfxEXqb
         KvvUG6sepmX1OqLni27AcqZ190SKjacss91y8UngeGVSTpb50qpjHrAptCUuB38MEVKK
         Xu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302673; x=1777907473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwdcHhWkIWf7saFPJuPYSpIlBoYbYnebxGTwKShIhmk=;
        b=M1BNQnaV9NbzEp4CApuxUTrLBBZDhZZ/L2I0eSCZYYpoXvLLffE6tEsPfC4CA6pXRZ
         UKV5oWHQ/Fi7yl/hnq8mfZ9aAuzONw5DmAPnNTOwpsFCqstCACr80I+wkqVX5rs4kemP
         LUyDWxM+4LaIDpX6SeUYVOucE2GP9FXV7q+EL7bhWQa91E8QZSktJdOn6hQDDCAqg7HT
         4XwPV2m7WxChYjpPx7YP8uuSVp32VDiNPOIEjJZY9ySXl8v77qSBZ5AAYi8vbM5FFgdG
         mq0LjOZDEZ8sidd1mbNGhj5fMcs+6pmW6fwjl3TIWwhplhnbEtFCPDOEPnsbcEvuyl+Q
         O+VQ==
X-Gm-Message-State: AOJu0YzAokPNfCYdNCG4wp2Mo+tCR5il3BtZ2zqGE4+grK1tRfTcREkW
	aGm4n+wD6uEYQ+7sKSbu9hjPhsLKrVz0mzwJIyCNIELZkY9aSschrw8=
X-Gm-Gg: AeBDieu6JQrKBeWq6vhaxz6jAL/Pq7bAEZiykP2wn5klg8/Ows90K/zSspokxEw3R0G
	4akH541p1XOh0Vbm6oddCnABqFdxQGxkZIbBHinYzrvsfFy7eDR4UVo5ZlV4LtIy45l+N8KZ9v0
	8Nci+8nZ7WWXR23/R5qIaR0uJ5RXR/Vm2q/Wix/Yds/WfrxJkSC8x3Q0Q5crYXUbaESZJ7vZ1Y2
	lmNH9/Zit1LEJPvOvQDe4HBsXkOMpGX7tCe7ATJ3xD3yl/g59/youMUq5UEchPNshDWPnDr/3v0
	iK8crLuQYN6jxvJgOB+YQfgdGHXznL8t2xL55p2wvf4ztIgWsiZoHxNdCiur2cxdIJIFS7u/J1j
	whsArA19jWnZNtTxPSTnAeldcJmdmPZL380i60sfqbCYXUwdIhCC68GxnHNWgSCjPitLWAuJq97
	vTis3tXXcDlw77pGAvA7cPo5lEsrgyXVtWEl/DsCAbESL/Vf5ZDqPMjofYayrZJG1HkYkeESJyq
	3QkuR4y09gybQ==
X-Received: by 2002:a05:6a00:9507:b0:82f:4628:4198 with SMTP id d2e1a72fcca58-82f8c8c79dcmr48231184b3a.31.1777302672412;
        Mon, 27 Apr 2026 08:11:12 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea0a97esm39102752b3a.27.2026.04.27.08.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:11:11 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: axboe@kernel.dk,
	gregkh@linuxfoundation.org
Cc: linux-block@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH] badblocks: fix infinite loop due to incorrect rounding and overflow
Date: Mon, 27 Apr 2026 20:40:48 +0530
Message-ID: <20260427151048.756072-1-adhikari.resume@gmail.com>
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

