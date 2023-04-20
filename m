Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40860C77B7C
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDTPmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDTPm2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 11:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0341991
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682005282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMSBwIZQ/zCWnQN0K9nRCpthtcY6qGVrwDsFIyjdaXw=;
        b=Hn42JI3onUqwG7a/nv8a7ozYakzouvHBU75GARlFqkleN7j4LyC1yEd5e9YatjaFQ+zk5d
        p54SonEFyrPqGj9hP2tPbEzfYxBm2jBDbLp/1b7NPBwvq17adICd3iahjOgjjr4i5+mShv
        MFqxnvFGbuiBUZhZ78EkpoRjON8asmQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-mNP2keapMd6Iu3lcj81rzQ-1; Thu, 20 Apr 2023 11:41:20 -0400
X-MC-Unique: mNP2keapMd6Iu3lcj81rzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D11AC2A59542;
        Thu, 20 Apr 2023 15:41:19 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE2B851E3;
        Thu, 20 Apr 2023 15:41:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/7] ublk: cleanup io cmd code path by adding ublk_fill_io()
Date:   Thu, 20 Apr 2023 23:40:27 +0800
Message-Id: <20230420154032.1272836-3-ming.lei@redhat.com>
In-Reply-To: <20230420154032.1272836-1-ming.lei@redhat.com>
References: <20230420154032.1272836-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one small helper to cleanup io command hanlding code path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d6434c3354df..6baca0383b44 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1234,6 +1234,14 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 	return 0;
 }
 
+static inline void ublk_fill_io(struct ublk_io *io, struct io_uring_cmd *cmd,
+		unsigned long buf_addr)
+{
+	io->cmd = cmd;
+	io->flags |= UBLK_IO_FLAG_ACTIVE;
+	io->addr = buf_addr;
+}
+
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
@@ -1299,10 +1307,8 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		/* FETCH_RQ has to provide IO buffer if NEED GET DATA is not enabled */
 		if (!ub_cmd->addr && !ublk_need_get_data(ubq))
 			goto out;
-		io->cmd = cmd;
-		io->flags |= UBLK_IO_FLAG_ACTIVE;
-		io->addr = ub_cmd->addr;
 
+		ublk_fill_io(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
@@ -1315,17 +1321,13 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 			goto out;
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
-		io->addr = ub_cmd->addr;
-		io->flags |= UBLK_IO_FLAG_ACTIVE;
-		io->cmd = cmd;
+		ublk_fill_io(io, cmd, ub_cmd->addr);
 		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
-		io->addr = ub_cmd->addr;
-		io->cmd = cmd;
-		io->flags |= UBLK_IO_FLAG_ACTIVE;
+		ublk_fill_io(io, cmd, ub_cmd->addr);
 		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
 		break;
 	default:
-- 
2.39.2

