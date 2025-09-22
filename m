Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE902F56;
	Mon, 22 Sep 2025 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511902; cv=none; b=gQxTa3Zk2GMS2t/Rlh8jstaG8RlQ61Q/LZEcCQmKnvBh4feZGp2tNOP8Ki/vFwgixCQIIzwrKP8dWVY5qJfSAiYFDfzsL54sOJcQGhlSd+Bpo/U6IpFJ8EFRK9b2/o0gPZYq6e7kcx1fxT3G69fQqfwcUEFDiQlwsJfwo9baMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511902; c=relaxed/simple;
	bh=F19el03GgGwpZ8DVPVuDEwToiwI4Op4kQtB2cLa3uLQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FINeCMrhRkfrYCsdhu+uYr1/m+1lA7EieHJDKAjhDLjvoNZJ9YosDDyzuR9ZrDYc2BIXbn3RGAYuZAdHsIwKcOoBMvhjr5fK84SlgW87jssFYejGsi5OyRbnijzkpGzZd9KKQjaSBxPo+WODOtver9c04QyVutexttPRDyuL99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=SjR8O3W0; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="SjR8O3W0"
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 58M3VZcx065328;
	Mon, 22 Sep 2025 11:31:35 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 58M3TPM1052899;
	Mon, 22 Sep 2025 11:29:25 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4cVT843LdHz2K5NS5;
	Mon, 22 Sep 2025 11:27:48 +0800 (CST)
Received: from bj03382pcu03.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 22 Sep 2025 11:29:22 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        <linux-mm@kvack.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH] driver: loop: introduce synchronized read for loop driver
Date: Mon, 22 Sep 2025 11:29:15 +0800
Message-ID: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 58M3TPM1052899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1758511777;
	bh=naUubTQs4cvxZpd+FKA4m3TL3kOY3UI3T0jr+Hxcg5I=;
	h=From:To:Subject:Date;
	b=SjR8O3W0D4m5YndAEf7zM3GPQVmmpYj21lEwZrJZ7XACQ+Y31SzAZDa0e+B/0orgs
	 729F8t91BdmliWox18tjrRJsRpUuyEDiEWVSTAwKmLnq8c9huZNxPXBRsAyUlToH2O
	 hkPGPS5hPBUfw9+x0DJIxEsMjFjduiq+cMW/hcOk+WA+XPp1ZIk1RQRUf83XCArroa
	 8u5zlu4vi2FcjjR6uiU1d8F0lhKBq7uzFDgLt+MBENgkweYUKJaB8/qveMdln6ARAg
	 luOwbYA1X3eWo8MFF+2e6tAzAv1XP/2GKuxZVqfDJ+oSJH5+GM54whnUz+JMa8uH4V
	 uh2wC5Rn/oUoA==

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

For now, my android system with per pid memcgv2 setup are suffering
high block_rq_issue to block_rq_complete latency which is actually
introduced by schedule latency of too many kworker threads. By further
investigation, we found that the EAS scheduler which will pack small
load tasks into one CPU core will make this scenario worse. This commit
would like to introduce a way of synchronized read to be helpful on
this scenario. The I2C of loop device's request reduced from 14ms to
2.1ms under fio test.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/block/Kconfig | 10 ++++++++++
 drivers/block/loop.c  | 22 +++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index df38fb364904..a30d6c5f466e 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -383,4 +383,14 @@ config BLK_DEV_ZONED_LOOP
 
 	  If unsure, say N.
 
+config LOOP_SYNC_READ
+	bool "enable synchronized read for loop device"
+	default n
+	help
+	  provide a way of synchronized read for loop device which could be
+	  helpful when you are concerned with the schedule latency affection
+	  over the requests of loop device especially when plenty of blkcgs
+	  setup within the system. The loop device should be configured as
+	  LO_FLAGS_DIRECT_IO when applying this config.
+
 endif # BLK_DEV
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 053a086d547e..1e18abe48d2b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1884,7 +1884,27 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 #endif
 	}
 #endif
-	loop_queue_work(lo, cmd);
+#ifdef CONFIG_LOOP_SYNC_READ
+	if (req_op(rq) == REQ_OP_READ && cmd->use_aio && current->plug) {
+		struct blk_plug *plug = current->plug;
+
+		current->plug = NULL;
+		/* iterate through the plug->mq_list and launch the requests to real device */
+		while (rq) {
+			loff_t pos;
+
+			cmd = blk_mq_rq_to_pdu(rq);
+			pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
+			lo_rw_aio(lo, cmd, pos, ITER_DEST);
+			rq = rq_list_pop(&plug->mq_list);
+		}
+		plug->rq_count = 0;
+		current->plug = plug;
+	} else
+		loop_queue_work(lo, cmd);
+#else
+		loop_queue_work(lo, cmd);
+#endif
 
 	return BLK_STS_OK;
 }
-- 
2.25.1

