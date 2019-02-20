Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5A2C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C8321773
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Osc6LUsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfBTIMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:12:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33059 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBTIMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 03:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550650374; x=1582186374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5CW7u7EwiyR07Aq0jB0ICAd3wo3S0fLFxGkXBcNz26k=;
  b=Osc6LUsdbkd5ZiIaNcNiXLC9ovcnTGEhxesZKLp0wo1LcOLSQ2EqMQMC
   D1gmqcas0Gb0z3g/VZFqhC1L/w1WTYYgMjqMFaZxYfo42mQF8syObtbXE
   uV5XWqtIoEkVFLvqSL3+RQ1XWzQgWQi52pbh6Ba7ELoEDv3bwX7v2NeCb
   1xPKLkGe0TiDu4Iz94Ql94UGBS4n8JUSz3BffrHY4ugv7QSpG4XRVg+Jq
   CUXET9djiANxqhu7M34uWxCZ8DVuj5DNESQqiDFw+tqEEbbjaZFUkqIS7
   TR+SIxYriXdmWTFMw6V2rEjtzpEU79yWgAdmCvhDMV3/F6tJ+zhPmjCfS
   w==;
X-IronPort-AV: E=Sophos;i="5.58,390,1544457600"; 
   d="scan'208";a="106683025"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 16:12:53 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 23:51:16 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2019 00:12:51 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 4/5] common: Add _test_dev_is_partition() helper function
Date:   Wed, 20 Feb 2019 17:12:30 +0900
Message-Id: <20190220081231.15366-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To control test conditions unique for partition devices, introduce the
_test_dev_is_partition() helper function. Refer TEST_DEV_PART_SYSFS
variable to tell if the TEST_DEV is a partition device or not.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 153a323..0c354a2 100644
--- a/common/rc
+++ b/common/rc
@@ -208,6 +208,14 @@ _test_dev_in_hotplug_slot() {
 	return 0
 }
 
+_test_dev_is_partition() {
+	if [[ -z ${TEST_DEV_PART_SYSFS} ]]; then
+		SKIP_REASON="${TEST_DEV} is not a partition device"
+		return 1
+	fi
+	return 0
+}
+
 # Older versions of xfs_io use pwrite64 and such, so the error messages won't
 # match current versions of xfs_io. See c52086226bc6 ("filter: xfs_io output
 # has dropped "64" from error messages") in xfstests.
-- 
2.20.1

