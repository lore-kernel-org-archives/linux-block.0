Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FCC433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 07:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C0B6115C
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 07:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhJDHYB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:24:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62416 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJDHYB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Oct 2021 03:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633332132; x=1664868132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bEOW0QwWHGGB3v9nSYwslw4Gnf/nh+EGMsJSY4HslIc=;
  b=VEnUWfk+OeSL4o1tCBbL3/2ocOsciLCBX4hRMR0DMVJ6bI7gynrXIzNH
   awgOFfLKtIovWuGsHuSfePOlks/eulHb1aPeLvobASQ2kh4BDgHLwp60o
   qsMlP3mITXOF1QCoTWFFYsdYMxGyYPy3OPj9480MR0yzRNH3PxDQahXuC
   vIrpWMNGynJvFutVqhbxn2+KRP36CtLAZMGDky2qqP8jKdu+/ukn1HLwk
   3Dsra19+6/TFNYf3+M/GJ1HxvJ7v8rIvxI1k3av5WpsBRwossJuYWGaeP
   D8Z6y6xe3BDlLY/cBv3fLty9qLhssUX2zkrLevGEfIFxOB94yF9PvixfM
   g==;
X-IronPort-AV: E=Sophos;i="5.85,345,1624291200"; 
   d="scan'208";a="180805817"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2021 15:22:10 +0800
IronPort-SDR: Z/dupNbK6OQFkNPvFZ8idQ0fOjx5VLjwhMDBMYKTRV44/0j24xgXoFPa0emNWENKKEpsHmBIOS
 RKKT0hvhXZI5QhXNZp+55CYn2HiTXkPqB64E7mvuRMnhuBSVOymcznnb6r+zcV4bTO2/t/xXde
 oVYSurrJjAumHJu8TZG1CZZJVKkwpVuZ0ps5yScRcESAsNts+tg3E5xhySqqa79mDHCNJ6V1yq
 L+ad/Lid64zHYtOhJ0+7lpfwNcStN0zS3UVV26o2fOq49LdTTpjh4gADHOCqdQYcRKzXb597G4
 5feB5xDmWzbXxTCWiDzVgge2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 23:56:35 -0700
IronPort-SDR: 1DY8xMQC8L5dOfCHmrl7sBv4+vgul9e3AKyAkY2RPleanbvd5okWx8xfMO+BXHgPV/4sgc0CXY
 yqel/s6qVMMAyHcwqAoTTwL01BuHSkns2YMdF5/7BnnINFUC5z5bUAYW0p6aEmGPES84dcJroT
 hHDSRYgMdHdWkp97PFkopJijinu1OpAsPFOT8L9gfHm2C5h81Q9530TRu0qrXJwkD1DOlQhsJ0
 8wPV+i5BEr9FCZViq9AjYO9iSMv249/hCO1YKQVsPmFU1dwB4C8bvGn9CVETB31WCmjGf1oSc5
 3Ec=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 00:22:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] block: decode QUEUE_FLAG_HCTX_ACTIVE in debugfs output
Date:   Mon,  4 Oct 2021 16:22:07 +0900
Message-Id: <4351076388918075bd80ef07756f9d2ce63be12c.1633332053.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While debugging an issue we've found that $DEBUGFS/block/$disk/state
doesn't decode QUEUE_FLAG_HCTX_ACTIVE but only displays its numerical
value.

Add QUEUE_FLAG(HCTX_ACTIVE) to the blk_queue_flag_name array so it'll get
decoded properly.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-mq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4b66d2776eda..3b38d15723de 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -129,6 +129,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(PCI_P2PDMA),
 	QUEUE_FLAG_NAME(ZONE_RESETALL),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
+	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(NOWAIT),
 };
 #undef QUEUE_FLAG_NAME
-- 
2.32.0

