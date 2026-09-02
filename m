Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7134A9D44
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364952; cv=none; b=sCyMuNTHmUrnfJ083KavXjkbqf6fZpiOiUttQPAfy54Q8K0ZtEwXsyQn+oY0tx7g1yrA3u0+dpR/UjaG7ZYnF6X5uks3U6Y4jt8QvzC8hw0iSL03meGGFPypVx7ZvYDTDJ1BK+NaHPGRW6CNWUqRZGwVOoy++fLOANikd6N1TJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364952; c=relaxed/simple;
	bh=ZInTpzKZERTZ4FkUKOwOz/nBdUIVfWm6aAmNrLuXKtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm6dd5yWehwopGzGNAtpr9gsHgBUDYqk8YNil/5bE6kYqlerO6HHfS++iZ5TBDLuqNGrztCGLB4StajnjxkWlBoFVrI6YHGHIjy1KQ3ghl4UvlspBgV9RV+0X6NayxACsW3LfR/6b+GyZF1NWDMMjXglGlOuv111Ja/1IVIzg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYUo/IoK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYUo/IoK"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so1025715a12.2
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364950; x=1788969750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TRYcBCPX4lvzNtncJflh64mK7PkuQNxZzNIGvARw6uI=;
        b=PYUo/IoKjzhrw45DwAczlk14mZ0b5AaPkPpWiWR2TfefOHFBkupq6t1GPr8JSZBGWP
         Q9Vni8qC4op/GyxcJfJgjF30ZR0fI9cqAh3JgPGKYs3pSDtskf7Ls2kSElkMtnoIiS+P
         Ee8ehTwNGspMGxbmEnhV714S+nhoqTnEWkClMZjOHPo0J/GejTiEN3JTOv/W5GvWcVSs
         nCr+2ntZQ6Ynw9rGAdDwrqkqd9U6/FrCBOVw0fCyJqb1hPDS2CSBdV1oqp36zZJFW4Sr
         lzc/0YEwJe2f6SJe09F5zL7TXbzd8mXcZaRWZTrLLLDNwL3aeNabv8ubFYhXifxRnAKi
         tw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364950; x=1788969750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TRYcBCPX4lvzNtncJflh64mK7PkuQNxZzNIGvARw6uI=;
        b=StzraKC2ulaxSA5yCjrFgxRYps0o7MjrCfaMtLsFyhdpIozEEw1BDKvVjpBTCqpRtt
         2/NQ63m8wn2sIV4V3v5YNt4VGUj+2pA4YjJxf3yhRRiwRcumuqrN/5Or/HVS5kbgHde9
         9rITy0zUEMM2f7Lv3oBoSdftd7PNk4WlbUutxV4WGw2/k7c7ScJCOScsPI5mvlcXUBgE
         E9vThveGXLoteUhAS+vFbonkhlFq//iHVjoO/ltocmlt5YllF/oTBZTaipKsDv3bhekt
         oGsJPG9BqKfveAbNMMw8wrSwt3rAVjyeACfTfCD1CwUGGf0L1PN2JeM5sOchLmD8DkCT
         t7dA==
X-Forwarded-Encrypted: i=1; AKwUvByl/lnFof6rPDX6eIVQ6tsqcr3B6bgjOlRAESxUiE7IrHicp9FK6qb6MXKCsqHu2X8SsbkePZIUOTRl7w==@vger.kernel.org
X-Gm-Message-State: AFuF++nx5gjSQh609PlDFkBePNXy+70GC+nyM7HYYjQrOQHJYiWD7u/m
	pq1lKzp4c1FgTy7VsdklhPNVSK0HVNrk4nCFnyWu5xUn3pm3x6ko5Xg=
X-Gm-Gg: AYBFou0R7VktG5/9b5L1Z6Y9NcmJ/XOxhSQk+EVu5lpJWyA557GDTjTiI+0g+dpmmTi
	khYk9k1FSJ3VOJl35HHvWEENbg8+vDFxkBxjPQGmbR1cmK17GleSurfwoJitDdwZ9PKVc0mt4QS
	ovw6CsdsrMl+2YqeD2lm2M2e0UvCs2P46oXyOAbSu8m1ozPeYY1iYscrzXF2CsyQB95fUnRs8lJ
	OV956qNF/bP6jrsqwdW6hqr8JiFQHJdsAIS5c9W100vuTidLMgwmWSudwqLLyNNCaq5olzzlHuZ
	E83/TEpqcx/gTc9Sc31U/pnSCHTUUZZvFbG9K8wmFrsEV4RReu0gtYPSpNSigMDkrx3pm1RmQej
	S1npOSbAO4fX2GOrAcj8LKtVauzTuD+xtSeCIpW2aGd4nAhZMwA91f0pca/lRI/yG2lbO7DlzX5
	A8D/ss0OuvzcskyMCKauQQ2rVUBM6rMceYeIzRcqtdLOw+ZNfz8sFkL/zcVIiS3SCglLTE7IVOO
	7PdlRvl9AyHWhXgmhYDRgV3pIlw92lLS3QiF0TY
X-Received: by 2002:a17:90b:3b52:b0:396:d28e:bd8 with SMTP id 98e67ed59e1d1-39aedf61001mr8054165a91.3.1788364948425;
        Wed, 02 Sep 2026 09:02:28 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7bd00sm7327447eec.14.2026.09.02.09.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:02:28 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: axboe@kernel.dk
Cc: colyli@fygo.io,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v7 2/2] badblocks: validate sector range and shift before rounding
Date: Wed,  2 Sep 2026 21:32:06 +0530
Message-ID: <20260902160206.322319-3-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902160206.322319-1-adhikari.resume@gmail.com>
References: <20260902160206.322319-1-adhikari.resume@gmail.com>
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
Reviewed-by: Coly Li <colyli@fygo.io>
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
