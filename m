Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A274C001DC
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 07:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGSHPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGSHPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:17 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BBC1736
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689750916; x=1721286916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WERDZROZ8kUNfcKK8O+apK3tBjtGrS7Ji1//OKmLZzY=;
  b=kmmSHts+mm+hZJrKeA/Hn2wzLI7wOI9cslO6qoZ/BZ6/wwNtL7cZ9AMw
   p3Y4YCVVkGsnL7/5BnkeloF+U7NYKfWXNE7zUAhywKkPFSPta6D3XZM6T
   nFck3YUV4tesfcvgYI1UEmqKMY/nujZLBbiiWXWrCmLOUFw3R1h9tgfPF
   8YYrgaNSbZ41cFOdrCBUTiKgHo70PhYIzBHO9qIacPGcRSzal408721kI
   bBgaiTAUjJr2Zr9Ce1UyyJEp4jzyUxRLZ76OvEFcaq+muDMLXA0RitJWs
   OjGKN1Nxn80o7WedzFKgIIf8M5yUCMaKrJyMTvRT9LEQGt0fR9MwaWpdi
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208";a="238846525"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 15:15:16 +0800
IronPort-SDR: qziA6LpH01vvy0hmxnhUq7bNyY6+43e4be6BgTzrtT6GRkRPZTjsiBpmHvu+QNALxta45BFues
 CdTygJAwypwOqb1wJEucPuW+icUOcccO2uQJ3FMr99/cRYHFQE3d/Q6ylKXdrP572ImHEHOntK
 lDdSNcSktUS8b33Pf3kFno6ZxnVxjvo072YQhQp/fc54ILSlYshuOyd3jQvZI/05YmnkxWNuYL
 fYv/b11IRFkZLti/qmYawlt5S7Emv3N/7oqon4Z/Mt5ewUQApu7jkkr/VZe3ziwTnk0cRHGQAj
 FkM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2023 23:29:08 -0700
IronPort-SDR: dvCXn4AvVLWl9E8H2Bj1MD1XpKA/nY6dTUN6c9bYEbJv9jkd2r0xHSvWFBxGciwGun1XwU0Yvq
 U8sj9yRU7TEOtfqVTjfDbr3UWQsWorEdjW3NHK6gnkKqxSKS5FAyuU25YSzgql7FAZ1GliMMtU
 GsaI8VcpQLaRJ5kbZM0UVNrJNRHk3l+q9DrSpkep0IVAUuGLqwDcZ/k4NdWqJNHw5XMbb3FlMs
 +neVSZaHREyIE8EwRdTdVFfCpm+iBIavjuTEbsHtXRqxvVhq7gR1iTYSxpfd4BTlL2co66TS+Y
 egk=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jul 2023 00:15:15 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 6/6] block/005: require queue/scheduler sysfs attribute
Date:   Wed, 19 Jul 2023 16:15:10 +0900
Message-Id: <20230719071510.530623-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
References: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case block/005 does "switch schedulers while doing IO" then it requires
the queue/scheduler sysfs attribute. Check that requirement.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/005 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/block/005 b/tests/block/005
index bd04a00..6a58da0 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -14,6 +14,10 @@ requires() {
 	_have_fio
 }
 
+device_requires() {
+	_require_test_dev_sysfs queue/scheduler
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
-- 
2.40.1

