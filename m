Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D433C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD2420700
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DODzmeBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfBTIMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:12:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33059 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfBTIMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 03:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550650369; x=1582186369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36HgFHv8uO7kYgOmbWwJe/pa53EhS+fSa4xy9BBm11s=;
  b=DODzmeBak5qfyinnnpYaolZtsj7dBsa5b71aMnZ+7xtZyLmL9bFekSsg
   nECX2TWxmCpjGLZg2gy2Ob9fIwc/tk8wVC1YsOir2kmyKYhICrLc/Naqp
   NQvufA2vzu9Xs7aBOgTUp90N6z4oGTxuWzGUKV9VzBRIptx+KCTniGwI2
   /xFxZ2SIJMUTM/gojiVBww4yvmV6PmjriPZz22Y+PQGrdpYwnEtiAKfV/
   wtUMWfPD3lFQ3zHE2tlVRwPMnTb4s9Nh1q021bOu+Exk8jdkZJdBRRqcT
   +BHvEyIxn0yFezeyRGBt40TjRzNv729lkTB/rFNNYv0LjhOJbFl+8WhXZ
   w==;
X-IronPort-AV: E=Sophos;i="5.58,390,1544457600"; 
   d="scan'208";a="106682987"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 16:12:48 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 23:51:11 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2019 00:12:46 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 2/5] zbd/004: Add zone condition "Closed" for sequential write required zones
Date:   Wed, 20 Feb 2019 17:12:28 +0900
Message-Id: <20190220081231.15366-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case zbd/004 executes write operations for two sequential write
required zones across the zone boundary between them. After the write
operation, the second zone has non-zero write pointer. At that status,
the zone can have not only "Implicit Open" condition but also "Closed"
condition based on zone status management logic of the block zoned device.

Add "Closed" condition to the zone condition check logic in zbd/004. Add
ZONE_COND_CLOSED constant definition in zbd/rc.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/004 | 9 ++++++++-
 tests/zbd/rc  | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/zbd/004 b/tests/zbd/004
index 291626d..ac0cf50 100755
--- a/tests/zbd/004
+++ b/tests/zbd/004
@@ -83,7 +83,14 @@ test_device() {
 	_put_blkzone_report
 	_get_blkzone_report "${TEST_DEV}" || return $?
 	_check_zone_cond "${idx}" "${ZONE_COND_FULL}" || return $?
-	_check_zone_cond "$((idx+1))" "${ZONE_COND_IMPLICIT_OPEN}" || return $?
+	if ((ZONE_CONDS[idx+1] != ZONE_COND_IMPLICIT_OPEN)) && \
+		   ((ZONE_CONDS[idx+1] != ZONE_COND_CLOSED)); then
+		echo -n "Zone ${idx+1} condition is neither "
+		echo -n "${ZONE_COND_ARRAY[ZONE_COND_IMPLICIT_OPEN]} nor "
+		echo -n "${ZONE_COND_ARRAY[ZONE_COND_CLOSED]} "
+		echo "cond: ${ZONE_COND_ARRAY[ZONE_CONDS[idx+1]]}"
+		return 1
+	fi
 	if [[ ${ZONE_WPTRS[idx+1]} -ne ${phys_blk_sectors} ]]; then
 		echo -n "Unexpected write pointer for zone $((idx+1)) "
 		echo "wp: ${ZONE_WPTRS[idx+1]}"
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 1d6f80a..c32bf31 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -39,6 +39,7 @@ export ZONE_TYPE_SEQ_WRITE_PREFERRED=3
 
 export ZONE_COND_EMPTY=1
 export ZONE_COND_IMPLICIT_OPEN=2
+export ZONE_COND_CLOSED=4
 export ZONE_COND_FULL=14
 
 export ZONE_TYPE_ARRAY=(
-- 
2.20.1

