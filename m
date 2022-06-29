Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C7CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 07:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiF2Hct (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2Hct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 03:32:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AEC35A95
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656487965; x=1688023965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aiiCC9IpeXJuLtV5JBDSufrzvxUcHU0jZZyDcb+Omv8=;
  b=Wzml65jwtCTtTwBMn0Hb67S8ku5G3CRk1GVR28g96fmZZTYD5dlopJC1
   5Hi28oQzVjHuxg2LWjJy4cKrGekEg49hApvMs4d7OjuKUt+GQfMZrWndD
   dWZgX9eC7490oJXQ03Jse+1tkr81v0ZJAKUgUaM656AHHQiMUz96Y6W//
   kj8p0N4EBwtDKRapw9/rQotsS46uv/I6UlUr+P9RFZJvkhU/gHchiN2Me
   bRfr2nrsez1hjGmRz/WNqM+XFwZnMmCvWP1hk+Rl1ayHoSdw/GrjK3gTB
   k9oFZHnQASVHCnh8XJ8c0zzPVSQCbeTAwWqC2kPGzRgePT6PSUfYEItWK
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="209235219"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 15:32:44 +0800
IronPort-SDR: 7EvPjDirI6BEAZAbmyLrltd6Ka1+I468EWa2gpGm8zjz8r6oj988q2CP3N4wGuoMRrhgELGC9+
 2PVeTHnubEQuFqthsxAGus3lstMuFg/BsDHW+6JnKl7m0TBckLAe/H/dEsYm4oVh31moQywbPF
 99VcaFCBYi0RrisPkL5Ui0TjfQoRfJ/vxTaJMWC60MnXYA5gUCtEio8LQTD+mGxHJVkzrhaGDV
 gYoXMDXqyVyHcUaakJzRLgsEx7xQ0TcsQ1l0FebzGZks3wOzbbBW+sRMHLRctn6UgdLqxNT10b
 HJwKi97EASslS9UtfmPJHpHR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 23:55:06 -0700
IronPort-SDR: pV+kQSROS/ndjismkgRvouFcfWKTMi2Z/HYHBDzROEF82OQWesVzE9ttJTkaRwG4Z2QXybtrmh
 bG1ugpZoG+fgy4Ee4GyMaMuYUEXPcMXJN8aieMxdIO5MQwTk+QLLQqMIh/Zdl8a1o/PjhFBr7o
 bTD2rVQtlccEM80992GIN1CgUj+9X4Dc4S8AEZrZBMCKe79hXpaPa7ejchmtCODG0vqIs4cWw/
 JI9AefOe8oukIJiHd5/syotiW2IvJPaqSujiJBUZaceFzGCrEgNwNg6QZ/QbK/1IgwWU8q5Lb8
 6Pw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2022 00:32:45 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/007: support fallback device
Date:   Wed, 29 Jun 2022 16:32:44 +0900
Message-Id: <20220629073244.941432-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case block/007 requires TEST_DEVS which support IO polling.
To allow test case executed without such devices, fallback to a null_blk
device when TEST_DEVS is empty.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/007 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/block/007 b/tests/block/007
index a8fe998..0cb0888 100755
--- a/tests/block/007
+++ b/tests/block/007
@@ -6,6 +6,7 @@
 
 . tests/block/rc
 . common/iopoll
+. common/null_blk
 
 DESCRIPTION="test classic and hybrid IO polling"
 TIMED=1
@@ -19,6 +20,17 @@ device_requires() {
 		_require_test_dev_supports_io_poll_delay
 }
 
+fallback_device() {
+	if ! _configure_null_blk nullb1 power=1; then
+		return 1
+	fi
+	echo /dev/nullb1
+}
+
+cleanup_fallback_device() {
+	_exit_null_blk
+}
+
 run_fio_job() {
 	if _test_dev_is_rotational; then
 		size="32m"
-- 
2.36.1

