Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7135C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806E72086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 09:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lSEH3ifo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfARJo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:44:59 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34681 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfARJo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 04:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547804699; x=1579340699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=belcQJkHcVNsJOQ2LbbzH9iZkSR71iOqh7MfiW4t+O8=;
  b=lSEH3ifoMFQAYXP4DfpRORtqsCYH7hWh5HYZ6uHjXmWF38o0ARNrmQqN
   sUFky6dB1J6Qxyqcx+SFQM/h3C3B0BBaWKEoM3ymEkvOtgGq9LKMTWJoi
   E5wvfK7mbQIzrCi34IJHh/y0eyomm0r0j22xhhynS3QbG39CYE1pwj793
   lVg9Dnpp1BTta+3/6p6W3jVKWtkbRx6puBvWd9Ivldrt0LMfjaroFA8aE
   8shw+TTQczCdhIl+W7qA5W8WLJ6wUs+rVzJhsRWsQ/0FAWBldmG3BBvLr
   hCQgQJQ6w2Y8kNmYBMhvdlik1U1KLRiy7NKzspojZPieBx5QSlfWbBbYM
   A==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="100920224"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 17:44:59 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 18 Jan 2019 01:26:16 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2019 01:44:54 -0800
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
Subject: [PATCH blktests v3 00/13] Implement zoned block device support
Date:   Fri, 18 Jan 2019 18:44:40 +0900
Message-Id: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
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

The series addresses two aspects: the first 4 patches introduce changes to the
common scripts and configuration to allow existing test cases to run against a
 null_blk device with zone mode enabled (new RUN_ZONED_TESTS config variable)
as well as whitelisting tests that can support zoned block devices
(new CAN_BE_ZONED test flag). Helper functions are introduced to facilitate
checking a device zone model.

The second part, composed of the last 9 patches, introduce the new zbd test
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

Changes from v2:
* Replaced ZONED with RUN_FOR_ZONED and CAN_BE_ZONED variables
* Introduce fallback_device mechanism instead of relying on group rc script
* Dropped set_scheduler() move to common

Changes from v1:
* Fixed _test_dev_is_zoned
* Added _have_fio_zbd_zonemode
* Added patch 10 to move _dd to common/rc
* Addressed various nit commented on the list

Masato Suzuki (6):
  tests: Introduce zbd test group
  zbd/001: sysfs and ioctl consistency test
  zbd/002: report zone test
  zbd/003: Test sequential zones reset
  zbd/004: Check write split accross sequential zones
  zbd/005: Test write ordering

Shin'ichiro Kawasaki (7):
  config: Introduce RUN_ZONED_TESTS variable and CAN_BE_ZONED flag
  common: Introduce _have_fio_zbd_zonemode() helper function
  block/004: Adjust fio conditions for zoned block devices
  block: Whitelist tests supporting zoned block devices
  check: Introduce fallback_device() and cleanup_fallback_device()
  common: Introduce _dd() helper function
  src: Introduce zbdioctl program

 Documentation/running-tests.md |  13 +++
 check                          |  54 ++++++++-
 common/fio                     |   9 ++
 common/null_blk                |  23 +++-
 common/rc                      |  31 ++++++
 common/shellcheck              |   2 +-
 new                            |   4 +
 src/.gitignore                 |   1 +
 src/Makefile                   |   3 +-
 src/zbdioctl.c                 |  83 ++++++++++++++
 tests/block/004                |  18 ++-
 tests/block/005                |   1 +
 tests/block/006                |   1 +
 tests/block/010                |   1 +
 tests/block/011                |   1 +
 tests/block/016                |   1 +
 tests/block/017                |   1 +
 tests/block/020                |   1 +
 tests/block/021                |   1 +
 tests/block/023                |   1 +
 tests/zbd/001                  |  75 +++++++++++++
 tests/zbd/001.out              |   2 +
 tests/zbd/002                  | 108 ++++++++++++++++++
 tests/zbd/002.out              |   2 +
 tests/zbd/003                  |  78 +++++++++++++
 tests/zbd/003.out              |   2 +
 tests/zbd/004                  |  90 +++++++++++++++
 tests/zbd/004.out              |   2 +
 tests/zbd/005                  |  67 +++++++++++
 tests/zbd/005.out              |   2 +
 tests/zbd/rc                   | 195 +++++++++++++++++++++++++++++++++
 31 files changed, 866 insertions(+), 7 deletions(-)
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

