Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77570C4321E
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B55D6054F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhJYJtb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232766AbhJYJrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cg1UR0pPs0cRD9ms/MKv3518rMttKGPifKIk8cWUouM=;
        b=Y2obF0z4GJJhidoxaK8/hLqY+TymR73Uo85UdWeB3VLQUrksLXHGH8Z34v8L6gjMMSo0UZ
        QL1pOoKhZ+dm6bYBVMj2DCeUItJXEk0hLwZve/v03MXlcKc2B1CEyvXoIPC59hc7rRgZyg
        w0TGzauJ9AxKFsW/SsQftlrlsuuT7DQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-4sHgtGhCP9amZnzNhr6DnQ-1; Mon, 25 Oct 2021 05:45:07 -0400
X-MC-Unique: 4sHgtGhCP9amZnzNhr6DnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74F6F8030B7;
        Mon, 25 Oct 2021 09:44:56 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C7C91948C;
        Mon, 25 Oct 2021 09:44:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/8] loop: add one helper for submitting IO on backing file
Date:   Mon, 25 Oct 2021 17:44:32 +0800
Message-Id: <20211025094437.2837701-4-ming.lei@redhat.com>
In-Reply-To: <20211025094437.2837701-1-ming.lei@redhat.com>
References: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No functional change, new helper is added so that we can unifying buffered
IO on backing file.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8c3f5d2affc7..769cf84c6899 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -571,6 +571,14 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 	lo_rw_aio_do_completion(cmd);
 }
 
+static inline int lo_call_backing_rw_iter(struct file *file,
+		struct kiocb *iocb, struct iov_iter *iter, bool rw)
+{
+	if (rw == WRITE)
+		return call_write_iter(file, iocb, iter);
+	return call_read_iter(file, iocb, iter);
+}
+
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		     loff_t pos, bool rw)
 {
@@ -628,10 +636,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (rw == WRITE)
-		ret = call_write_iter(file, &cmd->iocb, &iter);
-	else
-		ret = call_read_iter(file, &cmd->iocb, &iter);
+	ret = lo_call_backing_rw_iter(file, &cmd->iocb, &iter, rw);
 
 	lo_rw_aio_do_completion(cmd);
 
-- 
2.31.1

