Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73385C001DC
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 07:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGSHPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSHPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640DE60
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689750912; x=1721286912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sLArJoAtmPe/VjopnAfkMevLryeC7xck7O0k1mWLxSE=;
  b=YY1Z1yEgLl5zI+jG0jlbae1rWwgzkDQtbGb/GTfr7I1fQQ6OzeLJah8w
   0ww52gn52IXYlwUOX4BN1ZFIzJJK/36ymm5/t4YgCp/GJuAqOuDyreOMn
   a/KA9Z/11s+ItL5sqzzuPeVBtPbVI/mGXmlrZOzl06bfw0DukU7kwgfHQ
   VHEJh/7s57YOEvLcc4SmcajMxUdM+2hoT9m/bgpxEUnSdAEg4lbKfzaOJ
   24MUN3sOs683vTjeZhnhZ6syTfSw7bbn1d6E6xIjuA4689ftcs9ba1VXr
   k5TQxjHSHh7nEWTCKAZ+92tnr0zx6t2AEpK8RMFfyWHV89XJWvdaqwnWm
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,216,1684771200"; 
   d="scan'208";a="238846513"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2023 15:15:11 +0800
IronPort-SDR: lXDHbgmJJGtM5Y8ug8I9YJlyUUJrWomPqPo6F1opuTu5gm9UB+4MIWn/ILmG/+asHtVBvIyWXA
 vhNFbQ77/vNyDkov8cuNhbjipomuma7KE6Vhp/DOyNyxBN0J74Y5c1rmvcoaEc7aPkEB5y/n5p
 qtDs/swpm63MwPO32woc67/1R9Rm3GbEBaprNvns9Vh/A/2kjygRbVkw46GWQmeCTjAoddhV3g
 wCKbkSV+n4lACWkWmveMYMGLG+pNZV5iTKJirAK2Jp7Q7hEBFru/KieFshkS9psCNvW6aT/UXI
 N1k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2023 23:23:23 -0700
IronPort-SDR: WcMQe8i/xsElO3zkpOHj+Kap7DW61J4PzR3fm4fFt14fg+5ha6KXoV7SS2sGCWBh2jxkW4GBMP
 zwx19p7y/kWBCN5itkR6XgS580tBXEiKF5O8LtECTH7cxf2CjkND3tRS7LLMjtlg9/+lBHLmAV
 soOtLIKFBOl+Z4MFyz2XYj6QHWzj6+msv3Kvk9/DJkkCtBd4egDPY6G2ujtA5IBqdPGRj0o3Mf
 GrDNRapgujLD9pP5ppwpYxmqJ165skseHzWEA4BGEBa90vocuyjOx4e1iEejEyFHSLeRFH2KWc
 l/g=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jul 2023 00:15:11 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/6] fix failures with bio based device-mapper
Date:   Wed, 19 Jul 2023 16:15:04 +0900
Message-Id: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When bio based device-mappers are set to TEST_DEVS, the test cases block/004,
block/005, zbd/005 and zbd/006 fail (or silently skipped) on kernel version
v6.5-rcX. This happens because the kernel no longer provides the sysfs
attribute queue/scheduler for bio based block devices, and the test cases sets
scheduler through the sysfs attribute and fail.

This series address the failures. The first two patches are preparations. Next
two patches introduce new helper functions: one to set scheduler to destination
devices of bio based device-mapper. The other to check queue/scheduler attribute
existence. The last two patches fix the test cases by calling the new helper
functions.

Shin'ichiro Kawasaki (6):
  check, common/rc: save sysfs attribute path
  common/dm: add script file for device-mapper functions
  common/{rc,dm}: introduce functions to set scheduler of dm
    destinations
  common/rc: introduce _require_test_dev_sysfs
  block/004, zbd/{005,006}: call _test_dev_set_scheduler
  block/005: require queue/scheduler sysfs attribute

 check           | 10 +++++-----
 common/dm       | 44 ++++++++++++++++++++++++++++++++++++++++++++
 common/rc       | 29 ++++++++++++++++++++++++-----
 tests/block/004 |  2 +-
 tests/block/005 |  4 ++++
 tests/zbd/005   |  2 +-
 tests/zbd/006   |  2 +-
 tests/zbd/rc    | 19 +------------------
 8 files changed, 81 insertions(+), 31 deletions(-)
 create mode 100644 common/dm

-- 
2.40.1

