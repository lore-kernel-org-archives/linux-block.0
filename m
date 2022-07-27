Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42936C19F2D
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 08:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiG0IxA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiG0Iw7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 04:52:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B772046D8C
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658911978; x=1690447978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FuJxPAQuEVxYFqdrcw7CgJn80w9jEhJ0pB1tM1eFiZY=;
  b=bcYUyUVVdbEdRNGXjpur1hV1T+/PJAkKXsSWuLsVYtewcPdnmU/Bkp7Q
   1XECgGmO9ISfEUKpaVq7aMvyvIRcs57GORTWzYMnkyK2y8MBOXsxLEcJZ
   9wq6EidsBwdOZEed+x1VL6lFL28UEeaPHVc+DgoxraQMMbrQg3DW+ldgg
   qnkZrpjWtLWYGdwqScfhhLwYMMgDjZqZK8BfAtOoM0xEMkBM/FTqwOka5
   UXYjTo6kdWJYfaVGOJqF3leHRt++7NsBAGimbEQ209V8NyUX952Owoni7
   qf37iZylisOm6wTueMNL7neVZutu9XpxGwgtM90F6dzXipcruTUSOiYR2
   g==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="205584989"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 16:52:58 +0800
IronPort-SDR: 09+gCHQjgEcL2B4+VwAZkGSUioDvj9Z/bTr/fSTBFZGFHq5lKbR81IDoY5a5f3N/Ti2aAv/Q5/
 pxyWLId9peKLhFsGdvZmTHRe/SqmrcL6Q3BQla19zjCQPnkxUVUO/zrAvs86GNITFtElxor7Tg
 Jwam1Ozm6t06xJTtpTWmtfjLle1hsN2GHYL6sJ4dRh72zR0tPbezKj1skSJNI36ogMlE8kDOEx
 Pow4dS09r7mqawMkf0jIAyjUTUZJzKVLmGJQBzcGmlZMJv487wHj/rBdWttD3owHk+95wLcDAJ
 RfetHZM2MELh/FBfRDulA+Kz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 01:14:10 -0700
IronPort-SDR: hFfG8tBt2UxA3j9/mQu8hNAy5BZQAy1BKWjtYn45sMHyWXcxca3NDlW/oyMQLDwW/OUYFLKHYb
 PrCOqxX4GT6JBd/yD6w8nWaFZEXZHFi3uu8aduA10lKeK3mn9RoYTGProA+5buqUxCegY629SV
 mK9TUtp1hs2eUu49Jl8Fik5g5oE38gBoifJ0Vwl9aFmFKc+bYZFcdscQxYJwKel8Q2b/nRsqCi
 7svdbUBHOZ6uRiN91jqiW78YHwLYv/AOlZ0sAwE+twE4glMgxDTfPc+BYxF6RXuv4cnmb15t0L
 /Ks=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jul 2022 01:52:58 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 6/6] srp/rc: allow test with built-in sd_mod and sg drivers
Date:   Wed, 27 Jul 2022 17:52:51 +0900
Message-Id: <20220727085251.1474340-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
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
2.36.1

