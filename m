Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A0C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 15:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C8C2084C
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 15:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I9nhFYX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDIPJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:09:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:3984 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfDIPJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 11:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554822615; x=1586358615;
  h=from:to:cc:subject:date:message-id;
  bh=tTns3NWdvPncL7ovKcClltty6prWzEOUVJ/qV/YsXLU=;
  b=I9nhFYX35MfHvac32vXia4GugPY6g4BO1AhcE5FZxYrjEQYCihfyHspO
   1EYvvidoOMalBdH5QwgNyys9GlJgqdrAb3mjF9m/oNGcBzMC1payKZ3gl
   dbCDCM88fly8MxB5URDc3YPYrKhHEUt3aGf/XN0mq9gzrLoGh7a8ANqrx
   jV26NcfQ8tlWpZTIfXcQUIq5fIzfsVpi40GHQAZrZGpR//3/4i50sCvMF
   DEaoJ/PZHYcVurJ4qu9F7DEJ8Agq54jQ7PmbCxV59N9JMjqqBQT9neoQt
   MfpqP+53PXaXt6e0pdhBghWqb2TRQu8jDljplLc5mRtkffRW3KOUHXtxV
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,329,1549900800"; 
   d="scan'208";a="204253344"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2019 23:10:15 +0800
IronPort-SDR: T5c0qU5bEomP+6rOLM0ZDr5hnUswaITWprN9gSzcb6wiuFt9G0Y0cyuDL2guVlLQwckY4aNHQ8
 l2A9wmeZrWxAa2S8LjNjwqdloBkCsKcCkNV0lrbTne+/VwDyM127LHWjgIx4hz6RRoAU7VgeYj
 vBXUqJfiIavVymV9cgKcHO9JREsLxU2zaQihobYOp/QzXJoF4kU3nQFJcMVfOWAiF4EBbg+uSw
 ZDa6qKAFSswRWi3UxvJMOot+2xx3EYP+cwPx2SyLg2kLmSP/Y1ve7pYHbQ282VO/OnXaOsm/qc
 V61M8c5Mu0OnY68ckjA8wdOY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 09 Apr 2019 07:46:55 -0700
IronPort-SDR: Ij45UTcdw4Vltqlo/tUV1va+Q7JHpmMkhWoeVKBVj2mKB/M9bmM5cDe1CthvGLj5K0i7G/xWVB
 lQUqwMH29L+eXp0iMMJDTW8yhhe+j6RBvRa6ujQRetI7PFOYUyCUPhIyef+3wKFuFwml5iaHvL
 8oK+lh0aUXkfr5WEd2s1QN/dAfS/h5gNwJcFZSmKSPHzKXYQ7LRJHKoYK+lsLzI9+qG7S6KUN3
 6j/n7QPzJjB1o1sEpqIihxueV0dkLWwseFaiaL+JdIQjOw1X34ntvpPdaClYz7vo63hW4KKEBI
 B68=
Received: from z820.hgst.com (HELO z820.fms.local) ([10.41.103.236])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2019 08:09:59 -0700
From:   Mark Lehrer <mark.lehrer@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Damien.LeMoal@wdc.com, hch@infradead.org,
        Mark Lehrer <mark.lehrer@wdc.com>
Subject: [PATCH 1/1] brd: Add an option to disable 512e sector size
Date:   Tue,  9 Apr 2019 09:08:44 -0600
Message-Id: <20190409150844.26270-1-mark.lehrer@wdc.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mark Lehrer <mark.lehrer@wdc.com>

This patch adds a new option, "disable_512e", which causes the driver to 
set the blk_queue_logical_block_size to 4K to match the 
blk_queue_physical_block_size.  If this option is left at the default, brd
will work the same way it always has so this shouldn't affect anyone 
unexpectedly.


Signed-off-by: Mark Lehrer <mark.lehrer@wdc.com>
---

diff -uprN a/drivers/block/brd.c b/drivers/block/brd.c
--- a/drivers/block/brd.c       2019-04-08 09:57:42.016921473 -0600
+++ b/drivers/block/brd.c       2019-04-08 10:20:58.248623425 -0600
@@ -342,6 +342,10 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+static int disable_512e = 0;
+module_param(disable_512e, int, 0444);
+MODULE_PARM_DESC(disable_512e, "Disable Logical 512e sector size");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -389,6 +393,10 @@ static struct brd_device *brd_alloc(int
          *  is harmless)
          */
         blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);
+
+       if (disable_512e)
+               blk_queue_logical_block_size(brd->brd_queue, PAGE_SIZE);
+
         disk = brd->brd_disk = alloc_disk(max_part);
         if (!disk)
                 goto out_free_queue;


