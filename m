Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9639BC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71079208DB
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 10:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHKID (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 06:08:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:20904 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgEHKIC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 06:08:02 -0400
IronPort-SDR: cNVJRZPmFMuVVZJ+EHXILCmSTsuP/kffJTLr0n4cup9dfYQIneewmAVDr9wtFQ3rPZcg2//SK8
 NaN6ofo1t12w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 03:08:02 -0700
IronPort-SDR: szn0S+lD3rZBPGA0jbATvx3XslYZfw4CfP2d3IeZmP+GB89A6OLMLSnOT/St9H8Y6AOabeBI4v
 CLO793phILGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="250352587"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2020 03:08:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7EDA7124; Fri,  8 May 2020 13:07:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] zcomp: Use ARRAY_SIZE() for backends list
Date:   Fri,  8 May 2020 13:07:58 +0300
Message-Id: <20200508100758.51644-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of keeping NULL terminated array switch to use ARRAY_SIZE()
which helps to further clean up.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
v2: added Ack (Minchan), resent with new people in Cc list (Minchan)
 drivers/block/zram/zcomp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1a8564a79d8dc..e78e7a2ccfd58 100644
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
2.26.2

