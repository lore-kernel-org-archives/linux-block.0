Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C330139D0A
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717845; cv=none; b=mb1307SQPnsYARDopGfZDHUxuSPOQR8Dgybv2NbBzMsbiDjm0tBYZow0ULPIBV6r5vDkeDsOhCXCEVDJY736rtFBX9S+SlnaAZKghHMCjgi6DYeX013uBdmTrbjFZpycvWtF7/adL0MZc410M1EnZVqd7Sk2DSG31NCT1kLXx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717845; c=relaxed/simple;
	bh=E2R/sHZWwbzruh78w11M/GJqLsE92X3XLWcZY6s3+PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGKDIWWmHKbxC/9clStkwmufq/sRzR0HxIGxDu09q9sEVlal3UosnBkGALwXaiqYqKhrQOcSIiCm5kICf1vyyKDAZaldGLHpzngLp9+uD7oxQXFLnMdh7OHqur9D5fgUASp5642ctJw8Q5vd1q/ApFTIK4WjeNAyM+nClTm75Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iI59nGD5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iI59nGD5"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82748257f5fso176286b3a.1
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773717844; x=1774322644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fALKEtwVUlhiV3LDTLfOGewg1HDF3QwssUtCeBDAQNY=;
        b=iI59nGD5ucrLfHlxuhKZwlHKQvWRiMHknnsX4lvHi3+gfsTL/LlItzHar7nmzEXo0Y
         GLeWNtPeAi2lB2FKSLDXgGvZ2V9evpEwT4DV6RoQslrg3o9u09S8ssEK/eqrqkXniW6u
         v1C8ujUezQUXbW55qwxulwpZ/GadTwGos9d4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773717844; x=1774322644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fALKEtwVUlhiV3LDTLfOGewg1HDF3QwssUtCeBDAQNY=;
        b=G2uYg2JaW8q328l5LzGXBUlUlSwywNJKc6/KPxqOO7tumzPLgvht0RXLakWNgtp58T
         7YOKVpuSkTkO47eye2rKGMr5dKNg6exu3GqUNGicwDCJj3IPTtRA5zfKH/yLVDudhgiA
         6OauJ8sNUlxNXnLPSKrFzQllyzir8jUskcuWshfl1WyE96A8FXBC6GQVaybLHpVGfOjC
         aK0MnurrWg5S0uCMKIcjR6fcALx0eYZtJa926J5kMvCPCmx5Z0AOBKi8f/+2nsxEfHCJ
         FK14OLQkb6veiZJDH9RSDvUyfv8y6AE+BA0c7rrQv5tS4UkY8irckOC1yqF/4mABnI4e
         o2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVw57FOE5wzzTpnj4phAmc/0B36oh63w9ZgU5Wz/j+bYArx9YYFfGZoihLkbex/l9+SgRcAGxs5pd3dyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCK+vZtF1xkqtxvJqy1nvlKJJoJ98KZhXSp2lCPNc4/0eIcQRv
	kwQ3iNN+7r9Q9+yCBV+9hqQQQqmhuHpBWVzD81m8LC9lIu5sTwgVbPw40fc4gfTDbg==
X-Gm-Gg: ATEYQzyOpij26c4DvUvaxchyRWXnkq/eiq+M6dVtFccijsrEtv7wGF/+09DzkpboO9g
	QMetsGAuRbK+1h4JHHszygnnHvw7PuemstqRaUwOKCIWur7ryRWDuodqRGtoVK9LpE/T31WF4NU
	h5dkS0edggO2UWaWGccVIWvmKanXbWhZVLAEQAXGduNcQ0bCMYImkeaUikA2c/XzXCyPMlKQP3j
	H9Ke6Qh72Cxty8VFZl1XMoo2sn+uFb7ssSuCqbCWPYs5AhOO1DHqxeSL3GeYWKM00fbdlU+2UBT
	0tQeT5vUPk3SOFzBfR4qtOMwtWftqnvrbdt+LIV3A5EauR4S8e/SvcBOMpx0PdmK5K/Vyk9pO9y
	ROWhKmrEMBYjJlKxaRYAoA945X00ZUvQDRCKuybn3uQlQmS0TFovdOiuUONz2jcQBHGaRlKNXf9
	5ih/Dr8tyV3Mtpm7syT12fi8JJBerc4MIQKZUMk7/wv49JMVyYBVYT2mAf8qoofILdQ6O10j8Tg
	mjGf4ghtyc5TQ==
X-Received: by 2002:a05:6300:85:b0:398:9a45:9cb5 with SMTP id adf61e73a8af0-39b7e061c47mr1611249637.32.1773717843902;
        Mon, 16 Mar 2026 20:24:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:4523:d548:3639:235b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb7f2basm9840364a12.29.2026.03.16.20.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 20:24:03 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: change scan_slots to return void
Date: Tue, 17 Mar 2026 12:23:19 +0900
Message-ID: <20260317032349.753645-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scan_slots_for_writeback() and scan_slots_for_recompress()
work in a "best effort" fashion, if they cannot allocate
memory for a new pp-slot candidate they just return and
post-processing selects slots that were successfully
scanned thus far.  scan_slots functions never return
errors and their callers never check the return status,
so convert them to return void.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7e45b8c8c33d..1b0e1c02ece7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1212,9 +1212,9 @@ static int parse_mode(char *val, u32 *mode)
 	return 0;
 }
 
-static int scan_slots_for_writeback(struct zram *zram, u32 mode,
-				    unsigned long lo, unsigned long hi,
-				    struct zram_pp_ctl *ctl)
+static void scan_slots_for_writeback(struct zram *zram, u32 mode,
+				     unsigned long lo, unsigned long hi,
+				     struct zram_pp_ctl *ctl)
 {
 	u32 index = lo;
 
@@ -1246,8 +1246,6 @@ static int scan_slots_for_writeback(struct zram *zram, u32 mode,
 			break;
 		index++;
 	}
-
-	return 0;
 }
 
 static ssize_t writeback_store(struct device *dev,
@@ -2379,8 +2377,8 @@ static bool highest_priority_algorithm(struct zram *zram, u32 prio)
 	return true;
 }
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio,
-				     struct zram_pp_ctl *ctl)
+static void scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio,
+				      struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long index;
@@ -2415,8 +2413,6 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio,
 		if (!ok)
 			break;
 	}
-
-	return 0;
 }
 
 /*
-- 
2.53.0.851.ga537e3e6e9-goog

