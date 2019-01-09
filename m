Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA53C43612
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F9E20821
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 01:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pAeBrDzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfAIBfr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:35:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43884 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfAIBfr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 20:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546997747; x=1578533747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lvHoK0wXxKr7f9x0T4q8uIseuWD7SsbjITwmY5GYfWQ=;
  b=pAeBrDzXQesQZj7s+r8/5qMs8lONfeOh8mA3/gBMYtjr9Cj8mEKcZ+fB
   PjEPa8NL6UQMQKVQKYh+S79Re5GOsIouI89yumW6aYNZCAVmgXxf/i3hh
   A9RMwepdByp6Pks79O6V90511nwjbrTbqjcmUELXOSCeANN0rC8IgeEoe
   kmnghIkcRrMPIypjQhMbg8xG9zom9GR/68NGv4KP7L8BoJZ+GWdh0RJIg
   sk1tytWC3H9b42RXntpQdm5oXnLJdsQwYsXfwZ2npTz3MUkSExj/8EF1u
   RZ7KKbDi3ZWQcaDo4R06fz9X75Vw3wKBp/QbCpnte+xSZkRvRbfp8oyjz
   g==;
X-IronPort-AV: E=Sophos;i="5.56,455,1539619200"; 
   d="scan'208";a="100066841"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2019 09:35:47 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 17:15:47 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 17:35:44 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH blktests 00/14] Implement zoned block device support
Date:   Wed,  9 Jan 2019 10:35:28 +0900
Message-Id: <20190109013542.23686-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current blktests infrastucture and test cases do not support zoned block
devices and no specific test cases exist to test these block devices special
features (zone report and reset, sequential write constraint). This patch series
implement this missing support.

The series addresses two aspects: the first 6 patches introduce changes to the
common scripts and configuration are introduced to allow existing test cases to
run against a null_blk device with zone mode enabled (new ZONED config variable)
or for these test cases to be skipped if a test declare itself as not zoned
compliant. Helper functions are introduced to facilitate checking a device
zone model.

The second part, composed of the last 8 patches, introduce the new zbd test
group to cover zoned block device specific test cases. All these test cases are
implemented using the test_device() function so that target devices can be
specified in the TEST_DEVS config variable, to cover a variety of zoned block
devices: physical real drives, partitions and dm-linear setups on top of zoned
block devices, etc. Furthermore, using the infrastructure changes of the first
part, the TEST_DEVS definition can be left empty, resulting in the zbd test
cases to be run against an automatically created null_blk device with zoned
mode enabled.

5 test cases are added to the new zbd test group to check the kernel ioctl and
sysfs interface, zone report operation, zone reset and write command handling.
These tests are simple but only a start. We will in the future send more test
cases to cover at least the regressions and bugs found and fixed in the zoned
block device code since its introduction with kernel 4.10.

Another still to be added part is support for host-managed ZBC emulation in
scsi-debug to further improve test coverage without requiring a physical SMR
disk. This work is ongoing and will be added to blktests once the relevant
scsi-debug changes are accepted in the kernel.

Masato Suzuki (6):
  tests: Introduce zbd test group
  zbd/001: sysfs and ioctl consistency test
  zbd/002: report zone test
  zbd/003: Test sequential zones reset
  zbd/004: Check write split accross sequential zones
  zbd/005: Test write ordering

Shin'ichiro Kawasaki (8):
  config: Introduce ZONED variable
  common: Introduce _test_dev_is_zoned() helper function
  common: Move set_scheduler() function from multipath-over-rdma to rc
  block/004: Adjust fio conditions for zoned block device
  block/013: Skip for zoned block devices
  block/018,024: Skip when ZONED is set
  check: Introduce group_exit() function
  src: Introduce zbdioctl program

 Documentation/running-tests.md |  11 ++
 check                          |   6 +
 common/multipath-over-rdma     |  24 ----
 common/null_blk                |  23 ++-
 common/rc                      |  33 +++++
 src/.gitignore                 |   1 +
 src/Makefile                   |   3 +-
 src/zbdioctl.c                 |  83 +++++++++++
 tests/block/004                |  12 +-
 tests/block/013                |   8 ++
 tests/block/018                |   2 +-
 tests/block/024                |   2 +-
 tests/zbd/001                  |  66 +++++++++
 tests/zbd/001.out              |   2 +
 tests/zbd/002                  |  99 +++++++++++++
 tests/zbd/002.out              |   2 +
 tests/zbd/003                  |  69 +++++++++
 tests/zbd/003.out              |   2 +
 tests/zbd/004                  |  81 +++++++++++
 tests/zbd/004.out              |   2 +
 tests/zbd/005                  |  57 ++++++++
 tests/zbd/005.out              |   2 +
 tests/zbd/rc                   | 250 +++++++++++++++++++++++++++++++++
 23 files changed, 811 insertions(+), 29 deletions(-)
 create mode 100644 src/zbdioctl.c
 create mode 100755 tests/zbd/001
 create mode 100644 tests/zbd/001.out
 create mode 100755 tests/zbd/002
 create mode 100644 tests/zbd/002.out
 create mode 100755 tests/zbd/003
 create mode 100644 tests/zbd/003.out
 create mode 100755 tests/zbd/004
 create mode 100644 tests/zbd/004.out
 create mode 100755 tests/zbd/005
 create mode 100644 tests/zbd/005.out
 create mode 100644 tests/zbd/rc

-- 
2.20.1

