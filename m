Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927C3CD13D8
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 04:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjIREMZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 00:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbjIREMV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 00:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB97115
        for <linux-block@vger.kernel.org>; Sun, 17 Sep 2023 21:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695010289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPWT02s2CM706fOFGqrBFd6kGdqjwMylb/OMZksDA8s=;
        b=QfrQl+X+lTB34i7Uz2fY4v5lmDTcaK3Tgr0DuD8iBTW57tSu3SG0Ljcq4KE6527bvasQnn
        IDvvbe6/JTLzwWl1EarW7FPqPgXga+i7Xt+Ke6jgr0G11E661+IgceNoXWIDw5IVNADJMU
        y26eFPhPfv+l2KkHWosBwD3NA3rVotQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-TtqFWRStO_mLqTTwQlvOXg-1; Mon, 18 Sep 2023 00:11:27 -0400
X-MC-Unique: TtqFWRStO_mLqTTwQlvOXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 687E0801779;
        Mon, 18 Sep 2023 04:11:27 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89D5640C2064;
        Mon, 18 Sep 2023 04:11:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 02/10] io_uring: pass io_uring_ctx->id to uring_cmd
Date:   Mon, 18 Sep 2023 12:10:58 +0800
Message-Id: <20230918041106.2134250-3-ming.lei@redhat.com>
In-Reply-To: <20230918041106.2134250-1-ming.lei@redhat.com>
References: <20230918041106.2134250-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass io_uring_ctx-id to uring_cmd driver, and prepare for supporting
io_uring ctx or task exit notifier.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring.h | 6 +++++-
 io_uring/uring_cmd.c     | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index ec9714e36477..c395807bd7cf 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -33,7 +33,11 @@ struct io_uring_cmd {
 	};
 	u32		cmd_op;
 	u32		flags;
-	u8		pdu[32]; /* available inline for free use */
+	union {
+		/* driver needs to save ctx_id */
+		u32		ctx_id;
+		u8		pdu[32]; /* available inline for free use */
+	};
 };
 
 static inline const void *io_uring_sqe_cmd(const struct io_uring_sqe *sqe)
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 537795fddc87..c54c627fb6b9 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -105,6 +105,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		req->imu = ctx->user_bufs[index];
 		io_req_set_rsrc_node(req, ctx, 0);
 	}
+	ioucmd->ctx_id = req->ctx->id;
 	ioucmd->sqe = sqe;
 	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
 	return 0;
-- 
2.40.1

