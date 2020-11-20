Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17113C388F9
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF9722255
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 01:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TiI/DhPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKTBzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:55:42 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6553 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKTBzl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 20:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605837341; x=1637373341;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qZLwtJZJLuSMQnzgPEPlsWFqjRL4sKLV7bdetrg+OlU=;
  b=TiI/DhPqXGiibUxxKdt+nZoBnFwXIsBQGcXffJAGSOOFcH+HZS1/83Cg
   eZA1F1cvW/yI1SERiiR5dJJqZm157CgNXOfHokpZO5rVJtLYPBDXyY6go
   HKDB6M5wSHCiDXf1xGLZjh7n4wTvvtWYH/ZoVagiw8NBwhxd363cg3Xbj
   PRqKhAB1VN1fXLyrSXt/V0oWkUNlXM53H19lArq2ZfxYQZISA51Ujs8QC
   G6fHl9q+hU4rncYpiTE2oqdYql6iRadmyln4Ior+08J9lfe+fj9iPNClM
   459/tKlOEe3XL9hjPhenOYH+RWaNzk3ITY+pYE8kt3P9B/LcLLEHk8sN9
   A==;
IronPort-SDR: HoQYGonXEMTZfG0WdfF1E6wyq58enlrAX9m0bFE5tMLJLpd0s9zIp055qrsQNFH0NYQyIattei
 o3WkvMebuGX/S6uH+QFMv+FY5mAK3luacAyBvJLzA/CpvOzGuuEcTh+lld9oAOmiO+sKJfIgZj
 LKyOCIYBY5szkmdsYae4JM0e4usPK+5egMnC3oQAiGH++87JJwz0htxKPaNwMSZykQAX5RHZfk
 UUi2E5EcyiXOTUYDw33OoCKABvMHMlKTQZVfDchKZuxGSTZG0At2rzWg1MFcLs3Mt54gSYZdHF
 CMo=
X-IronPort-AV: E=Sophos;i="5.78,354,1599494400"; 
   d="scan'208";a="157516398"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 09:55:40 +0800
IronPort-SDR: 3b+20MyOQBIZkNBV1H5UhzniCRalBr6vGGKzzWigxXPYXhudbQ5GniIwJpo1DF2yFXlww93E7C
 nY49ayswrnYXuafM2dKn6d16kFka1T1WUS7xXNEidKfj83VDoZrWvjEGE/5+hvOMXLTpYo5JoD
 chJdVJVeHw+N/N6GCS/Jrk89KNqF3yKgNY0a+f7kehgtWa1tC2TBhEedEHT22lMppw5OXyJb49
 bPUfVV2CqE9jLEejZv3tJL90lBhQ2taIsNHvE+YwuLFCWM7EU3cFpbTycbcEZJpdabyO3hQRq9
 ZN4CGV8IKoh+liVlnc+EXjc0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 17:41:30 -0800
IronPort-SDR: ihFYuo9m7MyurT3HdK5/hZrfJWQWBgRfyqdjsMi1x4CSB4HBjpLjnicSX0QbzWON49wlM2wc4z
 0Hl/tIFwTAUORaxJo93zmwLUqK0dbBcZyfWti1z1cQJlqJOKJD3FlEN+Pwbh1Y42pABzZFv20E
 z0QBYFB9NL1SsVPoTrvwx0jIC+LjJ1ewnbQQdXU+qyYF6V5XdmqQAfAI8gHOK9JDUtydOsMFtG
 rkmTSMA3CQMeLDPwyLcd2R/xTAAXc7h6Jo9T+Mf7U4qXtlFD+2JP97zXb446kuY2CzgB4mel6w
 o8A=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 17:55:40 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 0/9] null_blk fixes, improvements and cleanup
Date:   Fri, 20 Nov 2020 10:55:10 +0900
Message-Id: <20201120015519.276820-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
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

Changes from v3:
* Use inline function for zone res lock instead of macro as suggested by
  Christoph.
* Added Reviewed-by tags

Changes from v2:
* Make patch 3 a generic blk-settings fix
* Reworked patch 4 zone locking as suggested by Christoph
* Small change in patch 6 as suggested by Christoph

Changes from v1:
* Added patch 2, 3 and 8.
* Fix the last patch as suggested by Bart (file names under
  driver/block/null_blk/)
* Reworded patch 1 commit message to more correctly describe the
  problem.

Damien Le Moal (9):
  null_blk: Fix zone size initialization
  null_blk: Fail zone append to conventional zones
  block: Align max_hw_sectors to logical blocksize
  null_blk: improve zone locking
  null_blk: Improve implicit zone close
  null_blk: cleanup discard handling
  null_blk: discard zones on reset
  null_blk: Allow controlling max_hw_sectors limit
  null_blk: Move driver into its own directory

 block/blk-settings.c                          |  23 +-
 drivers/block/Kconfig                         |   8 +-
 drivers/block/Makefile                        |   7 +-
 drivers/block/null_blk/Kconfig                |  12 +
 drivers/block/null_blk/Makefile               |  11 +
 .../{null_blk_main.c => null_blk/main.c}      |  63 ++--
 drivers/block/{ => null_blk}/null_blk.h       |  32 +-
 .../{null_blk_trace.c => null_blk/trace.c}    |   2 +-
 .../{null_blk_trace.h => null_blk/trace.h}    |   2 +-
 .../{null_blk_zoned.c => null_blk/zoned.c}    | 333 +++++++++++-------
 10 files changed, 317 insertions(+), 176 deletions(-)
 create mode 100644 drivers/block/null_blk/Kconfig
 create mode 100644 drivers/block/null_blk/Makefile
 rename drivers/block/{null_blk_main.c => null_blk/main.c} (97%)
 rename drivers/block/{ => null_blk}/null_blk.h (83%)
 rename drivers/block/{null_blk_trace.c => null_blk/trace.c} (93%)
 rename drivers/block/{null_blk_trace.h => null_blk/trace.h} (97%)
 rename drivers/block/{null_blk_zoned.c => null_blk/zoned.c} (68%)

-- 
2.28.0

