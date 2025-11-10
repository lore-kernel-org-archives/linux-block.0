Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934862E8E14
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752485; cv=none; b=o0oDFyB/kLjPi3bX25GS1wyETNepqI4Af2O2dlZ/PstzkAyGiJ37fbCLVSz5AIqusi0/YjbaYVjIlpQ4RIuAhUjlU3sSocFTk8tOCObW2T0Th8Piz0RfPhrWvDHIM7DvcsyCTUck8eqbH6czqVLfW7th5LYxf8ya2Ei8Zs6GDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752485; c=relaxed/simple;
	bh=HZ7iFC8g2jWgg3RLDaD0ihKgqLcxowR4WiYlLsW8XIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZsA4DI+bTQBsmiMBPeN0fkcfnEH19XAXzh3h/RggFIlGZFIlh6p4YWxBunIp+EV0H7w5YbIxHVRT8KoMRko+hL0nK5sJHEIhKvqkXkOzm44XRANWTObeoTw8QnYEThw+f573BmOXJHHrPi+YtkAszxFHdV7+vPOADRMag4erNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dmAkk6KG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dmAkk6KG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29558061c68so31564875ad.0
        for <linux-block@vger.kernel.org>; Sun, 09 Nov 2025 21:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762752482; x=1763357282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tvapgbH3jkD+AdkhW294xxn0JZbD4KOae/vm4TVUuSk=;
        b=dmAkk6KGbW95Jhuw79sD/vPyaAYyFrz1tv7QdfDuFWPfKsCDhdCtwO41Er2iNjzWmY
         qhMZ30ZY6Egb2Qq+tjZ6UNo+a/1fc4peA+zCxpi6ESieedbhiUtV7Qs2hrf4D46AAJb5
         OtE+FlqvPb0FK7ysNzIxCFpzhKnL4ee7FNo+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762752482; x=1763357282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvapgbH3jkD+AdkhW294xxn0JZbD4KOae/vm4TVUuSk=;
        b=KeaKzg7jvzc3WJeQgOiEAZSXXtyAJRwmMt3jc5V9BWPAWN5Ff50pZypHER9VQdMYT9
         h2tGZV8nx2egfJOD4ukoCEB7bFc73e8Rqe320B0S7N7kjBHrfN0XkbEqjXM+j+udKbO4
         KO+FiLm25y0sWUcvn3dNLfxuLow9F/E7bYWRhqPo16iHtWzW9jKa8QT/k1WaEk9xtlqB
         92u+m1D95b/fNT1Wi/OKGkKtRwi83AsCKSQrjtGxX6a9VGTlAPdNQmB+VcoANHgJQWEp
         TPGhrAgtgMW030BRUdN50rz7Pn50BhYwVD55Jb/BLS6nSB4++b1Dc9180+KhAF1Z3iLg
         dGYA==
X-Forwarded-Encrypted: i=1; AJvYcCVFTiuLcGiXk1YPqEug3ZaBFg4FS9crK6QWAX4hoT3wubdva8RXCZCTqkQWSwgsr9byUrKEMb4gtAlO5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfg48bc605pEAa+tih96mp3SXkwb70+oFDZ6ecpxp2c5ZbMEMl
	SJtj4AJB9VGzeC6ATMSpaVdWp9owekrIjnsJGoYYCzge8fNEDYru3q/GY+iSsfe6Jw==
X-Gm-Gg: ASbGncsAwo75AcJvDp7tfeFZqZJnDXYF9AbgEk/DJxD2nFXx9s25dLt2MPAEgVhY/Q6
	zP3+t87GTbu6tmwpZqQ6PjxFCoPdMo/E2m0YRlcklKAwmyVdhv6YluAtaJbqPUqgqWTQrZsPbT4
	K5gUASCnMjUTXwG/R5xg8ODt9V2v/KIqN/gwADv4kK5AsWg/+aBxF1lFsWuutnefcvvTGnTEarH
	aDEDezRNP5TP1P9ZmS+ugcc4dKcRHRQlsvnYkob/50oQvztaJwMwYz21ma0H2FBIh69m1V2bJC3
	mv0nI8FBn21yg3LHWX8bPVOzn8mrcBmp54oBiiYWfCuh1SiQss/7oqIR0oYJQGVhhvOsYBSWHQN
	S46BlfE06dwmtsEimJfshi84JKeGNSaefdQPIMkXgu5Y3BW+/hgRzoEEtjmWkYZnORHA4sGdSSY
	0PT4MRLoGpnRiMF03Lh9nBMUlkYGcDYqJDxvt7GQ==
X-Google-Smtp-Source: AGHT+IHymLI6kE6r/xB7IR1Kudj8hm5wJJouSqUSb1t5jP8J2KHp1GbLAwBuqPctZvgTviQ0dYbp7w==
X-Received: by 2002:a17:903:2b06:b0:297:f5ad:6708 with SMTP id d9443c01a7336-297f5ad67dbmr66282975ad.43.1762752481882;
        Sun, 09 Nov 2025 21:28:01 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f189:dea3:4254:ff1e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c778a5sm131804095ad.73.2025.11.09.21.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:28:01 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Shin Kawamura <kawasin@google.com>,
	Brian Geffon <bgeffon@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] zram: do not hardcode 4K page size for writeback
Date: Mon, 10 Nov 2025 14:27:41 +0900
Message-ID: <20251110052741.92031-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writeback operates on physical pages and writes a whole
physical page to a backing device at a time.  We should
not use hard-coded 4K units, as on systems with PAGE_SIZE
larger than 4K this leads to incorrect writeback limit
handling and bd_stat accounting.

Reported-by: Shin Kawamura <kawasin@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 21 +++++++++------------
 drivers/block/zram/zram_drv.c               | 13 ++++++-------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 3e273c1bb749..afba174e3471 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -211,8 +211,8 @@ reset             	WO	trigger device reset
 mem_used_max      	WO	reset the `mem_used_max` counter (see later)
 mem_limit         	WO	specifies the maximum amount of memory ZRAM can
 				use to store the compressed data
-writeback_limit   	WO	specifies the maximum amount of write IO zram
-				can write out to backing device as 4KB unit
+writeback_limit   	WO	specifies the maximum number of physical pages
+				zram can write out to backing device
 writeback_limit_enable  RW	show and set writeback_limit feature
 comp_algorithm    	RW	show and change the compression algorithm
 algorithm_params	WO	setup compression algorithm parameters
@@ -286,12 +286,9 @@ The bd_stat file represents a device's backing device statistics. It consists of
 a single line of text and contains the following stats separated by whitespace:
 
  ============== =============================================================
- bd_count	size of data written in backing device.
-		Unit: 4K bytes
+ bd_count	the number of physical pages currently stored on backing device
  bd_reads	the number of reads from backing device
-		Unit: 4K bytes
  bd_writes	the number of writes to backing device
-		Unit: 4K bytes
  ============== =============================================================
 
 9) Deactivate
@@ -409,17 +406,17 @@ assigned via /sys/block/zramX/writeback_limit is meaningless.)
 If admin wants to limit writeback as per-day 400M, they could do it
 like below::
 
-	$ MB_SHIFT=20
-	$ 4K_SHIFT=12
-	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
-		/sys/block/zram0/writeback_limit.
+	$ PAGE_SIZE=$(getconf PAGESIZE)
+	$ echo $((419430400/PAGE_SIZE)) > /sys/block/zram0/writeback_limit
 	$ echo 1 > /sys/block/zram0/writeback_limit_enable
 
+Note that writeback operates with physical pages, so please make sure that
+the limit value is in PAGE_SIZE units.
+
 If admins want to allow further write again once the budget is exhausted,
 they could do it like below::
 
-	$ echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
-		/sys/block/zram0/writeback_limit
+	$ echo $((419430400/PAGE_SIZE)) > /sys/block/zram0/writeback_limit
 
 If an admin wants to see the remaining writeback budget since last set::
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..51074fed342c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -823,7 +823,7 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		atomic64_inc(&zram->stats.pages_stored);
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+			zram->bd_wb_limit -= 1;
 		spin_unlock(&zram->wb_limit_lock);
 next:
 		zram_slot_unlock(zram, index);
@@ -1529,9 +1529,8 @@ static ssize_t mm_stat_show(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
-#define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
-static ssize_t bd_stat_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t bd_stat_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t ret;
@@ -1539,9 +1538,9 @@ static ssize_t bd_stat_show(struct device *dev,
 	down_read(&zram->init_lock);
 	ret = sysfs_emit(buf,
 			"%8llu %8llu %8llu\n",
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
+			atomic64_read(&zram->stats.bd_count),
+			atomic64_read(&zram->stats.bd_reads),
+			atomic64_read(&zram->stats.bd_writes));
 	up_read(&zram->init_lock);
 
 	return ret;
-- 
2.51.2.1041.gc1ab5b90ca-goog

