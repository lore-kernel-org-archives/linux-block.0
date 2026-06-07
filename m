Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0704A59
	for <linux-block@vger.kernel.org>; Sun,  7 Jun 2026 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780846301; cv=none; b=EwXd5r85mSWOblEAr9HAANxwb91ULNDOopqhRHwv+YUqvZuNHyk3SF6uGhJcEF3dTStHP/5nXxnaxfa01s3xQtZi/C3GIDEO+RaKYt9jc0Y6j3VA44wEjPzU3QmRYCoFI1hPC+mMHqc+PZtAKlA1SNafxCMcP/DsyGzN68N07Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780846301; c=relaxed/simple;
	bh=TlmLmmEdIltRo2BIo1mCH5GJSl9bJynMtQ9IYx5fN3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BExn+E6RKsMHrtwrUtNpbN+KNWdgiQrjV188X3ME4zDN0cQAz4RzQjdVJhl/WVe7KFiCX5eiNiHeza3XZsBmcA/mfSrOlIm6E1mL1ytPv4IyxAJB10pHyOr4/ZJAkFnaWR6xJ6IZsx8JFVPUFG6fBLdyWqu0+Li9hjYpAVxvZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdmN1Igz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdmN1Igz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf20f6be6bso26163015ad.3
        for <linux-block@vger.kernel.org>; Sun, 07 Jun 2026 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780846299; x=1781451099; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHJyYDhMXVt1yaIWJJ/Iiee7A4hciuqO204G7KWYjDU=;
        b=HdmN1IgzWIdsLejww3ph3Ce119vLkafn99az4b79Os/qydTuHTMW9wLtAdGK1ipMzK
         j+mkGIBERrgdqvgXDZ/zESW6lDexmt9dh8w6LP+l7uOZ8MqZIkqwOa8NY0R55vgSrk06
         fpNqTQQp0UB4S8ddUSKx+yLpk4Yb561/eI4QrLIW5WikqYzGC4qgyTKuG29feOFHUXeG
         Kf01npc4303Dm6zr5e/EmaQ2ik+Cv2pgE8wme68ffzPzu+44LqVg4XCAY8qm/3SmZhPr
         hkPqKOURAi299j9JHtInm+lWPzahZaXMoLOG3yYfdT+Sc31d2dF7xl3e+wcnzqwyix4y
         6Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780846299; x=1781451099;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHJyYDhMXVt1yaIWJJ/Iiee7A4hciuqO204G7KWYjDU=;
        b=CuutK/LutbtACYqfDodFRfMNjaos6exvAUyhhbaGyZfp/fgCYerY9FMHXoLciW1gPl
         vGSF1ArRNSQctOBpRhHJ5iu58Cvad+nPo159CnTeOyLXY3uBLFsV4j4bgcNFET8A+L45
         82riqC8lyDOfQOzri3JxvSSFBlollF8ENH03TFK4lxY0Ix3ZJ4RC3UJg1RCm2m9wzHMK
         jMTDGYzsp0Aj/hNX8v1usw9vRlmSAnrSneoidfv1Yg2UUpxdQlrCmZ0bZMuUrFayHmq0
         L8wakiGiGUM3AhZIbpvDCchGVGLdS2tvt7JD2a0eUBO56r6HsNXxRCs789adCorbEBLm
         yZ3A==
X-Forwarded-Encrypted: i=1; AFNElJ/gQxT8+KmNOCHF81ixwEBwfdF4GMuwrV9SHoi/HkdvSpb8NzFFh+fb39rLTqRPRKGejUmDSPpD4qB6Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywamzw5D1EDj1kyrECrc6vDOn3WMh04PA5LcdRLqbLBDh8ZZed0
	5eOWJTsIGO3+AWkBG1bRl80vQVXgazbfaG2XoDKtfLYSzkSXaK1qKW1/QlBh0paW
X-Gm-Gg: Acq92OH6+alw+5lAE8EQaF88f3Ad0CbEW4F1a/SpDTbUOw99psN2vrgFjuG6xTtJEcz
	L0RfiY48LiA5kB4HlNwrp80uNUhj9WhtLbxebmpSTYM/m79zfyJYGa9YKvWtPHbqz3lRJuruSK/
	SNVhlIqK4YIelBHUVurS1klGY8HxSqUxWYo3j18WTZ+ha0F9sQcSxao2IK8hlavsIhrLDqUxBop
	MV60HW4K8M7HM+GVsYrjVxY34c6ZKL1hpUeRhp8P9NHIybd/8cccjYtx4FBwy1yFlC9P6c6KEmb
	3SOg1KBYTmiDoECNGYgi+uqQPlbRYYBDQkFxwlNTbOAcC90hY+n6SJlObKSUQ13c7rDTMi/p3TA
	GTMgxyJ2e8dpR3Qhv4QeyOaeXaIXq/bhwyBm+pMoUfBnxSFccL077/ctH3orXGpGPg7JvaFdfVP
	W3eE6LOzHUtk6P3lMFcfZ4TN7hFDCzScN5Elg5Eg/iRVlJUN6Ymt2TZ9GYQ1ESjsq4IpSo+1n5J
	SqYDVExtg==
X-Received: by 2002:a17:903:1aed:b0:2c2:245a:3364 with SMTP id d9443c01a7336-2c2245a35e2mr69107515ad.32.1780846299036;
        Sun, 07 Jun 2026 08:31:39 -0700 (PDT)
Received: from NV-J4GCB44.localdomain ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2d7sm156530735ad.39.2026.06.07.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 08:31:38 -0700 (PDT)
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Sun, 07 Jun 2026 23:31:31 +0800
Subject: [PATCH v2] zram: fix partial I/O gating on non-4K PAGE_SIZE
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-zram-fix-partial-io-config-check-on-akpm-v2-1-6f492c9f1233@gmail.com>
X-B4-Tracking: v=1; b=H4sIANKOJWoC/52NQQ6CMBBFr0K6dgytguDKexgWQ5nCBNqSlhCVc
 HcrR3D5fvLf20SkwBTFPdtEoJUje5dAnTKhB3Q9AXeJhcpVmRcXCZ+AFgy/YMawME7AHrR3hnv
 QA+kRvAMcZwu6VG19U1dZmkok3Rwo3Y7Us0k8cFx8eB/lVf7WPyKrBAnU5lXR1ZVBwkdvkaez9
 lY0+75/Ae9OqjvgAAAA
To: minchan@kernel.org
Cc: Jianyue Wu <wujianyue000@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1780846295; l=3920;
 i=wujianyue000@gmail.com; s=id_ed25519; h=from:subject:message-id;
 bh=TlmLmmEdIltRo2BIo1mCH5GJSl9bJynMtQ9IYx5fN3g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgW51Zh3v9nG0Wlld2Ti8ylp1TnO7yB
 H+z9CbXty/WEAQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJK4sNvE8lx25E4nOkCigFYmrSQA34s3oenL0g56plVBsbYBA6PTmiowfCWh2UAWp8u4iJGPdVf
 FYBuoNwg+lgI=
X-Developer-Key: i=wujianyue000@gmail.com; a=openssh;
 fpr=SHA256:gVWBPJbHGWlCIw+V8F63Ff0k21S7AB5+rZt8+huemvg

IS_ENABLED() mainly for CONFIG_* symbols. ZRAM_PARTIAL_IO is a macro
defined as 1 on non-4K builds, so IS_ENABLED(ZRAM_PARTIAL_IO) becomes
IS_ENABLED(1) and evaluates false.

Replace that check with PAGE_SIZE == 4096 and fold is_partial_io() into
one helper so partial-I/O policy stays consistent. PAGE_SIZE is a
build-time constant, so the PAGE_SIZE == 4096 checks fold away on the
configurations where partial I/O is supported.

Tested-on: Raspberry Pi 5 (BCM2712, 4 KiB and 16 KiB page kernels)

Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
---
To: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org

zram: fix partial I/O gating on non-4K PAGE_SIZE

On PAGE_SIZE > 4K, zram writeback can use sub-page bvec I/O. The
synchronous read_from_bdev() path is used for that case.

v1 used IS_ENABLED(ZRAM_PARTIAL_IO) where ZRAM_PARTIAL_IO is a local
macro defined as 1, so the check expands to IS_ENABLED(1) and is always
false. The WARN_ON_ONCE(!IS_ENABLED(...)) guard then rejects the sync
path with -EIO.

Replace that check with PAGE_SIZE == 4096 and fold is_partial_io() into
one helper so partial-I/O policy stays consistent. PAGE_SIZE is a
build-time constant, so the PAGE_SIZE == 4096 checks fold away on the
configurations where partial I/O is supported.

Testing (Raspberry Pi 5, BCM2712, rpi-6.12.y):

16 KiB kernel (6.12.92-v8-16k+):
- full-page I/O: PASS
- sub-page I/O: PASS
- writeback-backed read: PASS (bd_reads=100)
- no zram WARNING in dmesg

4 KiB kernel (6.12.92-v8-4k+):
- full-page I/O: PASS
- sub-page I/O: PASS (regression; partial path not used by design)
- writeback-backed read: PASS (bd_reads=161)
- no WARN_ON_ONCE(PAGE_SIZE == 4096) in dmesg

Writeback tests use a loop block device as backing_dev. On 4 KiB
builds partial-path success is not required by design because
is_partial_io() is always false when PAGE_SIZE == 4096.
---
Changes in v2:
- Use PAGE_SIZE == 4096 for the read_from_bdev() guard.
- Fold is_partial_io() into one helper.
- Expand commit message with root cause, impact, and build-time note.
- Add Raspberry Pi 5 validation on 4 KiB and 16 KiB kernels.
- Link to v1: https://lore.kernel.org/r/20260531-zram-fix-partial-io-config-check-on-akpm-v1-1-eb085d98faea@gmail.com

Jianyue Wu (1):
  zram: fix partial I/O gating on non-4K PAGE_SIZE
---
 drivers/block/zram/zram_drv.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6e1330ce4bc1..ddea09afd8dd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -216,18 +216,12 @@ static bool zram_can_store_page(struct zram *zram)
 	return !zram->limit_pages || alloced_pages <= zram->limit_pages;
 }
 
-#if PAGE_SIZE != 4096
 static inline bool is_partial_io(struct bio_vec *bvec)
 {
+	if (PAGE_SIZE == 4096)
+		return false;
 	return bvec->bv_len != PAGE_SIZE;
 }
-#define ZRAM_PARTIAL_IO		1
-#else
-static inline bool is_partial_io(struct bio_vec *bvec)
-{
-	return false;
-}
-#endif
 
 #if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
 struct zram_pp_slot {
@@ -1510,7 +1504,8 @@ static int read_from_bdev(struct zram *zram, struct page *page, u32 index,
 {
 	atomic64_inc(&zram->stats.bd_reads);
 	if (!parent) {
-		if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
+		/* Sub-page I/O only exists on non-4K PAGE_SIZE builds. */
+		if (WARN_ON_ONCE(PAGE_SIZE == 4096))
 			return -EIO;
 		return read_from_bdev_sync(zram, page, index, blk_idx);
 	}

---
base-commit: 404fb4f38e8f38469dfff4df0205c9d18eeb1f57
change-id: 20260531-zram-fix-partial-io-config-check-on-akpm-c62b972416f8

Best regards,
-- 
Jianyue Wu <wujianyue000@gmail.com>

