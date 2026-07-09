Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE1628000F
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603157; cv=none; b=tPAaUPCbEF+arFxgcPH3ftg6tBNzfdQooQ5VN8OnggirIcsbJnaU5lVzydbvlxMSxqoF+1b6sKya5snRBqVTxE7tstH4IGxTSV5tSzy7e+ahY9QU+bpxDhW2PadAoJaftuLv8aFRfXvOR4DW/ZUT2Vb1NJCBVBfUMDMGSt3CyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603157; c=relaxed/simple;
	bh=T2u541qQ+z0RnOgRw7bMFV+eieAFDFj+xTZQdyN6NUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvH0kPej4bd0WBm2im5X2trg2/mpqEkJ49chpY/4vJ6k4gXTG1KQfs86GEH9L2dWOV8JQytjreBzjQvVGau1uCBtSJg5xmYAsknWHHL638XvjP+/fDqYXHX4j73nU4/s47+yvCiYaZWGGr3qqKLhmvzB70Gnx7BebR2USY0UemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6/Mznt+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6/Mznt+"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so606842a12.2
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2026 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783603155; x=1784207955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7teN60MU+Gp3txyOBv3fyoxyVU/6erlMzYso9Y2plQ=;
        b=l6/Mznt+FGL/bWtEUKO3r2NizjJJevQ9Gq1H+lIT6FNmQnaeu2CWVEkqlBjNwuvtRR
         WLR177Hmquwc/TxwcEPyetBSK0LW6CECzJns0Esh6bKEKmjXYOFjAzG8IQ9PDASO/vrE
         TScS64zKMi7ulSP3SKjQ2AddN1vkvFvQzJwbSZwPsvN4HaBVl4KxubwaVeiBCSd+hgKM
         SFYKssapZldO4tXcsvNaUl6UTb/phZwv147+ZtfvGGsPtgYttBR46uB/yBleqs48gwl2
         haPdH2SdVbly/aFPdvHW7Boojp2itGJwpFb+dZb5QaPsy4jLqOUnb6RU8OKzrXN3YQ/B
         k4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783603155; x=1784207955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m7teN60MU+Gp3txyOBv3fyoxyVU/6erlMzYso9Y2plQ=;
        b=Mz2HSvy8pgG950P8VbUhQZQiarDg77e7c6xtg4G/jGQNSBCYP26YGRi2YamVv+ZITl
         0dxmOVZ3nlXl44wM+h01rZ0QY+5x4Df741ei7C7cJ+GIYT0da5W/Uw44GYK5+1Wk/Car
         yphuWcJFfsH/Y3tKrXnAM7GsIVCvCrYrXa+PhAeLX1R5O4h2DLFFrMkQgrdwdMUxeRaL
         Wx4pQPQEEFT5pWzfgxUOMIBBlDVxcAQ36OwLrIDHiB/YwwsjHUhQwSdir5H+RRXGU2hX
         md+BEG0Sd1PG/KnWugu1lFaE22jCopTltE+5d8UQ+tt2YtHykqupInSy8CKmEc5V1/s0
         fwZg==
X-Forwarded-Encrypted: i=1; AHgh+Ro43VTrPiRZdHePW/PI0kxsV7UtwC5XpAm1kGO1pknpn7yhAJ846KN2uyGYDa7gTLsAXuTgLEY/quAXiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xB2GFYEq0Ky36RfBfm9mf3s6ObtcriTOcRKRumoKwzrehK/9
	5ufi3m9tUfuK5B2qy3X2PTa9JcdSKuIbcdDa7B5Lzsy/bmpniKqxZJU=
X-Gm-Gg: AfdE7cn3RclEDydpzIFdj8Vvr6WqospTZzyQO1IzCrYMJu+liT5SDxHe2iwnINu3t29
	/3eX152tj5TpzR12saLcjBcsxyvZcLLVgE3OtUEuQ3k8TrG1M2okqTBvSJchZv0PnWemVwwbCwO
	RMFMvumWLAoLdGUOOlw65/R54VIHad/llSfhB6QohPPx+D9GJthzlaaEo5Bbsxz55EdMRHnM0Xx
	mXc/QHwXdGCnzPoN6+BkFLDaa3iUsNmTpi73T7Lup514oMFdVMfhFDXsRu8Kg58sfbzjpEZx+ll
	sKhIiUmq7QJ9dLVhWBe16sT7iiDEWo333gAAjdYgTK6um1hfdBYv8INkytCFPoCsz5Xj17QTh88
	OAThtVP64VnUzcC8rG+xc9KpNN6AaNIorgzKTIwRogqlaa+wASugrYKURh+wTb7vx/i5nZuiG18
	bPJTicdF4LyzLMWyGa4fDiOa1gSS7Gqe+RZ2XBAoEXWShHjIkNZwP4roXw34PllUYO
X-Received: by 2002:a05:6a21:3a85:b0:3c0:9c18:d5ae with SMTP id adf61e73a8af0-3c0bd23f657mr8729454637.75.1783603155192;
        Thu, 09 Jul 2026 06:19:15 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([58.146.106.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm33960852eec.31.2026.07.09.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:19:14 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io,
	axboe@kernel.dk
Cc: gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v6 2/2] badblocks: validate sector range and shift before rounding
Date: Thu,  9 Jul 2026 18:49:04 +0530
Message-ID: <20260709131904.596684-3-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709131904.596684-1-adhikari.resume@gmail.com>
References: <ak9CC591ivuQ4BP1@studio.local>
 <20260709131904.596684-1-adhikari.resume@gmail.com>
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

Add an explicit s+sectors overflow check, reject any bb->shift
that is too large to shift a sector_t by, cast the shift operand
to sector_t so the shift itself is never performed on a 32-bit
int, and detect post-rounding wrap by comparing the rounded
result back against the pre-rounding value.

Suggested-by: Coly Li <colyli@fygo.io>
Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 block/badblocks.c | 52 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 1f786b193fb..00a59729600 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -853,12 +853,23 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* Invalid sectors number */
 		return false;
 
+	if (s > ULLONG_MAX - sectors)
+		/* Range wraps past the end of sector_t */
+		return false;
+
 	if (bb->shift) {
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		s = round_down(s, 1 << bb->shift);
-		next = round_up(next, 1 << bb->shift);
+		if (bb->shift >= BITS_PER_LONG_LONG)
+			/* Corrupt/unsanitised shift value */
+			return false;
+
+		s = round_down(s, (sector_t)1 << bb->shift);
+		next = round_up(next, (sector_t)1 << bb->shift);
+		if (next <= s)
+			/* Rounding wrapped past the end of sector_t */
+			return false;
 		sectors = next - s;
 	}
 
@@ -1061,7 +1072,12 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		/* Invalid sectors number */
 		return false;
 
+	if (s > ULLONG_MAX - sectors)
+		/* Range wraps past the end of sector_t */
+		return false;
+
 	if (bb->shift) {
+		sector_t orig_s = s;
 		sector_t target;
 
 		/* When clearing we round the start up and the end down.
@@ -1070,10 +1086,21 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * However it is better the think a block is bad when it
 		 * isn't than to think a block is not bad when it is.
 		 */
+		if (bb->shift >= BITS_PER_LONG_LONG)
+			/* Corrupt/unsanitised shift value */
+			return false;
+
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
@@ -1303,12 +1330,23 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 
 	WARN_ON(bb->shift < 0 || sectors == 0);
 
+	if (s > ULLONG_MAX - sectors)
+		/* Range wraps past the end of sector_t */
+		return -EINVAL;
+
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		s = round_down(s, 1 << bb->shift);
-		target = round_up(target, 1 << bb->shift);
+		if (bb->shift >= BITS_PER_LONG_LONG)
+			/* Corrupt/unsanitised shift value */
+			return -EINVAL;
+
+		s = round_down(s, (sector_t)1 << bb->shift);
+		target = round_up(target, (sector_t)1 << bb->shift);
+		if (target <= s)
+			/* Rounding wrapped past the end of sector_t */
+			return 0;
 		sectors = target - s;
 	}
 
-- 
2.43.0

