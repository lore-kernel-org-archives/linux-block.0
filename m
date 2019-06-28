Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3A0C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 23:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA26D2083B
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 23:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JZANTjyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF1X3J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:29:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49912 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1X3J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 19:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561764591; x=1593300591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OsJ4533FGIsd9sT3eaMWIKnkvnlm7ICcCh8oC0A01v8=;
  b=JZANTjydQ760Vyib04Eq6QwID6y6kSyYn3GWw4UJLM+Ss6kN6Wnnlo5S
   KEV72MXcaHglbG3IZtItG4QJyrvBQ7PrkAj+ieaw1lx5290jeHDjgo0gN
   KHbmMdDyDxzGTwOK7QZiJxJjxAaH51hYqb9z9DrLSzYhRl16LBY742vKu
   PCXKQr8HOqxg5N5JWHuHDfBb15SRmlwBrG2WFGCJYYsb146grmEkOyM/u
   Y65XXl5jeI681843TFfu0/YOtex35Aj89jb88xIIoESnCI7r/KDOBg2UD
   /bnbCEdLWAczMWkTftSqFvQP1KGzxhje5dtAUvGQSATatbVl9NYbSCgzN
   w==;
X-IronPort-AV: E=Sophos;i="5.63,429,1557158400"; 
   d="scan'208";a="211646990"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 07:29:50 +0800
IronPort-SDR: PNy7bUaEnRk5MK6j3lKEw8ISLd05lEPHKzqbsQguxgo9UGfExwzcDyXm9+rMfTxCl796Il+iOl
 JlRqWc3NQCfS77i15EM6JMlMocUlZv9FunJN4Wcf9K/hcVT3W9VHcCnsq3YpSot188j3RYi2nw
 ZJXg/GW70WuTePP5q7ec3qLz3PdSO09e0FM1ZwtJxhRSxKbxlWGS5Ubxf4vDxests2tr8nXgnc
 lLanRBq+4cjkt1aO1Fjr59l0oou9jwzh4hcTZDEzExZJhW0BASwf5BPafKs4/IRmb6jp/82H8k
 UXFVEceYaJ9tavCmGwiPRoxg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 28 Jun 2019 16:28:13 -0700
IronPort-SDR: 2Sy2JUfh+VD4vfM57pkQDgfzmKGQXgMknyoE0gu3c51JSNrsJjYKR3+2c8/4adaj/3V8ingvO6
 sqkJVditaIkyThMpZ5W/ZnGnsjVRDPVxfLpw18kFutJzJXUlVoda2RzJgjh8ok6BjqL7ggjksZ
 tSx7f/g1u8apzYeRbumNX9sm09RianykeqBLQI9DHumpNrXqQI2W4nJWy0byYvTCGrRvpflSyV
 bYWQJ8EnW+2O4h0i9KpDvf8sHIBN0io940Gv7wb1z5C+P4wdLEB9HH7LUY8VHg8y9aWEX8T00x
 jUQ=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jun 2019 16:29:08 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: fix type mismatch null_handle_cmd()
Date:   Fri, 28 Jun 2019 16:29:04 -0700
Message-Id: <20190628232904.31211-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In null_handle_cmd() when device is configured as zoned, variable op is
decalred as an int, where it is used to hold values of type
REQ_OP_XXX which is of type enum req_opf. Change the type from
int to enum req_opf.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 22303e59a274..99328ded60d1 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1198,7 +1198,7 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 	if (!cmd->error && dev->zoned) {
 		sector_t sector;
 		unsigned int nr_sectors;
-		int op;
+		enum req_opf op;
 
 		if (dev->queue_mode == NULL_Q_BIO) {
 			op = bio_op(cmd->bio);
-- 
2.21.0

