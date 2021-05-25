Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14887C2B9F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45B86141D
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhEYC1J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:27:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34067 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhEYC1J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621909540; x=1653445540;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6KcUWNHYsY7ETS+NXmbH4WQKrTLvtOpubjnYGbgeOyk=;
  b=PVOPHjfOcscDbtNQXBhs9IKP/0pvJuVQGvTziMWuM54fd35VZU94Zoh6
   QVSBhEsWLLhY/wrG3ShpXQRaNsvkrf2RMIZCH6CeCYqcHW5Akjq6nwJD2
   74oefthCzcAcpwh+zp++JRUjOHjlekMTwp/kIFkq4LDGudHgJCguVTCFo
   tEhfw9FJOBks58jDC//HmRTQJApf+8+r2nPy0FmlCXI6ZS1+HnyCtbm/o
   TeQUYEs4uAvXU3yv8S49RkuzUrlAo4l2xUv4MlBf+ztjEXTe3iK5SekW9
   EwCbffD88VOYvQG0F2sOFBnKzdpFqB1vOPil/CQTYTR/QrkgYpzDKRT3/
   g==;
IronPort-SDR: KWPHfUc5AGgCISl8puT87z3R6Y/hL1oKHgG2U0fTbaS4ul9dF9Nzm8Cj8xApyo3/HnPd/8Yp2S
 bjkCVewLdsSBm6L4HuLdjllWSYtomeX66zutAT8lSw9ahrou1xKVsnKlHnOYUGeIDpOj1k565X
 XqKmKOe7hqi+pqytDC9iQIBIl3DUyEtmaZq4Bq5HNIg0QgSoVQ3Cx3v+QQfh4uPqMXQx14EClv
 1dH+DUmD6J75VQbGMiXspIfJEuo2UhWgcSTBBvY6TfjZ7nu1rmziEHkan+4dInUN+sG2Jul8od
 6ww=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173981313"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 10:25:40 +0800
IronPort-SDR: Ll1v6/ySsVW22x28t1L1ZOQm5ilHZyoR7n6VKADG36gphdYlJ5PnmkwmMik17l1xfT+o0rF75x
 QNj8HOVaU6j2wb4YlBbs0VFB1nbUj7Sfs1QVUbLVjnSlffe5CcBM+GU+hj/vWDOhIgCpQV1uun
 IxpcZLeA3S4b4WcAzkIGYuWuuHSHQE7jL/HzU/s+H+EG/vBIDQsvxV415lUSuCJvDv5PksiK+2
 rm46UtX9Hw4rPOTcDfDNBqOYJs06qOPXHInW5Hp//uUWWge887KIwHRzMMKuRnfFwl4dWIYKBD
 331xojVcGl4zZQXxzOK784q6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:03:54 -0700
IronPort-SDR: WoCjn06vNnQAlnlv1p4iyV9s4DNGMjYjHUm1ASW0KfxEitteLFLdaj3FY5cBjAZa32G3McnkVK
 Oi9FzceS1Y/i4iTUuH6YlZGHeVbr5zZ0nuU9vaVkCa3KZgDTVVp5GYDAH9/7wiV5TGynddjy10
 u2Rm1QheboeiSrQc1lsFWNxLSzqUsD92scXDHdhUFbUiH79QBFEUY5Ov69CScLbtu/lWlusi81
 meq8+InorQl7rk6/efvkAdDNbV/Zeo3s3V/wTV+S34bNavhcYttxUgvEVkmBMaA1zDvzVd4zTE
 4X4=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2021 19:25:39 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 00/11] dm: Improve zoned block device support
Date:   Tue, 25 May 2021 11:25:28 +0900
Message-Id: <20210525022539.119661-1-damien.lemoal@wdc.com>
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
 drivers/md/dm.c               | 202 +++--------
 drivers/md/dm.h               |  30 +-
 include/linux/blk_types.h     |   1 +
 include/linux/blkdev.h        |  12 +
 include/linux/device-mapper.h |   9 +-
 13 files changed, 955 insertions(+), 207 deletions(-)
 create mode 100644 drivers/md/dm-zone.c

-- 
2.31.1

