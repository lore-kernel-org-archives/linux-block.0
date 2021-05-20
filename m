Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB1C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BC26108C
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhETEXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:23:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETEXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484554; x=1653020554;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0wvrBF+PmXIKL6WT7q2S9+AJ0dOhYMZY187Y9appg7A=;
  b=GkiUlet1rGKHKC2lfkZdgP2ttIwFp6U8xqxTgz6m0l1p7NMw/kqLH0kJ
   l8SREamrJ4IRqeosVk7gxDQR3q5cspN0qqOPSOpDfIo7S4WmeGHAcdi00
   SEPC7V18s508t+1Ew1wx7QD+9Os/+n0PKcgb5hKrq183h3YIReKtTHBh8
   1wOTnYQvYRSt++eowI2zFpe+6M6P2rs4PGCB5WYucOj1d9spm+g24L8mt
   +U8OHsQ5C3/RCSgQnlX32Hkq++McMQddHxAehJMEagD+CBmSflOywG3wF
   lKkUVwRnOOAy6UTrJiVmdstM4Yx0VeD1WUUCQUJGTvKN8QTWGQKezpLwr
   A==;
IronPort-SDR: kOwB16Ky8SIwlIpHVNbkXlDaREX3G/sLFiHDesiRQRfWF/ZgqZngb1A8ky8tsPXTmz1mD9HnZw
 mrZN5a+mp8J3A5qnK1W3itQBfuvW+tAHwL12An5F1jhOa5CN/rBQ729JTniwtVxmRHefyGN/6u
 LMZFQJuQmZnqZ+M5CD2JyMaVn1/MkXJs6EZhg38pRPS+SoI4ywaW0yYREjRJ2l5n7x2YoAq8VF
 w9efrtSF4ndTazdp6OGcorVcQiPF30asD43qtfYyX5vVll4mcIZ2VyKiGOm7npeVglT9KJ5RXb
 gH4=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105840"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:34 +0800
IronPort-SDR: yYROGyYqIWvwZAgTrcXkVblYqhkM4O8b4tBulyNZrn7lyP4lX1y9YHn1iaCZfR83oIFCXsDSG1
 FZP/WnYIsU17P7SEWTgyHjHzVAIL9pr0cCSN2PEcrbWOjcozY3/c1OFHQo00Z7Pvs3INqN2uqm
 LMCONb2Xc2nfNUi1imSOX6PekAmp1XBUoPlU4IoUAO8u5U80bWHqN8MxriXobb05HULMI41TFu
 uisqwQtfkYgU9u3BCG/+JKEtCUJ8XlCuw1fLd9SQ/pdZBTL1+JkV2GBZyl/sRFe6CntY4o6raZ
 RB5Haumka03Yr1+3XdV77Nv3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:11 -0700
IronPort-SDR: iMmTcvoJTNMSGxLdflsNlb0SPMpOaH43yQqsXpbohPjfRNCpHlofi/mjOrwqlECx8ajOvgT7K9
 cEbfH3r3qOk2NkgY3djchM2QSKyxEVQpnpFlFXFmsOr2/6w9gCvjGwxs2LpGyGDtbqre2riAhM
 HoNF0seytkMRnXc4Yr7EDkash/6hYoN9qv550pNm0I0SgA2Jxsrm52xpGDl0LAC2jX3qjT6dJv
 +R8Eg4GP/AJEvKh3GNTpdF5iSK1ucH5Ihr1UNZRzQ4kecA64JmH3Gq4Di2xw2S8IgGBlfhHO98
 7wg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:33 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 04/11] dm: Fix dm_accept_partial_bio()
Date:   Thu, 20 May 2021 13:22:21 +0900
Message-Id: <20210520042228.974083-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520042228.974083-1-damien.lemoal@wdc.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix dm_accept_partial_bio() to actually check that zone management
commands are not passed as explained in the function documentation
comment. Also, since a zone append operation cannot be split, add
REQ_OP_ZONE_APPEND as a forbidden command.

White lines are added around the group of BUG_ON() calls to make the
code more legible.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ca2aedd8ee7d..a9211575bfed 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1237,8 +1237,9 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
- * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
- * REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH.
+ * allowed for all bio types except REQ_PREFLUSH, zone management operations
+ * (REQ_OP_ZONE_RESET, REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and
+ * REQ_OP_ZONE_FINISH) and zone append writes.
  *
  * dm_accept_partial_bio informs the dm that the target only wants to process
  * additional n_sectors sectors of the bio and the rest of the data should be
@@ -1268,9 +1269,13 @@ void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
 {
 	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
 	unsigned bi_size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+
 	BUG_ON(bio->bi_opf & REQ_PREFLUSH);
+	BUG_ON(op_is_zone_mgmt(bio_op(bio)));
+	BUG_ON(bio_op(bio) == REQ_OP_ZONE_APPEND);
 	BUG_ON(bi_size > *tio->len_ptr);
 	BUG_ON(n_sectors > bi_size);
+
 	*tio->len_ptr -= bi_size - n_sectors;
 	bio->bi_iter.bi_size = n_sectors << SECTOR_SHIFT;
 }
-- 
2.31.1

