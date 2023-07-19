Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F10C001B0
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 22:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGSWCq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 18:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGSWCq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 18:02:46 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AFB199A;
        Wed, 19 Jul 2023 15:02:43 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMFEZ-0008I7-1O;
        Wed, 19 Jul 2023 22:01:23 +0000
Date:   Wed, 19 Jul 2023 23:01:14 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Daniel Golle <daniel@makrotopia.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [RFC PATCH 0/6] nvmem: add block device NVMEM provider
Message-ID: <cover.1689802933.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On embedded devices using an eMMC it is common that one or more (hw/sw)
partitions on the eMMC are used to store MAC addresses and Wi-Fi
calibration EEPROM data.

Implement an NVMEM provider backed by block devices as typically the
NVMEM framework is used to have kernel drivers read and use binary data
from EEPROMs, efuses, flash memory (MTD), ...

In order to be able to reference hardware partitions on an eMMC, add code
to bind each hardware partition to a specific firmware subnode.

This series is meant to open the discussion on how exactly the device tree
schema for block devices and partitions may look like, and even if using
the block layer to back the NVMEM device is at all the way to go -- to me
it seemed to be a good solution because it will be reuable e.g. for NVMe.

Daniel Golle (6):
  mmc: core: set card fwnode_handle
  mmc: block: set fwnode of disk devices
  block: add new genhd flag GENHD_FL_NO_NVMEM
  mtd: blkdevs: set GENHD_FL_NO_NVMEM
  mtd: ubi: block: set GENHD_FL_NO_NVMEM
  block: implement NVMEM provider

 block/Kconfig             |   8 ++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 187 ++++++++++++++++++++++++++++++++++++++
 block/blk.h               |  13 +++
 block/genhd.c             |   2 +
 block/partitions/core.c   |   2 +
 drivers/mmc/core/block.c  |   8 ++
 drivers/mmc/core/bus.c    |   2 +
 drivers/mtd/mtd_blkdevs.c |   1 +
 drivers/mtd/ubi/block.c   |   2 +-
 include/linux/blkdev.h    |   3 +
 11 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 block/blk-nvmem.c

-- 
2.41.0
