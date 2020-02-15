Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FCAC3B1BF
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09C220726
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ptwWMw0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBOA6C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:58:02 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49846 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgBOA6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 19:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581728281; x=1613264281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ey8Ny12sY8G6vwMHtw69Ge4+C8Np2CTxr8c2vg9CR40=;
  b=ptwWMw0oSv11qz9OHrP92gUUxufLfNPc6vG3Nwy5Kb23XplzwYKEpBL/
   urflLffVEQZNV1gMJSaAG3KlpDak2JkfgPum8eoZSARyMpKc+HCLcZf8z
   PTh/yjjbFLou7NQHm/6jXBc7WSM4WSTP7fRzGEla67pkr0a1lzu2YJVrI
   dRuJvODsj+AQxe1bMlezzvxi1HoF/t0ildgaSa0i8OZ1Q+y0TSnal7JEE
   GVT7bVuDxnXQhFL7fPTxkuygFYlIw8XOM6Pp7svi7aAA4x9zrTTL2ZN9V
   Cdpr19/IKiyEM8c5LGRlbHwoaAC7EaNN06bvvXdnLJWDPlV0LHvzC08pA
   Q==;
IronPort-SDR: k22vemmwcaKa1/KDfjZH4jcyymV0gow+w9IUY6Ao2mbfszzLUj9bp4Yr/356PvCUyz18YWgEMW
 lSW50IfmlT+nBkTt4igpNNf+fir5022p+nWHzpI90xFv0LuIuvoE2UEqnp21BbI19o4ngSA/rH
 oEoUZUD8gbY+mE02IYiEFG2VO/yL5BAvAAstJ7rWRVrHqyPhS8RSLOZbGgozYn24MpQA6jMcYX
 /jwZUEKO6ulghBlLfrsUS9j0OuRr0GWGyULKzKswEkruD75RRnyAimswmCQcW+NKzyKPEXgt+G
 BQU=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; 
   d="scan'208";a="129905394"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 08:58:01 +0800
IronPort-SDR: uPMCOz+abbeFU74Ia4BJfb2dLuR/0dZjrjBXJwuNtLthqrwN2/NaDejpXyCBYv22UWchZzVT8s
 IWy3eq4RljwXdLuZ3oIpBqDYpPu8VwvX06tox1y+At1bl6CQ+pfrRNw+HymJ48IyCR53XdJ4DW
 pUXO+bk1rwGvld9b2ailYvqhgBrNX3S+wvC8/55KPLR9RFo2GRRD2iJ9/cVotl67gP2r6e+L9h
 0wxoUac8O0on0BeMCzcSB2mpLRpScNbn8b9Q7TIpeyDEENjHhuHb9rZ3/yfuVvbcNA03bS32PW
 q/oUswt+yQQHayU7yGavg0gQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 16:50:46 -0800
IronPort-SDR: 1kFSBs/wS/9sBdiM0gC6NIn8LO6B6yzECQLtF8+keyPgah7crINXo/BaF+d8W9g9H/cwaaV5FX
 j3KtlVeecd0CFD9StbCgtC9FPE4A0IOmaZS18B3XZxSkuT5Gn+M3u7Zv6r3l266jxDkTtqED9f
 GjwFnVrFgr9uhLP2R6DUZaRS7ZdfCnXk6mzyRrPIh42/lGUreW+AV7b71CXxuK0t8Ge5Z0eJDP
 0rJp8m60DPpU4Epr0TfWtiB2jmZw1si+R4Bku5pTmE4aVUTp6oJ1HmrsExDBzS1PKQwD+82Izf
 +XQ=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 16:58:01 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, damien.lemoal@wdc.com
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/3] block: add a zone condition debug helper
Date:   Fri, 14 Feb 2020 16:57:56 -0800
Message-Id: <20200215005758.3212-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
References: <20200215005758.3212-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a helper to stringify the zone conditions. We use this helper in the
next patch to track zone conditions in tracepoints.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c             | 14 ++++++++++++++
 include/linux/blkdev.h        | 26 ++++++++++++++++++++++++++
 include/uapi/linux/blkzoned.h |  1 +
 3 files changed, 41 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 05741c6f618b..2c4df98b513c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -20,6 +20,20 @@
 
 #include "blk.h"
 
+#define ZONE_COND_NAME(name) [BLK_ZONE_COND_##name] = #name
+const char *const zone_cond_name[BLK_ZONE_COND_LAST] = {
+	ZONE_COND_NAME(NOT_WP),
+	ZONE_COND_NAME(EMPTY),
+	ZONE_COND_NAME(IMP_OPEN),
+	ZONE_COND_NAME(EXP_OPEN),
+	ZONE_COND_NAME(CLOSED),
+	ZONE_COND_NAME(READONLY),
+	ZONE_COND_NAME(FULL),
+	ZONE_COND_NAME(OFFLINE),
+};
+EXPORT_SYMBOL_GPL(zone_cond_name);
+#undef ZONE_COND_NAME
+
 static inline sector_t blk_zone_start(struct request_queue *q,
 				      sector_t sector)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 053ea4b51988..5204eda6e4c1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -887,6 +887,32 @@ extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(unsigned int op);
 
+#ifdef CONFIG_BLK_DEV_ZONED
+extern const char *const zone_cond_name[BLK_ZONE_COND_LAST];
+/**
+ * blk_zone_cond_str - Return string XXX in BLK_ZONE_COND_XXX.
+ * @zone_cond: BLK_ZONE_COND_XXX.
+ *
+ * Description: Centralize block layer function to convert BLK_ZONE_COND_XXX
+ * into string format. Useful in the debugging and tracing zone conditions. For
+ * invalid BLK_ZONE_COND_XXX it returns string "UNKNOWN".
+ */
+static inline const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
+{
+	const char *zone_cond_str = "UNKNOWN";
+
+	if (zone_cond < BLK_ZONE_COND_LAST && zone_cond_name[zone_cond])
+		zone_cond_str = zone_cond_name[zone_cond];
+
+	return zone_cond_str;
+}
+#else
+static inline const char *blk_zone_cond_str(unsigned int zone_cond)
+{
+	return "NOT SUPPORTED";
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
 int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 0cdef67135f0..28ad29973a45 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -71,6 +71,7 @@ enum blk_zone_cond {
 	BLK_ZONE_COND_READONLY	= 0xD,
 	BLK_ZONE_COND_FULL	= 0xE,
 	BLK_ZONE_COND_OFFLINE	= 0xF,
+	BLK_ZONE_COND_LAST,
 };
 
 /**
-- 
2.22.1

