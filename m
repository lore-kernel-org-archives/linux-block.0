Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA3C4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AF06140B
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhHPBpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37260 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhHPBpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078298; x=1660614298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MrpnXIKWUC0dmE7Z0g2CW1TV4HRoAliflafQGfaYq/c=;
  b=B+BnoU2KXRDVFbrXM7EABWvipV9LVZLZJpDL0AmJrmLneX1tj2hHLvIt
   rcas6LvQqs1oPJVZbMJzLoflf5ZQpmgo4mzB66naOUUA8SweZ0lVpvyMj
   9ifeQIVr21inPQ3oZBVajsgVm3GnRLFRnmEwSYAtVVJa5o9Ln0NW7NKpy
   iMQ9pykXB7lRyny23wIdnYoV6w+fP8C1uQ6T4JTW2q951RCYVpJgutky/
   unmLjFVboxI6W8YQWBEJR6efvE51hVbNfn5cjp1dzZxcLFjzGVHlwVEb3
   x/x9gNeIe3euFI7EhsOv6c8hTDrhYnv/SQaUC9m8OrPdXdNLi6yKSep3a
   w==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326671"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:44:57 +0800
IronPort-SDR: 6jR4k2qgRZ7Wxgx3iv8vQtu2QUGqtcmZfww593AKtXKE/rqMp/MppBD58AsjU/8bFrnKAj5avU
 szaCkSDqCefR9TN2blr9Vq+B/N1NNpO3ioSfcgb4WaGtfMfYm6+tQrqAntD5XLaifaTgxqicqx
 Dhi6evl4oy0xoxquecb3j5MNeKIuE+iHWSsqohxzw/yp7RdBiQWXhI20iwPD1Ju5sm4AUx3py+
 6BN+oiaAepBY+6/YsdZILWcvbWLBBN1CBz2Kfxu0cZNaX21mRNac/oA53GccJpD5rPK82ZBvLD
 Rlvrvh0+qnx4KU7yJUr/Z3sf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:24 -0700
IronPort-SDR: Tir6s5ElN8753P2n5auBKgpEG5U059nla13Qpy/humnfEXNXwu/+PuDbP8Xj8t/bLLPxXAto7m
 ZIbqP7sAhKBGFiFkg4rCeuR8Lni6fxPUS4sfN43B0yKTWmBeHYyhI063e+CiIWkDE/EPGzNi+E
 ep3/FX8un0Xw+qoRE2G80b7cz5Zj8GZL4sZvzibeRUuLAz+W5a/bS9z88YC2dY0VsuFgWx3uZE
 VGuNQBozwAgJ2XzfkqkoIQyA2HLawVTwmhluGmq7N5uTkIlWGVNK7W84C4+J8hqsWfquM/pBwE
 Csw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:44:59 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 00/11] libata cleanups and improvements
Date:   Mon, 16 Aug 2021 10:44:45 +0900
Message-Id: <20210816014456.2191776-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The first three patches of this series fix sparse and kernel bot
warnings (potential NULL pointer dereference and locking imbalance).

The following three patches cleanup libata-core code in the area of
device configuration (ata_dev_configure() function).

Patch 7 improves ata_read_log_page() to avoid unnecessary warning
messages and patch 8 adds an informational message on device scan to
advertize the features supported by a device.

Path 9 adds the new sysfs ahci device attribute ncq_prio_supported to
indicate that a disk supports NCQ priority.

Patch 10 and 11 update the ABI user documentation files.

Changes from v6:
* Added patch 10 and 11

Changes from v5:
* Updated patch 9 to include adding the new ncq_prio_supported sysfs
  attribute for SATA adapters other than AHCI. Changed the patch title
  and commit message accordingly.

Changes from v4:
* Fixed patch 1 to avoid an out-of-bounds array access
* Changed title of patch 3 to describe the change (as opposed to only
  mentioning the tool that found the problem)
* Removed patch 10 from this series as Martin took it through the scsi
  tree
* Added reviewed-by tags

Changes from v3:
* Reworked patch 1
* Added patch 3 to fix a sparse warning discovered while checking
  patch 1 & 2
* Added reviewed-by tags

Changes from v2:
* Reworked patch 4 to avoid the need for an additional on-stack string
  for device information messages
* Added reviewed-by tags

Changes from v1:
* Added patch 1 and 2 to fix problems reported by the kernel test robot
* Use strscpy() instead of strcpy in patch 4
* Use sysfs_emit in patch 8 and 9 as suggested by Bart
* Fix typos in comments of the new sas_ncq_prio_supported attribute in
  patch 9

Damien Le Moal (10):
  libata: fix ata_host_alloc_pinfo()
  libata: fix ata_host_start()
  libata: simplify ata_scsi_rbuf_fill()
  libata: cleanup device sleep capability detection
  libata: cleanup ata_dev_configure()
  libata: cleanup NCQ priority handling
  libata: fix ata_read_log_page() warning
  libata: print feature list on device scan
  libata: Introduce ncq_prio_supported sysfs sttribute
  docs: sysfs-block-device: document ncq_prio_supported

Niklas Cassel (1):
  docs: sysfs-block-device: improve ncq_prio_enable documentation

 Documentation/ABI/testing/sysfs-block-device |  43 ++-
 drivers/ata/libahci.c                        |   1 +
 drivers/ata/libata-core.c                    | 290 ++++++++++---------
 drivers/ata/libata-sata.c                    |  62 ++--
 drivers/ata/libata-scsi.c                    |  60 +---
 include/linux/libata.h                       |   5 +
 6 files changed, 252 insertions(+), 209 deletions(-)

-- 
2.31.1

