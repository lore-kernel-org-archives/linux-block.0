Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E0AC6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 14:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjCXOAn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjCXOAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 10:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2813A1B31A
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679666340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48AKVP9yTkY1ambTnk0VYH59I7XP/ONXFtXKzcPT0nk=;
        b=GVX8EB/gkxYTzRli00L4O9gUli/7GKMH49AW2T8vvNjiZheBPhcglODgd6XeemY7JA4JX7
        3b3Xfqb6UXazaYXorvDxqOfaritJx6JYGskTObvZC81wfYxrTt+3O/88aFAnqKrqOiubF/
        nTIwRZcbiL4YUfJdFvfX/x5bHfdwgTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-CNqsnyGUN0CmZTTtEOvAmA-1; Fri, 24 Mar 2023 09:58:57 -0400
X-MC-Unique: CNqsnyGUN0CmZTTtEOvAmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FF27802C15;
        Fri, 24 Mar 2023 13:58:56 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B60331121314;
        Fri, 24 Mar 2023 13:58:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 10/17] block: ublk_drv: clean up several helpers
Date:   Fri, 24 Mar 2023 21:58:01 +0800
Message-Id: <20230324135808.855245-11-ming.lei@redhat.com>
In-Reply-To: <20230324135808.855245-1-ming.lei@redhat.com>
References: <20230324135808.855245-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert the following pattern in several helpers
	if (Z)
		return true
	return false
into:
	return Z;

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 43c0b1247924..c35922f9a066 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -298,9 +298,7 @@ static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 {
-	if (ubq->flags & UBLK_F_NEED_GET_DATA)
-		return true;
-	return false;
+	return ubq->flags & UBLK_F_NEED_GET_DATA;
 }
 
 static struct ublk_device *ublk_get_device(struct ublk_device *ub)
@@ -349,25 +347,19 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 static inline bool ublk_queue_can_use_recovery_reissue(
 		struct ublk_queue *ubq)
 {
-	if ((ubq->flags & UBLK_F_USER_RECOVERY) &&
-			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE))
-		return true;
-	return false;
+	return (ubq->flags & UBLK_F_USER_RECOVERY) &&
+			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE);
 }
 
 static inline bool ublk_queue_can_use_recovery(
 		struct ublk_queue *ubq)
 {
-	if (ubq->flags & UBLK_F_USER_RECOVERY)
-		return true;
-	return false;
+	return ubq->flags & UBLK_F_USER_RECOVERY;
 }
 
 static inline bool ublk_can_use_recovery(struct ublk_device *ub)
 {
-	if (ub->dev_info.flags & UBLK_F_USER_RECOVERY)
-		return true;
-	return false;
+	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
 }
 
 static void ublk_free_disk(struct gendisk *disk)
-- 
2.39.2

