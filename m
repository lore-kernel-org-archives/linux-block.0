Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C0C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC1B20700
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EZCzLhWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfBTIMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:12:47 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33059 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfBTIMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 03:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550650366; x=1582186366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LvJrlHnRZmqL4mGzQKasZJBL92POFQ4m97sZWudPadU=;
  b=EZCzLhWIf7MN+SRTUYhK2YaSzQlv0razHgs2437W84OvBuo0ArsJPYnN
   GVD+EwvS1De+XZdX7yYvBvEwkypsGGS1MAO8tijXCiGfW31Mr6XzukWIK
   DOka142/ugRhnBUy2AQoQCI22foGacOxDeqGVK+JCYsYeGPSx4rrk4vwF
   R3baMuJbA4OVZ0WDZNCbgy0lv1XVHOAcyGEgeBdmfRXDNAgDIHpPNOK0M
   CSspr+gW4j2z97h5ASSVhNk6ueVPeZ+qfVsHjjOjTJHP/qy3j+x0TAOv2
   88K9Es5ztGlvm3KIxXW0upIgz11oj4b0kyuSp1zaKIgU3FxxjR7AmDBDQ
   w==;
X-IronPort-AV: E=Sophos;i="5.58,390,1544457600"; 
   d="scan'208";a="106682981"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 16:12:46 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 23:51:09 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2019 00:12:44 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 1/5] block/024: Increase I/O time
Date:   Wed, 20 Feb 2019 17:12:27 +0900
Message-Id: <20190220081231.15366-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Masato Suzuki <masato.suzuki@wdc.com>

The total time spent on write I/Os for the 3 dd executions will be at most
1500 * 3 * 0.5ms = 2250ms, that is, 2.25s. Due to system overhead and
timer triggers, a total write I/O time larger than this value is generally
reported through I/O stat. However, for a system with very low overhead
and/or very precise timers, the reported value can be under 2.5s, leading
to a rounded value equal to 2s, and not the 3s expected.

To avoid the test to fail due to this problem, increase the number of write
I/Os executed so that the total exact I/O time exceeds 2.5s, leading to a
rounded value equal to 3s. The change increases the number of I/Os of the
second and third dd calls to 1800, leading to an exact write I/O time of
(1500 + 1800 * 2) * 0.5 ms = 2.55s.

Signed-off-by: Masato Suzuki <masato.suzuki@wdc.com>
---
 tests/block/024 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/block/024 b/tests/block/024
index cf14707..b40a869 100755
--- a/tests/block/024
+++ b/tests/block/024
@@ -53,9 +53,10 @@ test() {
 	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none
 	show_times
 
+	# 1800 * 0.5 ms is 0.9 seconds.
 	dd if=/dev/nullb0 of=/dev/null bs=4096 iflag=direct count=1500 status=none &
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none &
-	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1500 status=none &
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1800 status=none &
+	dd if=/dev/zero of=/dev/nullb0 bs=4096 oflag=direct count=1800 status=none &
 	wait
 	show_times
 
-- 
2.20.1

