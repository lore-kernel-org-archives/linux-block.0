Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B4AC28B2B
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 01:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiHRB0e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiHRB0d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 21:26:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE99A031B
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 18:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660785992; x=1692321992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gidMCjksyDoobZco5DsPMXmlo5oysRo95C8k0fCVQHk=;
  b=K8+5sVN5N+siSoMYjwEFwbTZs7fPXEHm2RnJTEs4XdS7qZQG3cB7liWa
   +Rf138kab7y+SgQVplOdeRJ1G94Pm12nK6wxR0/b1Drw8i/TMjVh+SWoA
   t1o3rktkWEd9rrph+ahuS69OFfM4lTMAyWKucIIeQojSsAnDEYA2z958r
   sv1A1pzbJMmbqD2ojYsWcB81zvPq0thb6EX7ZCqFwCqLOuVzNZi9KgbDR
   n7eM0C31MQEJXvMDNpyAeZV9q32vnNvGd1hXvpCUZPg83aKSFy0zSQeoU
   aF+FquQVFLxuYR6DJid0oJx41F2UVyF1aiOLBeMet4CUAEYzpRB1RqLYN
   w==;
X-IronPort-AV: E=Sophos;i="5.93,244,1654531200"; 
   d="scan'208";a="321085647"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 09:26:32 +0800
IronPort-SDR: uNymg+GCsDhwO3Vo3IJXUfmGqNBT/bNahLgXV8o/QjRTTAYxUuGK5sSqbbpmXp96cU+9q0gaIS
 Qguxv09+Y+sZaPe1GM6N7+oF89CroGR8nyaT+X8eXSjqEMfCFgGQAWHGjUxCbDrL1H/GqIrnmx
 9tAQxlyG94cWdr4JNgeb0NBaRNOUmRdw/dDSNQ7tNuHiFePlDNGNa11hHW1yz2RmgW6VQBYeYd
 sEGT2M8Bmdlaii9rViaU1bu1Qb8fpNR6RS7mSfuHUq60A9VgqqyVd5OH/x0h+mgVIrg0FIfwog
 0dNaVmZSuJCXvnV+Xty4WpEk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 17:41:59 -0700
IronPort-SDR: We15CybPik55AKWzSPc/BJp3u9isR28UR5vYDbOYp38S47x3gkXW8wnrIVin2uHhK+XpOxwMuK
 zRpC/shlKljcNfo2ILwtjzPUmOlO+Y2xgyiNDTQbiJW9Uvc9bw/cICrbTH//jscsSRKP3d92S9
 lL4eJLtKtWb2ETqD+mGBCtEa8ywGTDkDepbjgSQQ5MsEYkTUXMsll+Ic9qM/785+LFUjvjqw/D
 O2uGd8Z0FIdaqeO+qPsHGlwGqvfuYXet5eqm/cGS0KBApSlb9A/42ngBptb88y03siaKbR7ePU
 2Ws=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2022 18:26:32 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 6/6] srp/rc: allow test with built-in sd_mod and sg drivers
Date:   Thu, 18 Aug 2022 10:26:24 +0900
Message-Id: <20220818012624.71544-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The srp test group can be executed with built-in sd_mod and sg drivers.
Check the drivers with _have_drivers() in place of _have_modules.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/srp/rc | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 94ee97c..46c75c6 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -28,13 +28,18 @@ is_lio_configured() {
 }
 
 group_requires() {
-	local m name p required_modules
+	local m name p required_drivers required_modules
 
 	_have_configfs || return
 	if is_lio_configured; then
 		SKIP_REASONS+=("LIO must be unloaded before the SRP tests are run")
 		return
 	fi
+	required_drivers=(
+		sd_mod
+		sg
+	)
+	_have_drivers "${required_drivers[@]}"
 	required_modules=(
 		dm_multipath
 		dm_queue_length
@@ -51,9 +56,6 @@ group_requires() {
 		scsi_dh_alua
 		scsi_dh_emc
 		scsi_dh_rdac
-		sd_mod
-		sd_mod
-		sg
 		target_core_iblock
 		target_core_mod
 	)
-- 
2.37.1

