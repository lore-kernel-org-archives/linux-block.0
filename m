Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BF374A19
	for <linux-block@vger.kernel.org>; Sat,  4 Jul 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185367; cv=none; b=HmnsOLJ/aQikoOQBWHVp3o3RrQuPB7zI1uHcYlipCVgvnC2JQGarhxfa8YT32yHsqJUx8yWRj9uqhaO3+JP6e6z79fOQdD52f6EoPVvudWrCtC3e8aviNbnjNLWOAG4zisCJLEaIaBOISJ8+0IsgwoV8WrFgHSMUTMvcnnDStQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185367; c=relaxed/simple;
	bh=uqVUKZYuiHplE+yHfo3stb05fU/h7uOfwnAK4XVUajs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgVROriHMgdxZWnGux26Q8NCBH41LCaI3zqHWPOGL33ZVKr6zBodhQFU7zfIY01n4X5oOr8Brhr2YLT4Z+LyWudUekixKqIzmeXCJBNxO58izjHCX2GfWAn7lNMMYIzya/6h6wewjT3agKYHSFVD06cXwlSkCiciMRBMCPvCJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skvxSK6/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skvxSK6/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384c94c9414so99033a91.3
        for <linux-block@vger.kernel.org>; Sat, 04 Jul 2026 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783185366; x=1783790166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUJOl1IrLR4QLZ3yl+xmXHxn/gPQpgl66zAYngIU4h0=;
        b=skvxSK6/NkQIrKb18xPP6FH8W0R4bjQT0D3bvEt15ljRoykYzlqE0SNizk8y4TeeOQ
         9EObk5w4wTY3yR1IgPOmHpOeULlEAOJ9GSuywMSl9zfszSI9E+9jFphVs2dIbp/Wi2em
         gyHriiD/i8DteusGpvfTxuZ4NTQDnl/0GdblGrfIr61yg+mySQbCYz1FelcSBNCWkDuT
         96g6q7iOZfF4bDQbOFx7XLz3B+xIs39MK5ae/bSpEROaFEUECLMKYqtNRlhO0l210hPl
         u0L/R2BNRebrOyhf4UbCWLdoi0niTrNPKBRsYrh+fo4b+NfPG8x+ayyYOZsH4gW3ATCX
         AnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783185366; x=1783790166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EUJOl1IrLR4QLZ3yl+xmXHxn/gPQpgl66zAYngIU4h0=;
        b=N6GFbOJqJRdj2Rf84cs75O5Hd8AiS+U7HGRv/3tQEFkYI4wmPMGR4xDIzi7+ksaBle
         +3lEpYuhS1avbZg890ar0fssM2iwfGSe3CXCF6wfRjTmgfe2IIw5P3hlUTt/5HgIUYmc
         HCPZDsBSuVJ6NvB51NxFOfhuV2WZJYT3+2B4NLD0E3talOAH4NNx6fvxzc4QFCfy7lhD
         alZKuHdr/noSEqwjumpG7cEQo4f8z1PoxI4n9nfLPPBUbxKpP2euPnGI7Gz6+PBiQG7f
         A1Lmz1M0fq/VQdEcHECoHDehJAw3LgP36ckJH/QvcIKkCxtYyiJkRx08YyaSns2eFf3/
         +mbg==
X-Gm-Message-State: AOJu0Yxaz8R+AkE6BGd6ASJ2FN/0vuv6WKZ1xTZhroULjoaMYZiFXE8I
	AwjePs4CkDJdPnVpqwf4yADN2j1QYWI58wjpOu2j9lRA157KacZ1hxeX2y8aCdGdDA==
X-Gm-Gg: AfdE7cncRR8YXTMAyFmFxiyD51lWbiAcTeeM5fKQdtMR85JDb9i9L8Zsrs7CDLYDfyA
	n6aa+Wk+nZbQx8ZhTFHYGECW33G3m6SgaOErkxJMvQteFLDNqFLbdd8BOJLhypmbimrpHuxPhZS
	+QXyE6C6yDmxuUOC/8rT1NJZzm+s1US5wY27KzNZGLnZdTICwNSmPhpSQa/+tb2zynLXWmZchPs
	SuDsEQPEJerZCKQm11uvU4elYubqPtF8scrwljqrnRmT1llUvfizjcbaa3PGqkCHoiUAazmV8Ye
	iwPgH8acDrDPTaq+xSb2X4cMRxbDTmNcqx3vI2pH3CtkQCFQlxJaGVctHShRSzMUQTIMxk+7AnB
	hk4ov+X/B/B/EO1F0l8ubQbBa10B5Zy/OS+iDQD6+dIjVJLcvXHm2EjQ9YxNZf8pGqb4Z0fGlvq
	ENrqfHK+ygDyXerj+qAeAjSSn5SXT1IF4J59wJ0O3Vdl/8SQD5T47p4irmemT8KhA=
X-Received: by 2002:a17:90b:1f8a:b0:37d:7bb4:bffb with SMTP id 98e67ed59e1d1-382803b4445mr3995151a91.2.1783185365485;
        Sat, 04 Jul 2026 10:16:05 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([137.59.92.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb7fe46sm39418200eec.14.2026.07.04.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 10:16:05 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: axboe@kernel.dk,
	gregkh@linuxfoundation.org
Cc: linux-block@vger.kernel.org,
	lkp@intel.com,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v5] badblocks: fix infinite loop due to incorrect rounding and overflow
Date: Sat,  4 Jul 2026 22:43:21 +0530
Message-ID: <20260704171321.1956937-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427151048.756072-1-adhikari.resume@gmail.com>
References: <20260427151048.756072-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The roundup() and rounddown() macros return the rounded value but
do not modify their input in place. In _badblocks_set(),
_badblocks_clear(), and badblocks_check(), the return values were
being discarded, so s and target/next remained unrounded. Sectors
were then calculated from these unrounded values, which could make
sectors way too large (or zero), causing infinite loops in the
re_insert/re_clear/re_check loops.

This was confirmed with local syzkaller fuzzing against the nvdimm
ioctl path (ND_IOCTL_CLEAR_ERROR -> nvdimm_clear_badblocks_region()
-> badblocks_clear()), which reliably produces RCU stalls with the
looping task caught mid-loop:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu: rcu_preempt kthread starved for 21001 jiffies! g40229 f0x0 RCU_GP_WAIT_FQS(5)
  ...
  Call Trace:
   badblocks_clear+0x259/0xb10
   nvdimm_clear_badblocks_region+0x165/0x1e0 [libnvdimm]
   device_for_each_child+0x11e/0x1a0
   nd_ioctl+0x1413/0x1750 [libnvdimm]
   __x64_sys_ioctl+0x18e/0x210
   do_syscall_64+0x102/0x5a0

Fix this by properly capturing the return values of round_up()/
round_down() (the power-of-two variants, since 1 << bb->shift is
always a power of two -- roundup()/rounddown() use a division/
modulo internally, which is undesirable here). Also add overflow
checks (s > ULLONG_MAX - sectors) before the s + sectors addition
in all three functions, and handle the case where sectors becomes
zero after rounding.

The overflow check is done unconditionally, before the bb->shift
rounding block, rather than inside it. bb->shift == 0 is not just
an initial state -- __badblocks_init() sets it to 0 by default, and
drivers/md/md.c explicitly sets rdev->badblocks.shift back to 0 in
several paths -- so s + sectors needs the same overflow guard
whether or not rounding happens.

Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
v1-v3 chased individual len==0 symptoms in _badblocks_clear()/
_badblocks_check() one call site at a time. Jens pointed out that
approach wasn't finding the actual bug, just papering over spots as
they were noticed. v4 was a full rewrite around the real root cause
(roundup()/rounddown() discarding their return values), covering all
three functions with proper overflow handling.

Changes in v5:
 - Switch from roundup()/rounddown() (which use division/modulo on
   sector_t, a u64) to round_up()/round_down() (bitmask-based, since
   1 << bb->shift is always a power of two). Fixes the v4 build
   failure kernel test robot reported on 32-bit (undefined reference
   to __aeabi_uldivmod on ARM, __umoddi3 on i386).
 - Move the s > ULLONG_MAX - sectors overflow check so it runs
   unconditionally in all three functions, instead of only inside
   the `if (bb->shift)` block. bb->shift == 0 is a real, common
   state (default init value, and explicitly set by drivers/md/md.c
   in several paths), so the overflow guard needs to apply there
   too, not just when rounding is active.
 - Build-tested locally (x86_64) and confirmed no residual div/mod
   symbols in the object file.

Link to v4: https://lore.kernel.org/r/20260427151048.756072-1-adhikari.resume@gmail.com

 block/badblocks.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..e8484912532 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -853,15 +853,21 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* Invalid sectors number */
 		return false;
 
+	if (s > ULLONG_MAX - sectors)
+		return false;
+
 	if (bb->shift) {
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(next, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		next = round_up(next, 1 << bb->shift);
 		sectors = next - s;
 	}
 
+	if (sectors == 0)
+		return false;
+
 	write_seqlock_irqsave(&bb->lock, flags);
 
 	bad.ack = acknowledged;
@@ -1061,6 +1067,9 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		/* Invalid sectors number */
 		return false;
 
+	if (s > ULLONG_MAX - sectors)
+		return false;
+
 	if (bb->shift) {
 		sector_t target;
 
@@ -1071,11 +1080,17 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * isn't than to think a block is not bad when it is.
 		 */
 		target = s + sectors;
-		roundup(s, 1 << bb->shift);
-		rounddown(target, 1 << bb->shift);
-		sectors = target - s;
+		s = round_up(s, 1 << bb->shift);
+		target = round_down(target, 1 << bb->shift);
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
@@ -1303,13 +1318,22 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 
 	WARN_ON(bb->shift < 0 || sectors == 0);
 
+	if (s > ULLONG_MAX - sectors)
+		return -EINVAL;
+
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(target, 1 << bb->shift);
-		sectors = target - s;
+		s = round_down(s, 1 << bb->shift);
+		target = round_up(target, 1 << bb->shift);
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

