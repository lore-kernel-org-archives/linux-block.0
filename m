Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80226C433EF
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 01:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiC3BeJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiC3BeG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 21:34:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0301717AD
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648603941; x=1680139941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5aHkV6+rAGtYgGTmYFJdF85HBK6nztvzU0n+dzYbdIw=;
  b=Z4NyoYciJEEeKWMIIdwXCv26LwfZjd9SAcOoUjKonCLV8r/0bDU35COt
   0yJtJ8h40eFkQpOgG89pND7ykVIQSe4FLX1neNYYtgT5uO2VAJmFyWxun
   rZIgF5dbsApqzLdwAdLLsMwIuxvOqRymkz0zNvdNw7EatZ4YzGJJ4f2pQ
   EBQIKtBta+n4N44HxcNE4eRTClhrkX1B2yrTZGGQQRNI4iEBdmtV1/11p
   tWqHSCmUePZ272U6XN8+xAVM5FnM7c28N8zNdvYibCNmIVJ+9OatBEqeQ
   Yua3BZeFbdf3aRuiFJ3YuX8V96cJYyV2hfCjo3NKHKCqGbY8IT13Gu1SA
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,221,1643644800"; 
   d="scan'208";a="201439160"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2022 09:32:21 +0800
IronPort-SDR: m7/jtkPgAcYs82yEfxq6UQTDdzbbqWOEEgPrphcobZkeg0eRhVnJHbvBeDv3xF17J+fv7oRoD4
 s625M0vsDwXA4dJtL5bDBf/1yc1qGg8Nk1uG4IkgLiM+6m/oWP1+NgHOYLuAb73ya9mfdh306p
 0djBdAmDMl9K9L4zxX7u3ucHtIvWLoSYlNm7ba2/GqfYGLbhLaQdc3fiLHVgkDjl/0Ywn7a0aX
 qnvUFvI0uNW96pVt3U+Ugltl6idXDGQ53qc4zEkqyL/YVNH5ZNyMTYRso0Z5/ZlSh3LaDvU2Av
 Hg8OovKdStKJRP8QLYlautoN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 18:03:13 -0700
IronPort-SDR: O01J147aaaYj8Rlz6pNwWpe96swyuQUQbGQkv4m7O2qXm5iEeODHNK/j4hrFCRDkrkZIFhmHyp
 xW69pznqWLurRUax6JezaZ08HXxuvK4Cdp8F14+9hscNnDeVBrU8hdqmc8rdEUyoaFC6kZ32Y3
 1ABw2f+7DATvKVyEikkWe3eS2u/HWTFwNtrhq3GgH+cFjnNPfz/7qIAZTAjohtMIL/HljTepJt
 sqbGeEUMzfWaZj03tncBsW+JC8Ab3Hc7ILdxJIvyGTtFPh2ixt9E4NPdqUp9Jy/UbN018Cezv5
 KME=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2022 18:32:21 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/6] scsi/006: whitelist for zoned mode
Date:   Wed, 30 Mar 2022 10:32:13 +0900
Message-Id: <20220330013215.463555-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
References: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define CAN_BE_ZONED=1 in scsi/006. This test case can be executed
without problem against zoned SCSI devices specified in TEST_DEVS, such
as SMR HDDs.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/scsi/006 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/scsi/006 b/tests/scsi/006
index 05ed652..74df39d 100755
--- a/tests/scsi/006
+++ b/tests/scsi/006
@@ -10,6 +10,7 @@
 
 DESCRIPTION="toggle SCSI cache type"
 QUICK=1
+CAN_BE_ZONED=1
 
 device_requires() {
 	_require_test_dev_is_scsi_disk
-- 
2.34.1

