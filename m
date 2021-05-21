Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3487C433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CAB6128A
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhEUDCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 23:02:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhEUDCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566086; x=1653102086;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ufPSlVbwPGym1w8qq3VpiWPqELmfMohbbGux1r6mm7k=;
  b=fY+gI7fU2ZhOsTljc7179NjdIZojTiUJI4duIs7BEZTHdXiJR6dQu+3H
   yKFpoUB0ePzJ4eM8G1D3PVshIQ/A414biYMefm8/UiJG9dkHUMIEOnkvO
   2SWwEsxjDRscu85cl3GyOwvVkbnXYGyFM2IxR1I1CAv4383YsGpGUEo+W
   RRAfbS7juSsoMXoUrhAZs2xKlcLi9nhxmFvk7Uzb8+gpGS850wARts0JS
   Rj12gDTlDoYXTYqzpgzCWUJ9SS7MZuUA/9xH3AGYAGd0fjCoWp/Wk7LGU
   qQUwGefohrf9Eqfg/KLPCF/bMzZFpxi8jTolfXfizIETKS8Klmuj4uGwy
   g==;
IronPort-SDR: ceSJHM50IRaKAoga1DYm5WdVo+sM8QMqgJyU3aLpA4lWOd4HwtMtVCPtRQ+2Zah/VstS/D6Z0t
 jgc/XJnTvZxzpJ4XkzyoZeP+Hh1HVbAQJuhfoC9/hTPXkUOw6uXbJRhEzmMuUFnsDDwV3yVTjj
 QvgwN2p5K+T+RYMi1Jx1ZmYZNe8iqLFkKBk/Ss/XHbIFUFE9o7BafwIPR3AtEVT41z7RZdS/NU
 m3nDnDKQSxDl5cEQSQWoqAj4ixa/K4MmHbiWl2AsFZ8iyIxweJRE22JuSAubChB92WzSR9PbPV
 8YQ=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943821"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:26 +0800
IronPort-SDR: i8aOKU/PkR1GRBUmpZX+sT3ct6lqDZh+XOhJaT6xKFSVZsAvMdfxcE1MbrTss70BOQBHbKDEg9
 7YXCoxOMieIZijrazBT66c9qxRdZh+8m4AXkHq7Y45H/dG7vtsn4K8FufPi5xgul8Xd8WZRFcD
 68w/kv4Y8NReFgoddRuVzb8Otn7FHICekYCE826wjqPGjOgpOpUujxJKwxsMWXzDcoFcYXlSo1
 KzVYWytyFX7mPakmiQqw1JRtpcsbXdpDHJ+jJK9qtiM1t0N+Z3L3ASru4inArVKaLuB4TXeGtH
 L3ZLzQDfJRW8JMAQxblNwZXJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:41:02 -0700
IronPort-SDR: 0rXFbAARo+VBtr5JRENEYPHlGpVr3hVF0f/SSFtwxSu9j0wbFEysCpN3hFtPOBkbKZwaVJT1h1
 Th87fWx/CNKLTWDVs1UBk8pC7kB/VEu057k0lhIn2lJ81cZue8HyNUsFeUn6eGTz+RhITO1onq
 S6OalEtQQTiluUhkcB76VTR9lurzyhS/c8x+7UIrAb5duuOcY3O8EoryDiERSb1nhDZlwIGh99
 3aD0v/0Sor0/Yx0H/IZGHiE6tLARLZa6iombSzX09yTJhU0NoYi2o111mUCkFFnQFjRFwzzfwx
 b80=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:26 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 04/11] dm: Fix dm_accept_partial_bio()
Date:   Fri, 21 May 2021 12:01:12 +0900
Message-Id: <20210521030119.1209035-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521030119.1209035-1-damien.lemoal@wdc.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

