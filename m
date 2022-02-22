Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB01C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 01:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiBVBa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Feb 2022 20:30:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiBVBaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Feb 2022 20:30:24 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8865A25585;
        Mon, 21 Feb 2022 17:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645493400; x=1677029400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eyXpTaIq25nB5bdHP4lR4iF+QtCbpy796Ah/ggXuoxw=;
  b=XYqpVKQMEXxkGAotQ6G0sUH2lv6KVtpkA2V2IR4Z3I/Jvy9q7cip/voD
   iIG4aTzu0IFG6iOFqfgyDB2hesI1n3UvxqExhVkF0MmmGKqqsj8BXR7mJ
   wpXqbQteaqlc8/uKP4hnsUqOd8QD1FPpzXOXhHk9lMFx8YJVmClXHfP3R
   /Jv5yU/MHj7jJ1Fu/e5KbJ1AJdYwsR7KV0Vdw4qJAPkBL4YUu9WKivNCj
   kwh9adesBvJr5gyzk1+FdVN+9HvITdvl7byozjccaDTIp1PuwcRa2uuVM
   7CaUO+5UQnOLE/RNnGAZe3FR3Iixd3S3WqIch0WFRoeFbUPdLk8Pv7FjR
   w==;
X-IronPort-AV: E=Sophos;i="5.88,386,1635177600"; 
   d="scan'208";a="198419408"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2022 09:29:59 +0800
IronPort-SDR: 9KiK8UW06quco6nxQtLGaNpIeJHha3/04PQRsqjyzNjlajbNe2EfrX5eflgzAeuRsvSPE+BdAk
 zJMt7atHvdAs6P36ji++NvAljbh9UXqrFagIABKF6deF+rzIzHs3OsSJKduPYKm0MJYrUPE05D
 6M1skOODT5ko398pSBN9uGWB8JhuO3Vwvz8DB+UIV3RlEZaMRP1MN8w+1fqLkTfNZW4xsAzPa1
 XqSa43XqFTQmLVrA1h/xpErJGhvPBwD+kNDIWS5T7ZVyh3ue3TyTaEcduVVGOzrQINMOcoEZ1B
 yQuJq9NdtriNuhFbqVtFWGmc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 17:01:33 -0800
IronPort-SDR: hP/NO1r0AXmpYAmOdVmDuk4md91+2huKGSssd3ZywihjXh5pebiz89MX3TFxdCJ6JGak0lFA9e
 4WuvzU993R6V725NLuc4ucCdksrijTLKmpDFOOk1hagtcH6hh0W77SHLAjNq9+QTjqKbeIIE/D
 e2i0vXjZC5zPQsOGaoNL1GpVIlKXPdhbAKl2+DBz+o3XTuJ398Bc/SPyQiMxpf14Jr8mVIPoQP
 3nJY841nlgErkxQbAAX28Pqh0Of3LOPpwlyeJcdhoESnOSjoRET54p1tdUiq/SzaT3NtMcYcAq
 xWI=
WDCIronportException: Internal
Received: from hlpbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Feb 2022 17:29:59 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] Documentation: block/diskstats: update function names
Date:   Tue, 22 Feb 2022 10:27:51 +0900
Message-Id: <20220222012751.1933194-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__make_request() and end_that_request_last() do no longer exist. Replace
them with the current call-site.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 Documentation/admin-guide/iostats.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 9b14b0c2c9c4..609a3201fd4e 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -76,7 +76,7 @@ Field  3 -- # of sectors read (unsigned long)
 
 Field  4 -- # of milliseconds spent reading (unsigned int)
     This is the total number of milliseconds spent by all reads (as
-    measured from __make_request() to end_that_request_last()).
+    measured from blk_mq_alloc_request() to __blk_mq_end_request()).
 
 Field  5 -- # of writes completed (unsigned long)
     This is the total number of writes completed successfully.
@@ -89,7 +89,7 @@ Field  7 -- # of sectors written (unsigned long)
 
 Field  8 -- # of milliseconds spent writing (unsigned int)
     This is the total number of milliseconds spent by all writes (as
-    measured from __make_request() to end_that_request_last()).
+    measured from blk_mq_alloc_request() to __blk_mq_end_request()).
 
 Field  9 -- # of I/Os currently in progress (unsigned int)
     The only field that should go to zero. Incremented as requests are
@@ -120,7 +120,7 @@ Field 14 -- # of sectors discarded (unsigned long)
 
 Field 15 -- # of milliseconds spent discarding (unsigned int)
     This is the total number of milliseconds spent by all discards (as
-    measured from __make_request() to end_that_request_last()).
+    measured from blk_mq_alloc_request() to __blk_mq_end_request()).
 
 Field 16 -- # of flush requests completed
     This is the total number of flush requests completed successfully.
-- 
2.35.1

