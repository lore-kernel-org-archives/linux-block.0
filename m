Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43577C56201
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD1B20789
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hA5I9ime"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgKIMvi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:51:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43846 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgKIMvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 07:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604926276; x=1636462276;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P54iPOl5qnG2p5CzwD2BBLquaomeh0qmBKaQFP/SQRg=;
  b=hA5I9ime1f5C7a/svYZbex0hcDRKI5xH5Kvg9FJWa+3ykYnYYrTJoasi
   wkpojwxqdxnb9mvY9ACuZJK74ud0zzsvl0kQvaLGlH0OvT1WReiaMwCj6
   UVYwHq4i5cCDqhVjCIutgR/p0wBhYl4Mq+mvgw/deEquR1NI65ZDp0xIO
   h55p0+k6+iF/4cXDEaMgKW/kO+v/nNPh+7dZ/Kx6Fqr5w/R/KFO8V3WkM
   0kxu9meDRgZ3auw0I+AYSx+w1mfUWvzrH3ZA++hO2nEd5DwCap22oUBjE
   qYtLMveWsJBvG06tkTGiwoUxJQu2F7687oViW43JvbwvZyLzrKGrZM0PD
   g==;
IronPort-SDR: 4m/qGSJZnP+AAd/cWB8FIOmR+0spjftg2umWJb6/Si6vFdnMbyKl6ybR41MGceVEw69l1Uh5L+
 1CBMG0ZSR85X5RI5xqqUEOV8g4FfwpKhQmj5nSxW1W+Y4JyanS2KUmNh6QJkodg6+lmHw7xso+
 yCT9+owntaepPBuVuKuFjhL6rNUrA2OJE16pLosco3H2EvdZpyBzvBrjkrqG56u7mPMEgMcFHc
 RNhBvQBZ1WwhV7c+AUefPMGGOxJyVEqS9PQavIdwdnKC/QL/seKV11UwANFvWx9148lf9dJXcM
 iTg=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="156668395"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 20:51:08 +0800
IronPort-SDR: 6vgqxBcOb2jg4ai9U3DstTRAifUxWOEl/F1ScHVn2gRLI+3f3FAkw6IT6qC6ievn6BrXosOe9P
 j7bxHDWXWr2Df4710MD4kjyI29h6h8q4zsUXli3CD9FlRny3NbcVfIZYtD9320ueQwqm/gT6uz
 Vj6JctfvGjP0u3rsVkkanG1xoxG3xWoVeNOxmGTUGlNUvrS/y55YXj2YnzGI5O39Z776aVwTt4
 ByGtX/LH8g2PhC8p/Xoqdb23SGdAdMs9TKZRLF8iJSZ8ha+lZv6DpDQf4RgQK837jqVTmAJcv1
 fhXfHhmjQ9TbqaqvKHkp/obq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:37:11 -0800
IronPort-SDR: +7RSBrRmBmlEqniFjaOSnFtRTYj3bMhCg/rBnF/jZa/icqLuvHS/jG6+h/2J4mMtd2FfaqXT6S
 +lJYn9mLLaEMy1XPDg4+owIP9bhfeYWau+GeYhwF1BcyjVKkB4JA3ZGcCog7SUt/ZrVewBOpzk
 MwWx8GZe7+SnW0KyR9OSKaChvE+fydTL/qW0hPrEoOo99UYG+526Np3AGjQrnonjDe0z4s5Gec
 VpiTrhG223DszN+t4VyieUDOPEiuNDNzsrpQTJ1mcP6y1OwLdygqLn/gsQDt/HLFLtC7mYo1su
 4aU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 04:51:08 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/6] null_blk fixes, improvements and cleanup
Date:   Mon,  9 Nov 2020 21:50:59 +0900
Message-Id: <20201109125105.551734-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

This series provides fixes and improvements for null_blk zoned mode.
The first patch fixes a problem with zone size initialization when the
device capacity is not a multiple of the zone size.

The second patch improves zone locking overall, and especially the
memory backing disabled case by introducing a spinlock array to
implement a per zone lock in place of a global lock. With this patch,
write performance remains mostly unchanged, but read performance with
a multi-queue setup more than double from 1.3 MIOPS to 3.3 MIOPS (4K
random reads to zones with fio zonemode=zbd).

These 2 patches could probably go into the current cycle.

The remaining 4 patches likely belong to the next cycle: patch 3
improves zone implicit close, patch 4 is a small code cleanup in
preparation of patch 5 which allows freeing the memory used by a zone
when the zone is reset with memory backing enabled.

The last patch is another cleanup which moves null_blk driver code into
its own directory under drivers/block/null_blk.

Comments are as always welcome.

Damien Le Moal (6):
  null_blk: Fix zone size initialization
  null_blk: improve zone locking
  null_blk: Improve implicit zone close
  null_blk: cleanup discard handling
  null_blk: discard zones on reset
  null_blk: Move driver into its own directory

 drivers/block/Makefile                        |   7 +-
 drivers/block/null_blk/Makefile               |  11 +
 drivers/block/{ => null_blk}/null_blk.h       |   8 +-
 drivers/block/{ => null_blk}/null_blk_main.c  |  43 ++--
 drivers/block/{ => null_blk}/null_blk_trace.c |   0
 drivers/block/{ => null_blk}/null_blk_trace.h |   0
 drivers/block/{ => null_blk}/null_blk_zoned.c | 234 ++++++++++++------
 7 files changed, 196 insertions(+), 107 deletions(-)
 create mode 100644 drivers/block/null_blk/Makefile
 rename drivers/block/{ => null_blk}/null_blk.h (95%)
 rename drivers/block/{ => null_blk}/null_blk_main.c (98%)
 rename drivers/block/{ => null_blk}/null_blk_trace.c (100%)
 rename drivers/block/{ => null_blk}/null_blk_trace.h (100%)
 rename drivers/block/{ => null_blk}/null_blk_zoned.c (78%)

-- 
2.26.2

