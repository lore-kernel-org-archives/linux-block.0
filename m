Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D256E732CA
	for <linux-block@archiver.kernel.org>; Thu, 28 Sep 2023 12:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjI1Mo2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Sep 2023 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjI1Mo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2023 08:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423DD191
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695905021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfLlvPH45HtA+ABsFEkKa0PbHb5o88ZJzs3bc5tDHII=;
        b=ceEEk7TAo41qJqOMmQw+Gr5xOFubwuH/wsu8r1j5fm82C6G3SNQAwbmOgZcX1TqXxhtP6P
        b66lMnvmTojOcB0PGNj6vJHAWu/nVjM/z9rOP/4oshmV47GFmReQdipCSExlSq/XTALXsZ
        T+64i/iwK85d/Ud8qSBB7WgLno35DJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-NZS41LVtMWivMpwHQNdnpw-1; Thu, 28 Sep 2023 08:43:40 -0400
X-MC-Unique: NZS41LVtMWivMpwHQNdnpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B5F3811E7B;
        Thu, 28 Sep 2023 12:43:39 +0000 (UTC)
Received: from localhost (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6B8B40C2070;
        Thu, 28 Sep 2023 12:43:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 1/2] io_uring: retain top 8bits of uring_cmd flags for kernel internal use
Date:   Thu, 28 Sep 2023 20:43:24 +0800
Message-ID: <20230928124327.135679-2-ming.lei@redhat.com>
In-Reply-To: <20230928124327.135679-1-ming.lei@redhat.com>
References: <20230928124327.135679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Retain top 8bits of uring_cmd flags for kernel internal use, so that we
can move IORING_URING_CMD_POLLED out of uapi header.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/io_uring.h      | 3 +++
 include/uapi/linux/io_uring.h | 5 ++---
 io_uring/io_uring.c           | 3 +++
 io_uring/uring_cmd.c          | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 106cdc55ff3b..ae08d6f66e62 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -22,6 +22,9 @@ enum io_uring_cmd_flags {
 	IO_URING_F_IOPOLL		= (1 << 10),
 };
 
+/* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
+#define IORING_URING_CMD_POLLED		(1U << 31)
+
 struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 8e61f8b7c2ce..de77ad08b123 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -246,13 +246,12 @@ enum io_uring_op {
 };
 
 /*
- * sqe->uring_cmd_flags
+ * sqe->uring_cmd_flags		top 8bits aren't available for userspace
  * IORING_URING_CMD_FIXED	use registered buffer; pass this flag
  *				along with setting sqe->buf_index.
- * IORING_URING_CMD_POLLED	driver use only
  */
 #define IORING_URING_CMD_FIXED	(1U << 0)
-#define IORING_URING_CMD_POLLED	(1U << 31)
+#define IORING_URING_CMD_MASK	IORING_URING_CMD_FIXED
 
 
 /*
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 783ed0fff71b..9aedb7202403 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4666,6 +4666,9 @@ static int __init io_uring_init(void)
 
 	BUILD_BUG_ON(sizeof(atomic_t) != sizeof(u32));
 
+	/* top 8bits are for internal use */
+	BUILD_BUG_ON((IORING_URING_CMD_MASK & 0xff000000) != 0);
+
 	io_uring_optable_init();
 
 	/*
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 537795fddc87..a0b0ec5473bf 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -91,7 +91,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	ioucmd->flags = READ_ONCE(sqe->uring_cmd_flags);
-	if (ioucmd->flags & ~IORING_URING_CMD_FIXED)
+	if (ioucmd->flags & ~IORING_URING_CMD_MASK)
 		return -EINVAL;
 
 	if (ioucmd->flags & IORING_URING_CMD_FIXED) {
-- 
2.41.0

