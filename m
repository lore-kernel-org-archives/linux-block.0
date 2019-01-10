Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEDBC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E26214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EN26hE7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfAJJhj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:37:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25539 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAJJhj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547113094; x=1578649094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5JJMNF36dAu/M7VQo3QuCwldHftUiXhavgL1sNL/hY=;
  b=EN26hE7oYP8wIyobCnTVAj9FwuAMAoPtdi3MqbH0A8+/h1k+ZpgobUYv
   KN7bWgVXTxPBvC86kJERHolzJ25Yd2kO820Gu7QEHsXt31bcTtpaL8eB+
   h7yiHOj2FisTlNWAuK3VzFvRwwdH0diGKTTC3qAVp/gIfd2O1O1mIqbYT
   PaMoae/8XKNkYbnxQ2WKouGL1UbW5fROPZU8jDJ4p3RptCnxL2LmNpEzd
   bHjqfyBiZmIKyKOR8R9ZZExYeHTkNyMbZvN4mO82dLTu/HDcLknfb7jUT
   OaKh/JgdJzM0dPML6MWq+sg+XIkL/NobPj/vDv9yYEJ2ItcmqqAPXjEcV
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,460,1539619200"; 
   d="scan'208";a="196468974"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2019 17:38:13 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jan 2019 01:19:09 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2019 01:37:35 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 02/16] common: Introduce _test_dev_is_zoned() helper function
Date:   Thu, 10 Jan 2019 18:37:11 +0900
Message-Id: <20190110093725.32675-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the helper function _test_dev_is_zoned() to check if a test
device is a zoned block device. Using this function, test scripts can
adjust test conditions based on the device zone model.
This function can also be used within test scripts implementation of the
device_requires() function to ensure that the test is run only for zoned
block device or only for non-zoned block device.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 153a323..e628f96 100644
--- a/common/rc
+++ b/common/rc
@@ -214,3 +214,11 @@ _test_dev_in_hotplug_slot() {
 _filter_xfs_io_error() {
 	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'
 }
+
+_test_dev_is_zoned() {
+	if grep -qe "none" "${TEST_DEV_SYSFS}/queue/zoned" ; then
+		SKIP_REASON="${TEST_DEV} is not a zoned block device"
+		return 1
+	fi
+	return 0
+}
-- 
2.20.1

