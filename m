Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E06CC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777F360FE3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFVXWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:22:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13320 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVXWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404036; x=1655940036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9nbTJ+gg0XaJsT5Gy2yJ9AVn3OP0irj0uDzoD29dxVQ=;
  b=kUqcHLcHCMIgIpBo3UHXQlP8PI0UzB5gSwSXt+hf6cM3yxvGDWhwIspK
   r/WQTrrazP0T8NMKmQmq4X84WFIZPVV75p+ksV/Vx3pLyiY9qDHEIYXo7
   yYqEoShnnO0UbbrGFdwxdH463wSge9WYZ6Tz6DrzVpEDpr1Q4cm/lJZxc
   ZtLc+d/nVSbEQN6BgOnu9UI6uL41X7iJgptbF6lUY4pjCNCP2KhWQ3Sk8
   Zm7JG8IMpSpo9twWIEkJG6usb49KW8e5yXnwko3cbIoo7Oc6JK7v1muu7
   8TjavV3BgORqzDkFrrDAYKiVBcAv4cdu4Buom524U5AV68f8K3/yMCVMx
   g==;
IronPort-SDR: m/ZkQp55GIk83ib8U0JYJ5s6pMdVRtMebJVOw0XCp1jygPiFoKjPGQcVHZT1h2fpwteQTAnNqI
 C5brLcTPQWpAmvQXsFGNC8FI8QXwsuCi9B33+4ycqJU9dSAk66YbMjG669OEfhj2rD6CgDiilc
 7GaVWvg4m5x6v9AD3SVNYiNGGXpzWhVZK/N3mhxyupB0h4oFauaVJGcGTpoDuMax+oi1294Lhz
 fIvoaNSgjO/gtlc/G5l3bIcQNOvnVNKcsMNFCgWE+2w91VfnMBOZYbT/qNIRV+SCZX/WGaZF5E
 TUo=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="276419106"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:20:36 +0800
IronPort-SDR: RpCT6o9wkGQwO9o5DpsI2XcXzeay4ejT9pDPAfAaNMo8jh7Ip61LyjetRrWDwCcjqPUDWbUK6n
 EU163PD+s3/PGj4guQDDgwc5kx8/y+MCWPkizDsDZa+7Gl//SHMdpGeATwI9HihYb/PgDJhU/A
 NK3rRmaX3cfNDI83k6oALl99Zx0BVt6WQMKp5NfA+pr/xH9jfBujok/9y/YTsoUpklIF31AV5i
 Cr0cV9m/IH6x85k6CPTba5ONYKex1x7EffGy02+9WO9HqEIrLXT9axZcFzI4GLPT3NRyJ/V38F
 dQt2sl3Lkr8CobQt3N1pYLhX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:57:47 -0700
IronPort-SDR: k5PmqSZMGU6Q7TGdlg9UfSZRxuLysozXpuLyxkFz4ADR0p0zj4pA9FYVj9EhKmoegs2hqlTNJD
 cU+q8vUWFY9c+1t5IKAUO0mvnRHvAuy51ao/2YeXyUyUYkAsfLq2c8HxOA6Bom+Mr5W6rkT6gZ
 GkEkGQ78sZ5h8orrgSrM4Dn82aaqI0SqBLkqEg6ce8rxcTteiZA8yoWdOPTKbP2z2oCrHjzoJe
 y2IOSfcaGZ+8kOEnp6eORm/OCgof6yd952PDcd8coz0y4inM3R1jDF5zIvFGcQTSAI7xSkGXm3
 B+g=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:20:30 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/9] loop: use sysfs_emit() in the sysfs autoclear show
Date:   Tue, 22 Jun 2021 16:19:45 -0700
Message-Id: <20210622231952.5625-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for autoclear
attribute.
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 084fa914a399..3b11d9f21018 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -819,7 +819,7 @@ static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
 	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
 
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", autoclear ? "1" : "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
-- 
2.22.1

