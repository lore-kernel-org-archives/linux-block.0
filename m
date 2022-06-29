Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C04C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiF2XcC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiF2XcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:02 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7467C25C
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:01 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d5so15451977plo.12
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRxku0WXDANm7z5TeUSMTAVqAqjVwDmJwFzBJtXG76A=;
        b=My4BbBLk7GHGpcJrdimDjbx1wf/P89jF0Lxi8FAi3JccMRY+QWvCfa/cLJpQ3Eojiw
         7kDuUMuT66GPOXmxcW/a67N7bkj6EGurS4gy6kWsGUmsKTpA5kb1RCvG72PCBc5R4hp+
         zegMnp2Hr/uTRVYm1TUhQcrd7QA+HZPMw2xL2n+dk2WHrpwYu2PCaBrGbva87M9sg34N
         YlelEgfZ3K2K6ZMl5ptJGI6yryRpZdMzutZrLo8N01w8AMdUaPBhqnvMP/Ok6j9B2G4v
         uSCStuSsYuNzokH24fDNrKGOeoo2PhrreaWcZlIIoSRxzRbN38TkYLM+p52s5ZBxtAw8
         ArTQ==
X-Gm-Message-State: AJIora+COq0pqwMDAvcEYYaE2pmCaLHbaXE4Q8tWTUpqzlFwfn+h8fqn
        VQPmII+F5342yxhaGXvwOzs=
X-Google-Smtp-Source: AGRyM1ui/4coAT9nkCuGHDLI3TBebSjgp/JMNb6BiiLRW5DUZLeqagJkLKlS0/Mha+kXAhARgNjcAA==
X-Received: by 2002:a17:902:b681:b0:16a:f81:6b02 with SMTP id c1-20020a170902b68100b0016a0f816b02mr12110611pls.28.1656545520923;
        Wed, 29 Jun 2022 16:32:00 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 04/63] block: Change the type of req_op() and bio_op() into enum req_op
Date:   Wed, 29 Jun 2022 16:30:46 -0700
Message-Id: <20220629233145.2779494-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
index 8872f9c63688..c6e004157da3 100644
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
index 43aad0da3305..16b70f952a07 100644
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
