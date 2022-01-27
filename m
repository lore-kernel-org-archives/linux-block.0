Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C931FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 19:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbiA0THt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239096AbiA0THt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 14:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643310468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Mcb+ktGUGJ4HlzXNV8rq6rWy920OMZnuBuYL0YqXQLQ=;
        b=hm0cCKumtMsDn3dCl/Q1XAajJm+aqGDhYrJYvl9HfVCx5gDfn3wm8ds1wZush6DvDxWaZi
        0Rkqr6p6py0UJuWXsOWqCZEpyaWIxJuEgVDTXZGbdb01Os5xXcy+u1tzkfLxY5PTPwGnBd
        135FSdzQKH9+zD2fPlTnPAHjGyJPtRA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-_nVZmE3vNLOUMQmLQe7S7A-1; Thu, 27 Jan 2022 14:07:47 -0500
X-MC-Unique: _nVZmE3vNLOUMQmLQe7S7A-1
Received: by mail-qk1-f199.google.com with SMTP id d11-20020a37680b000000b0047d87e46f4aso3108918qkc.11
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 11:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mcb+ktGUGJ4HlzXNV8rq6rWy920OMZnuBuYL0YqXQLQ=;
        b=5r4/1PjzhtY6bE8YcJr3FOXa2shqODDw7Y7+nu/RhOjt+m9DrakL1Un2kuGC7elYBX
         2m8UzgTka9cM0Qep5aJ28bfYpa7LN/fksFRpztDcSdmUqSbEb+cQohY6yKK3+KL2F2Kt
         BBzcZNINXo1RwoXqNwsrFdvfmqBWQNQqhDhIWyvnmv5bjRtiVJfva69QXoMYZJP23K1N
         9IwgWMH6ARxyg4VGyp62vMkbBIvqBeyhS5+gR8f//dXLQJqMmyN5YbFitUIr8Aec305y
         +IpSl+nU+ankgDmGXCAmLNUAEiOSN8qUHwKPVTzfM8jCmsTv3+1fMrarOccuLY/CicMS
         eHXA==
X-Gm-Message-State: AOAM530+MOjGPc0OL2DJ/YEj2SrFdsa79evHKjs/V5DbIDXGlmy0gI5z
        z3x7XQQamHzsc3p+SG4Ksv6D8HwNG43Jp5TXREb4ziemWVfC54u+RRONAZSAXP1SEX1tJg0aCwr
        7kYcXU6TI6DmPnbh53qNAIw==
X-Received: by 2002:a05:6214:c66:: with SMTP id t6mr4716133qvj.19.1643310466551;
        Thu, 27 Jan 2022 11:07:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXHG1MTwpN3KTgGPH5X5OglQEa0u195K9rFWI52LePU9Dx+L87Vn0bG74FauJJTD6KSNMkRg==
X-Received: by 2002:a05:6214:c66:: with SMTP id t6mr4716108qvj.19.1643310466185;
        Thu, 27 Jan 2022 11:07:46 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d13sm1891974qte.77.2022.01.27.11.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:07:45 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: add __bio_start_io_acct() to control start_time
Date:   Thu, 27 Jan 2022 14:07:40 -0500
Message-Id: <20220127190742.12776-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127190742.12776-1-snitzer@redhat.com>
References: <20220127190742.12776-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__bio_start_io_acct() interface is like bio_start_io_acct() that
allows start_time to be passed in. This gives drivers the ability to
defer starting accounting until after IO is issued (but possibily not
entirely due to bio splitting).

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-core.c       | 27 ++++++++++++++++++++-------
 include/linux/blkdev.h |  1 +
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 97f8bc8d3a79..18cd12fee67d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1060,21 +1060,30 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	}
 }
 
-static unsigned long __part_start_io_acct(struct block_device *part,
-					  unsigned int sectors, unsigned int op)
+static void __part_start_io_acct(struct block_device *part, unsigned int sectors,
+				 unsigned int op, unsigned long start_time)
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
+}
 
-	return now;
+/**
+ * __bio_start_io_acct - start I/O accounting for bio based drivers
+ * @bio:	bio to start account for
+ * @start_time:	start time that should be passed back to bio_end_io_acct().
+ */
+void __bio_start_io_acct(struct bio *bio, unsigned long start_time)
+{
+	__part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
+			     bio_op(bio), start_time);
 }
+EXPORT_SYMBOL_GPL(__bio_start_io_acct);
 
 /**
  * bio_start_io_acct - start I/O accounting for bio based drivers
@@ -1084,14 +1093,18 @@ static unsigned long __part_start_io_acct(struct block_device *part,
  */
 unsigned long bio_start_io_acct(struct bio *bio)
 {
-	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio), bio_op(bio));
+	unsigned long now = READ_ONCE(jiffies);
+	__bio_start_io_acct(bio, now);
+	return now;
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 				 unsigned int op)
 {
-	return __part_start_io_acct(disk->part0, sectors, op);
+	unsigned long now = READ_ONCE(jiffies);
+	__part_start_io_acct(disk->part0, sectors, op, now);
+	return now;
 }
 EXPORT_SYMBOL(disk_start_io_acct);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9c95df26fc26..ed3cd5f7f984 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1258,6 +1258,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		unsigned long start_time);
 
+void __bio_start_io_acct(struct bio *bio, unsigned long start_time);
 unsigned long bio_start_io_acct(struct bio *bio);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 		struct block_device *orig_bdev);
-- 
2.15.0

