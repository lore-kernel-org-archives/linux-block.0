Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE5AC433E1
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 23:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB0F20873
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AhWiHxdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgETXCG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 19:02:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7017 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgETXCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 19:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590015727; x=1621551727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hsKjT73X9xJTLvvur1ylGmlHAREjIduh/gg6/OUtCww=;
  b=AhWiHxdVjsdhanONf15Tp/6akb0Ai2vP+DkIybFQ+zBn4rjnACiQ8139
   2ckQ1Firt2jxmIG3S8IKyWvyWcacHh5AZV5joDL3vL0vP2J8xgcHHdbxx
   b264OfHKOn70xspnhMUDTY/GhlBmXQqPhDQEbnGFtPKe4xfGFqiHXdmDI
   aeClssPSvN7u203ux5VAyKwhAlNxZlzNhGo/LxjPmnAAg5WR31MNdIeyu
   LM0XgHlI23K5tdfQM8TH0ICVgDnLazSNyCot3jTCRTcnxO3TqYzNoS3so
   C1u95vUxbUQ2EzkljZZGdZBYUm2y1eGWuBRvcizUFUIJn5cjzBE5JErKz
   A==;
IronPort-SDR: 0jJfxl+amzAHLOdCZW4FsdPP1LrdxC4bQWQ+NACgiIaq7e10OelU7pyV01QOUPAFEfGslqpti8
 5N0+8LSkJfOAZkdb1bhijmw6tiUFByVWYWTGbif7x2Lx90M8asHKrZwwqiSHpyFn/Qp0TDxetS
 EL1RzIs6ELCjirF2KKm1EhXJ8JDKVKJymLtlHksA4Z661uDLgewSEDn9O8y1cNg3MHxAnGhuP6
 qM7ibRK18kgX2J9iMr7LW8lwOJi/FOsmmIEOvHjcF/op9f8DQXnZDe84y0V9KjvRhy+XO8YJJB
 5ws=
X-IronPort-AV: E=Sophos;i="5.73,415,1583164800"; 
   d="scan'208";a="142501785"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 07:02:07 +0800
IronPort-SDR: 1S57mlKJrZWeVcuQWFx5Ww5Uyp+tGLaWTQVbPPMIPAOaATK3KxGTpgaIb6rImhCrWcpu45H8JN
 nUaq8F12Di3g0X5R1j5jF5HNVTz1WuBZA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 15:51:34 -0700
IronPort-SDR: ZF7p+m+ln/kC5g4cC7LhRsIqOT1KEWwYKr0MNyb2yxPg3Pm06ZGd/DJLIvvpanv8Stu+1hqO8m
 1TIx/6V8H9cg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 May 2020 16:02:06 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/2] null_blk: don't allow discard for zoned mode
Date:   Wed, 20 May 2020 16:01:52 -0700
Message-Id: <20200520230152.36120-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200520230152.36120-1-chaitanya.kulkarni@wdc.com>
References: <20200520230152.36120-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zoned block device specification do not define the behavior of
discard/trim command as this command is generally replaced by the reset
write pointer (zone reset) command. Emulate this in null_blk by making
zoned and discard options mutually exclusive.

Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4f37b9fb28bb..6126f771ae99 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1561,6 +1561,13 @@ static void null_config_discard(struct nullb *nullb)
 {
 	if (nullb->dev->discard == false)
 		return;
+
+	if (nullb->dev->zoned) {
+		nullb->dev->discard = false;
+		pr_info("discard option is ignored in zoned mode\n");
+		return;
+	}
+
 	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
 	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
 	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
-- 
2.22.1

