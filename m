Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41482CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiFWTAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiFWTAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:06 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D1B85B7
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:40 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id q140so164215pgq.6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iW10J4r9MKGhlA5RnPdc1iFrQ28tpX2vruzg3An4r7o=;
        b=dKk2c+nLIvqlcPyPdtA822/4I6ZOZi+c5Pj8yFF6e9k6fsxnVa/P6odMYzc2t/tlEd
         wDARO/qfpnjQxVrLgdTe1o/TfWaQ4nl8Bo1nI6oXlzD1ydhJR3lAI/HVAaHllGH45ZDW
         AZciC9GX2n+/1TxdA6IHHaht/T/QeSP+6zVMVGAAs9ZA891pj7USmhhv8Pnec0KuXhCe
         2f7JVnVk1CDBI6Clr4ApUt1SaSdCJ+nk85IHrhydqvODavXL+VmJGTr/Iv3X9jJQwnZQ
         nVBNaMoqWugHSFSBMEdX2RxBTDfaifRO4D5U3KnRWaywOR6X5usxN48BTQ/TTXVv0Unk
         791A==
X-Gm-Message-State: AJIora/fPd2LY3MN9Wa2odPEmPyjR1KGot7lm3RfM6GK30C0TTCVy1Ye
        tfee0+TK5gzMssvNgu7y9lM=
X-Google-Smtp-Source: AGRyM1vg01Z+OcrDxoBcBNy2EQm4TDGdbaxlO32jzW61PWfBbYJ8bsy92T9PRscBaRFvXw5qwEvYcg==
X-Received: by 2002:a63:3851:0:b0:40d:622:1b7b with SMTP id h17-20020a633851000000b0040d06221b7bmr8613137pgn.431.1656007540158;
        Thu, 23 Jun 2022 11:05:40 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 04/51] block: Change the type of req_op() and bio_op() into enum req_op
Date:   Thu, 23 Jun 2022 11:04:41 -0700
Message-Id: <20220623180528.3595304-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c         | 2 ++
 drivers/block/paride/pd.c | 2 ++
 drivers/md/dm.c           | 2 ++
 include/linux/blk-mq.h    | 6 ++++--
 include/linux/blk_types.h | 6 ++++--
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0f5f42ebd0bb..9d96c9239219 100644
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
index 3637c38c72f9..a186f5bf235e 100644
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
index 789f48e1a0e5..bed7ad573f79 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1539,6 +1539,8 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
 	case REQ_OP_WRITE_ZEROES:
 		num_bios = ti->num_write_zeroes_bios;
 		break;
+	default:
+		break;
 	}
 
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 45d69cc46dc7..9a1838bbed02 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -197,8 +197,10 @@ struct request {
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
