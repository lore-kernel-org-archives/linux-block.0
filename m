Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018DCC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B9A64E9A
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhBBFhj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:37:39 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34101 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBBFhj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244258; x=1643780258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iB/yJ9Lgv7J9LvlB+DckFJp9mu+dsQ1oIN/8MI2+2So=;
  b=BcZkFzpldMD5xlnLtPXzBQrLeFDx8Q1Xa+P5u9SWe6E2a0OVuzKQ1eAT
   cOeAxqipkZE9rxJ6VnKTAx25GITDd6xNo5CwLMub7mYXy9Rslboxq29aZ
   UQ9EhXbnGwaLutL2FFIN91GOj38+ig7nHCcB3TyBbIHyusLbQzvJ+8F8k
   qdybq7yPGCQE9kOHVJHwUHFFmZOmRiz8Qt+pbWGfnFcbHgDEJ4wkJR9yY
   O8E+911u+oKgs3Ttv2aZGkea5BCM1H6BERSVJfAfCOU+5BBhfs1wfqDTV
   5KFxObyF0TgeVW1N0HeAP7lo+6w8JXtfbURU28KO4gxNW15eBzoJyyy2u
   A==;
IronPort-SDR: d4ODxpObyHpAI+nJ3HPpIhJd8CARiKGFx756czylIyKoImweDmgRkmIL5DHpJtoSF/4TiJcXD3
 FVAEpHvB3d8eYKy8JOBJjAOxnzQmKKslKqDj7n4wL9XnW/rxW77afg/NOTQCPiUbTPVgN6RDFM
 W9ti0SHWzw/FH/uz5CcNf1duFLkkcRxU6U6Fx7/a2+BQ5KbZqoGjdhQjlsoeXbKN6ZtpRANJjt
 JV+rpAabE9zyMSJ9+RDj785fM7SAl8OFiOacZzt1myDk5JXwUjn4FSmzNV4U1t3lWGoxFk2pup
 5+0=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="269301769"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:36:32 +0800
IronPort-SDR: fh4Lnswaaq4zngPDsRlbXuAvGn2zTGS8MKCP0oQdm8xZL4gVbC7pKjFbbkjr1ayvpfe9LadAyd
 tzcJUfTWzXK23LBdoYqN5BFxxIpOSiT+ahZyTCOOsoTWkH0NIda8G/8/brIfpMJF/nATWSXYPB
 l+r2PSum6UDWy6sSN1K5gGqpIwfVr4OW1MXWbkH7Oi3NJzbjc7MAfcVHR+Ar+CWkiNGT3XE/ek
 FUo1seW4hPA3fsyD9N8YK6yv9LjVmXy5A5pB6W4MMSDCvkr2C79ye4rXWcXZUq7fvkz49yAkUP
 OMSERmvYTUWFFmbJehDJkoJC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:18:42 -0800
IronPort-SDR: GEPPIz8EZzMsuZwtJ+UEA/QeJmUIPYjG4hzy6QCEYBScfy+GYPk6pRad2uTLjxL17sAKbIeFFW
 rDbn40V9XciOxmmniyR7oGKtyCDpBkIET9y34lP4LSJnFkVNHbGSjfT3Dvt1qKDSb4txeujRZI
 f+GcXFVvpuRF4e6vgsUjPAsVI3mNon9muZnDBX2swZ1VkEMp2Ml7N4P1ovozL1e3twk+CSbGno
 E33k2xbTtgxsAdYBtmKt+z1SCsSa3gkae2hyrQqM5nslZxRDzsxNrYJJwy3VlUCTWZtTeJL4Yj
 n5w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:36:33 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 05/20] loop: use snprintf for XXX_show()
Date:   Mon,  1 Feb 2021 21:35:37 -0800
Message-Id: <20210202053552.4844-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use snprintf() over sprintf() which allows us to limit the target
buffer size.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf2789f7e6ba..3f8d9bdfc16e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -806,33 +806,35 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
+	return snprintf(buf, PAGE_SIZE,
+			"%llu\n", (unsigned long long)lo->lo_offset);
 }
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
+	return snprintf(buf, PAGE_SIZE,
+			"%llu\n", (unsigned long long)lo->lo_sizelimit);
 }
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
 	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
 
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return snprintf(buf, PAGE_SIZE, "%s\n", autoclear ? "1" : "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
 {
 	int partscan = (lo->lo_flags & LO_FLAGS_PARTSCAN);
 
-	return sprintf(buf, "%s\n", partscan ? "1" : "0");
+	return snprintf(buf, PAGE_SIZE, "%s\n", partscan ? "1" : "0");
 }
 
 static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 {
 	int dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
-	return sprintf(buf, "%s\n", dio ? "1" : "0");
+	return snprintf(buf, PAGE_SIZE, "%s\n", dio ? "1" : "0");
 }
 
 LOOP_ATTR_RO(backing_file);
-- 
2.22.1

