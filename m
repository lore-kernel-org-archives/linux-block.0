Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E79AC4707F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B206138C
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEYV0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36430 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhEYV0e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977904; x=1653513904;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O4unyN5qCc+ZJCBhhthG+VPqTWJlcHTvjYW22aMZC7w=;
  b=bP4hsbqv6wycP5SgLDbfdIhHZTEmFKY2bpla4oUlzpQ8MhG+ZYym3dJo
   RqzVyvmX1ILJ//GSiTJiIKJDXifYNSBihootc4c9xqd9vbqt4/mK6f7WK
   geXrr22EyefTakRW1R7Eiry+1TLxGI0TNghQZvOGcMZUprM7R8c7PFGL/
   CBPVRk2LPcjNR3BrMAw9SQKteYgm3jvJIwJwXgI1a3VXeN19N+EIqUiqK
   HHu7MIFqbyXVa/0CNM5WNnZP9+VLyP501mVI4qI6BRsWFrOp7RdDb7Zod
   JHfgVF2Ve/unrfUmaAi5GfwYoobmT68dcvqSMYnzceyoBrqNV1ehGZF1q
   Q==;
IronPort-SDR: U200Z/yPfX/62ljK2cxFSrMhTmqD6t6IK+6cdkvUXChN6E4CMeELx3wdSo2pfK+x7swosWBYC2
 uw9IKZqjlXpsaiMmfYeD7gSgEKNSeZxbHxEnGdCSHoy7SFO1l4VleFiQ4Y2V3uvZrVJ7pFf5aF
 lVNu41mVWW+ER6qY9sRUB1ORkeddyl+9drAkJtaATKW/rO2Os6W/oVlZxPllfw2yX1zedixFZa
 GRGbbYwx6c7KYDEXaJJMm+3F/gUiKZfnZV01rq5AvjbXHm7VEXjKC0Z+G6Kp5AgnIrGyBc7Gww
 elg=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717508"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:04 +0800
IronPort-SDR: y0TtFXKqYgQN8P9we7OFaTfqpelkE7qV3zrLF1a/5NaUJzbSFf2ClsMAa4mlONgr3adRQgoMWW
 amXiGvXBtT1BJgrW/BRmrjiavxgAc1dXe5/aMoexNa4r7Od6UbCaJ6445DmUmeCcexG0f4BwXi
 6nztkVTJRW1wgEKkpxZSWPH09eVsOFFd8ID+lpJ1ixRa/wQFJaLxbGaOSYxYztcuz4H3yoXYw6
 7nsTC3fE1q0F8PMsHlKyhmp8h9IKaUIPBytzOaWB/6g2cMNIMv7DUVhvH/NSGivEwFxURv4Jsd
 sw6qnXJif6UYsdsF1p1s/cSS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:31 -0700
IronPort-SDR: xWy5TXbJxL/WICIduGJeqXsWqGXSHJsOL1aq+twxCdZeMwkruoxv0K7xlBbzMzn8pAfV52XMmz
 2PTC51bhtyyMP+rV9vnOL0QIR7lALawp9nTy6RIppSzxcMFLxFvJxoHbS0MertIL4DNEz/3/Gv
 HN4I3h9XxYK8irIZeDUVxHCPBQNg7u8y2uTY8H3n3otPgJ6L8sBEa4hYqOjyn8uh/iAv34Hs5V
 jr7IIejAa5l8iNt/pxgf1oLx/4hahgss/vWSKjI4Yd3HHRLgAiY6HfxLFgIy1ufpCL23P+NuEU
 zn0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:03 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 00/11] dm: Improve zoned block device support
Date:   Wed, 26 May 2021 06:24:50 +0900
Message-Id: <20210525212501.226888-1-damien.lemoal@wdc.com>
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

Changes from v4:
* Remove useless extra space in variable initialization in patch 1
* Shorten dm_accept_partial_bio() documentation comment in patch 4
* Added reviewed-by tags

Changes from v3:
* Fixed missing variable initialization in
  blkdev_zone_reset_all_emulated() in patch 1.
* Rebased on rc3
* Added reviewed-by tags

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

 block/blk-zoned.c             | 119 +++++--
 drivers/md/Makefile           |   4 +
 drivers/md/dm-core.h          |  65 ++++
 drivers/md/dm-crypt.c         |  31 +-
 drivers/md/dm-flakey.c        |   7 +-
 drivers/md/dm-linear.c        |   7 +-
 drivers/md/dm-table.c         |  21 +-
 drivers/md/dm-zone.c          | 654 ++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               | 201 +++--------
 drivers/md/dm.h               |  30 +-
 include/linux/blk_types.h     |   1 +
 include/linux/blkdev.h        |  12 +
 include/linux/device-mapper.h |   9 +-
 13 files changed, 954 insertions(+), 207 deletions(-)
 create mode 100644 drivers/md/dm-zone.c

-- 
2.31.1

