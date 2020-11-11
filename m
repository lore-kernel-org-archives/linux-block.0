Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A163C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D86F20729
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FvSuAV5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKKFQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:16:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43928 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKFQv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071811; x=1636607811;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V+1pxFE3wfVWNzNv6wTByGQUOkJZV5/eLfE5mwWWuXM=;
  b=FvSuAV5k4UCYKGk2FYUbiS05i2CDH8H5fDZlD9/5LF3ZPLRWWkq+BGHL
   Fm3uUk4VqheQ4I/q52nJ9vLN8wI4vMjrvSVwUGpNkJU2W8852ucNEnLwq
   OGi8hoF+iSVrPFv84mr7gwvyi2FoHBvDDtHVNPXaekbscWtV0FVfPbAnq
   4hisncM+JUEmZ28sYeC3CsOYRhtMVxepa2czLtjDnXpRpd0TRZb3RzAf2
   x6OzBPayF+YlnjvVfXctZCh3CQERflTY2P5g9xy9dFoB1q10xnys7U/jC
   Tk6Z3rkmy56rFKXNKlIeH5391XXR6SJ8CFteUe+6u/Fain88Fxzjz5v/V
   w==;
IronPort-SDR: M2CwHEFDQEagBinIhoiSOKqIz6xIV9MmvMy6bkaK6SZRr2ETpIMpxgOArskBIFd9Swydr4r3iQ
 /3vaN6ttb5+5km2I+/HIcu/0nsh+brNDajLTQ3IQ5j96bWWbSQ4otkQQNxjoQDZeSQ51ZonYx8
 mTCjIlKfqml8sKzAeqttHepNSDA1Ca5lmCznUkAjWRCjTGB9HGllTiXSfyI1v7z6F+RXtwclVS
 T7Xw9LegDbmt+t66W/2Ludbpxr32/hgGcbNvFKub1Uad/BukpK05Mso0QWoUi9S8HQt5uHwCzb
 jMg=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152254624"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:16:50 +0800
IronPort-SDR: z1oUvW9U2t+4yMlNnY/zrymdlWqQ0z17NYB2n6u9NNQMhSOhCqO3OgypaQQRnnDd7smtu2uCUZ
 4Z2nYBa5brrNK8lMmBwUochSYLhm6ZUUzm4GecH28637HwuYhfr0M5NeQJDkKsL+935bYcAgU4
 tyg8hND935f8flZbnbXerFNoWcJJgHrLb9h+egtbC6IpC4/JawUH4TwmIbDGCcWjXs3N59k+e6
 6Gt/ULKJ90YCT8k5ilitsCmSArVorO0CYPewt3FHctaQc28xRYS6rY24lZ/XCFD/otOYnrOSEI
 ndsLZyvC/BMHYrHlgGUkwlJj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:01:37 -0800
IronPort-SDR: lFsDvR/UHZTaGd/jxi6nBFqBG/8vqGrGtG34DSUvGzY19Gh+tPnpoeJWy5wyszZtW5Jx7h3Y8F
 JFcRFYAlZqxZrqfsV9iMefvRRb/HWHVwQgEyw7s4u99Knd4oDp5bSJ8HvIzn4VkX3NQqZUrwMZ
 VP6JayWJtJ0Fapfy3Lj/LUzAQ60CmQyWHZM/b1ft18dZc9Tr6RXUv4mypUCpF/OT/xTk9ymawQ
 0/nTxEAglyx25PH/PwsCFuRhRvJh1DcweI+SF4v0e6thxMXcv4/AkWXYyy2GtjAt1dLO87MAMd
 Mjg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:16:50 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 0/9] null_blk fixes, improvements and cleanup
Date:   Wed, 11 Nov 2020 14:16:39 +0900
Message-Id: <20201111051648.635300-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

This series provides fixes and improvements for null_blk.

The first two patches are bug fixes which likely should go into 5.10.
The first patch fixes a problem with zone initialization when the
device capacity is not a multiple of the zone size and the second
patch fixes zone append handling.

The following patches are improvements and cleanups:
* Patch 3 makes sure that the device max_sectors limit is aligned to the
  block size.
* Patch 4 improves zone locking overall, and especially the memory
  backing disabled case by introducing a spinlock array to implement a
  per zone lock in place of a global lock. With this patch, write
  performance remains mostly unchanged, but read performance with a
  multi-queue setup more than double from 1.3 MIOPS to 3.3 MIOPS (4K
  random reads to zones with fio zonemode=zbd).
* Patch 5 improves implicit zone close
* Patch 6 and 7 cleanup discard handling code and use that code to free
  the memory backing a zone that is being reset.
* Patch 8 adds the max_sectors configuration option to allow changing
  the max_sectors/max_hw_sectors of the device.
* Finally, patch 9 moves nullblk into its own directory under
  drivers/block/null_blk/

Comments are as always welcome.

Damien Le Moal (9):
  null_blk: Fix zone size initialization
  null_blk: Fail zone append to conventional zones
  null_blk: Align max_hw_sectors to blocksize
  null_blk: improve zone locking
  null_blk: Improve implicit zone close
  null_blk: cleanup discard handling
  null_blk: discard zones on reset
  null_blk: Allow controlling max_hw_sectors limit
  null_blk: Move driver into its own directory

 drivers/block/Kconfig                         |   8 +-
 drivers/block/Makefile                        |   7 +-
 drivers/block/null_blk/Kconfig                |  12 +
 drivers/block/null_blk/Makefile               |  11 +
 .../{null_blk_main.c => null_blk/main.c}      |  65 +++--
 drivers/block/{ => null_blk}/null_blk.h       |   9 +-
 .../{null_blk_trace.c => null_blk/trace.c}    |   2 +-
 .../{null_blk_trace.h => null_blk/trace.h}    |   2 +-
 .../{null_blk_zoned.c => null_blk/zoned.c}    | 245 ++++++++++++------
 9 files changed, 239 insertions(+), 122 deletions(-)
 create mode 100644 drivers/block/null_blk/Kconfig
 create mode 100644 drivers/block/null_blk/Makefile
 rename drivers/block/{null_blk_main.c => null_blk/main.c} (97%)
 rename drivers/block/{ => null_blk}/null_blk.h (94%)
 rename drivers/block/{null_blk_trace.c => null_blk/trace.c} (93%)
 rename drivers/block/{null_blk_trace.h => null_blk/trace.h} (97%)
 rename drivers/block/{null_blk_zoned.c => null_blk/zoned.c} (76%)

-- 
2.26.2

