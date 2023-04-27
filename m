Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C91EC77B73
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 12:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbjD0MpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 08:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbjD0MpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 08:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE24233
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682599473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dehvtx8JiMw1iS4HkfW+eV7Iijc2rl3zXXDIKkCePzc=;
        b=apApMMoEjFcwV4RlChWHRCTLrfVIuBmQj7qKvLCf7q242IiGWNdHTn0K5fwguqw8oN/k/y
        mhRGdVro9lF0RqZaXl83Bt1/38wNW4wAfMHf0ydJk8HPJ2uHbQ90Vl8Vrkbp++b77l1IGX
        kruE6aTZTmyrYMOHVJ1ZELmToiZrkzo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-o1tqt8aHP5SNzeRZeaiLIA-1; Thu, 27 Apr 2023 08:44:27 -0400
X-MC-Unique: o1tqt8aHP5SNzeRZeaiLIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 261AF2A5955D;
        Thu, 27 Apr 2023 12:44:27 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5968240C2064;
        Thu, 27 Apr 2023 12:44:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/7] ublk: cleanup io cmd code path by adding ublk_fill_io()
Date:   Thu, 27 Apr 2023 20:44:09 +0800
Message-Id: <20230427124414.319945-3-ming.lei@redhat.com>
In-Reply-To: <20230427124414.319945-1-ming.lei@redhat.com>
References: <20230427124414.319945-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one small helper to cleanup io command hanlding code path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 068d8b99605b..0980c9fec669 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1238,6 +1238,14 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
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
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       struct ublksrv_io_cmd *ub_cmd)
@@ -1304,10 +1312,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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
@@ -1320,17 +1326,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
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
2.40.0

