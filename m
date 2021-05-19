Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADCC433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD2E61244
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 02:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhESC4z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 22:56:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5175 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhESC4y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 22:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621392935; x=1652928935;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2vVwCP/3ZUymwi7nSrTUwfXgB66YKY0EOI/cZefWxco=;
  b=UZ+fUk/uPl+1smxW1lkybFv4OAelKa7JDc3Y/cXxxc5NFj9vScUDlJOX
   b6kUH7dtZtRs2R5dL/FBuxu4m+amawBXyxigpii6XhDSfrI6oU8+rn9kq
   kIPPioOaAfqUdYwum6Nf5DU9uZHUt6WhSMsmXmcgTzUk37Vvz+1AzhhgR
   kNLX9LoYnhX2jbsyIAlNeIZ4dKtsqOo3/ugElytHRBuC8HWKCRaP1HuSo
   QNm+rJKAkHbrhWLVtH43w7hXeK5EwZu7Z6HRImciR/9In3SOyhVCSEAU6
   oknXf2CJgbDOFLvrHTiPUllV9amVo1l84Ni+d9ingc5Gnv8uxPFR7p4ZG
   g==;
IronPort-SDR: YvwVA8b4frPWEGgTaMq4h6byrXf1ZNzsH8zxbLoJBf9x+lFPGBdgk1hG60fpwZiRO+4E2qyNQT
 pWsw9zjlFS/xZ//QvFX++DCUuVFY4jyx2q4pQuEeifZCWlIYRNrRCb2OlWZWvnuK+0+V2slqof
 IXU46TCcfzQ6NY+Kw0Ar8XD+AdPOVa3Uiz7FOLsiOWLJJkga81Wlfb48qpRfaYCnmiBiqj754b
 KtIVmjAb41GPcDFisW9/pt1uIrpYZ8ovD+cavkhpCMEXGt37WejJo1rAstOK44ual8x5DJGcub
 vHo=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; 
   d="scan'208";a="173265898"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 10:55:34 +0800
IronPort-SDR: MuBQPe+1UTxgNn57ijTOgxABsRMalpDuxzWLJv4m1BdU6LsSLQxv98X4uvHHTgOHE3Ajset473
 KgMlnbBV3iDhkm7NMF0KJxhX3a3/9NiQsXlnCJ8Sf5wh1L+3vWEIK68TQR8c/w62a+TxF7CslO
 Ru+91QpxLL0VVLY7zpj7KmGjXJLz+LCpm2cUIwh40W7s+DP4Mk3AOt9ZrpUeXVvDMUvXt75Dlr
 IEytW2eptz4VLv9LopNiaj+usG7TZ9EGig8BbUPHI4xNmoiVgaZv+vnMsfbGjlEtPq9NlTRMn0
 GkeO7AEKmthsippNAM7jwyOa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 19:35:14 -0700
IronPort-SDR: eBdyt+Zu6RnJp2t8ia3+EQ301600BuwRL4NGvgzYP/66dBzoFoyWUHDrhMoHZbzBHQMUvImMgr
 4OJ3LahGeuRsTiZHZRBWzTKEVWS+Faj1r3e5wbGKnym2kzosN/k/fB1/TmkziejJUG18tq8/9o
 qw6SWqkMc0KzpOthvJLzmKTj9YQGb0hjJ2a04uGT6gG6dj+UuU08uYLMiYxlanDFQ5pieiAe3W
 EmCHk3lXr0LYCY7tbcJq7OxfkvZmhj+LHvTBI9O0YC6T2O8EzfgZ7u90ODSFPMaOyALKFuZeGz
 cWc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 19:55:34 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] dm: Fix dm_accept_partial_bio()
Date:   Wed, 19 May 2021 11:55:22 +0900
Message-Id: <20210519025529.707897-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519025529.707897-1-damien.lemoal@wdc.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
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

