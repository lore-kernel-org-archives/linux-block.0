Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1F33374F
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652203; cv=none; b=P4VVLwhkzT4B/bBzdfy4YdPbfAgXrBHwXOjoBCX42J58buFZoGZGJDIG9ACjLiUdNXWPCfTUElic6nnayYzq2HlBvWT0Jd9wA+Sv17KZlvwOX14fEM/Hnwx8fBrXM6p44dXoxok+DH4pPwyHvqE9zfJfrP5xVbsxuTkZKvZUxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652203; c=relaxed/simple;
	bh=19IcGc/7CN6FJaWvzPDso+RUb7gKc7Q9cSuKvJGU2UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmVeb/UvzCzyIPtlVYQSXPotz/6/dw4Yh5Kc3Idc9m8D4m2/UQEJiVfoOPo7Y83xv8x8EC6hmw76Kecy/lnTv+Sb6uwhzTsx5udQyhtseQZP0Xm5hty0oXhRSzuJXAQFD4QcIGzYyeOi8/+eR8GzUk1Fy5pLc4QFQkKg6hTVr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdqpjufC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdqpjufC"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso8248794a12.3
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784652201; x=1785257001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0YEU1On5Z9QygyW7afm3G5c7ueZM2Z9hLMwsovoUjpM=;
        b=VdqpjufCCkyvdUI7RFBpMfumeM7N33uOLXZShg36bm5xGavnt2Ida3uYY4D8wpTsN9
         mT9TwG+8Gm6CLDsVvrZCJfBUIPgVYn46+9U7xURwfVEPfVj/97GUZD7A7IOOu0LZkzRN
         Q/R43aZ+2xvOye/0CAIheBJFhOR3kQL/21ttSsPvly4vCkX3URbFf5v37X0NPM8yrjAk
         jSA4oUGh1EH1B7GSo9k9koL5Zwa5IxRqb7KhNnLGHXXAsiOnLdlaM4XiI2RrjxVQSZHx
         klvSL4ewMbfHUb/nJes+S7z56qqdZOYkiZxPttoabNq1D+qsC9jSCVhPCivAvWMX9MQ7
         6Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652201; x=1785257001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0YEU1On5Z9QygyW7afm3G5c7ueZM2Z9hLMwsovoUjpM=;
        b=VWZcJfcCmvqSMgF+ao6Ptn2XGJFhX+onzUor7owM80Le8sn0+S4tscWtD4eriYX+E2
         ZP6otg6hRR5ePv20n7fP+nnh9L/WJ5EaSrSppQghJL7K7rycgZeyCk6SsYh4WvLk60Nv
         Zf1A6V/es+I7Zo6tfUdIj1oxmNP7d/P+iH71SEo/q+XXYeYIPn1lKKJ68mkb+96mVkeK
         D2wa6gRmDXXRidlplHQ1vSuH9MhiW/jNkzBVK/hnLlOU0QCIj5j6Lsv+8Ks6+og1NdYJ
         BOVF/WxdTybHUC4G98AwUWrZfs3vitJ5j4AwgsCEcEYJHoqrlJgBdVQUmke+DeBFtLcs
         hWSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoMFKPdeg3xwBNk1asf5SpBQjz4XOAAVIT/4ssALmk9r5/blICnOe/GvHljBuptVMjReykS74YVCiY/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb38YyiN/LxhcUPGHaB6/uq/OFBqrbBjycIk9G8Eg5J5Z6bjhO
	cejyGHORwXcDeN9iTbHjGWlyDu2R8D1E2+D3YmsbjA4ykyw0snnMEH0=
X-Gm-Gg: AfdE7cmGXI3qwBoEj2uMGMALAT0BXoLMb6IsGppuwpZgLpO/sgLHskvy2M6tg+7QU9E
	axm/7xeSxg0cCTIBZWC57+qCVT7TxWH3S7JKSVT9H3MPAT+iH6Y2dLckJEPm5oNaXpxKEtXkE4N
	Clas2YLK/7EVyUnahT89H8CFiJU5Vn193280+mzskc47CwUbxV+5jOshWAiSBwqAodcymimPtg4
	ZILvzLziSX10rw+mypYshhADtG2ccKNvNXR0BVNPIhPzXZ8Xj3ZiGhCm4COVpabobQEw5nvSkOw
	Ykyt8yIJ3OFMG15nZZFkqZGsCk1OBhu1RbZmhLgSkdQSkBxStL/i5yRiESKUjZs5jFNVoVh0ymQ
	7IFYUUokFSSO4A7H6yb1zRrwhAdiPZRHOFHZQ/sLbgt4zvhTF1vlEjnUeS1JQUQFXC55be2KXRN
	MpeFh2wkyKXVhHG8sZ9WUYquM2FiqB/gKOcCX9ZUzon9PeVlhUCgLI8w==
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:fb94 with SMTP id adf61e73a8af0-3c3ada37416mr20565979637.54.1784652201182;
        Tue, 21 Jul 2026 09:43:21 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c7ff4sm447487eec.27.2026.07.21.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:43:20 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v7 2/2] badblocks: validate sector range and shift before rounding
Date: Tue, 21 Jul 2026 22:10:24 +0530
Message-ID: <20260721164027.637078-3-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721164027.637078-1-adhikari.resume@gmail.com>
References: <20260709131904.596684-3-adhikari.resume@gmail.com>
 <20260721164027.637078-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_badblocks_set(), _badblocks_clear() and badblocks_check() round
the caller-supplied [s, s+sectors) range to the current bb->shift
block size before touching the bad block table. That rounding
was not defensive against a few cases:

- s + sectors can overflow sector_t (u64), wrapping the range
  end before it is ever compared against s.

- bb->shift is a plain 'int' field, populated in one case
  (drivers/md/md.c, from the on-disk superblock's bblog_shift)
  straight from an unvalidated byte with no upper bound. Shifting
  by an amount >= the width of the shifted type is undefined
  behaviour in C; "1 << bb->shift" was shifting an int literal,
  so this was already undefined for bb->shift >= 32, let alone
  the full 0-255 range bblog_shift allows.

- round_up()/round_down() rounding a value near ULLONG_MAX can
  itself wrap back to a small value, so even with a valid shift
  the rounded end of the range could end up smaller than the
  rounded start, silently turning a small range into a huge one
  (in _badblocks_clear()/badblocks_check(), which round the end
  up) or losing the range entirely.

Add an explicit s+sectors overflow check and cast the shift
operand to sector_t so the shift itself is never performed on a
32-bit int, and detect post-rounding wrap by comparing the
rounded result back against the pre-rounding value.

badblocks.c does not itself bound bb->shift: every caller except
drivers/md/md.c always leaves it at 0, so the one caller that
populates it from untrusted on-disk data is responsible for
bounding it before assigning it, per struct badblocks's shift
field documentation in include/linux/badblocks.h. That md.c-side
bound is being sent as a separate patch.

badblocks_check() returns 0 rather than -EINVAL on the wrap case,
matching its existing "0: no known bad blocks in the range"
return convention instead of introducing a new error path callers
don't expect.

Suggested-by: Coly Li <colyli@fygo.io>
Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
Changes in v7 (per Coly Li's review of v6):
 - Simplify the overflow check in all three call sites from
   "s > ULLONG_MAX - sectors" to "(s + sectors) < s".
 - Drop the "bb->shift >= BITS_PER_LONG_LONG" guards in badblocks.c.
   Only drivers/md/md.c ever sets a nonzero bb->shift, so the bound
   belongs where bblog_shift is read off the on-disk superblock, not
   scattered through the badblocks API. Documented the caller
   requirement on struct badblocks.shift in badblocks.h instead; the
   md.c-side bound follows as a separate patch.
 - badblocks_check() now returns 0 instead of -EINVAL on the wrap
   case, consistent with its existing return convention.

 block/badblocks.c         | 40 ++++++++++++++++++++++++++++++++-------
 include/linux/badblocks.h |  6 +++++-
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 1f786b193fb..728b59a1a5d 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -853,12 +853,19 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* Invalid sectors number */
 		return false;
 
+	if ((s + sectors) < s)
+		/* Range wraps past the end of sector_t */
+		return false;
+
 	if (bb->shift) {
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		s = round_down(s, 1 << bb->shift);
-		next = round_up(next, 1 << bb->shift);
+		s = round_down(s, (sector_t)1 << bb->shift);
+		next = round_up(next, (sector_t)1 << bb->shift);
+		if (next <= s)
+			/* Rounding wrapped past the end of sector_t */
+			return false;
 		sectors = next - s;
 	}
 
@@ -1061,7 +1068,12 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		/* Invalid sectors number */
 		return false;
 
+	if ((s + sectors) < s)
+		/* Range wraps past the end of sector_t */
+		return false;
+
 	if (bb->shift) {
+		sector_t orig_s = s;
 		sector_t target;
 
 		/* When clearing we round the start up and the end down.
@@ -1071,9 +1083,16 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * isn't than to think a block is not bad when it is.
 		 */
 		target = s + sectors;
-		s = round_up(s, 1 << bb->shift);
-		target = round_down(target, 1 << bb->shift);
-		sectors = target - s;
+		s = round_up(s, (sector_t)1 << bb->shift);
+		target = round_down(target, (sector_t)1 << bb->shift);
+		if (s < orig_s || target < s)
+			/* Rounding wrapped, or range collapsed */
+			sectors = 0;
+		else
+			sectors = target - s;
+
+		if (sectors == 0)
+			return false;
 	}
 
 	write_seqlock_irq(&bb->lock);
@@ -1303,12 +1322,19 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 
 	WARN_ON(bb->shift < 0 || sectors == 0);
 
+	if ((s + sectors) < s)
+		/* Range wraps past the end of sector_t */
+		return 0;
+
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		s = round_down(s, 1 << bb->shift);
-		target = round_up(target, 1 << bb->shift);
+		s = round_down(s, (sector_t)1 << bb->shift);
+		target = round_up(target, (sector_t)1 << bb->shift);
+		if (target <= s)
+			/* Rounding wrapped past the end of sector_t */
+			return 0;
 		sectors = target - s;
 	}
 
diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
index 996493917f3..5d88992b55a 100644
--- a/include/linux/badblocks.h
+++ b/include/linux/badblocks.h
@@ -34,7 +34,11 @@ struct badblocks {
 				 */
 	int shift;		/* shift from sectors to block size
 				 * a -ve shift means badblocks are
-				 * disabled.*/
+				 * disabled. Callers that set this from
+				 * untrusted/on-disk data are responsible
+				 * for bounding it so 1 << shift does not
+				 * overflow a sector_t.
+				 */
 	u64 *page;		/* badblock list */
 	int changed;
 	seqlock_t lock;
-- 
2.43.0

