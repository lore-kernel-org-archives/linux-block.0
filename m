Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B15C77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjESGvt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjESGvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C8E52
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684479056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/BonYn+qRDwKCLOpx8RcwQ6Nb+LEUIIsrgjEMNTTQI=;
        b=JO5+IFm0Xdtj25UZQBZO6TChsKNnngh5JzH90s9OWuNwWu1+wkYhf5M8XnbEa+FN6l3lGG
        BQ0iN2zxNoa9vsTc56KQLCSARvWxRA+HbZDvzTk/uQfkdAMsvS62E53DiVycbomm3FcvXq
        A/mTmBcqOI0xfixCQyR9xU1kheJ9IQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-FIfBKkn8Pv6zG23GidzW4w-1; Fri, 19 May 2023 02:50:52 -0400
X-MC-Unique: FIfBKkn8Pv6zG23GidzW4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2398E88B773;
        Fri, 19 May 2023 06:50:52 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB591121314;
        Fri, 19 May 2023 06:50:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/7] ublk: cleanup io cmd code path by adding ublk_fill_io_cmd()
Date:   Fri, 19 May 2023 14:50:25 +0800
Message-Id: <20230519065030.351216-3-ming.lei@redhat.com>
In-Reply-To: <20230519065030.351216-1-ming.lei@redhat.com>
References: <20230519065030.351216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one small helper to cleanup io command hanlding code path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b00c5c210c7f..0c8651c5ba4c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1256,6 +1256,14 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 	return 0;
 }
 
+static inline void ublk_fill_io_cmd(struct ublk_io *io,
+		struct io_uring_cmd *cmd, unsigned long buf_addr)
+{
+	io->cmd = cmd;
+	io->flags |= UBLK_IO_FLAG_ACTIVE;
+	io->addr = buf_addr;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1322,10 +1330,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		/* FETCH_RQ has to provide IO buffer if NEED GET DATA is not enabled */
 		if (!ub_cmd->addr && !ublk_need_get_data(ubq))
 			goto out;
-		io->cmd = cmd;
-		io->flags |= UBLK_IO_FLAG_ACTIVE;
-		io->addr = ub_cmd->addr;
 
+		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
@@ -1338,17 +1344,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
-		io->addr = ub_cmd->addr;
-		io->flags |= UBLK_IO_FLAG_ACTIVE;
-		io->cmd = cmd;
+		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
-		io->addr = ub_cmd->addr;
-		io->cmd = cmd;
-		io->flags |= UBLK_IO_FLAG_ACTIVE;
+		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
 		break;
 	default:
-- 
2.40.1

