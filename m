Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E84C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbiBKVla (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiBKVl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6B61C79
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=/xjT8ts7rFxVnWvoCjYqEguiAAMtKDyhhIzyuUrbQZc=;
        b=azR9kBwqCnTBHpTcx7Bqv1ucgliCxbBJdZhyDHw1wvNFKxZ+MoBuOC5EM3c+MC5sUfMJHn
        mU8EU1hK0LM8ahMJCoRtWH/VCKHbxj6uAmCRzXLlcVBuHRYIegl6QKiLszHBJO9XMt16Xu
        VycANuhIndYOSDh8L1WQNo4eS0dFgbI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-Jscgpdy8OvyKw09Z1Uf_ug-1; Fri, 11 Feb 2022 16:41:22 -0500
X-MC-Unique: Jscgpdy8OvyKw09Z1Uf_ug-1
Received: by mail-oo1-f71.google.com with SMTP id r12-20020a4aea8c000000b002fd5bc5d365so6323954ooh.18
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/xjT8ts7rFxVnWvoCjYqEguiAAMtKDyhhIzyuUrbQZc=;
        b=sckp3frwnX3mTEPhusFPyLAYtBJct8HUu2JlsMkqcS8M3drROi+q44poF5LyVsxF+P
         Chp69axQI08VQhO1uyBoU0Kz/jXPEYiJKGAyB7+mZy0MX3NuZD3FZ9hWrCoa5kW5wLeu
         cAY+eWm5uYpj25R2WvGJdsfyPkC8bKfLr9h+mNM6FkD7lA0UrRfJPPDEbvQqj6Pfca8M
         zxZCWO1jFLJnqlmy8gRHV29QPcbVr1Iz0PlUdVzAxYJnRL4FhIDudgQz1Ljw5CA8TAWP
         JUTCI79PdoqVJmtBfWNyOkGB/jrkz/kEmojXBC55WePk268zAdRrw7ASuKfUNFK0E3MB
         +IJw==
X-Gm-Message-State: AOAM532AfblI7VNMsPg/UVArKzBci3JjIeQzoZcRBcOufBCD2DZMCMmG
        Zx7syX8elJqDNw+XNX+bnk89vDDzfE6684XK2+jl6/iRR3HmNxNou28uCiHBpQvgcPt0NaEDG0f
        OKq2Nlg+YLHKqv9YAoLfvyg==
X-Received: by 2002:a05:6808:154:: with SMTP id h20mr1184671oie.103.1644615681662;
        Fri, 11 Feb 2022 13:41:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHoO/6sjs/LcgGlmXM+T/Mc5GkMP/b9FDb0SWRQu9wbHgj1CE1v/5gDlYkTPnYQty7DeOZug==
X-Received: by 2002:a05:6808:154:: with SMTP id h20mr1184665oie.103.1644615681470;
        Fri, 11 Feb 2022 13:41:21 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z4sm2876168oad.21.2022.02.11.13.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:21 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 10/14] block: add bio_start_io_acct_remapped for the benefit of DM
Date:   Fri, 11 Feb 2022 16:40:53 -0500
Message-Id: <20220211214057.40612-11-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DM needs the ability to account a clone bio's IO to the original
block_device. So add @orig_bdev argument to bio_start_io_acct_time.

Rename bio_start_io_acct_time to bio_start_io_acct_remapped.

Also, follow bio_end_io_acct and bio_end_io_acct_remapped pattern by
moving bio_start_io_acct to blkdev.h and have it call
bio_start_io_acct_remapped.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-core.c       | 24 ++++++++----------------
 drivers/md/dm.c        |  3 ++-
 include/linux/blkdev.h | 16 ++++++++++++++--
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index be8812f5489d..8f23be96c737 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1077,29 +1077,21 @@ static unsigned long __part_start_io_acct(struct block_device *part,
 }
 
 /**
- * bio_start_io_acct_time - start I/O accounting for bio based drivers
+ * bio_start_io_acct_remapped - start I/O accounting for bio based drivers
  * @bio:	bio to start account for
  * @start_time:	start time that should be passed back to bio_end_io_acct().
- */
-void bio_start_io_acct_time(struct bio *bio, unsigned long start_time)
-{
-	__part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-			     bio_op(bio), start_time);
-}
-EXPORT_SYMBOL_GPL(bio_start_io_acct_time);
-
-/**
- * bio_start_io_acct - start I/O accounting for bio based drivers
- * @bio:	bio to start account for
+ * @orig_bdev:	block device that I/O must be accounted to.
  *
  * Returns the start time that should be passed back to bio_end_io_acct().
  */
-unsigned long bio_start_io_acct(struct bio *bio)
+unsigned long bio_start_io_acct_remapped(struct bio *bio,
+				unsigned long start_time,
+				struct block_device *orig_bdev)
 {
-	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-				    bio_op(bio), jiffies);
+	return __part_start_io_acct(orig_bdev, bio_sectors(bio),
+				    bio_op(bio), start_time);
 }
-EXPORT_SYMBOL_GPL(bio_start_io_acct);
+EXPORT_SYMBOL_GPL(bio_start_io_acct_remapped);
 
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 				 unsigned int op)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 72686329f91e..c0177552b471 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -489,7 +489,8 @@ static void start_io_acct(struct dm_io *io)
 {
 	struct bio *bio = io->orig_bio;
 
-	bio_start_io_acct_time(bio, io->start_time);
+	bio_start_io_acct_remapped(bio, io->start_time,
+				   io->orig_bio->bi_bdev);
 
 	if (unlikely(dm_stats_used(&io->md->stats)))
 		dm_stats_account_io(&io->md->stats, bio_data_dir(bio),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3bfc75a2a450..31d055d4a17e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1512,11 +1512,23 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		unsigned long start_time);
 
-void bio_start_io_acct_time(struct bio *bio, unsigned long start_time);
-unsigned long bio_start_io_acct(struct bio *bio);
+unsigned long bio_start_io_acct_remapped(struct bio *bio,
+				unsigned long start_time,
+				struct block_device *orig_bdev);
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 		struct block_device *orig_bdev);
 
+/**
+ * bio_start_io_acct - start I/O accounting for bio based drivers
+ * @bio:	bio to start account for
+ *
+ * Returns the start time that should be passed back to bio_end_io_acct().
+ */
+static inline unsigned long bio_start_io_acct(struct bio *bio)
+{
+	return bio_start_io_acct_remapped(bio, jiffies, bio->bi_bdev);
+}
+
 /**
  * bio_end_io_acct - end I/O accounting for bio based drivers
  * @bio:	bio to end account for
-- 
2.15.0

