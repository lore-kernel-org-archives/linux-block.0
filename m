Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A41C7EE31
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 04:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjEZE6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 00:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjEZE6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 00:58:46 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985913A
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 21:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685077125; x=1716613125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pmt7t8vFaRTuFbJrPQjmtj1I56fHkQ5BSpFqy997CHk=;
  b=Z8LFQALq/vCX2KptV4bQ3ei3Y84cPXxIbzsz8CKwqcbdxUgQ+Bw3HQLJ
   G0f8u+lzoNNuCARZVcyvx9elpY55TM+fbrYueR1DFuNuZmGVylylWSc+s
   y72VB/c4JtVPGGj90XOiYqTtjaA4WdTkyt06C0L4ybmUaSuOBVkeeIQMG
   vHul6jVaezuff2DLHM9X1tkXnXviHCTGBIPK+XzwFkFPVblT2bugqU6du
   fOrFUzffTBY76UzDDpZMQ56z46zg0vQ7GXknaLw085ppCSvM7WaHmdwu9
   1pRjNRm72LO2AdpDdnGKVWFsc9cn63pmGdf21FoBfNSsmjMPcQxcOQtV7
   A==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231616517"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:58:45 +0800
IronPort-SDR: w8nSLFXCPNWt9Ai3ZNQtjwUZd1Rqb/5cQ0vIdBeqaMawCUQ1Y9zXXqMOUHe+FXf8xb6UBW33Us
 qfBaDixN44M7WEnuovnelQvU431e68gciM1F+56kT4TjBFP58OnRgbRLnR9WAc69PzKXx44bEe
 cA9Yv96+9OGKZXv5x24wY8u4TgWia9IkIL2YTZFC39aznQIfOaVXc82//ajkWja0CAntZPEjdd
 DcihQNCh5IfCa3LuVgr4Q4eS5fmE5X5zxmGj6C0JyEECnH10Xa2ZFgNC3uCEK7VU8+0/Rwc7EQ
 mNI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2023 21:08:03 -0700
IronPort-SDR: aC1JkN/ow4pe3FcmT3EdEXzfM1Kga/mi5QCAYNqf+JmNjwCu2/SPeCK6QUzYtG1Kkh4MEtHQTD
 bKJIbGAIJ1w0Wz1mAqW67y+Z7dG+jg1Tb8DMTM9Uj3BLQosDIPMiB04EwL3ExdNmvi2SrLHF9T
 Nje8KJwrpwFN9U2iQAm936L5rZoE0nnYjmehtdR3rbGC3yP1KwtvcBAIu/QLYX7GcqsmimfzNW
 p1b2K255p5A23g/rkqhViJHgrr1YiaUrhMg9NFfNnbhUCAnrosHidZJx2tUWEt9snYjehLPn67
 S4s=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 May 2023 21:58:44 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] common/rc: introduce _get_pci_from_dev_sysfs
Date:   Fri, 26 May 2023 13:58:41 +0900
Message-Id: <20230526045843.168739-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
References: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To prepare for block/011 test case improvement, add the helper function
which gets PCI device from the given sysfs path of a block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 57e0f42..90122c0 100644
--- a/common/rc
+++ b/common/rc
@@ -313,12 +313,16 @@ _require_test_dev_is_pci() {
 	return 0
 }
 
-_get_pci_dev_from_blkdev() {
-	readlink -f "$TEST_DEV_SYSFS/device" | \
+_get_pci_from_dev_sysfs() {
+	readlink -f "$1/device" | \
 		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
 		tail -1
 }
 
+_get_pci_dev_from_blkdev() {
+	_get_pci_from_dev_sysfs "$TEST_DEV_SYSFS"
+}
+
 _get_pci_parent_from_blkdev() {
 	readlink -f "$TEST_DEV_SYSFS/device" | \
 		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
-- 
2.40.1

