Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F51C3F2CD
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934CF20714
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 17:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCWRuM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:50:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:55473 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCWRuM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 13:50:12 -0400
IronPort-SDR: qSNyd7d3Hoiyx050wDY7VYDNrzP5beFuv03u6y2kZN+rwvrAUsY5sSWhSninz5QUH2MCTyH43w
 Q61wLu2vUjTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 10:50:11 -0700
IronPort-SDR: peCJUioh2h6rnERlHncPaXBRcTMnUGtR5/rV5Zplnp0zVTegVdYk2dpo0Pe5sYlb+3TVE68IuG
 RD+gG8bNQchQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="235292595"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2020 10:50:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C8AE814B; Mon, 23 Mar 2020 19:50:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] zcomp: Use ARRAY_SIZE() for backends list
Date:   Mon, 23 Mar 2020 19:50:08 +0200
Message-Id: <20200323175008.83393-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of keeping NULL terminated array switch to use ARRAY_SIZE()
which helps to further clean up.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/zram/zcomp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1a8564a79d8d..e78e7a2ccfd5 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -29,7 +29,6 @@ static const char * const backends[] = {
 #if IS_ENABLED(CONFIG_CRYPTO_ZSTD)
 	"zstd",
 #endif
-	NULL
 };
 
 static void zcomp_strm_free(struct zcomp_strm *zstrm)
@@ -67,7 +66,7 @@ bool zcomp_available_algorithm(const char *comp)
 {
 	int i;
 
-	i = __sysfs_match_string(backends, -1, comp);
+	i = sysfs_match_string(backends, comp);
 	if (i >= 0)
 		return true;
 
@@ -86,9 +85,9 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
 {
 	bool known_algorithm = false;
 	ssize_t sz = 0;
-	int i = 0;
+	int i;
 
-	for (; backends[i]; i++) {
+	for (i = 0; i < ARRAY_SIZE(backends); i++) {
 		if (!strcmp(comp, backends[i])) {
 			known_algorithm = true;
 			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
-- 
2.25.1

