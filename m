Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2F337B99
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652161; cv=none; b=Ua1bA5R5Yx7SkG9lfsgYYxIJ2Uv0Wqpf891J9AVTETCRj6jtin63Cl4HOjHT6gMdl/spOOwWna+gjuV6GteBJG0kjOVett7YItOhFV085NmrT1L9lVsq7C96wAI5s4WwBSKgDjLiCj3RLLh3eAmgq7E8i1ucS8qM1cpp4/hKBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652161; c=relaxed/simple;
	bh=aMqCQlU/51nTh4McNUnDQbM+oOF6RGhLFFsMPHidHeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmsstEmBF7lu3dQwRAi11hIE0kP1eynjTs93NKh8Pdemo1YL5q/jY0P4zr5FFTMOPEol2zXbMhzK4xsvDiIZnXlKEqK4dWXcR5VuHPxQ6wXtUJ4pcQ/Q9la9aO4aJ5qJRHzbhVx5KmFrD283fhbTEUFXWHni5jh7Nrs41woAUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEDymNyx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEDymNyx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so10314039a91.2
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784652158; x=1785256958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QyRI5K/D2UL8ohnuHgzhdDNvsAlVZY47bGS7E8xJ6wM=;
        b=jEDymNyxm/iIQVS2mjk+PcCdnaD9yA/k18Mp+HdwGBuvdf4GvJuA37vUuyOsObXw8L
         X7M+ZOIr1gIw+OkES4TnWPKRf3VTstG/kwnnNhZ/9THSWmmjJy74z1gCk6qo+FGl3Kg0
         eumt83orAttqJS+6+kjLfU7XQJAhP7yCjx89zzb8giyYvuzNQ7J0DuQX+ZRu9/RRP00G
         m3KssMN9J+UfxMb9yEJGsfqJtXakB2EYsyUsspfSe/7EsShZNX3uKAxJLXyXiRGq7akb
         exf35fI/L5G6m+sLi1fiOmnEB3B2sjJlkzE73nZuxxaOFX8dq1tSX0GCUNIkNgvUp82g
         MlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652158; x=1785256958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QyRI5K/D2UL8ohnuHgzhdDNvsAlVZY47bGS7E8xJ6wM=;
        b=A1TKDn1dNyIOZvwC1Rk923Vt0LS/JBGt2c6PySkPr0iY8hK3kxZt9u6tDMeSyqhDEZ
         5zZVYQqbfn9V5kbsd5DfqKRpTTHc3eAKs9YeQ+G/wpOSgTidy4RnMZmRWH7jDX5moWPB
         inJTJ82WSKb2XS2ULX0JeMsb9P6p/gdyYuulPWzI2HqTzgnO3ldHk0yqE9PoTo4RfgGv
         AgXexuLdKcUIJ2kBJcMLvDgnQyKJAghJbS26i9/7EOJ9rqwLYl6ftV/bURhsCtPobHqU
         tH0YhiEUppQv5TbXhglWp6szGd1gixJoWvsa1zmJE5AxNTaklKgIauipcVSIhtUdr55g
         zl+w==
X-Forwarded-Encrypted: i=1; AHgh+RpIDC6LtTdv7Qwef8A4KOnzmV48DQayUFCbTp0jmP7RRqWrP1NIdP+6WIPTdJScY0dAn951WOubrEOxHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4oAlg8GnQwaErAShCPgnjS+vTsQI8JuqoxIdYLKRbgDaff6Z
	53mdP/hPVS92rlSL6EovcpL1uJm0TvzuE7X1QvopE2X3jVJxMZWvIpI=
X-Gm-Gg: AfdE7cnw+w2r5QdAStU1VyELsxJ4LD0dD6NCoNtRHreIHnnvOdWRQnc0bRWntGyp+nK
	PCN3SHgH6gNXIReYnv6gxfp3h+UB5+vyVXk+8Gw6QteS+9L6S2mjUCKlEGHZkFAXd9evqMcD/mW
	YbBTnDxlOXZoz97E3ECtRhkC6vbdsbX1A0L99Axq9dyp4aolkE4Qnh3lXuGimL6vhA0ZsWHohoN
	9OzAPRmrnQyRl87ao3HpvIO+7cDXMAAjuxvnZCsJhrHvM+k1AyhBgioqaN3zhLPE5aEUdkOJHA4
	aJKhLyWHIGWCxHbXMyLfnQeg5ZZM6E6iyM5fZPC488m9O7WXBtbi6tffb603eDbJjNo71YsjneU
	x/TLHS6cndqxUFeoN7lU6nHDFJLWfR1Xp2F7gQASzau2HkF4d567VlFw910jg52g/WqbduSJj4p
	SmN6PnlJKmNoEa05/NJv/wMwZy82sr5oiPE5ptLqpzKifnKN0dpNeNtQ==
X-Received: by 2002:a05:6a21:4a81:b0:3c3:8298:da0c with SMTP id adf61e73a8af0-3c3ad972c12mr22065654637.41.1784652158424;
        Tue, 21 Jul 2026 09:42:38 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c7ff4sm447487eec.27.2026.07.21.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:42:38 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v7 1/2] badblocks: fix in-place round_up/round_down usage bug
Date: Tue, 21 Jul 2026 22:10:23 +0530
Message-ID: <20260721164027.637078-2-adhikari.resume@gmail.com>
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

rounddown() and roundup() do not modify their first argument in
place; they return the rounded value. _badblocks_set(),
_badblocks_clear() and badblocks_check() were calling them as
bare statements and discarding the result, so 's' (and 'next'/
'target') were never actually rounded. Depending on the caller's
alignment this can leave 'sectors' unchanged or, in the reported
case, produce a range whose end never advances, causing
_badblocks_check()/badblocks_check() to loop with a non-advancing
cursor and stall the CPU (RCU stall) when called through the
nvdimm ioctl path via nvdimm_clear_badblocks_region().

rounddown()/roundup() also do division/modulo on the sector_t
(u64) operand, which requires libgcc helpers (__aeabi_uldivmod,
__umoddi3) that are not linked into the kernel on 32-bit builds,
breaking the build on arm/i386 (reported by kernel test robot).

Switch to round_down()/round_up() (include/linux/math.h), which
are mask-based, assign their result back to the variable being
rounded, and require no 64-bit division, fixing both the
non-rounding bug and the 32-bit build breakage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604301231.IpPh4AiH-lkp@intel.com/
Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
Reviewed-by: Coly Li <colyli@fygo.io>
---
 block/badblocks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..1f786b193fb 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -857,8 +857,8 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(next, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		next = round_up(next, 1 << bb->shift);
 		sectors = next - s;
 	}
 
@@ -1071,8 +1071,8 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * isn't than to think a block is not bad when it is.
 		 */
 		target = s + sectors;
-		roundup(s, 1 << bb->shift);
-		rounddown(target, 1 << bb->shift);
+		s = round_up(s, 1 << bb->shift);
+		target = round_down(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
@@ -1307,8 +1307,8 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(target, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		target = round_up(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
-- 
2.43.0

