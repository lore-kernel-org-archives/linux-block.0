Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B4DC433FE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 15:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349800AbiA1P6v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245032AbiA1P6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643385526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=feoZP+F8CU+MhuuvBnIaQ56CdERUV6n68Kc4W9BEtGU=;
        b=g3F94lnge+RwRqyHrcfOsAtScS9MdiIRrsYPW3YyBvUt4Fxlvvomr22g+7gS+8bl+ZGCug
        Qo6UE8INXKdES0VuFvWIJaegxnQdGSUwIXFHYwmBcOIckXknbDGznwJrlSpARsKhC+yd7X
        MleYPzqVN9bCGpw8K/rlZnvWjtIgTUw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-7ooOfIh7MIGv-QAUs3zOnQ-1; Fri, 28 Jan 2022 10:58:45 -0500
X-MC-Unique: 7ooOfIh7MIGv-QAUs3zOnQ-1
Received: by mail-qt1-f199.google.com with SMTP id c20-20020ac84e14000000b002d198444921so4784237qtw.23
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 07:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=feoZP+F8CU+MhuuvBnIaQ56CdERUV6n68Kc4W9BEtGU=;
        b=kXjKymwQFfLANK6DuHMokK/U9/HfeXvYc+ICVT8gSbmG7hltqFBZ/IS1NtIPGIh1ED
         Fdm1RZZ+U1ZDai3086KyKOz9iaHLQycWOMwnkDhwzjeaL2tY2gcn2Ai+ckXUMTR+9gn7
         bClPVO/6cg2RMICHB6p5OIPuFeQV2Pzbsm2Qq9uwAM0vLMI7EaOSUJmqMmVRBEiRSpwx
         QZjxC5WZNHzTsAnWLPAKqc7BZcbHMOikaZb9E2GwJKjzbM4y9PnjYn7iVw9KQlH3rfpR
         w9jZgw6lY2w4byTPuIsohFs6iQt18LIt02z0jbtmdCHtkeUafineV9ByLk15z9fsKphP
         rODA==
X-Gm-Message-State: AOAM533auHgiLu9+2utC09a1OsWytcDL7e9jMir4rw01OhLhBELk96SJ
        U5CX5isqUy8j3qYmEW5ZEemQDVn8onGaelHILe8OhEmoFlXsRRy1O6t+AwIDNF8r4YOS4lMT3J5
        o7K/LAWF5vRN6dqiPxT/vfw==
X-Received: by 2002:a37:454d:: with SMTP id s74mr5909293qka.405.1643385524656;
        Fri, 28 Jan 2022 07:58:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuxz2dMV0PAXdD547KZ6/o97ih+oVUp28N/1DDUc/W/RNqad0W7Yx08YDHw8QRriC+il69ug==
X-Received: by 2002:a37:454d:: with SMTP id s74mr5909286qka.405.1643385524475;
        Fri, 28 Jan 2022 07:58:44 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w3sm3005092qta.13.2022.01.28.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 07:58:44 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v4 1/3] block: add bio_start_io_acct_time() to control start_time
Date:   Fri, 28 Jan 2022 10:58:39 -0500
Message-Id: <20220128155841.39644-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220128155841.39644-1-snitzer@redhat.com>
References: <20220128155841.39644-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_start_io_acct_time() interface is like bio_start_io_acct() that
allows start_time to be passed in. This gives drivers the ability to
defer starting accounting until after IO is issued (but possibily not
entirely due to bio splitting).

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

