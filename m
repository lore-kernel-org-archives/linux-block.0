Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC67C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D65920821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RFljwa0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfAIBgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:36:05 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65001 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfAIBgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997765; x=1578533765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKG2vAymaTJMq/foywP3hg9+7yRR5XAZY3FQ7ugAdL8=;
  b=RFljwa0HOId8Px4GyBWRQguFzOTX6VOUGM9OMZBaB76t7jT1EinLNmb3
   d8PJTgDtgY440oIumrMG4Nwl4yL6T0SR5vRSZFRE4qFTgQhJyZ+XdvgUt
   WT4mce3veLpZxDdFF0R5shVWSlR9Zd5x756ZcIG2srN4Xz0oYrXvZYjlM
   Eo/46gqtKp6stJ7fCvwO3/W4ftjxW6xajsWilDVJpSWZW6hy+sJVkNOOg
   642ViqKYqcWGcez0xPtLfqMq4992CZHrzUWpWkE+MHEHGUnBicajeS4km
   Y1yMG1N8DFal5hXq5/QtYpzr0CsN+5T3nju5i88G5USeEQj5F+M+5/B8X
   A==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="203169142"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:36:04 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:16:05 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:36:02 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 02/14] common: Introduce _test_dev_is_zoned() helper function
Date:   Wed,  9 Jan 2019 10:35:30 +0900
Message-Id: <20190109013542.23686-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109013542.23686-1-damien.lemoal@wdc.com>
References: <20190109013542.23686-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Introduce the helper function _test_dev_is_zoned() to check if a test
device is a zoned block device. Using this function, test scripts can
adjust test conditions based on the device zone model.
This function can also be used within test scripts implementation of the
device_requires() function to ensure that the test is run only for zoned
block device or only for non-zoned block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index 153a323..999590d 100644
--- a/common/rc
+++ b/common/rc
@@ -214,3 +214,12 @@ _test_dev_in_hotplug_slot() {
 _filter_xfs_io_error() {
 	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'
 }
+
+_test_dev_is_zoned() {
+	local zoned_file="${TEST_DEV_SYSFS}/queue/zoned"
+	if grep -q -e "none" "${zoned_file}" ; then
+		SKIP_REASON="${TEST_DEV} is not a zoned block device"
+		return 1
+	fi
+	return 0
+}
-- 
2.20.1

