Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F37C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiFWTA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiFWTAe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:34 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26FA1E0F
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:56 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id h192so175828pgc.4
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CYBwJNI0zfXDMBqtEhOK5NW3yhdwcJdPVHIPEW1sS0=;
        b=pqQ/xENAN6rGgLwdlQeJFjMb8jPrMECM1A8d56BVExYh8tmlauQ3F8nOqwjpv6U2y1
         f6gQcnqcfTYFDItbc5HEcGEKX5pqvtVkozJ1BFZrvKORQBFp1nyFzfF+5fyrya/lprNn
         8aE2ydth8w9hN71tZZgymNn31z4TmOgA6PTGGkNO8UFQQmBaW2vLZ6CGsXBOmZXqQl0O
         FnpUz2xrrKozL6GFFSAPy1aITpUOHgo7K8bYhKgH/rthUiI8y87YWFTrM9RX+Jnznatu
         3IWNQ0F/GHkeODp14YxYZm/uvWNkIgnqjFlyX0CcA/41ChbeDkOkwLyY7PHfDdPZ2hc5
         /JfA==
X-Gm-Message-State: AJIora/fTlq+NlZpuDKlIQZpCE0/kMDm57bfrVRojA8cW1X7Z0ceP75d
        c3jb+27/Af7VLwTcKCy26aVR34ZM+f0=
X-Google-Smtp-Source: AGRyM1sT8f3fuBGCkLZRpvuSK/xk+18DP+Q7+JiOKRyidbc4dV4jyzYQZsBL5ZL+l5MsjIDoxJlrzg==
X-Received: by 2002:a63:af1c:0:b0:40c:f9d6:9f07 with SMTP id w28-20020a63af1c000000b0040cf9d69f07mr8509371pge.384.1656007556151;
        Thu, 23 Jun 2022 11:05:56 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 14/51] dm/core: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:04:51 -0700
Message-Id: <20220623180528.3595304-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags all or not combined with a request
operation.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-io.c    | 18 ++++++++++--------
 drivers/md/dm.c       |  2 +-
 include/linux/dm-io.h |  5 +++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index e4b95eaeec8c..29ff150634cd 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -293,7 +293,7 @@ static void km_dp_init(struct dpages *dp, void *data)
 /*-----------------------------------------------------------------
  * IO routines that accept a list of pages.
  *---------------------------------------------------------------*/
-static void do_region(int op, int op_flags, unsigned region,
+static void do_region(enum req_op op, blk_opf_t op_flags, unsigned region,
 		      struct dm_io_region *where, struct dpages *dp,
 		      struct io *io)
 {
@@ -368,9 +368,9 @@ static void do_region(int op, int op_flags, unsigned region,
 	} while (remaining);
 }
 
-static void dispatch_io(int op, int op_flags, unsigned int num_regions,
-			struct dm_io_region *where, struct dpages *dp,
-			struct io *io, int sync)
+static void dispatch_io(enum req_op op, blk_opf_t op_flags,
+			unsigned int num_regions, struct dm_io_region *where,
+			struct dpages *dp, struct io *io, int sync)
 {
 	int i;
 	struct dpages old_pages = *dp;
@@ -411,8 +411,9 @@ static void sync_io_complete(unsigned long error, void *context)
 }
 
 static int sync_io(struct dm_io_client *client, unsigned int num_regions,
-		   struct dm_io_region *where, int op, int op_flags,
-		   struct dpages *dp, unsigned long *error_bits)
+		   struct dm_io_region *where, enum req_op op,
+		   blk_opf_t op_flags, struct dpages *dp,
+		   unsigned long *error_bits)
 {
 	struct io *io;
 	struct sync_io sio;
@@ -445,8 +446,9 @@ static int sync_io(struct dm_io_client *client, unsigned int num_regions,
 }
 
 static int async_io(struct dm_io_client *client, unsigned int num_regions,
-		    struct dm_io_region *where, int op, int op_flags,
-		    struct dpages *dp, io_notify_fn fn, void *context)
+		    struct dm_io_region *where, enum req_op op,
+		    blk_opf_t op_flags, struct dpages *dp, io_notify_fn fn,
+		    void *context)
 {
 	struct io *io;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index bed7ad573f79..ea0bbbd6837f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1622,7 +1622,7 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
 	 */
-	ci->submit_as_polled = ci->bio->bi_opf & REQ_POLLED;
+	ci->submit_as_polled = !!(ci->bio->bi_opf & REQ_POLLED);
 
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 	setup_split_accounting(ci, len);
diff --git a/include/linux/dm-io.h b/include/linux/dm-io.h
index a52c6580cc9a..811f29ca4971 100644
--- a/include/linux/dm-io.h
+++ b/include/linux/dm-io.h
@@ -13,6 +13,7 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
+#include <linux/blk_types.h>
 
 struct dm_io_region {
 	struct block_device *bdev;
@@ -57,8 +58,8 @@ struct dm_io_notify {
  */
 struct dm_io_client;
 struct dm_io_request {
-	int bi_op;			/* REQ_OP */
-	int bi_op_flags;		/* req_flag_bits */
+	enum req_op bi_op;		/* REQ_OP */
+	blk_opf_t bi_op_flags;	/* req_flag_bits */
 	struct dm_io_memory mem;	/* Memory to use for io */
 	struct dm_io_notify notify;	/* Synchronous if notify.fn is NULL */
 	struct dm_io_client *client;	/* Client memory handler */
