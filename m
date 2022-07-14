Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01841C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiGNSHo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiGNSHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:43 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F5474DB
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:42 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id v21so1116802plo.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FqWcVZR+TlS6nAYd4x1HnwZQVCB/mm92CN44/Naq0EY=;
        b=psRcrLWG8SYJywAwLfS+zWe/wIkASdIoI/XnfqpZKTNvnj3eS54z35uGzlQ8QaOxiG
         5QVu4jTW5MUedPu6g7ZU6Y1XwE01CRbvGZ8fcSozD/PMWFUZ70rKwHRO3haQ6ui/306l
         Zgg0ZOgeICjEIhdLq5iOEu6WvnqpUqtYllslTNe1s5UoFxIGtWcYKQU/M3PUbvv44PIH
         lppm0MCEKrbv8dZHjWCAWVPKGeafQQJkEWTA8+q9+F+Qgt32YeSgquYnsBFIkoCWTiiC
         4T1dQQWbeOzCE68LhMmLW+ecCnDf1cBnwXUO23ekmgNbWTKXYXg/ivVWsBMQm1z3JzYl
         YoNw==
X-Gm-Message-State: AJIora9GDj0h4mdKSWln8NiLK3wzpSTspeRg2UutXBJK0MnB8f39XEf/
        cIHZvEbcw1btL5IGH46zZxY=
X-Google-Smtp-Source: AGRyM1sL+jUnEqzIL+43kvvHupl8mPhTvecpUo4ccD0MUbROh6lWhszs1wA0nr3mpTM5vDf0TMh8XQ==
X-Received: by 2002:a17:902:8343:b0:167:8899:2f92 with SMTP id z3-20020a170902834300b0016788992f92mr9626162pln.117.1657822062106;
        Thu, 14 Jul 2022 11:07:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Tim Waugh <tim@cyberelk.net>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 04/63] block: Change the type of req_op() and bio_op() into enum req_op
Date:   Thu, 14 Jul 2022 11:06:30 -0700
Message-Id: <20220714180729.1065367-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by changing the type of the value returned by
req_op() and bio_op() from unsigned int into enum req_op. Insert
'default: break;' in switch statements on the enum req_op type to prevent
that the compiler warns about these switch statements.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Tim Waugh <tim@cyberelk.net>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c         | 2 ++
 drivers/block/paride/pd.c | 2 ++
 drivers/md/dm.c           | 2 ++
 include/linux/blk-mq.h    | 6 ++++--
 include/linux/blk_types.h | 6 ++++--
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5abf5aa5a5f0..de178a8b4c82 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -405,6 +405,8 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 		return 1;
 	case REQ_OP_WRITE_ZEROES:
 		return 0;
+	default:
+		break;
 	}
 
 	rq_for_each_bvec(bv, rq, iter)
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index c8c14c6f5c3a..f8a75bc90f70 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -501,6 +501,8 @@ static enum action do_pd_io_start(void)
 			return do_pd_read_start();
 		else
 			return do_pd_write_start();
+	default:
+		break;
 	}
 	return Fail;
 }
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 33d3799bb66e..6c21922b87d0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1542,6 +1542,8 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
 	case REQ_OP_WRITE_ZEROES:
 		num_bios = ti->num_write_zeroes_bios;
 		break;
+	default:
+		break;
 	}
 
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d74f6a6b7e69..677195de0663 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -198,8 +198,10 @@ struct request {
 	void *end_io_data;
 };
 
-#define req_op(req) \
-	((req)->cmd_flags & REQ_OP_MASK)
+static inline enum req_op req_op(const struct request *req)
+{
+	return req->cmd_flags & REQ_OP_MASK;
+}
 
 static inline bool blk_rq_is_passthrough(struct request *rq)
 {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cce8768bc00b..e66cbe377ae8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -463,8 +463,10 @@ enum stat_group {
 	NR_STAT_GROUPS
 };
 
-#define bio_op(bio) \
-	((bio)->bi_opf & REQ_OP_MASK)
+static inline enum req_op bio_op(const struct bio *bio)
+{
+	return bio->bi_opf & REQ_OP_MASK;
+}
 
 /* obsolete, don't use in new code */
 static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
