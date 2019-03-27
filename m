Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A2C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 22:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2729D21738
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 22:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDVfZi/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfC0W3G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:29:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45325 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfC0W2y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 18:28:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so9505620pfi.12
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2019 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fh5+WvkK8+4l9d2sJq6AabkUwOIion/kmkDLaN4jsE=;
        b=SDVfZi/F1ryoqh7vd+SSN1I+QUctJE/l6cbnCPk1wcIDYhUtTFnl3/FtgKwv4RRRAZ
         Pm5KDgp0ZtIEydCGLDwxiqlsR2NCOq1vfZA87sy0bJIxtlsteiTHbmY1H7jxVmcebbC6
         KpGM9iFgQFDcLnGTVlCz8Qnz/zHhdzFVxdJT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fh5+WvkK8+4l9d2sJq6AabkUwOIion/kmkDLaN4jsE=;
        b=ib/XVGAxOk+ITU6nBxzFSWheIXowgNuCg2f2Var6piIxqCOH//JvRMd2Zh38Q+DC2r
         +NKXLLrCzle5TsWNAWkRLmchffKBTJp/33fDMybWqCHkCSEFCoCkmQVjooMGC/kEMxeP
         BJHD3YnsGuYv5JkHMhYOdof4F94qqUGNgnkXBXDlYrf891o3yRWwYPsIych3juL5iRiT
         EgClqiqJODlIabA3fyYyPAXaS7cTiDlTC6p58WPoG5OFMsRhaUvvPt/xQ6Y4Tt/3Rjhz
         tximetRqulk1ArGqhSTkDk2dbyrtOUCKJ2V46BEjDQ86r+SjQpS1l8Z8QJgeMuUyu3rQ
         1YYw==
X-Gm-Message-State: APjAAAUeP2XpFIsjvkYxGysNoNCx1LRn7tCmxRMujS0bsDgzsGTfpWXV
        q/ws3rNM2vdsxDOKM9U1AU5bsw==
X-Google-Smtp-Source: APXvYqwoa3ksrft+5W+S8EIGxaMfDSimgZWkyLTByE/vZEfpc8THu9a5aE7CP12VxpAPIW4zZpWdQg==
X-Received: by 2002:a63:4383:: with SMTP id q125mr34400898pga.370.1553725733498;
        Wed, 27 Mar 2019 15:28:53 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id p88sm36928347pfa.80.2019.03.27.15.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 15:28:52 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] loop: Report EOPNOTSUPP properly
Date:   Wed, 27 Mar 2019 15:28:40 -0700
Message-Id: <20190327222841.38650-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327222841.38650-1-evgreen@chromium.org>
References: <20190327222841.38650-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Properly plumb out EOPNOTSUPP from loop driver operations, which may
get returned when for instance a discard operation is attempted but not
supported by the underlying block device. Before this change, everything
was reported in the log as an I/O error, which is scary and not
helpful in debugging.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---

Changes in v3:
- Updated tags

Changes in v2:
- Unnested error if statement (Bart)

 drivers/block/loop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bf1c61cab8eb..bbf21ebeccd3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -458,7 +458,9 @@ static void lo_complete_rq(struct request *rq)
 
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
-		if (cmd->ret < 0)
+		if (cmd->ret == -EOPNOTSUPP)
+			ret = BLK_STS_NOTSUPP;
+		else if (cmd->ret < 0)
 			ret = BLK_STS_IOERR;
 		goto end_io;
 	}
@@ -1892,7 +1894,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
-		cmd->ret = ret ? -EIO : 0;
+		if (ret == -EOPNOTSUPP)
+			cmd->ret = ret;
+		else
+			cmd->ret = ret ? -EIO : 0;
 		blk_mq_complete_request(rq);
 	}
 }
-- 
2.20.1

