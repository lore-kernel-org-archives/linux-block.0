Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D1EC3A589
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D836E233FD
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 04:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RUJjWjT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391761AbfHWEpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 00:45:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45792 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391750AbfHWEpv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 00:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566535550; x=1598071550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WrcGxDqywXDfY3arKaxOVoHAZYFwL8m4PFWA3SgNTeE=;
  b=RUJjWjT/sT/DtDA2B5J0JaX7QifyTU+6Orcq+jnIoZbCWwFarUa7Pfmn
   1bewrT7JSb0FieiQWG6x8WdvysGmBRuVB/Sgdcac2Qgtrb1yjeMa63urh
   S7tzSfwmG87NQcTK93Iaij2bc0x4vh2NfwHnQvNKUlSLOpS/rCS3vLsXN
   41udy/LrpJKEJWAY+QDWuQWIqXvfMKQCdeRoO1XPgMAnDTTM5+RaZ0AZF
   R9PqpxwgxnOJS/fcQ3l5Yp7Ii6/jXl0Z4+wC1u1wDQuLLf1z/1/Uad5a8
   om/d9drXMmHmk8qDs3GcE5e8mEVqmA3a9H7qokKQsN5IZUD4dzoFSCsOZ
   g==;
IronPort-SDR: K9lXyopte/8oEYOkXN0FopSSMwjyoJmWm+igYA5WScy6SYknk57zrnEus49cRn6F1DDG90etXl
 Cxlqy3kkvw4fwVMx06HP/P8R07BVJCZ1Ah8WgUXtbC7rya5DAtT0sLuxmClx9JfqKiy35+RcAZ
 C1xZpJjjMjRzQ5PHUYvehrjG9bcUUzW+KFHGG1jDk++CyQq3ZokugVvGTxNa9sGQwY40xFI2/d
 pkAxmGwdFD+xJL9JaWErebzXonXbr6+WNiYHBcvUTQa/Qhwb+y2Ftuvt68uPAKa8lQOQrQd2TK
 ktY=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="117414499"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 12:45:50 +0800
IronPort-SDR: gsLMGj7HpUfUY3DVBNt1P2gigG2N/UZfsOMb9mqdHKRuQNQmUkj8IWn8peSj/lf2xWF7f99VQz
 sKKFP1SBA4mxt7acjgjEL3gIMX2SDuwv2flRLm0sOW3mHkdceX8kBdO22pTWzkHnEM5ro4Aqp8
 OgcJLgLLxQNwNPW+3Nk3tvq4j19aBzY5nKJIJmXIq027Piz/VPtkChV3ZDlO4tkvlxLQ+gtjbD
 ky1UgQtD1q+0ieqfK6+nl9qYD4KbwmpiYYck35RukW76VNgazJgghX8wRWStfh1tcUv/RFr/OT
 fDkR08yE8XFDmsmAz6Ba3c2f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 21:43:09 -0700
IronPort-SDR: 7lLyp+He1xxfJgwK11eR71bAGMxMjQmG82Fl5fwywLzzX+1f9BhwjaXvVE5w+MBDnJYbTY8Pl3
 qz5hE7lsZoxFgrmkUuQDl+K0DkhkReVqdB1j6/312V+5+HAvlU1gRbBIFNzzjZJFxqMVZTkxsa
 HreRzTT8lJot4PnJfoujoKrLchVj1VI5UkyUh2VnzOk72zZEQzzUtKD1P2LjMeZXRnjFZhD4bl
 wjW8BrMO/6aCHqcGiYL0XY8vbGiLC6ZOLO6onoQz+CnRecjYzoEwHmKxgHYdLLKVU7YzFZy0UL
 O30=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 21:45:49 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 3/6] null_blk: create a helper for badblocks
Date:   Thu, 22 Aug 2019 21:45:16 -0700
Message-Id: <20190823044519.3939-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
References: <20190823044519.3939-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch creates a helper for handling badblocks code in the
null_handle_cmd().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 751679fadc9d..eefaea1aaa45 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1154,6 +1154,20 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
+static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
+						 sector_t sector,
+						 sector_t nr_sectors)
+{
+	struct badblocks *bb = &cmd->nq->dev->badblocks;
+	sector_t first_bad;
+	int bad_sectors;
+
+	if (badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors))
+		return BLK_STS_IOERR;
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 				    sector_t nr_sectors, enum req_opf op)
 {
@@ -1172,15 +1186,11 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd, sector_t sector,
 		cmd->error = errno_to_blk_status(null_handle_flush(nullb));
 		goto out;
 	}
-	if (nullb->dev->badblocks.shift != -1) {
-		int bad_sectors;
-		sector_t first_bad;
 
-		if (badblocks_check(&nullb->dev->badblocks, sector, nr_sectors,
-				&first_bad, &bad_sectors)) {
-			cmd->error = BLK_STS_IOERR;
+	if (nullb->dev->badblocks.shift != -1) {
+		cmd->error = null_handle_badblocks(cmd, sector, nr_sectors);
+		if (cmd->error != BLK_STS_OK)
 			goto out;
-		}
 	}
 
 	if (dev->memory_backed) {
-- 
2.17.0

