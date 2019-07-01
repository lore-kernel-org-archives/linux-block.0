Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D28C4646D
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0F821479
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SG6nNlNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGAV6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:58:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56724 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfGAV6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562018291; x=1593554291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=b0wGW7WtfWxUwKfj2wVFwZxNHKIT6iMJAeEE2CY/GA4=;
  b=SG6nNlNiJDoIOUPgDjDT1vEwCaQVHRxjRTUDPplqYINBPUJeG8vtgEMZ
   SHI4HrqsJSIuUNP5KVOT2/MqKFd58+QJ4Gp+Ne9Knp6WWWE5k80YZRkiV
   +gq6av/fAFiDEJbJzG7GMA/dMFW3+GGq+hrRiZ9dFFMLfTxoSODHzdczj
   6lq1TFpCKWG9SOVKFiY+ytJ320nuBtvkAB5/WK/gwrBRlzN0EwTv+Nwu4
   odEY2VYvS/0XOWJ3DFX1QsXX3y/CO0adbC9aAF2Ecm22l7Qb/rH01k8ND
   B3ERhVhcb3X5jveK3wZ/Ix/HI8zXHP5nMEzOYERJZrkV/qQdgkVuuMwPE
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="116844042"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:58:11 +0800
IronPort-SDR: EVsx4/4XKkXqYlxt9dv6fEAKdFor7neKkpSKkUHf9yYsSYH+dGVXgjgTx1qsRJWxIvUyjYMHIP
 I18UOf+7JgZdoP9g5a4EHcms9zhum2A2/PAdrYYvjvegDU2kutHExz7F2mRydk3qDbzROxgi54
 PPcpu+C9Q5r2KRGqpluZJ3eh74NjZN+pdD9zEUVOcK0WDfaAL0edbV+9Fx5WRvU+KW3+9H+s/U
 e9yrbDzXgSttP06vCjU099bQ7UyGqkVJU8j9/J+M6ZMmRw+ckWjdrtqWQDglIaMIKDUD0XRca4
 kG5WqQUllHpQ1DimyqDpHACN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 01 Jul 2019 14:57:13 -0700
IronPort-SDR: AABjtBQ8ZjxtlIypq0AuDMGuICj3Ru7OQR6RTokwwI5NwnheQDs9XZu6EHSysDkGvnSbjLSLzk
 svQHsZ3L9KuVfcFTjFKgPOsuSl7tPlG11lsjBb8z5kXGyUSeWfzv8y2JNrHN9XFqAP9GIoh801
 6/k7//Wxd+PiVP+eMja3fbegfEx0pWIXUEx/YSComqBkOzV5tvEeCB40Ty18Wl8YUlGpamcA0W
 YnMn0/OE8nFdC37M/MT1FRhMxXORwaN4jwQ92KCK2O3IsgCDvM1qCknYbY7bB2yB2W4O2NYyqp
 t5U=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2019 14:58:10 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-mm@kvack.org, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/5] Documentation/laptop: add block_dump documentation
Date:   Mon,  1 Jul 2019 14:57:26 -0700
Message-Id: <20190701215726.27601-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch updates the block_dump documentation with respect to the
changes from the earlier patch for submit_bio(). Also we adjust rest of
the lines to fit with standaed format.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 Documentation/laptops/laptop-mode.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/laptops/laptop-mode.txt b/Documentation/laptops/laptop-mode.txt
index 1c707fc9b141..d4d72ed677c4 100644
--- a/Documentation/laptops/laptop-mode.txt
+++ b/Documentation/laptops/laptop-mode.txt
@@ -101,14 +101,14 @@ a cache miss. The disk can then be spun down in the periods of inactivity.
 
 If you want to find out which process caused the disk to spin up, you can
 gather information by setting the flag /proc/sys/vm/block_dump. When this flag
-is set, Linux reports all disk read and write operations that take place, and
-all block dirtyings done to files. This makes it possible to debug why a disk
-needs to spin up, and to increase battery life even more. The output of
-block_dump is written to the kernel output, and it can be retrieved using
-"dmesg". When you use block_dump and your kernel logging level also includes
-kernel debugging messages, you probably want to turn off klogd, otherwise
-the output of block_dump will be logged, causing disk activity that is not
-normally there.
+is set, Linux reports all disk I/O operations along with read and write
+operations that take place, and all block dirtyings done to files. This makes
+it possible to debug why a disk needs to spin up, and to increase battery life
+even more. The output of block_dump is written to the kernel output, and it can
+be retrieved using "dmesg". When you use block_dump and your kernel logging
+level also includes kernel debugging messages, you probably want to turn off
+klogd, otherwise the output of block_dump will be logged, causing disk activity
+that is not normally there.
 
 
 Configuration
-- 
2.21.0

