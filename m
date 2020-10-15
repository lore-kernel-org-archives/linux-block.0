Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AD3C433E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B8622256
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 14:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gnxBu0Ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgJOOZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:25:43 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:16161 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgJOOZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 10:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1602771942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qACv2ER1JyTphbaRvO3qjGjCO4Ywxs60QaM06nUJtes=;
  b=gnxBu0Okljz4KZnafw9fJasKLyJEsI43noBV4BEOOxucWUU4pN1ER84H
   bjF80Y5hs/1HClri4hmBuq7vFIimhLPWYsvfkPmAYLv9IAnnkQLZXQ4VF
   CBK2MfO58C+MuosMAyDCt5RM44jKzXObbfPaf1nClUSKdhETtcZa+ZNfq
   U=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: pc4931EzyhHOF/1+wy2nZ4XleWl7qBYyCEkp00YAxqGPWcnc737w40tXoyYSmGIVRQQH4Iit93
 07qxT5ybUOhZ2qxJTCRSoPyXLgFI6SB+kOdkwJ+tnstszy0/PMaQb6jMTptLMYlA/iJY4Lf2Oi
 F/cLdsnFwau5CJFWfhOyvPnFRV7Fsi+iyINxA6sbSGk67l/81+RiveiaYesCDf5YPxdThZ1AFI
 ilb1k5+O1Wjm2wOq7NJkhCdFSBqRNJaXSmpoZMT/4v02/Y5YxNBbR02IjhXjykf3zIOuEoFlNN
 uzc=
X-SBRS: 2.5
X-MesageID: 29332243
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,379,1596513600"; 
   d="scan'208";a="29332243"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        SeongJae Park <sjpark@amazon.de>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        "J . Roeleveld" <joost@antarean.org>,
        =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
Subject: [PATCH 2/2] xen/blkback: turn the cache purge percent into a parameter
Date:   Thu, 15 Oct 2020 16:24:16 +0200
Message-ID: <20201015142416.70294-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015142416.70294-1-roger.pau@citrix.com>
References: <20201015142416.70294-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Assume that reads and writes to the variable will be atomic. The worse
that could happen is that one of the purges removes a partially
written percentage of grants, but the cache itself will recover.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: xen-devel@lists.xenproject.org
Cc: linux-block@vger.kernel.org
Cc: J. Roeleveld <joost@antarean.org>
Cc: Jürgen Groß <jgross@suse.com>
---
 Documentation/ABI/testing/sysfs-driver-xen-blkback | 9 +++++++++
 drivers/block/xen-blkback/blkback.c                | 7 +++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
index 776f25d335ca..7de791ad61f9 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
@@ -45,3 +45,12 @@ Description:
                 to be executed periodically. This parameter controls the time
                 interval between consecutive executions of the purge mechanism
                 is set in ms.
+
+What:           /sys/module/xen_blkback/parameters/lru_percent_clean
+Date:           October 2020
+KernelVersion:  5.10
+Contact:        Roger Pau Monné <roger.pau@citrix.com>
+Description:
+                When the persistent grants list is full we will remove unused
+                grants from the list. The percent number of grants to be
+                removed at each LRU execution.
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 6ad9b76fdb2b..772852d45a5a 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -127,7 +127,10 @@ MODULE_PARM_DESC(lru_internval,
  * from the list. The percent number of grants to be removed at each LRU
  * execution.
  */
-#define LRU_PERCENT_CLEAN 5
+static unsigned int lru_percent_clean = 5;
+module_param_named(lru_percent_clean, lru_percent_clean, uint, 0644);
+MODULE_PARM_DESC(lru_percent_clean,
+		 "Percentage of persistent grants to remove from the cache when full");
 
 /* Run-time switchable: /sys/module/blkback/parameters/ */
 static unsigned int log_stats;
@@ -404,7 +407,7 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
 	    !ring->blkif->vbd.overflow_max_grants)) {
 		num_clean = 0;
 	} else {
-		num_clean = (max_pgrants / 100) * LRU_PERCENT_CLEAN;
+		num_clean = (max_pgrants / 100) * lru_percent_clean;
 		num_clean = ring->persistent_gnt_c - max_pgrants + num_clean;
 		num_clean = min(ring->persistent_gnt_c, num_clean);
 		pr_debug("Going to purge at least %u persistent grants\n",
-- 
2.28.0

