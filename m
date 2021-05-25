Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D2CC2B9F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458CA6141F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhEYC1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:27:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34067 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhEYC1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621909545; x=1653445545;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ufPSlVbwPGym1w8qq3VpiWPqELmfMohbbGux1r6mm7k=;
  b=RD5Fea/ExQuqX7J9NG2tzUd5jJs+6M4zDU0bPQ2tYlL/aiSnHqMqj7/X
   KAwQwVFAd3+dfecsclKoxInpYBOnjiNI9xSD1dsQ7k2zetFqCcKP0yyNf
   ZUf+JJFdAs/iT7j4d9ktVZxnFLQhYaSDhrJzQRcmL6cZzw8cxX/UlFSg8
   g6cgjZ1YqRQS8+Xm3nsMtydqQ5Nu6svlskygH+hGnelQfVgxP/Y3McGYO
   d2VMtLHMkRU03oSFUll9ITWeetDI33YhM4s4hG+RDp9/uDSN1jF5WfQgV
   OB+SfwlmzRTGew4+ZSoFvjGSdC6r+PdJx7VAoLIC9xKh/85M5L8LOJAr+
   Q==;
IronPort-SDR: AbuANrYAF3Z1IEgfVyyyBYVo6c8rHGG7bPo8glWWNAP1A1OThQz9CiM8mVFAAhsuhlOr564nB6
 MgNElOcfiu2P03mQ3vvouKCWW0QsWJFYhxjzC84qpMbAXEL7hJahMvmDAxI/FXYMQI1eUqP4xs
 U3JzWcDKMtPOdkuex64ypEJM4hb2CsDwMGGUNe7E3rpcl7BYjs9torRdoY7v9gAR/GLHN05BMU
 h0H1XD8nsHg1DGNrery1kF2L8PFkNJIqnqR4OR+0d4KEIkFOeHYueegbCvfo6SOY95tLIp+GJo
 wKA=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173981325"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 10:25:45 +0800
IronPort-SDR: ++tXCQ+z++vSIfOWCQ+cQkxxxxO/kYj8mYeuzSK9B+U7LdooKIxIWdNEH3+7SublHtiM86iCWp
 xi+UySzvRkch63+6twhj8m3/J1K99AISXorBLsfliVuzMuDxrmTVYDmKc6nLmT7cwva+cZGpFY
 L53tAghkeFyvlCNX/HCsRK4GDFtRbuPKNGkOQF8K4wFSuFxKGKN+PHkGt6UHducZCEjcK8a85n
 +gpuEayZzsaIdutVAF9y4Dpc2JPs7V4KGVPAdfs/wTahCluduAPFfs90pkF5BpRMJToIrv7xxX
 +hNDBMcAv0nq2gOcyCYJJgh1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:04:00 -0700
IronPort-SDR: evLdklyIR/hm0PKVBfQN9LdyjlkgpnJ++Xlv8VYAWW9hGyUaDBFyLua/fX5LfD5lLW9bbd/0jP
 Ht6qUNZ2rEj1YsKoqesMRSoRbjVfhXDFCyuWURAMLnxcsUESk8WCQrZyzlTjLvaKulWjn8V1zk
 nUfrAwFQW3CubkAhG0Y6HWpIFHKd3HFWnbgwkS4yJmyxblTKkmcM8mS1kXWUr06i3rbaoayNJ5
 J3uaBnLFjQq10k4bqIpslfAKcuH4TTcVzOYjQTNWRgvqODnA5TcgKTo+Igi6NDb57IcOsu6Ce5
 bT0=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2021 19:25:44 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 04/11] dm: Fix dm_accept_partial_bio()
Date:   Tue, 25 May 2021 11:25:32 +0900
Message-Id: <20210525022539.119661-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525022539.119661-1-damien.lemoal@wdc.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
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

