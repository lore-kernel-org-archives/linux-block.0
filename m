Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E862EC4320A
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB6361052
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbhHJFuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:50:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9539 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhHJFuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628574583; x=1660110583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S0bYsjoV1eunFM+lwDQqMJQY2Y/ZYciuJeaZG1z5lNE=;
  b=nhnLWRaxwb1WeGlp9+Qq2fVmLpP4PD3sOCPo4LTMzQkH4QciPBdnLMl3
   rzT9EBke0IPgrpeHHM1Ho6oq2H03rUqGd0tyhhIpmsuIX81oCHrlJhruI
   GpFU0ibvdgm++bwgpjRPuwZUsLJWvn1frq/zYpCVJ0EXaJXymRd3YSUjF
   2JVG4YnAWkOiDYQUH46//E9tyJOdIDJqPMYMruvo7bNOGTbNoZ/w8ZMtL
   Hl2XQ/Bd9ZyRPUvwn9h/pngLBDEL4//H/3ggsLEFBDFDqPRihTOa7+8k4
   BmlLa2lQ525/VuPEzz0znyb7Z2giYvt42qybVHgvjdHmBuHYVSm4DYamW
   g==;
X-IronPort-AV: E=Sophos;i="5.84,309,1620662400"; 
   d="scan'208";a="288340178"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 13:49:43 +0800
IronPort-SDR: Y8IJCaibQiHyKUi7KkLSN3wSDn4FCvbNRTYLAM8jWcHklPvqCXrgLPVNSUhKvmK2QZISoSVwg0
 WHKICgIZZUReOKa8HiMvHMTk0ZBVNN4xq9cuyXbBftxVNVWHTRhgmK0Y1ODOPAcwNtyyTfqcgO
 g2u8RG+HvljscMamKlePX+nlJw+1qWTs8xTTMj7RRCHmL2LuCR0YzBGTKz/Po5slRMPc3GD5oc
 RBMACEEp6/TeCp4eW/lntwADay41tNQWxG7bieeDG03SQDtxhsMe/2OFS8zQ7xJ4bzDnattVVe
 3ETUnGd/tlIPHengl2RzXGjb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 22:27:05 -0700
IronPort-SDR: oWojxH11j6dI684ccL7eDJ1rKTWwVAdvOj4CqW0s+Y3WUUwT/qeZHIYQEo0Tjd8W8EYR5EDcEw
 Y4tng3dEp2IhsCUojDjaCsZ082VVesmRxf5sMCtwzm0vnmsGgiPZaq+6+1cr+TBuhvDm0pE+gj
 z8EkJ2LSBDuqHKd6uIwurlorl1LgjG5ZvkiW48orRyObS0GLSWUkfvcdUX4i5e+Cmp1xxFc6x1
 nBtD3RULgi0ArGwrmbLuldbHehLrBx94R/GG5RULUMnIgAnLXJZrvCr+25lb6ycxuZ4bD4WMHi
 pGA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2021 22:49:42 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v5 0/9] libata cleanups and improvements
Date:   Tue, 10 Aug 2021 14:49:30 +0900
Message-Id: <20210810054939.30760-1-damien.lemoal@wdc.com>
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
  libahci: Introduce ncq_prio_supported sysfs sttribute

 drivers/ata/libahci.c     |   1 +
 drivers/ata/libata-core.c | 290 +++++++++++++++++++++-----------------
 drivers/ata/libata-sata.c |  61 ++++----
 drivers/ata/libata-scsi.c |  60 ++------
 include/linux/libata.h    |   5 +
 5 files changed, 211 insertions(+), 206 deletions(-)

-- 
2.31.1

