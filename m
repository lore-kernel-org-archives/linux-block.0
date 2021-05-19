Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D8C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F04611BF
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbhESC4u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 22:56:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5175 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbhESC4t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 22:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621392930; x=1652928930;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cGYiXfkY7RctNo7QxMlFosjCLW8IBiFIuoeagTnYjzU=;
  b=JKTxLhriorDCA4yU6eywrWtY0OgYC8Ftq2UnIJ3QSQDebTerDE01tVjJ
   X8SPfGjADvANVBxtk03r/LH9KMiE2b5B78VYFokWZhYrmKbFrT6xvcE2Y
   IWTYhPve3YQRg98R583mpbPeM8+nFyQbLUT6xeOyaMVXp6G+Ou/TNyGIT
   IGAYlrkJ3QPcnCNZQ+HygQk1qWFI79tz6zLHYHEum0Jp/rj3TLG0NSyPG
   IKHGUR168GVcvvtTGtqdmtHCE/kDXdmpLmzltr9tRiWK27VLWUGOedPzv
   bGuiF1yNC1EN8li6xPLhFhvvou2EIbIUmopNSFDq/GJ5XujkB7t3AXlbl
   w==;
IronPort-SDR: Ueq0LzE2sXN2pAzdXWBkAns8UAycYV/JqJF5cn2kdH+9hoXclWy0iAYIJ+Z7lvAQJegZYmROIm
 SkfGthbExk/RuSdCj6K723W8H6ioMahnYElvwQoUg0XqNEW80VWe4I2j8XFc5GK48ZMuBJUXf6
 rM0pjIuKCGkcNLXKv3OZYGQ4hBD5BD5y0JvN+PTO2vNgJLU2GEwfpObFIZQegidCjvUaI6kyKk
 7bjvQkQ53Q8MvoJgecACWizudMMAhmBJgqdfNfQ0GJVGKOG8YLheq2cOwb9JocAtg9Lp4V27dy
 5Sg=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173265889"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 10:55:29 +0800
IronPort-SDR: WKsFFzRVeADC7s4lGFnSCDvlxOxCuZ3vjwEeevXx/WMcyvhKiZ9a7Yu2ITZgbRHGINsnNovg9u
 k/UPCiVVBoC3Aw3T0a+Yk3eypCDbuaz6lOJE58M9O/N3mBdsBnarnzFMSGHz7b/zyBORbuB9AO
 ZS3KK6z1At+nRGbDaPpip/Us/72A+WtpSfWDMnNZwKwRWjrrJOF+idKodNVqY4wZfZ9g6FzOKL
 3Ar7I9EWJthawwVljNsRs6GlFbVP4NR8h9zksJ0rnBSGqBQHyxVE50fhzI+AMWZztoV5BaP+LQ
 DGUtPT6CvYod78ToGcoC9gNH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 19:35:09 -0700
IronPort-SDR: CuvPZHrPla/TVDDGGoSewdiLJMlRfKOvCYdPzeqA8RxHcPVR2dl0IOkV5qhlQo+JZZJjwj8sJB
 DPIxlEKaBfxGAA0vzHGDJ+O/T8v2MFdHDO/d/x5KRnfq1VEsQEY6IHN06gPMph399cgo8XPatK
 aJbQ6oqP2XxH8mX1HABAbpt9K29cK5gwDBhbrPUyRGrOfyZWMa/4DOLjDpEAUNUKtu8BDNqEK7
 Q7wG+15WcWgSvyIIXaCvXEuNievVKCcxMiB1HP0yY7fhnYh2EOMxB17wVLcjQ10A/OiUcjQQY/
 Ik8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 19:55:29 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 00/11] dm: Improve zoned block device support
Date:   Wed, 19 May 2021 11:55:18 +0900
Message-Id: <20210519025529.707897-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series improve device mapper support for zoned block devices and
of targets exposing a zoned device.

The first patch improve support for user requests to reset all zones of
the target device. With the fix, such operation behave similarly to
physical block devices implementation based on the single zone reset
command with the ALL bit set.

The following 2 patches are preparatory block layer patches.

Patch 4 and 5 are 2 small fixes to DM core zoned block device support.

Patch 6 reorganizes DM core code, moving conditionally defined zoned
block device code into the new dm-zone.c file. This avoids sprinkly DM
with zone related code defined under an #ifdef CONFIG_BLK_DEV_ZONED.

Patch 7 improves DM zone report helper functions for target drivers.

Patch 8 fixes a potential problem with BIO requeue on zoned target.

Finally, patch 9 to 11 implement zone append emulation using regular
writes for target drivers that cannot natively support this BIO type.
The only target currently needing this emulation is dm-crypt. With this
change, a zoned dm-crypt device behaves exactly like a regular zoned
block device, correctly executing user zone append BIOs.

This series passes the following tests:
1) zonefs tests on top of dm-crypt with a zoned nullblk device
2) zonefs tests on top of dm-crypt+dm-linear with an SMR HDD
3) btrfs fstests on top of dm-crypt with zoned nullblk devices.

Comments are as always welcome.

Damien Le Moal (11):
  block: improve handling of all zones reset operation
  block: introduce bio zone helpers
  block: introduce BIO_ZONE_WRITE_LOCKED bio flag
  dm: Fix dm_accept_partial_bio()
  dm: cleanup device_area_is_invalid()
  dm: move zone related code to dm-zone.c
  dm: Introduce dm_report_zones()
  dm: Forbid requeue of writes to zones
  dm: rearrange core declarations
  dm: introduce zone append emulation
  dm crypt: Fix zoned block device support

 block/blk-zoned.c             |  87 +++--
 drivers/md/Makefile           |   4 +
 drivers/md/dm-core.h          |  66 ++++
 drivers/md/dm-crypt.c         |  31 +-
 drivers/md/dm-flakey.c        |   7 +-
 drivers/md/dm-linear.c        |   7 +-
 drivers/md/dm-table.c         |  21 +-
 drivers/md/dm-zone.c          | 691 ++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               | 203 +++-------
 drivers/md/dm.h               |  32 +-
 include/linux/blk_types.h     |   1 +
 include/linux/blkdev.h        |  12 +
 include/linux/device-mapper.h |   9 +-
 13 files changed, 967 insertions(+), 204 deletions(-)
 create mode 100644 drivers/md/dm-zone.c

-- 
2.31.1

