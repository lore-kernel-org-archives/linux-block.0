Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DF6C4320A
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A456101E
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 02:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhHLCoa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 22:44:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHLCo3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 22:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628736244; x=1660272244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ai5U5Qrjyu5jB3L3UPfCh+d9INDj4SDcGDI2/KFvMQY=;
  b=InLMnrRVDY6lhXB0pmpcZQT4Ui3+9H6NJrES9HZa4Tagh9DKHS7/oDMm
   g29lV1UyqLJ/9J/VfHgh77vF0iPOQcbeJf/L1RClbnOd4B0HPXediznaL
   A2kHiLIuTogwfpNBDt+NFyOwYTACfPldzamyg63ShbQiaYZAAJd/TkXTc
   qQfcU3SqBmg38nJoxnK9aPMxaNWc5leOwyKYtLr+Vbw3WFFw8KfAqPGLG
   TlSza2qDB3UZKilXTCTSaD1uH06c3iOE7sUMHzF5qgzIHyc4jtaX0VnHt
   58E7p7OaRhprvvGjPiZuUC2KnDULMlVAblqjJ4H9Zw1N67OwmXb6oeDhP
   w==;
X-IronPort-AV: E=Sophos;i="5.84,314,1620662400"; 
   d="scan'208";a="176999850"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 10:44:04 +0800
IronPort-SDR: ngmmJNR2MgAlMd1lJOZZKVR0QRn3Qax72L+l6f1i/Q9zc0Jb3eUoMZLrlroQljjX1LEffzPKv+
 0lmZDn9gDb2RCTHNdlIcInncaGLZd/WMxn1n1J8PV+FVqnHhcz9rCa03CTON2dDcEHzPDgu+8c
 b6Xrs9afx19OFj5AQfT0Yj4x76iXkLvEOMKZ1B3TyUOR9wi5Xmv0MItd3r2RrYcYIxX4x8+daX
 GoIkZP+AhFL9JgqTlljj26zlU6AlRyDxl0MuxS/2STGqXJC4umYO9VbBNwJ8Wipbik+NBaBzf4
 9aZYOUz3SeBI2p3kn7Sz7cFj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 19:19:35 -0700
IronPort-SDR: fjCvOzuOSi8mcol/e8ChorO6Yj8xDawPPGe+bmbZXhz0XXN3II5bfcJfN22Xy5Y4Un35qpGo8E
 rbzHq7e7VTe9FUIRhT5LfdHdhiP55UbBzQQMYgyy4l2uGrYYs5IMG1e8InkIkLJTE00qCAHTyi
 APOi8qCim42vIwGplRF3XTLskKc9Yia6qA/26diHpuGjIySY8a0j053oT+xV6xRoocko3ZCyhY
 3wqcVsp2UWboKWfD/wj8e7RfIevHQVAsn3SGWbyMfv5aAt49ORTOgASi6MZ2G3tfcIiN2FbKm8
 BSU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 19:44:04 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v6 0/9] libata cleanups and improvements
Date:   Thu, 12 Aug 2021 11:43:54 +0900
Message-Id: <20210812024403.765819-1-damien.lemoal@wdc.com>
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

Damien Le Moal (9):
  libata: fix ata_host_alloc_pinfo()
  libata: fix ata_host_start()
  libata: simplify ata_scsi_rbuf_fill()
  libata: cleanup device sleep capability detection
  libata: cleanup ata_dev_configure()
  libata: cleanup NCQ priority handling
  libata: fix ata_read_log_page() warning
  libata: print feature list on device scan
  libata: Introduce ncq_prio_supported sysfs sttribute

 drivers/ata/libahci.c     |   1 +
 drivers/ata/libata-core.c | 290 +++++++++++++++++++++-----------------
 drivers/ata/libata-sata.c |  62 ++++----
 drivers/ata/libata-scsi.c |  60 ++------
 include/linux/libata.h    |   5 +
 5 files changed, 212 insertions(+), 206 deletions(-)

-- 
2.31.1

