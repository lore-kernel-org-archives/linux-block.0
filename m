Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD4C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 15:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjC1PR5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 11:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjC1PRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 11:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78445113FA
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680016512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+LP/eGObxESjSZtnTg8CVLgYRu7HZvCpWjJZDO48e4=;
        b=GoIFc5YHToV4SfwBbznyQN2nXQe0Hcy3c8XJKRl5JaYXRl5BttVh8pP/yCQDM/6Ar+Bn62
        iriiEV0qp++leiHTZ8oSAKdn+hx4ScUpQmaNDWx57Gk5td38yXDWubKG3k/dp6/d3BoJ/q
        rxVQbp55LFI07oXdJVNnF2YBzwx4bNc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-MWpvJGt3PZ2YlU4lp9woSA-1; Tue, 28 Mar 2023 11:11:58 -0400
X-MC-Unique: MWpvJGt3PZ2YlU4lp9woSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D7218028B2;
        Tue, 28 Mar 2023 15:11:57 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6355314171BD;
        Tue, 28 Mar 2023 15:11:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 15/16] block: ublk_drv: don't check buffer in case of zero copy
Date:   Tue, 28 Mar 2023 23:09:57 +0800
Message-Id: <20230328150958.1253547-16-ming.lei@redhat.com>
In-Reply-To: <20230328150958.1253547-1-ming.lei@redhat.com>
References: <20230328150958.1253547-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of zero copy, ublk server needn't to pre-allocate IO buffer
and provide it to driver more.

Meantime not set the buffer in case of zero copy any more, and the
userspace can use pread()/pwrite() to read from/write to the io request
buffer, which is easier & simpler from userspace viewpoint.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 03ad33686808..a49b4de5ae1e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1410,25 +1410,30 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			goto out;
 		/* FETCH_RQ has to provide IO buffer if NEED GET DATA is not enabled */
-		if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-			goto out;
+		if (!ublk_support_zc(ubq)) {
+			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
+				goto out;
+			io->addr = ub_cmd->addr;
+		}
 		io->cmd = cmd;
 		io->flags |= UBLK_IO_FLAG_ACTIVE;
-		io->addr = ub_cmd->addr;
-
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
+
+		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+			goto out;
 		/*
 		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if NEED GET DATA is
 		 * not enabled or it is Read IO.
 		 */
-		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) || req_op(req) == REQ_OP_READ))
-			goto out;
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-			goto out;
-		io->addr = ub_cmd->addr;
+		if (!ublk_support_zc(ubq)) {
+			if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
+						req_op(req) == REQ_OP_READ))
+				goto out;
+			io->addr = ub_cmd->addr;
+		}
 		io->flags |= UBLK_IO_FLAG_ACTIVE;
 		io->cmd = cmd;
 		ublk_commit_completion(ub, ub_cmd);
-- 
2.39.2

