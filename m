Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C042C6FD1F
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 18:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCNSWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCNSWD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 14:22:03 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653BFAB094
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 11:22:01 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id k18-20020a17090a591200b0023d36e30cb5so3169001pji.1
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 11:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/dUDno2FJnXaQAIB8DGKZ56WFRROVuSaX+BWuSmFyc=;
        b=FGCuUPKhSE0jtMxM8KoIvC5V4HkuUyauXq4YMJmgpqXOC+CGhpAksQoPVtEJE8e9AC
         yRWOa45NkHFEpeSrw9oVJV8swQayoF/mCbDYjlZjkMKFi2DTvNi295+n8opeABCLeEjK
         Zh5d5aXXogA/4KFnUR84bTQBIbo8uQLwHG/ZfCXkRKLeDuItdVqh0qRb/IzI8derhpIp
         4LdxS1rEXoyFF9mscRd5jEGukq6mbHPgAe13nQyRYgAIuTSIEruMAtHEQb1p70Hnc8ap
         QdV4kxmhG0HU4q6sBA+epcwlh8Uk9+w9vszaasVul4J/FTthjLpudBRDHrieAFz+itbO
         eRWA==
X-Gm-Message-State: AO0yUKX4FBBzXzERf99svsQSdvPYk832/l8HBvF7VHtHxpGjEhIl8UWV
        3b50e7zx4cbkGZrryuIGgP0=
X-Google-Smtp-Source: AK7set88E3+jjuZkCk36UvjxD4AMhqk8dGYOG3+x+m4eNQIwwpz2P3RQhhV4ZrvUcSy+F9jvzBy0GA==
X-Received: by 2002:a17:903:485:b0:1a0:7425:4b73 with SMTP id jj5-20020a170903048500b001a074254b73mr1068551plb.4.1678818120684;
        Tue, 14 Mar 2023 11:22:00 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9cdb:df66:226e:e52a])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170902f94500b0019a837be977sm2051087plb.271.2023.03.14.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:22:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ming Lei <ming.lei@canonical.com>
Subject: [PATCH] loop: Fix use-after-free issues
Date:   Tue, 14 Mar 2023 11:21:54 -0700
Message-Id: <20230314182155.80625-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

do_req_filebacked() calls blk_mq_complete_request() synchronously or
asynchronously when using asynchronous I/O unless memory allocation fails.
Hence, modify loop_handle_cmd() such that it does not dereference 'cmd' nor
'rq' after do_req_filebacked() finished unless we are sure that the request
has not yet been completed. This patch fixes the following kernel crash:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000054
Call trace:
 css_put.42938+0x1c/0x1ac
 loop_process_work+0xc8c/0xfd4
 loop_rootcg_workfn+0x24/0x34
 process_one_work+0x244/0x558
 worker_thread+0x400/0x8fc
 kthread+0x16c/0x1e0
 ret_from_fork+0x10/0x20

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Fixes: c74d40e8b5e2 ("loop: charge i/o to mem and blk cg")
Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 839373451c2b..28eb59fd71ca 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1859,35 +1859,44 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void loop_handle_cmd(struct loop_cmd *cmd)
 {
+	struct cgroup_subsys_state *cmd_blkcg_css = cmd->blkcg_css;
+	struct cgroup_subsys_state *cmd_memcg_css = cmd->memcg_css;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	const bool write = op_is_write(req_op(rq));
 	struct loop_device *lo = rq->q->queuedata;
 	int ret = 0;
 	struct mem_cgroup *old_memcg = NULL;
+	const bool use_aio = cmd->use_aio;
 
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;
 	}
 
-	if (cmd->blkcg_css)
-		kthread_associate_blkcg(cmd->blkcg_css);
-	if (cmd->memcg_css)
+	if (cmd_blkcg_css)
+		kthread_associate_blkcg(cmd_blkcg_css);
+	if (cmd_memcg_css)
 		old_memcg = set_active_memcg(
-			mem_cgroup_from_css(cmd->memcg_css));
+			mem_cgroup_from_css(cmd_memcg_css));
 
+	/*
+	 * do_req_filebacked() may call blk_mq_complete_request() synchronously
+	 * or asynchronously if using aio. Hence, do not touch 'cmd' after
+	 * do_req_filebacked() has returned unless we are sure that 'cmd' has
+	 * not yet been completed.
+	 */
 	ret = do_req_filebacked(lo, rq);
 
-	if (cmd->blkcg_css)
+	if (cmd_blkcg_css)
 		kthread_associate_blkcg(NULL);
 
-	if (cmd->memcg_css) {
+	if (cmd_memcg_css) {
 		set_active_memcg(old_memcg);
-		css_put(cmd->memcg_css);
+		css_put(cmd_memcg_css);
 	}
  failed:
 	/* complete non-aio request */
-	if (!cmd->use_aio || ret) {
+	if (!use_aio || ret) {
 		if (ret == -EOPNOTSUPP)
 			cmd->ret = ret;
 		else
