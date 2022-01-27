Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7CDC433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 22:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiA0W4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:56:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbiA0W4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 17:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643324213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=LPT/xXbA8dMnjNDPrd3foEhpTUzqW1ZlXYJLQcHQMDc=;
        b=QFWkEuNGXxAoOEVqrh+qeAgt6FELWRpJ4VUWy928ylA4HEL1laFctIx7PxTld1oh5HyCsl
        kR7SiUj4j2ieQ+U+7FzAKuA328YNy1KgLtm2AX5QCtPFkO4CvnX7myYT/awdj907uCMaK3
        P2L6fsmxAqZOrVSb5w2vFlsMXh3f3Uk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-ftDUR_S0NhKAK_i8oxWjrA-1; Thu, 27 Jan 2022 17:56:51 -0500
X-MC-Unique: ftDUR_S0NhKAK_i8oxWjrA-1
Received: by mail-qt1-f198.google.com with SMTP id x5-20020ac84d45000000b002cf826b1a18so3336408qtv.2
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 14:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LPT/xXbA8dMnjNDPrd3foEhpTUzqW1ZlXYJLQcHQMDc=;
        b=13iO9zfYstyChK7gN/OW+3HVsyWnGjKG8AyGLajp3OBv5X76+II7dtYk9Ov9PZHrtH
         ViPHiQlDkHQCXDRDhzavMTUmCVIvPVQCyY/7HRqewj3GbKRqZIEWsAmnqfhogx7NRQS7
         APitIxBbrZotwXvG7hv0EyC/fP7fqxpELEZ6bgKRqk7Uu0Mb/949eu3gbXKcm8iefi7l
         ffVJpoGox3v9bSbQh9EkwcKsTjbsyDWhH9rtLrGU5puCDasUknrMMmn67P45jLVVpD4r
         tO6jeX0N4O3Z53wlu974YaMJVj0fJv91/8kkHcEM9Ih7H7EY2kXbtPBUB9zIEmXZac6y
         B9aA==
X-Gm-Message-State: AOAM532uM5f6615kyOHi2h+4Y4rf9FwzE8IYe1vCLS417xDMlydvV/84
        9uUEg2O3D8rZpxCKXVIeHi+IzUX3faYJZn9q41DyOhK390HjOi+ef+Wxlgj47lH6e+0876tbiOH
        TsVcWWUBRAnk/O98t2VfoKQ==
X-Received: by 2002:a05:620a:141a:: with SMTP id d26mr4086407qkj.403.1643324211288;
        Thu, 27 Jan 2022 14:56:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvpuCni4WvV5PNyzRGhC0OXvCVSabWWqJ2hiDnj4Ya0PLPWe4YLLKbvK6oGvLtvu8SjLW8yw==
X-Received: by 2002:a05:620a:141a:: with SMTP id d26mr4086396qkj.403.1643324211073;
        Thu, 27 Jan 2022 14:56:51 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id i5sm2205277qkn.19.2022.01.27.14.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:56:50 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 1/3] block: add bio_start_io_acct_time() to control start_time
Date:   Thu, 27 Jan 2022 17:56:46 -0500
Message-Id: <20220127225648.28729-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127225648.28729-1-snitzer@redhat.com>
References: <20220127225648.28729-1-snitzer@redhat.com>
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

