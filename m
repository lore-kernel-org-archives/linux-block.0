Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335BFC19F3A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAF86140B
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhHPBpo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37276 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhHPBpm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078309; x=1660614309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j+YSu3G8m1N242e8AZ8+DtgpNOkgeoLoxwljEWU6T60=;
  b=BQDqvFrkU4BUxVs0bV6NCTKMJfX7sV4S8e8wAxbWBIS7IAEkCq6wYT5t
   RfdRP1ZfUU2Kn8nfBf/jx1L/aseFZx2bm9GiHajaR6MMRSwJdIkhpIkRb
   tywXDdvmnST9MiGYeTyhDAk3+jKf/R2/MQM/rPDQfcSlknjNM4MSBNnBx
   UeTELyqPVD6t//aChnh6dAVqK+XbPpmtf2Scz9BDJuryuP9hnLfndkrpX
   x/MhS/shqcmMF5T9IT6L2bTzO/qg2g4Db/H/2lV4frTO5EddY4AwnXseR
   qkjqS8Ygi3ObE7SWkR7P8n3sD+wu9tFK4aYMOg/drUbEJXXk+/ohkH7zz
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326727"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:45:07 +0800
IronPort-SDR: I4bXPIJ4FwJ20KkNTwmpwJvAPVNVid9LA0/ftvaw7C/uYSHWDDC+C/shtMFIQ/OKki+2Eot76M
 YmlL5C0etxpN4xKaz6iORkEkVNQ/CPwihGRIQpWY1v5LWGxOYn+nLO7JbRn4IPSDaUyUYWr+NG
 RTOsyTt2zrspPNbQ+jgSr7oqZSFuGXP7amUos6dhrkG/rdwbg5f3ejDfHNPeDUJoXzZNHVztew
 CXs3SOJPmlQ0vBjAdyskusI5R1kbBfvS+wn3wy2THbQOa6Kdu+EYCty9AMfkNYJfHJP5nXse89
 LqGaQTn9GyF+nIZd3IdYAIIp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:34 -0700
IronPort-SDR: pX/X+1huhgyGVj2GKrWSu3okC5q4TmEHNcU+MAUGjtQuV2YLIyysfJSAG+wBTcAhldzcRHjG1L
 lluMnVrCTK6qG6Xp825SgVyV0ozvqQKDy3ZeDNf/wex+xSWC1IB89rEoGLcVnCh/N7USBMlAYQ
 xQ6OKep0lbRkuaDE55dYD1Ho76TxWxqbTf1oTJAqX0DF6PDZFfvi28bXum2WIXouQ4iIVw/oAM
 ai7noPfAAnRtnvZ8WDwrwJlUeq0kjkgIErsEsNxsHodxjoAe7PSLj6pSx8TGYoWmNgi0dkHm1k
 K8Y=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:09 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 11/11] docs: sysfs-block-device: document ncq_prio_supported
Date:   Mon, 16 Aug 2021 10:44:56 +0900
Message-Id: <20210816014456.2191776-12-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add documentation for the new device attribute file ncq_prio_supported,
and its SAS HBA equivalent sas_ncq_prio_supported.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/ABI/testing/sysfs-block-device | 25 +++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
index cf1013df4b92..7ac7b19b2f72 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -58,7 +58,8 @@ Description:
 		(RW) Write to the file to turn on or off the SATA NCQ (native
 		command queueing) priority support. By default this feature is
 		turned off. If the device does not support the SATA NCQ
-		priority feature, writing "1" to this file results in an error.
+		priority feature, writing "1" to this file results in an error
+		(see ncq_prio_supported).
 
 
 What:		/sys/block/*/device/sas_ncq_prio_enable
@@ -71,4 +72,26 @@ Description:
 		(HBA) implementing support for the SATA NCQ priority feature.
 		This file does not exist if the HBA driver does not implement
 		support for the SATA NCQ priority feature, regardless of the
+		device support for this feature (see sas_ncq_prio_supported).
+
+
+What:		/sys/block/*/device/ncq_prio_supported
+Date:		Aug, 2021
+KernelVersion:	v5.15
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RO) Indicates if the device supports the SATA NCQ (native
+		command queueing) priority feature.
+
+
+What:		/sys/block/*/device/sas_ncq_prio_supported
+Date:		Aug, 2021
+KernelVersion:	v5.15
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RO) This is the equivalent of the ncq_prio_supported attribute
+		file for SATA devices connected to a SAS host-bus-adapter
+		(HBA) implementing support for the SATA NCQ priority feature.
+		This file does not exist if the HBA driver does not implement
+		support for the SATA NCQ priority feature, regardless of the
 		device support for this feature.
-- 
2.31.1

