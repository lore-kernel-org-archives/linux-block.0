Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA1FC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 05:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A017120684
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 05:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o/troA/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfCEFYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:24:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55132 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfCEFYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 00:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551763489; x=1583299489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eQwHtGkMrKcW0f97NT6U3n81l4oao9L4ZvxIXDva1Yc=;
  b=o/troA/AmVT3d7d6Z15SrfXoiABQxOkEfbvxIecuLXxf44Yqo6yZnwnA
   P5d4swGmJG+fUNTtuhcY1LGM/RO6JaVG5m+gjh+30TIJDCg6g1FIfCzmo
   EZZ2C+eygTdnOE6YhKBpuMQPM4X8mlwQvkvtysy6IzNtb0OnkeC1ELFBy
   7OZoPhI5hYK7GEYCTNYlBJvG+NWyrThYDDnjFimLEwislgpO4n5dTRBX0
   agRrn8duwwQR3njKyFtcFb47hZMuTr04DKhTp4ScynBsnd677xcStm6Xl
   JxVizuXp1/LLn+i9N8OtpQWxlHZm/2+WDO9/X6URCi9sricb2tUz2hRIF
   w==;
X-IronPort-AV: E=Sophos;i="5.58,442,1544457600"; 
   d="scan'208";a="107735602"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2019 13:24:49 +0800
IronPort-SDR: E1FsBmOCFgOfxm8oSaD6Wns97ZafnVijT+1X+ZmIF1avN8ZeDMiY/LT6zBWzzaKDkdowccGCCW
 oBV24Z7YIw1UUv/65mKYbAk1TF5gV5e5DmQWKOYrHOBTHzYy+b1ZAfkofq7MG2PAoOmArFo6/k
 /5vvzfaY4vl7/WlQzjsMNSO2sWrfRnkAzzYPKd9r+slxz6+WxrgiyAoSEI+aHaYA7x9LHQC9WA
 zpa3k0YIyfkvLtRWBwp9HWk33N4ZnOXPsli9fVmxWep0GuZP8RSDpQpfmah8CnRnJJpF3pOnpb
 95QruI8sR18BxiWLHX+/3B6i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 04 Mar 2019 21:04:52 -0800
IronPort-SDR: lu6RoA73LKL6cgyG3okQeA7kaVRoa9iYAvOOuV71GeVJr9puBFqvH8QKtTmpXlNdjdB9D0NP2o
 JUdLCbR0IgabOSs7KTjPrjhAnYyfSUNhX50H6YGf92yELeb4AslguyE/V465fHdxqhbbY66yvV
 hW+B1FD7RAAG0JCQGeCotXdpYUhfkSbtts3xCJeYxzvZlc4u694gUaTE/kxKYjhGl4XMMw6dGB
 RIgmi9OPsnHmIkqwvtMeBRyLxmq59123GNkiWDP9rqcSyGabyWq/7zftdqUJPhdywW3Sos/F5j
 g78=
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Mar 2019 21:24:48 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests 0/3] Fix partition device sysfs access
Date:   Tue,  5 Mar 2019 14:24:44 +0900
Message-Id: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series fixes test failures found in the zbd test group when run on
partition devices. The failure cause is a block device sysfs attributes access
problem if the target device is a partition.

This series resends patches 3, 4 and 5 posted as a part of another series.

  https://www.spinics.net/lists/linux-block/msg37431.html

The patches reflect the review comments by Omar made on the list.

Shin'ichiro Kawasaki (3):
  check: Add TEST_DEV_PART_SYSFS variable
  common: Add _test_dev_is_partition() helper function
  zbd: Change sysfs path for partition devices

 check        | 46 +++++++++++++++++++++++++---------------------
 common/rc    |  8 ++++++++
 new          | 16 ++++++++++++++--
 tests/zbd/rc |  8 ++++++--
 4 files changed, 53 insertions(+), 25 deletions(-)

-- 
2.20.1

