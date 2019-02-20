Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544EFC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0938320700
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o58ZkTZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfBTIMf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:12:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37605 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfBTIMf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 03:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550650354; x=1582186354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l3FW5A+KQiAmA/kSqg8VJ47YMx0389P/2yyKe3gAMdA=;
  b=o58ZkTZCY1nN+zWlovODC4Pw4lstYDifKrtg13/DWgYpmc8L/thZ+WbN
   K5Jii/h0Rb/MAfsE2pUOKejxtR6SXaPs1NQqJcyh33Jcrb+jlGkhona5D
   /ZMJoe717mT9Jv+kncjMDHGKITh96GN2zupmC6iPSh1tF4SPdGtvx6E/O
   eigKFN0ad0K8dRbGLNQaCSN6vuCaBYeiCWOUAlxQDvVfGc6CcboryFInl
   MXXVG1POuIdol5vplcWgUoo/L2WGIGroOHXAefajNs6REpwI8RG747cb4
   SqXAKRsSBllkJlnLr74PHB+D2l933pWLZFmLo3laJAjijQ6affUgwqrmv
   w==;
X-IronPort-AV: E=Sophos;i="5.58,390,1544457600"; 
   d="scan'208";a="206904740"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 16:12:34 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 23:50:57 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2019 00:12:32 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 0/5] Fix failures found with zoned block devices
Date:   Wed, 20 Feb 2019 17:12:26 +0900
Message-Id: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series addresses two incorrect test failures found in the zbd test
group. Two other problems with the check script and the common rc script are
also fixed.

More specifically,
* Patch 1 addresses an incorrect failure of block/024 caused by shorter write
  I/O time than expected on very fast systems with a low overhead.
* Patch 2 fixes test zbd/004 which can fail when a disk closes an implicitly
  open zone after completion of a write command. To avoid this failure, the
  closed zone condition is added as an allowed condition.
* Patch 3 to 5 fix problems to access a block device sysfs attributes if the
  target device is a partition.

Of note is that test block/004 still fails with a target device that is a
partition of a zoned block device. The failure cause is due to an incorrect
access to sysfs disk attributes by fio. A patch to fix this issue was sent to
fio mailing list.

Masato Suzuki (1):
  block/024: Increase I/O time

Shin'ichiro Kawasaki (4):
  zbd/004: Add zone condition "Closed" for sequential write required
    zones
  check: Add TEST_DEV_PART_SYSFS variable
  common: Add _test_dev_is_partition() helper function
  zbd: Change sysfs path for partition devices

 check           | 51 ++++++++++++++++++++++++++++++++-----------------
 common/rc       |  8 ++++++++
 new             | 16 ++++++++++++++--
 tests/block/024 |  5 +++--
 tests/zbd/004   |  9 ++++++++-
 tests/zbd/rc    |  9 +++++++--
 6 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.20.1

