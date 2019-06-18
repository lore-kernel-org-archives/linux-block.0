Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177ACC31E5F
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27FB20673
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pPL1/8lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfFRHEM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:04:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7915 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFRHEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 03:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560841452; x=1592377452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTS3xe+OMh34VHu9uCStRTNuxPXwWPijIGYDUqe3v/8=;
  b=pPL1/8lx090cl7/lY0WZ+86I56/3CIGr9vLM1IxxNsxbGUOvzMnnjsxV
   eAsD51ihefdHxRgKT00E8FA7x2k4eN7xh/OTp/Q1Z170QPaY7Ywmysd5t
   ZcviO0m/61AE7jgGGx4w31ZKUcH5f0Oa9iHutRsCuZ15kyDs97PHCjz7m
   1agejFyOLb4olwPrxXLnkR/PolLdUNnP2bHdchLXAUchbs69obGsQhzJl
   jpQH5lMz4h557guoTuxUmoNhAJY1FKxgua2xzaufO756kV4YpRJzF+YXu
   zmeFtso62rn4AFrlawKuqrXZjGhMrYYMcKRITmE2/np6bNwIfQQGEUQHh
   w==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="115733438"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 13:42:49 +0800
IronPort-SDR: C1ZwNWkDo/B3oHW1uZdlvio2rug+9JENC/7Z7EJOm9wHV7SEQOQhz5t27NH9i8z7woZ3g/RkQX
 eYqgIAXDyn2PIAKZ/nlI8gyGsdx80YysVs+HO7s7kDyvlBIbiVsEa1pffekljVIoiSvX6W4QSx
 2DFqmQ0hLYtUtBUUcjfAk8UZfd4dDfmANvnXbbi/6bxFEOys0S9z4DzAf6nvm7F9DVzjXKkda5
 Us2PtjgNVp7QzShUdQYUPPHmsoPZlUOTmeSTwxn2sIVlR8FNNJTrwbv2lpjjATmOgMGcAPalRB
 Xhwiy03jpIqP6WF2X9n8hcGb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 22:42:18 -0700
IronPort-SDR: D3yxs5zEAgofk/QwMdynisRv/sbTqSjiMIkc9RjKEcuNtAFbsQU+ALQMqYs5ogCbU9CnRZun0x
 4S95b4muqUQ9uS0FW0+8IG0l9ollPlPpReNNvT5tuHmY22KrvgQoHVxJPMtDZuU7c5V5w+80E3
 kS0ocELd1ZgqvgKOot90JeA28yiQjL9D3D9dSm+RNt4HLYcYOEUYB3mztjDaYepStKa6t6aUR2
 KGSGZ02f63KzLXVIRnM9Qx7eTqf9gcvC0c6QWtWUUVA+jvjFr3LtNL2Kl7p3Bufss1ttpf8Fgm
 OyU=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 22:42:48 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 5/6] f2fs: use block layer helper for REQ_OP_XXX
Date:   Mon, 17 Jun 2019 22:42:23 -0700
Message-Id: <20190618054224.25985-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adjust the f2fs tracing code to use newly introduced block layer
function blk_op_str() which converts the REQ_OP_XXX into the string
XXX.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/f2fs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 53b96f12300c..ec4dba5a4c30 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1045,7 +1045,8 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		(unsigned long)__entry->index,
 		(unsigned long long)__entry->old_blkaddr,
 		(unsigned long long)__entry->new_blkaddr,
-		show_bio_type(__entry->op, __entry->op_flags),
+		blk_op_str(__entry->op),
+		show_bio_op_flags(__entry->op_flags),
 		show_block_temp(__entry->temp),
 		show_block_type(__entry->type))
 );
@@ -1097,7 +1098,8 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 	TP_printk("dev = (%d,%d)/(%d,%d), rw = %s(%s), %s, sector = %lld, size = %u",
 		show_dev(__entry->target),
 		show_dev(__entry->dev),
-		show_bio_type(__entry->op, __entry->op_flags),
+		blk_op_str(__entry->op),
+		show_bio_op_flags(__entry->op_flags),
 		show_block_type(__entry->type),
 		(unsigned long long)__entry->sector,
 		__entry->size)
-- 
2.19.1

