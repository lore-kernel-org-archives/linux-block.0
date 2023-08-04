Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF390C04A94
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjHDMUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjHDMUJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 08:20:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD446AA
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691151608; x=1722687608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YieW6eJRQOzF8ZkbYvqrh4aUKAw8ugK7F3X7svdaFdM=;
  b=DcfWPaF7v/qzGqAu/StQRxwKo7T+EP36ae5ST4y5JZIBPyP4WmSeUcLE
   kItzS3mZ6egEZhiq4I4ZsKiH4xXN/czJnLTwjwcnviFPfhFPXloFlctjH
   fr2AWvh26HS/Y5qn20lwbJH5+eW7+QZuGG6KMrlVghWSiEqsjoW+K/Qc8
   74Du1+L6XDBLeK1G7vErQK/6V1fmZKm2GMigLy1FDSznfEllvkJPl1931
   x0ZylyNYegHV7cOd2OBNLHSyZRoO6Z1UDr6djDmVCBu2E879z0RMVK7pa
   Zzx7qSZR7EI1F9XKdI3T3HM+3d20IBNBHjRzNRH3SCXo1pkFrhPaz21E1
   g==;
X-IronPort-AV: E=Sophos;i="6.01,255,1684771200"; 
   d="scan'208";a="240463428"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2023 20:20:08 +0800
IronPort-SDR: MWW0DSiyLw2xaWxtjIi5hS5kcjtBE/BToqyN8cz6K88/osnlMak3bRZJCBb6ZIKR7ryUaqLuUI
 vvALETDCNtok4h+BbLF0R4JVzLeNQ0JQv2+86qtLpCXzDHmKcFhO8vTJULvyeYHWj9aP6FWSk9
 /LqbMuVMI9OgNFD0PzJwhQoi72wtjaFxt/NYsRQEXwxYVJZDMTKDLRXPFOMRifzN+2s16dypP+
 R32wC6oDpGjfNcTVt3kto0HIeRWaSv3cof6bHFwED8XIo0PJgX05/QqeFN7iuWyA+ZPJQy9k3K
 5Uo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2023 04:33:40 -0700
IronPort-SDR: lx0a0MCjc/2o0r4HhYsDwTNHy8COqvzkF0xVMmmtkxSvVdd353kndLzGaZUq4qLXxybaQzmTaI
 /5/xQ1bkyW9hkcXaEFEp/C4d22hKrv/x9MN3BlIZUfWl2TW3LxrKo9fkUlNMKNJS90mzl2Tvtg
 9NB9J+iSrQYgCZ4Wm9KI9kPQlvU+d7SUgvWqSQ5uI8Lejg9rBbFURfUaqe4h2qkC2uFRI7aRJD
 rY0d8o3x5uMR6yPhKxAGpYwjnwnLquGDDIlaOXdfQoof90V3yQWkTGO+T6+d7GR6ua0pltnd58
 fCo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Aug 2023 05:20:08 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/004: reset zones of TEST_DEV before fio operation
Date:   Fri,  4 Aug 2023 21:20:07 +0900
Message-Id: <20230804122007.2396170-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When test target is a zoned block device with max_active_zones limit
larger than max_open_zones, fio write operation may fail depending on
zone conditions. To avoid the failure, reset zones of the device before
the fio run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/004 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/block/004 b/tests/block/004
index 63484a4..52a260f 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -15,7 +15,10 @@ requires() {
 }
 
 device_requires() {
-	! _test_dev_is_zoned || _have_fio_zbd_zonemode
+	if _test_dev_is_zoned; then
+		_have_fio_zbd_zonemode
+		_have_program blkzone
+	fi
 }
 
 test_device() {
@@ -24,6 +27,7 @@ test_device() {
 	local -a opts=()
 
 	if _test_dev_is_zoned; then
+		blkzone reset "$TEST_DEV"
 		_test_dev_set_scheduler deadline
 		opts+=("--direct=1" "--zonemode=zbd")
 		opts+=("--max_open_zones=$(_test_dev_max_open_active_zones)")
-- 
2.40.1

