Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D1C388F3
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 10:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbiDLKL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352950AbiDLJyZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 05:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE2B96948E
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 01:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649753836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Kgra35BNLPF+KPHNAv0PXTEPcsn2mHMlil0KXV/udI=;
        b=Wc8rfbWE6PjEToTidaueaBB11ah1MrxWlgiIcDwqM6qMRg3OxCHhYrS7XHMI11ucVZrkDW
        17JpjaL9ORPjZkwUxyDoboHSGIX7KaGitKalhRxIkUJ5bRXZ6S2+ngsuYlJVpXmwEsAsn2
        BkpwAXPDwj3gxkSVHd0NN6TJ3umO+YI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-Gs6SbN-mPzq4VtohAcpO4g-1; Tue, 12 Apr 2022 04:57:10 -0400
X-MC-Unique: Gs6SbN-mPzq4VtohAcpO4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80DFC18812C7;
        Tue, 12 Apr 2022 08:57:10 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83520C44B1D;
        Tue, 12 Apr 2022 08:57:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/8] dm: switch to bdev based io accounting interface
Date:   Tue, 12 Apr 2022 16:56:12 +0800
Message-Id: <20220412085616.1409626-5-ming.lei@redhat.com>
In-Reply-To: <20220412085616.1409626-1-ming.lei@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DM won't account sectors in flush IO, also we can retrieve sectors
from 'dm_io' for avoiding to allocate & update new original bio, which
will be done in the following patch.

So switch to bdev based io accounting interface.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ed85cd1165a4..31eacc0e93ed 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -504,29 +504,24 @@ static void dm_io_acct(struct dm_io *io, bool end)
 	unsigned long start_time = io->start_time;
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
-	bool is_flush_with_data;
-	unsigned int bi_size;
+	unsigned int sectors;
 
 	/* If REQ_PREFLUSH set save any payload but do not account it */
-	is_flush_with_data = bio_is_flush_with_data(bio);
-	if (is_flush_with_data) {
-		bi_size = bio->bi_iter.bi_size;
-		bio->bi_iter.bi_size = 0;
-	}
+	if (bio_is_flush_with_data(bio))
+		sectors = 0;
+	else
+		sectors = bio_sectors(bio);
 
 	if (!end)
-		bio_start_io_acct_time(bio, start_time);
+		bdev_start_io_acct(bio->bi_bdev, sectors, bio_op(bio),
+				start_time);
 	else
-		bio_end_io_acct(bio, start_time);
+		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
 				    end, start_time, stats_aux);
-
-	/* Restore bio's payload so it does get accounted upon requeue */
-	if (is_flush_with_data)
-		bio->bi_iter.bi_size = bi_size;
 }
 
 static void __dm_start_io_acct(struct dm_io *io)
-- 
2.31.1

