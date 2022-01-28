Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF9C433FE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 04:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbiA1ER6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 23:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236875AbiA1ER6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 23:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643343477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=LPT/xXbA8dMnjNDPrd3foEhpTUzqW1ZlXYJLQcHQMDc=;
        b=IWw27skig7vTTsjsuyw07AtIx+PfRVzbIs8XXmObRMqgNE0tV5hPMXnQ0CpjPC8ynUH+Z6
        Gas4EEked27Nh9T344WqIanyc/zXHyFNZ+ufELx72QU5eOXC+B2WR607C76GtYZQl2RoNC
        iiKL86vFfb07hbaXSQC+vJn63nzdNes=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-PQGmj2gNOXi3vL-ZsY_BCg-1; Thu, 27 Jan 2022 23:17:56 -0500
X-MC-Unique: PQGmj2gNOXi3vL-ZsY_BCg-1
Received: by mail-qv1-f70.google.com with SMTP id u15-20020a0cec8f000000b00425d89d8be0so2586640qvo.20
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 20:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LPT/xXbA8dMnjNDPrd3foEhpTUzqW1ZlXYJLQcHQMDc=;
        b=x9/YsV6c/1Z+2a4XM4Tl/Di9lRCKr7/NWqY90tWlUUx4N4TtmORNDA6UvYQ0ICHnQE
         OIqXcmp/1lmERbhorUTCDpEfw6I/v/dTTh5Zkx+odli/XRNfoN2BiVpZiP0jYx3phNfP
         KPLI8WCGpBQ+ngu+tqiepdzMXipEqqak6upAR6IJmLaYNgfap7V5Ho89sQGryaGkgjc3
         xYr4tILWfTeTVj0jha3YQrdx78p0OuLoB/vvikoPPnT73ClfXS5f8Y5mEabY+AZvOBHe
         FRBdkVLFmnVAOw6701bGS+t1NRoJIJ2fPVWvphEPyS7VPz0Bkw+5Ys34SQ8q0oqHyhc4
         irEA==
X-Gm-Message-State: AOAM5338JadSw9R8KXmurEM1jsDw+ZXRzeN9Eb1PXjkMmmtp2/oo+zia
        mxrh8vG4IuaTeY5VS3C9fZrIIcv9YEMZjoN5TFKYP1QAcigdv17y8khrvJcp1MzA2Tmzuf6ZfpL
        U1TXIbs+GcLUqdgYJgZITJw==
X-Received: by 2002:a05:622a:2ca:: with SMTP id a10mr2856217qtx.298.1643343475936;
        Thu, 27 Jan 2022 20:17:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5RF7BzncHiFMVWiTMxZmqy6R9FtGtyMp3kV52MUk+7hmiCaTdZrq/spDha5BE/Q8LIfYHBA==
X-Received: by 2002:a05:622a:2ca:: with SMTP id a10mr2856214qtx.298.1643343475751;
        Thu, 27 Jan 2022 20:17:55 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d13sm2318189qtx.35.2022.01.27.20.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 20:17:55 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 1/3] block: add bio_start_io_acct_time() to control start_time
Date:   Thu, 27 Jan 2022 23:17:51 -0500
Message-Id: <20220128041753.32195-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220128041753.32195-1-snitzer@redhat.com>
References: <20220128041753.32195-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_start_io_acct_time() interface is like bio_start_io_acct() that
allows start_time to be passed in. This gives drivers the ability to
defer starting accounting until after IO is issued (but possibily not
entirely due to bio splitting).

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-core.c       | 25 +++++++++++++++++++------
 include/linux/blkdev.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 97f8bc8d3a79..d93e3bb9a769 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1061,20 +1061,32 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 }
 
 static unsigned long __part_start_io_acct(struct block_device *part,
-					  unsigned int sectors, unsigned int op)
+					  unsigned int sectors, unsigned int op,
+					  unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
-	unsigned long now = READ_ONCE(jiffies);
 
 	part_stat_lock();
-	update_io_ticks(part, now, false);
+	update_io_ticks(part, start_time, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
 	part_stat_local_inc(part, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
-	return now;
+	return start_time;
+}
+
+/**
+ * bio_start_io_acct_time - start I/O accounting for bio based drivers
+ * @bio:	bio to start account for
+ * @start_time:	start time that should be passed back to bio_end_io_acct().
+ */
+void bio_start_io_acct_time(struct bio *bio, unsigned long start_time)
+{
+	__part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
+			     bio_op(bio), start_time);
 }
+EXPORT_SYMBOL_GPL(bio_start_io_acct_time);
 
 /**
  * bio_start_io_acct - start I/O accounting for bio based drivers
@@ -1084,14 +1096,15 @@ static unsigned long __part_start_io_acct(struct block_device *part,
  */
 unsigned long bio_start_io_acct(struct bio *bio)
 {
-	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio), bio_op(bio));
+	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
+				    bio_op(bio), jiffies);
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 				 unsigned int op)
 {
-	return __part_start_io_acct(disk->part0, sectors, op);
+	return __part_start_io_acct(disk->part0, sectors, op, jiffies);
 }
 EXPORT_SYMBOL(disk_start_io_acct);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9c95df26fc26..f35aea98bc35 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1258,6 +1258,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		unsigned long start_time);
 
+void bio_start_io_acct_time(struct bio *bio, unsigned long start_time);
 unsigned long bio_start_io_acct(struct bio *bio);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 		struct block_device *orig_bdev);
-- 
2.15.0

