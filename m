Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41D4C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834816121E
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhEUDCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 23:02:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhEUDCn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566081; x=1653102081;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XCJD+7N6tk0F5upMycnIBKbx/cj9V2Tc3B8pA0JgAT0=;
  b=qJ1ad4D1DhoB6ScngzgZ+jLKrQKNlQGLR4aKnZPhziKpmMPlYyOCXDym
   HU8sV5SWGIoO4bpUHI9VlSLz71jwfrAYQ6xz91OUG+U4IhoM0p7GhHWVy
   WOgI/dTEX+yhoe+/dLAQNaBSIPzM9FSupPOtDWb2F+vLMNohasy2+Qh2D
   GIdRfJ1tmAfuDSCUYUC1UWAhwYOIg0cBgG6PvD/HhIJ2hWbtQQ35T3KMt
   U8JsQTBH2STjYJa4dtiUQG4ZIwq4lrd0gEidICJ9oLMtiWYH+z/JcImMp
   8E9UFmn+j60do6xUsmMsuRrv8sTYM5GibCqfY5I8//TVKKvKqgz4s1OZE
   w==;
IronPort-SDR: ivvbesDdTV/DqT/NhTN9Ow8V+82NBReB670BbXZcWZ2jcHb5DNAE6XKevxxh//0xW/+SC0fEjZ
 NEQyqIM41tZfIKYu6/4MhfyqNm2SUrXXOcV9LljCk7i+ww4mvTJo0gkPJRhBM4xCbRgYMwpCnB
 mqmEmMTEqfDrZyNNrK5I4izKqWui0PZEAkrm21188H9JeXdfkUqycSVCAHRSf35lS76z8fqXB3
 Qk5Mz6sYqqS6b6bvoYjWboVjK+6OX/R50qip2G50L8SKqo1dMHot04uamFapaulKKXFa6e3DTp
 NbU=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943789"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:20 +0800
IronPort-SDR: JW/IcndtvKblyfRDcZTDgypfiMLBAtDcq6wwDy9wRBpc9Im0OJeBTKMDHuwpk2L/2SUmUGqtBo
 4kG1SO0zFOWKv9mmeY6oCJKtF2T/zIO/r/ZPtCrF/X2fsMJNHEl3go5yb3wEglCK00yArjvWgG
 kzaVD/8q8ANNCJZCrswGh7HSwDMe6USTuWW/7csXepQrwd+eZkoxMiqOHF+mfx3HGP+k+VlPhd
 TQIM1uWJ64M7/RF6ZgnTNORf9FRCE7dwigJ53J9untP31ZhCbgwkC5FIzebkDIJXlYK4klmZ84
 E+u5ztevb1O7ZLrAtySSmjMP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:40:56 -0700
IronPort-SDR: G8GtJBclerJvhX1yly86IfVF6GTofO/iVFe1yIMjDh7WiizhIGHVjghuG6S6/jfl9MC6yo9/l0
 TXSKR144Tna19FuYAQLNIp0sK4pe7eeAyufFUdSp7gKtEn5iRSxz5tXfokgKns6hMib30CXOrq
 npEtXs68TM5d1p4+f5ntgiZOdYYwoIxaFE8vRgi4mxBA0Ow1zfJd3FSQMM3J4G0tFETN+rGyyB
 VDeSisecljL9OYeVOzIqwNfnR8UymPSZH0pkjrDcFvvcHn0oTT4Ab+T1DcLb5FgTgAYRWF/bJ8
 uBQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:20 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 00/11] dm: Improve zoned block device support
Date:   Fri, 21 May 2021 12:01:08 +0900
Message-Id: <20210521030119.1209035-1-damien.lemoal@wdc.com>
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

Changes from v2:
* Replace use of spinlock to protect the zone write pointer offset
  array in patch 11 with READ_ONCE/WRITE_ONCE as suggested by Hannes.
* Added reviewed-by tags

Changes from v1:
* Use Christoph proposed approach for patch 1 (split reset all
  processing into different functions)
* Changed helpers introduced in patch 2 to remove the request_queue
  argument
* Improve patch 3 commit message as suggested by Christoph (explaining
  that the flag is a special case that cannot use a REQ_XXX flag)
* Changed DMWARN() into DMDEBUG in patch 11 as suggested by Milan
* Added reviewed-by tags

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

 block/blk-zoned.c             | 117 ++++--
 drivers/md/Makefile           |   4 +
 drivers/md/dm-core.h          |  65 ++++
 drivers/md/dm-crypt.c         |  31 +-
 drivers/md/dm-flakey.c        |   7 +-
 drivers/md/dm-linear.c        |   7 +-
 drivers/md/dm-table.c         |  21 +-
 drivers/md/dm-zone.c          | 654 ++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               | 202 +++--------
 drivers/md/dm.h               |  30 +-
 include/linux/blk_types.h     |   1 +
 include/linux/blkdev.h        |  12 +
 include/linux/device-mapper.h |   9 +-
 13 files changed, 953 insertions(+), 207 deletions(-)
 create mode 100644 drivers/md/dm-zone.c

-- 
2.31.1

