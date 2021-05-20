Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F58C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A89611AE
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhETEXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:23:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhETEXu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484550; x=1653020550;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BeEbylTxICYxyd5YyldDLa97h4tezbzf3NQx15RvkeY=;
  b=XzPBEM0JD/nKRmNDjdXjnU19G+qclz5kLqCjBu74yJA4uAAkxdzQJeqe
   jb8WyEIn6U6G+Vr4tdimOtkgDrL5JHN3NKbLYVE30Cz7zMZK5HcIeft5k
   5KdczSkE26XxGw7uMwc1v5ZNsUdlVwH+9onR9lITCTavlVr8bbA17gFF3
   ro+6McGU8JnTwlcovmGuTqHIbkPTlkN5c3Wet6p3zMsO2ETQze6wtW6CT
   KL16SCHNkmLXEFYaEMSGmPMcd9Yzl+mQucoyAKZG3CKqiu6vvInRrQqUL
   Smjs42vZmWfh8TTWkThJWxUAqvQYqFpCddjsyO6jR+/W9kOGQXc3ruSvy
   A==;
IronPort-SDR: E9XPQr3CbIYgKx4v7/KHSlYj8a1ydruCE3oka+e4Vv+XBrgXPwixjLqgCTHIOyBJGT7MeVH1XH
 mKLGaDiVavRA6x7twrHjGD3dzp95OYDh0J8wykcnoJ4BZmel/3fhZBb30/lA+lzxcH2QtSyozs
 7KVSctPAOlooRMzqeuTsDl8Ec9t5np40lYIjzDlhRKNGd85o4TDskrXxMgCKMzNLEWGjuA1s47
 UpvtcyRL8pOzMvanUJJvO6+Q61pKM1Lbg5db5ASJ//2gQu25TLpIvguh5T5XDeqhZ2Nx+kjpRm
 c5w=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105829"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:29 +0800
IronPort-SDR: lkUBY52D8F92aZNrgckpEiAuBMCeOntfT5UZrIEufCQ5sEw2TJkfXc5B3xXQRg6gqhES4ZE9K5
 j9QDD17r0ybBND1h91PaDU+v5ahHgYRyMLX2rwGeg8Nd2Btoy76dao83QpSUBUR0R6JWz6o0TP
 eWn/sV/8WjKZnfwpU97rlha2hrV4ZF9AsdKT5DzbM9OgOfdb/JuI2qZOmARUmkfLmjvjgdBzlJ
 Nqm2R1ZxG0OQRe1Sh03UvZtMaWho3CtOtbc4pKNZ2mS4r1cBoelhNIwoTrJpxZDZlA2bNHFvvm
 S4Wf774oBliVPMuOMgtwU8Fl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:06 -0700
IronPort-SDR: kqkx6Wgss/J1P0XbNojevRZX6KCllmhPyNFdKU7WOHMBrlhfHpIfJW142FtWDL8KffHOxpgJuw
 AB4cOEMViGbThbO0F68lgS/H3lobe5cow8FMHOpjnM+OEo2BZSviEHcx3qtOmmar427AEESGxY
 zbYuKYqz9wxHxcgbpi/dq8WmFKefB5fYDOfWaTHJ9FxkTKyMyO/cWN6Vfgxis17pDZykmUXZ5g
 6BwEPysC09/VvoiHQP1fYX332HqZYJ5Sc9Tm7DU8NCN950O4SPRaeK4jvyfINuzbvEJFLKYx79
 NTI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:28 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 00/11] dm: Improve zoned block device support
Date:   Thu, 20 May 2021 13:22:17 +0900
Message-Id: <20210520042228.974083-1-damien.lemoal@wdc.com>
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
 drivers/md/dm-core.h          |  66 ++++
 drivers/md/dm-crypt.c         |  31 +-
 drivers/md/dm-flakey.c        |   7 +-
 drivers/md/dm-linear.c        |   7 +-
 drivers/md/dm-table.c         |  21 +-
 drivers/md/dm-zone.c          | 689 ++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               | 203 +++-------
 drivers/md/dm.h               |  32 +-
 include/linux/blk_types.h     |   1 +
 include/linux/blkdev.h        |  12 +
 include/linux/device-mapper.h |   9 +-
 13 files changed, 992 insertions(+), 207 deletions(-)
 create mode 100644 drivers/md/dm-zone.c

-- 
2.31.1

