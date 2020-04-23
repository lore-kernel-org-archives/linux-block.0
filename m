Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304EBC55191
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 03:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5420857
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 03:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BSerle18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDWDCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 23:02:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26228 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWDCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 23:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587610959; x=1619146959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5E8lsYwW2FDbVtO9ANUZD8gxp7h2hqPAsvgt6X+EmoQ=;
  b=BSerle18BfVp5dbT4eIPi8yfZJPnSEv1Bd0Eh2yXdPsoot9oPwXCCFbu
   ayQ/wY7vG07atD+w5VnANzvQvMHDqSdmytQGLt6JSOoWcLQSS5a1gAJvB
   BDIJUHRgSCZYo5pfy26ibIW1b+bGYuix28XVAdSrSb8/GUtXZD04XKorW
   O0t43mCDsNQ2GbHp31/eEoJphdAZ+hOPkPt8vuAkjzd1UAXc/WK36A3y4
   lH7DexIvpsGmzZBKTkPitG5vVOspizPYapWAJLSRqUGBFuQkjuWqCgWjJ
   lHOOd2VnnoiOrsdzldnjrewCl8dA4gPg+elprd5jrfYwbOGsKm1otcZoM
   g==;
IronPort-SDR: v0L7bKJn/WDRm7unGVJjhja802xIYoBjxqj7PiImktweV/j6P6WQs35TrgXBAX8k1/v06Ov8w4
 oLU1arabo70MNUPb1KrliKLEe1l5ZEjSTOx3wS2j+ccfQ7dsR461ppGR0yDd65QUaKV523JtHP
 JgdHsEtCQWSJ0VDEQOATv/ZTd/p6tWwyhNQ3hfabl+hCsgjiy2KnwTVTHKk2N9ZsNLlBBLr3VG
 qcgkKhLt2quJIps8MQiYypB/4z12zV2kHK3ZV0xMp1tzXPfVjynqPpHlPgG9s5G/RNMA/IZJed
 dYE=
X-IronPort-AV: E=Sophos;i="5.73,305,1583164800"; 
   d="scan'208";a="140292052"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 11:02:39 +0800
IronPort-SDR: iNNd3tKPsDzjlIY4BH0cRlAi4Lo+678aNC0cNO9xHxLiUpNalJYnRwfhrC1ozGQ6gtjpXlvWHz
 MaE9pa5HDDRMUmnypDaMVA/1Veho1nJMI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 19:53:28 -0700
IronPort-SDR: 4uZtoCl5/f0/UT//di4BDnDEAt5zBNFUyYV4DVHVZmvbsogDFJ5nLOAQiuPmUbEPMfFOXF3wOd
 81YM16ha13Qg==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Apr 2020 20:02:39 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/2] null_blk cleanup and fix
Date:   Thu, 23 Apr 2020 12:02:36 +0900
Message-Id: <20200423030238.494843-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

The first patch of this series extracts and extends a fix included in
the zone append series to correctly handle writes to null_blk zoned
devices. The fix forces zone type and zone condition checks to be
executed before the generic null_blk bad block and memory backing
options handling. The fix also makes sure that a zone write pointer
position is updated only if these two generic operations are executed
successfully.

The second patch is from Johannes series for REQ_OP_ZONE_APPEND support
to clean up null_blk zoned device initialization. The reviewed tag
from Christoph sent for the patch within Johannes post is included here.

Please consider these patches for inclusion in 5.7.

Changes from v2:
* Rebased on block-5.7 branch
* Fixed first patch title
* Added reviewed-by tags

Changes from v1:
* Reversed patch order
* Addressed Christoph comments on patch 1 (function name, inline, etc)

Damien Le Moal (2):
  null_blk: Fix zoned command handling
  null_blk: Cleanup zoned device initialization

 drivers/block/null_blk.h       | 29 ++++++++++------
 drivers/block/null_blk_main.c  | 62 +++++++++++++++++-----------------
 drivers/block/null_blk_zoned.c | 45 +++++++++++++++++-------
 3 files changed, 83 insertions(+), 53 deletions(-)

-- 
2.25.3

