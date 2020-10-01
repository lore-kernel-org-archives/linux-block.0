Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B739C4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1913F20838
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f/++4sp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgJAKPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:15:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12424 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAKPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 06:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601547337; x=1633083337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=slIAKLU442gX7UIrGpn0JbRb1Znj3t8bElJdZmFc6Ow=;
  b=f/++4sp/3SUsvcPXhQtLejxiO8YA1gYUbyvPEHd/jTBMke0+Z9q7Z68S
   jDVOad+aa8Oh5yAwuDPxTu7U5Tnu3WF2NrsQqy5g+UKyDE14YLTp29P+N
   cQdfHM8dpdlw9usvxHSm6T0RGDLJtRbe0FwhO5h8h0H+xYNWgLR+TeoUq
   ybnTRW0ZtxZruYNlw65JM98SHKzJe3xgndAKiog1PpYljKMc+jETxXHyW
   Z2kVDOWUQvDcP/K4BeCMttPLR3fi3q7pr0yXmHVriQCbF48f8m4x/hhDt
   kNse1oYuYRvQvH9DvAxi3mWcutzo2w1ilROE5Sw1lYUHkt6m93UIm2LJC
   A==;
IronPort-SDR: +HZAmLQzfyPsuJUceP0pTbyr6PPa+zZbrxiVOxhH4v2EwuOxvwr1+AyMpXCk/DjGPPFHuOLCMM
 l6s5bmZlAruzi3Ed6FdcgtZr3FM6JS47Oz8EIgPw2DV1rUHNQFWgfGG7e5YSAywXaISaI24M9V
 rwbG/E+Bv8ObmLQ/C9QCEbaHlcJRucTNQiuglATLjf08P6H+hg7/+xl7mendzKFs/XLMobqsQh
 0M2JMZsifOXIN0gcBwBI5geHzpWzpwHWTUUSQ9zfCALmOQ9mtW/XEw/kD6VA1+j4PWdYHqUvaD
 2BE=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; 
   d="scan'208";a="258516746"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 18:15:37 +0800
IronPort-SDR: ershdsHMUdfTeXk6R9sFOrzcAfOBN1+BrIka6VWAekt6noaS0RzBiu5YLcmkw2IQ97u/mAZr96
 YCr73/H9vCEg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 03:02:29 -0700
IronPort-SDR: Ddnpk8cCwQDDlJgGePNjPdAgNDhEgmvrl1nw2q+SQ00qcnj/CaFzR8Xi+TftuyFpNc7Ry9Agf+
 uPM2pyNR+9hg==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 03:15:37 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/3] zbd/003: Reset zones when the test device has max_active_zones limit
Date:   Thu,  1 Oct 2020 19:15:31 +0900
Message-Id: <20201001101531.333879-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
References: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the test target device has the max_active_zones limit, write
operations by test case zbd/003 may open zones beyond the limit and
trigger write failures.

To avoid the failure, check max_active_zones limit of the test target
device. If the limit is valid, reset all zones of the device at test
start to ensure that number of open zones does not exceed the limit.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/003 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/zbd/003 b/tests/zbd/003
index 079be02..1e92e81 100755
--- a/tests/zbd/003
+++ b/tests/zbd/003
@@ -30,6 +30,11 @@ test_device() {
 
 	echo "Running ${TEST_NAME}"
 
+	# When the test device has max_active_zone limit, reset all zones. This
+	# ensures the write operations in this test case do not open zones
+	# beyond the limit.
+	(($(_test_dev_max_active_zones))) && blkzone reset "${TEST_DEV}"
+
 	# Get physical block size as dd block size to meet zoned block device
 	# requirement
 	_get_sysfs_variable "${TEST_DEV}" || return $?
-- 
2.26.2

