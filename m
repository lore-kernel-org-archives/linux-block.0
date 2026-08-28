Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A33E0222
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905924; cv=none; b=Bx/U5MFQv3pLnJQ+YpydEqytZWCbYb8ha18apke60hnFLZCYUvhbLGGsix6f57WzS7AkHAbEPyiE3SWqcUX9s/Gza8bJFxCgGNN2dZYOMMM060uTwp936Yi15TMcIbsK/VWYZvkIs/ujAgXu9cwfCKeTjQvHS7IlGNpclGv2yH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905924; c=relaxed/simple;
	bh=lY9wqR5/ikqnh+/RV8zDWcYa0uqcVqHsypPo+22s70Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iIM0fNryXfe+dJXmP/tdWoyPpUple8gD2WJT0jAhYO2xFH57+PQ3aAAt6H26reD4/5vucSL2letmHhRtlNmqE4Xk3mLUZKHuH8/Gp56rYZhEM0VZ9myyIKU6Gk/eDrq6W2af0sScwC81ViExOdfRlZedXZX+UJXkCmzSQlGcvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtKboi9Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtKboi9Z"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caed617615so5255295ad.3
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787905922; x=1788510722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhr2QiA56aojMpA07bo8qE5RApOWiL6TjFXkbxkAUgg=;
        b=LtKboi9Zu+B4e7ak5omHnrRHIx/jN4FdGqoV2mye7trB4bWRrHL8xqVAiiReDQHb75
         P1dXbSOTfEi9lyY9MbB/lBoFCycUKwxOEndPt73JTESIBIDwYviKRGvuoz4HcTqtzX+J
         Knxjgsp8VMcA3tuKy3uruwC3VEevz1JE9jRHDjJvIZM88u7zzFHkLVFLPObD0wjt6xRb
         mJiBXFwHQPqA3qVYiLj8x3t33cUCqkMwYCKlYIOj1m9LY1FRyfkr8BjwPq46bPao0cPH
         srQ7wIx2QThR43GYj+IeIqRDzlX3fFWHqyEb7OUYzTfvCtQRLYsGv5ITYuQL94SFe7sf
         Posg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787905922; x=1788510722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhr2QiA56aojMpA07bo8qE5RApOWiL6TjFXkbxkAUgg=;
        b=YFc0guEveB4yU9nOh6auip+LsO3YFZZsJXAlJ9guSAIKtWhJVKpi9WxdFkheZwKFBx
         n4SXxO+VHiRMxEkPRtWdqj9k0PwHYzIb7maJ4KffGOCTFRUNl78oE5mnogVhK1BmyhjO
         vzDU8yxaxPYVj7lxfKo4kKAdm1Og8FSlarud2RyhZAHEZP3lCWseUt3H58mdeYCWzTxF
         tVGC0V68Ki8OgE16mnQ1FK58sETq42KHAa/LrLfzpd55wGyYfJ6qfzOYw3WEPgoAGgjs
         knjyzW1tRTIFPXV58NQ5Gb8W8MxWH3y4g6NTRUDxyGwp8n6wKXvKycg4lTyC4f8Tkhlh
         2/zg==
X-Forwarded-Encrypted: i=1; AHgh+RobqzG55nDZRoUwQCZAB8YHCP3oCKldkYmNhrSit8k4oWXMCrbhF9hEKhT5Xv4buOp2E1bjqUkBxyZhuQ==@vger.kernel.org
X-Gm-Message-State: AFuF++khkeHGjp5UI0CfD/Id6LK97v0vsYgamYYj2FV5A21ORZiXhm63
	Sb0ZVT962+5X6Qu+bj1/RkPa+S3l5ACp8sCL//fQw29+tqEaDfZufjoY
X-Gm-Gg: AR+sD10FU3BLZQcRBUf+GP+48iYj2he4XlAjt8AJ7lRYMONfhrRkXhp+JKDsAApWxh/
	qt5VlSAL5FSaFSPNlr1sVBcFbPXAKA3SCaRuka4RjNOoAKP72kwbeZ/EI+gPuY31aeLpAU1faDp
	aehN4gzm0N97XDIIbn8Gt2QwP96olAAGjENgnjbprAwsG6uxU2Zh4YURm25q/c0YvdW6aUuLDLe
	UAa1OqneiZbe3NtYdeyd795Ysqb/xTMq1/kK7DI6Q24CyE36JuURMpYKZrjfiOCjkwaPkUgBcH9
	/TUOCsjiH+605Wojfd0XBMSEp30/B8Xytc93dqUQnaP7LB9D2PtTOlTLuPJ4C8YJwOwZxoZ2Jx9
	AqEUvWpwxfvB0oVT+wP9E7tPYfixO2CbBH6Vtai5HB8Dujlf7rDbrEIwj05mjK0yoAH2YDOmzP0
	gMUMoTGjCuESGAo6kS5Cq+uhH79xNOK5QNfOHop+7zKiuRQyJdCNx7inUpA6jYm2B6KqCjtt8tu
	1Wo8SenG/if2VRb7V7yQzRYiw==
X-Received: by 2002:a17:903:22d0:b0:2d6:ccc5:a3dd with SMTP id d9443c01a7336-2d74dc2ff23mr87286795ad.4.1787905922221;
        Fri, 28 Aug 2026 01:32:02 -0700 (PDT)
Received: from localhost.localdomain ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75986d3b7sm3306095ad.41.2026.08.28.01.31.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 01:32:01 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	bgeffon@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
Date: Fri, 28 Aug 2026 16:31:49 +0800
Message-Id: <20260828083149.45760-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
idle_store() computes the idle cutoff as:

	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);

Because the left operand is cast to u32, when age_sec exceeds the current
uptime the subtraction wraps modulo 2^32 and the huge result is
zero-extended into the s64 cutoff. mark_idle() then marks every entry as
idle instead of matching nothing. For instance, running

	echo 86400 > /sys/block/zramX/idle

on a machine up for only two minutes marks all newly written pages idle
and hands them to idle writeback and recompression.

No slot can have been accessed before the system booted, so an age_sec
that reaches back past uptime cannot match any slot. Return early in that
case, without walking the table or taking any slot locks.

Track the cutoff as time64_t rather than ktime_t. Both cutoff and
ac_time are boot-time values in seconds, so a plain arithmetic
comparison against ac_time in mark_idle() is correct and no ktime
helpers are needed.

Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")
Cc: stable@vger.kernel.org
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 drivers/block/zram/zram_drv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a9b3bb1d3bef..4ba0f77b2abd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -415,7 +415,7 @@ static ssize_t mem_used_max_store(struct device *dev,
  * Mark all pages which are older than or equal to cutoff as IDLE.
  * Callers should hold the zram init lock in read mode
  */
-static void mark_idle(struct zram *zram, ktime_t cutoff)
+static void mark_idle(struct zram *zram, time64_t cutoff)
 {
 	int is_idle = 1;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -439,7 +439,7 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 		is_idle = !cutoff ||
-			ktime_after(cutoff, zram->table[index].attr.ac_time);
+			cutoff > zram->table[index].attr.ac_time;
 #endif
 		if (is_idle)
 			set_slot_flag(zram, index, ZRAM_IDLE);
@@ -453,21 +453,26 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	ktime_t cutoff = 0;
+	time64_t cutoff = 0;
 
 	if (!sysfs_streq(buf, "all")) {
 		/*
 		 * If it did not parse as 'all' try to treat it as an integer
 		 * when we have memory tracking enabled.
 		 */
+		time64_t uptime;
 		u32 age_sec;
 
-		if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
-		    !kstrtouint(buf, 0, &age_sec))
-			cutoff = ktime_sub((u32)ktime_get_boottime_seconds(),
-					   age_sec);
-		else
+		if (!IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) ||
+		    kstrtouint(buf, 0, &age_sec))
 			return -EINVAL;
+
+		/* No slot can be older than the system uptime */
+		uptime = ktime_get_boottime_seconds();
+		if (age_sec >= uptime)
+			return len;
+
+		cutoff = uptime - age_sec;
 	}
 
 	guard(rwsem_read)(&zram->dev_lock);
-- 
2.34.1

