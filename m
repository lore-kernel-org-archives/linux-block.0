Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0B284880
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786393367; cv=none; b=GCVyevgHmQEMwMWA0ckZirD1VL0yO7Y2Q+fJZ18anm4gU8AhsGwscOpgTo0jL0Xl08AI7/yJGzgivaS/ExKJY3t6fszdUHKD6SLUU0RuBZBTcRi24AEPvsdXcc0crxY0r89Ba54J1bDAn5V7EgEbQ1x7lVUN77gGhHwsZv45yKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786393367; c=relaxed/simple;
	bh=qcQX1+AZrS2kX+Wex7hD4Y+hpYPLqYtAqA2dUMnWHzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meKI0vvUOy1NXidA2MM2zVBzWEHQqa9ATHJWFi/8z0q+elxoExia8oiOSnKH3TtkPcygaTyzpgqexQvbVz/BtHAsuM8/2Y4o3m00UF5wZ1g8nKffhHNFvcI7aC3oIk/4BNxoOY3wjyJc0eTtctvroclXoZS1+dikCUViquYwTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0hEf8A3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0hEf8A3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b966dd74so13984175e9.3
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786393364; x=1786998164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t2ztazlPZ90mOodZaQ/lnbgOFKp+L+nRQrvHK2eGVwA=;
        b=i0hEf8A3G9BXWFTCIgObFgnIvfuZURtS814KYFkYnroSCwfTVf2VdJoVXHcZqaqTT1
         SGcmjDHgKTZzdy/7SiqyN9+jFB98OvLHMJhTw4XJX/SdN/xsENQ0FAOn/66pyN9GvMHU
         1WX/dQNByfHdKFNgI7b19J8Px2U21R1O3z6VcUttOBUx1SLmIXNhXcgbsIyM/fEJ/L1I
         dytia5EL8d2eBG8kYu1hsubDEmQ/ydK0qApyEc5dO6feFE4aTnq6/U2A+A2W6qfaUu4U
         oP+QSVxI+hlXZd8SOpMlt8hqj0AiWVcC8GoG1EfJdFE06melbJpzpEsDDg+CisYKI8l5
         j5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786393364; x=1786998164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2ztazlPZ90mOodZaQ/lnbgOFKp+L+nRQrvHK2eGVwA=;
        b=UOZUNwGEc/wv3kBRKUuE8Hn1U05xO/CbNlKMAqB6GdsWVLHmCo+VHr1eN6+mIssABE
         dccVRAd8lhKBLPFPSwn6WNI9BJn2H+tYizciWEOt7jqMFeTuoWSUPwJD511zDqeLtnCs
         MmMX6+E71KTpBNjWujr7NfMZqzVfjcs+GZcZwOXtRj8fUK693LpypomTMknaWMOeqWDI
         W2lqDlbkbXA/gE4Ougd0DnQqjvGU2+1E162KYk9D2OpejxTD4YnO/Od3Lx6htFOTDzCP
         1kTt2i5S+E6mHXd3tWgKxZjbndVcZhYfXvjIyNg6TcvI0nQWWJC6HQUrRwe1nCwzTXBa
         iR+w==
X-Forwarded-Encrypted: i=1; AHgh+RqTngFB81P35bqYCcd2vmgaYtbv6jpIxSYyaZ/d74c6j117km8F8Ag6Vu7ivUOrP8nz1+IzORRfmb7Y9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYAFWee/bUKG8gSPJRbW6gRGPpOrlkX4+fJRJowLSHgChU2C9L
	vRwUujBUqziFqCpCVhJDnN89tHD4+ymW+2WoewyeSJkdwDcjX9/JPY33
X-Gm-Gg: AR+sD11sYbwTDH/zzsol5WmuKSds0TOBNgd4CxRJmrg6ONmkcjBoFWbpa2Gpk8/ufeG
	iKS/MN/H0IYjyi8wjlMlPBuSloh8ct0lXxkPxfAo8zdpQER+jLqgVzfoLgK2iSOIVSo1YAeeHOH
	3EJPO4rNjp+zcJzzsbQdiI+vWyu97fbRWJygeMOtaFKkQphK9Fa5zSOguD5AZYfr2/hGYco6mWe
	MZpDBrt876sZHkfxwPfnhXbC5L8Zo6p4u3ITxE7Lq2OZahaWMrdXV869vYnOmDZEIpzFuHPpoXK
	TIeiirMzo2CWn9jEzAMN7zbZCPc3qWm/mDl8HK18foqx1xUbnM3yVighdgrfHSQvAuGce3ygBMM
	v+h5ngVj5f5+5p/0/FYedcnM1dWKV8d8faHK0oxJpfZLoVipDhKzSm2BAB33q+WjHClWMGzMLvw
	VIVuxhy2/FykvyD4r3tuT3LseQ3uxZvPnJxokMAlv0o9XTwTNX1PkNlFAlGM2OIatYGd5YWZWv3
	qGnXG68DHxX8uQNJss639geyCCqOs/fyuhNYoXCJj5T6MfoTbfgSqUbR+w=
X-Received: by 2002:a05:600c:8287:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-499727c5cf1mr67210645e9.18.1786393364310;
        Mon, 10 Aug 2026 13:22:44 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740d1553sm13623455e9.7.2026.08.10.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:22:43 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] zram: fix slot lock bit position on big-endian 64-bit
Date: Mon, 10 Aug 2026 21:22:37 +0100
Message-ID: <20260810202241.2436603-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The slot lock is a bit operation on the whole __lock word, which
flags and ac_time alias as two u32s. On little-endian the lock bit
lands in the position ZRAM_ENTRY_LOCK reserves in flags, so the
aliasing works out. On 64-bit big-endian it lands in ac_time
instead: with ZRAM_TRACK_ENTRY_ACTIME enabled, storing the access
time from mark_slot_accessed() or slot_free() wipes out the held
lock bit, letting another CPU take the same slot lock; an access
time value with that bit set makes the slot look locked forever.

Shift the lock bit into the flags half of the word on big-endian
64-bit.

Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/block/zram/zram_drv.c |  6 +++---
 drivers/block/zram/zram_drv.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d09fdca49cbd..a9b3bb1d3bef 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -74,7 +74,7 @@ static __must_check bool slot_trylock(struct zram *zram, unsigned long index)
 {
 	unsigned long *lock = &zram->table[index].__lock;
 
-	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK_BIT, lock)) {
 		mutex_acquire(&zram->table_lock_map, 0, 1, _RET_IP_);
 		lock_acquired(&zram->table_lock_map, _RET_IP_);
 		return true;
@@ -88,7 +88,7 @@ static void slot_lock(struct zram *zram, unsigned long index)
 	unsigned long *lock = &zram->table[index].__lock;
 
 	mutex_acquire(&zram->table_lock_map, 0, 0, _RET_IP_);
-	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
+	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK_BIT, TASK_UNINTERRUPTIBLE);
 	lock_acquired(&zram->table_lock_map, _RET_IP_);
 }
 
@@ -97,7 +97,7 @@ static void slot_unlock(struct zram *zram, unsigned long index)
 	unsigned long *lock = &zram->table[index].__lock;
 
 	mutex_release(&zram->table_lock_map, _RET_IP_);
-	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
+	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK_BIT, lock);
 }
 
 static inline bool init_done(struct zram *zram)
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 4fddc582f3b8..7a55d751417e 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -15,6 +15,7 @@
 #ifndef _ZRAM_DRV_H_
 #define _ZRAM_DRV_H_
 
+#include <asm/byteorder.h>
 #include <linux/rwsem.h>
 #include <linux/zsmalloc.h>
 
@@ -57,6 +58,19 @@ enum zram_pageflags {
 	__NR_ZRAM_PAGEFLAGS,
 };
 
+/*
+ * The slot lock is a bit-wait lock on the whole __lock word, while
+ * flags and ac_time alias that word as two u32s.  The lock bit must
+ * land in the slot that ZRAM_ENTRY_LOCK reserves in attr.flags; on
+ * 64-bit big-endian the flags word maps to the upper half of __lock,
+ * so the bit position has to be shifted up.
+ */
+#if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
+#define ZRAM_ENTRY_LOCK_BIT  (ZRAM_ENTRY_LOCK + 32)
+#else
+#define ZRAM_ENTRY_LOCK_BIT  ZRAM_ENTRY_LOCK
+#endif
+
 /*
  * Allocated for each disk page.  We use bit-lock (ZRAM_ENTRY_LOCK bit
  * of flags) to save memory.  There can be plenty of entries and standard
-- 
2.55.0

