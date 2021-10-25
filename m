Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4BAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA61604AC
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhJYJtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232769AbhJYJre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhzDWQIX4+Wb2bsy2LXwMv0NPwVmCROV8XMyUaaDVtE=;
        b=fFP7p5FtusWm2sDbZbukQrWqddBvrEXiRhm5urQBNQEc6NuXJvpahQEoo2n+BlYNYhLagi
        b6YCgt3ImDW846pQ98tqYufDx4w9tCBxFcW9M2m7c0issgGBdjjhHlfmpoOCLcyAQyicme
        Njtw7wyv+iWCaQgZ25FL3hIb11KT4b0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-ZB28wlbYPECG3RodHMYy5A-1; Mon, 25 Oct 2021 05:45:08 -0400
X-MC-Unique: ZB28wlbYPECG3RodHMYy5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DA4B1060D1E;
        Mon, 25 Oct 2021 09:45:03 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77EC15F4EE;
        Mon, 25 Oct 2021 09:45:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/8] loop: fallback to buffered IO in case of dio submission
Date:   Mon, 25 Oct 2021 17:44:34 +0800
Message-Id: <20211025094437.2837701-6-ming.lei@redhat.com>
In-Reply-To: <20211025094437.2837701-1-ming.lei@redhat.com>
References: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DIO submission on underlying file may fail because of unaligned buffer or
start_sector & sector_length, fallback to buffered IO when that happens,
this way will make loop dio mode more reliable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d1784f825b6b..fee78a640f75 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -590,6 +590,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 	if (!cmd->use_dio) {
 		atomic_set(&cmd->ref, 1);
+buffered_io:
 		cmd->iocb.ki_flags = 0;
 		cmd->ret = lo_call_backing_rw_iter(file, &cmd->iocb, &iter, rw);
 		lo_rw_aio_do_completion(cmd);
@@ -603,8 +604,13 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 
 	lo_rw_aio_do_completion(cmd);
 
-	if (ret != -EIOCBQUEUED)
+	if (ret != -EIOCBQUEUED) {
+		if (ret < 0) {
+			cmd->use_dio = false;
+			goto buffered_io;
+		}
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
+	}
 	return 0;
 }
 
-- 
2.31.1

