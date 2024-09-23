Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD34DF60;
	Mon, 23 Sep 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110135; cv=none; b=KqL71kg1IP2HgeSW5SRrykVEmk7BvtJj0Q8qbZDqgHNtEwHlutWvJ8/0C4EoZVmpwGfdPR/ABCWgogOS2+jpixgCsR7UrqxZtWRW1GlzonCqNRSz82B+yMNPPUypOThmTR44nkS4cLii9PVO2Ve/1zpHr7DN0NIsL1tRerbhZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110135; c=relaxed/simple;
	bh=X4iwtPBM51ziRrceO3QdT6g1PRZE4IhgMtL2UmG7LZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axK6btIHE6atQJ4+81aDXFk2MuMEr1Rb6/UYyAnsm+iSi3AsumuoC0+QiUj2WrTJwVjBLEiGxMQmEgwPeLseawAO1+aZc9wh0NZakdVhJecWCxntrWb93v7rQvMoZdGZ4GLVKwVnpWmOIUpJH2donqBY0o3NXb0OtC5t2Hl2lLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Med12sKp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Med12sKp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cc8782869so43787385e9.2;
        Mon, 23 Sep 2024 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727110132; x=1727714932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSWdaUAIYBXCymZNBFOL2fQ+V5QkB1tVGt6L1heAaJ4=;
        b=Med12sKpMfMo87oPQRC5+S4fURs+vpSEa4mpk4SMj1GxTgLHu2o/SrYRwoBItQM/HT
         /Sijsu4MzLqdgmf3FmeLsbaQRIr25dtSpUDuuaFLDh1X/SGFxRiuGuxsXFYNlfOc3f70
         CVnW3l62sPMuJvCAiIrqiNKBowd1HGAI4P7o4Iui/i+U3fZMQvGyQRAsmCfh21PAGxfS
         lDkXflarmDpIiD7Joi+ex3WDRTX7UfJXyh9vTh8ktq3b2IFFJrRLZDt+E7aNeqRkpNfY
         bfkF+S8B3exm9E/ZJGLH3cqukt0OFJxL7oF8vXTeDnXMFIhbWBOk0cqyFKeabEwPAD/Q
         ojyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727110132; x=1727714932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSWdaUAIYBXCymZNBFOL2fQ+V5QkB1tVGt6L1heAaJ4=;
        b=dMIyZgOLDrDFJEvgoP5wMm9qQkxfjx/FDqsLsVJJ72pBkEu/VHfzBQczz7oRuDloKz
         yX3pwumVAB/5aar69cswJRRdfRipfLkJWYRW9tKdlcR38b5IQ42KY9jKEN1TovLTXvhn
         v1i5gpDcF9kSLgMxWoCPcPA2c7JiQk4MF06n1xbXky/Ykk5RCOt4tfzGv7+5XTIaZhyZ
         3CbBBdS3lc6dHbDXa9x7C2KasteDjyj1E/IdRuVfvs541bXI/vyQUbTmMurhftAG4g+q
         QQ/7eBImF0FKdi8+kyAKY9C7j2XpnpniFd1uNnBaQrpAicdhmwJ7Wr2Cb7ZpEYPUe7jL
         FF5g==
X-Forwarded-Encrypted: i=1; AJvYcCUOdYh+et/mjT4+DoWztH1sMCET5pqUSjgKTdd7cdobwneOwK/sL06bu8gKPjM34Se+izBeI9QbZLfLkg==@vger.kernel.org, AJvYcCX9BBpPTsJwUos0AuEKTqqyjA1Z7Y06Tu5p0R9fYo1DBHHBBMEicjtB1vFmm2ts51RiJlkzzSYv@vger.kernel.org, AJvYcCXaRtyQ0eYxtFfAdPSQjCgrFtHMvxZJA5La1e8ynULZsuibWs+wsVMOjdsQi2ZMjfpKi5xnN1zJVZ94FW2q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oZbeD1begBwxo9dOrg+oWd5LfoY4HmsNw2MdS+Cqs2j/FOlQ
	pZjgSegsvNyrPzj6sXj6jLgsNUtR6LHRNDRSj61p6ce/i4Hb3yBV
X-Google-Smtp-Source: AGHT+IHPU6wCXBsJs8+wEQmq9WExOqEQI5tcapZXJYh3UOfJ8NuHwYDjCC/t/ElcVLnRjtCsF6u3SA==
X-Received: by 2002:a5d:664a:0:b0:374:bb00:31eb with SMTP id ffacd0b85a97d-37a42252c99mr6787406f8f.6.1727110132022;
        Mon, 23 Sep 2024 09:48:52 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78002besm25041308f8f.67.2024.09.23.09.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:48:51 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] zram: don't free statically defined names
Date: Mon, 23 Sep 2024 19:48:43 +0300
Message-ID: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_ZRAM_MULTI_COMP isn't set ZRAM_SECONDARY_COMP can hold
default_compressor, because it's the same offset as ZRAM_PRIMARY_COMP,
so we need to make sure that we don't attempt to kfree() the
statically defined compressor name.

This is detected by KASAN.

==================================================================
  Call trace:
   kfree+0x60/0x3a0
   zram_destroy_comps+0x98/0x198 [zram]
   zram_reset_device+0x22c/0x4a8 [zram]
   reset_store+0x1bc/0x2d8 [zram]
   dev_attr_store+0x44/0x80
   sysfs_kf_write+0xfc/0x188
   kernfs_fop_write_iter+0x28c/0x428
   vfs_write+0x4dc/0x9b8
   ksys_write+0x100/0x1f8
   __arm64_sys_write+0x74/0xb8
   invoke_syscall+0xd8/0x260
   el0_svc_common.constprop.0+0xb4/0x240
   do_el0_svc+0x48/0x68
   el0_svc+0x40/0xc8
   el0t_64_sync_handler+0x120/0x130
   el0t_64_sync+0x190/0x198
==================================================================

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Fixes: 684826f8271a ("zram: free secondary algorithms names")
Cc: <stable@vger.kernel.org>
---

Changes in v2:
 - removed comment from source code about freeing statically defined compression
 - removed part of KASAN report from commit description
 - added information about CONFIG_ZRAM_MULTI_COMP into commit description

Changes in v3:
 - modified commit description based on Sergey's comment
 - changed start for-loop to ZRAM_PRIMARY_COMP


 drivers/block/zram/zram_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c3d245617083d..ad9c9bc3ccfc5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->num_active_comps--;
 	}
 
-	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
-		kfree(zram->comp_algs[prio]);
+	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+		/* Do not free statically defined compression algorithms */
+		if (zram->comp_algs[prio] != default_compressor)
+			kfree(zram->comp_algs[prio]);
 		zram->comp_algs[prio] = NULL;
 	}
 
-- 
2.45.2

