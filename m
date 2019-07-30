Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB118C0650F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8555320C01
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfG3SSH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:18:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36409 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbfG3SSG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 14:18:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so30267884pfl.3
        for <linux-block@vger.kernel.org>; Tue, 30 Jul 2019 11:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFf7FfipKf4YjMmj4Z92Pfv4esvoZUAtr/L6dGQBO9E=;
        b=pKsAoO6r7u3yhcl3ITY7bxNq6D+E4urfI0+dnnUTkObQCMr/ccbnkn4JSYjt2Tc497
         Jnd9FFH1esKDDhRBHx395R38uxv+O6tXBE+uufvISt4Qs6vm20Wr+oAzGyo3brLsPt9B
         zhH+fnu6mkGZtas7dQ9SO1cVlcfGRslSjSLcp4oMxh1HKljj9hJgTpBDPfieokkHvP9d
         sGLuGSDzuV2RBQjb2s7GGNtif5UU5lrj0MFwn6e/wHFcekwpNFl4Xbmt2BzSFxVmWHXI
         LoSaoEtUSKeiYOQvVq6oZS8PDdEZ2PbvJMwJE172OMBZvkzAZ+T0fbiTEH38vtLjSCaP
         QXSw==
X-Gm-Message-State: APjAAAUpTtPDmD9GB2EVTgKEayuZvkiZxArmiuTz/UnydJ/OCwDW3GPw
        7HQ08+2K0faFQoHLitwd38E=
X-Google-Smtp-Source: APXvYqzrBt5ufTV6Ie1bjQLWU4GGIWm3eCei3tp5Me7h0lIl0hix25rGQhVJsYx5DSMBIjwohQnX+g==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr112578233pgc.310.1564510685887;
        Tue, 30 Jul 2019 11:18:05 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 32sm12165895pgt.43.2019.07.30.11.18.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:18:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alexandru Moise <00moses.alexander00@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 1/2] block: Verify whether blk_queue_enter() is used when necessary
Date:   Tue, 30 Jul 2019 11:17:56 -0700
Message-Id: <20190730181757.248832-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181757.248832-1-bvanassche@acm.org>
References: <20190730181757.248832-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is required to protect blkg_lookup() calls with a blk_queue_enter() /
blk_queue_exit() pair. Since it is nontrivial to verify whether this is
the case, verify this at runtime. Only perform this verification if
CONFIG_LOCKDEP=y to avoid that unnecessary runtime overhead is added.

Note: using lock_acquire()/lock_release() to verify whether blkg_lookup()
is protected correctly is not possible since lock_acquire() and
lock_release() must be called from the same task and since
blk_queue_enter() and blk_queue_exit() can be called from different
tasks.

Suggested-by: Tejun Heo <tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-cgroup.c         |  2 ++
 block/blk-core.c           | 21 +++++++++++++++++++++
 include/linux/blk-cgroup.h |  2 ++
 include/linux/blkdev.h     |  8 ++++++++
 4 files changed, 33 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 24ed26957367..04b6e962eefb 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -196,6 +196,8 @@ struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 {
 	struct blkcg_gq *blkg;
 
+	WARN_ON_ONCE(!blk_entered_queue(q));
+
 	/*
 	 * Hint didn't match.  Look up from the radix tree.  Note that the
 	 * hint can only be updated under queue_lock as otherwise @blkg
diff --git a/block/blk-core.c b/block/blk-core.c
index 5878504a29af..ff27c3080348 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -389,6 +389,25 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+#ifdef CONFIG_PROVE_LOCKING
+/**
+ * blk_entered_queue() - whether or not it is safe to access cgroup information
+ * @q: request queue pointer
+ *
+ * In order to avoid races between accessing cgroup information and the cgroup
+ * information removal from inside __blk_release_queue(), any code that accesses
+ * cgroup information must be protected by a blk_queue_enter()/blk_queue_exit()
+ * pair or must be called after queue cleanup progressed to a stage in which
+ * only the cleanup code accesses the queue.
+ */
+bool blk_entered_queue(struct request_queue *q)
+{
+	return percpu_ref_is_dying(&q->q_usage_counter) ||
+		!percpu_ref_is_zero(&q->q_usage_counter);
+}
+EXPORT_SYMBOL(blk_entered_queue);
+#endif
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -878,6 +897,8 @@ generic_make_request_checks(struct bio *bio)
 		goto end_io;
 	}
 
+	WARN_ON_ONCE(!blk_entered_queue(q));
+
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue is not a request based queue.
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 689a58231288..397df0719bda 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -358,6 +358,8 @@ static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
 {
 	struct blkcg_gq *blkg;
 
+	WARN_ON_ONCE(!blk_entered_queue(q));
+
 	if (blkcg == &blkcg_root)
 		return q->root_blkg;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 96a29a72fd4a..e57651888450 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -856,6 +856,14 @@ extern int sg_scsi_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
+#ifdef CONFIG_PROVE_LOCKING
+extern bool blk_entered_queue(struct request_queue *q);
+#else
+static inline bool blk_entered_queue(struct request_queue *q)
+{
+	return true;
+}
+#endif
 extern void blk_sync_queue(struct request_queue *q);
 extern int blk_rq_map_user(struct request_queue *, struct request *,
 			   struct rq_map_data *, void __user *, unsigned long,
-- 
2.22.0.709.g102302147b-goog

