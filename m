Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC7AC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 17:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E662520652
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 17:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4vAlzdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfEBRoS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 13:44:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43439 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfEBRoR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 13:44:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id e67so1473224pfe.10
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUp7h+veODMik8pQbwsoI+ANQjqMfD2BY5Z1tO2egIk=;
        b=e4vAlzdyFwrD/FzVxBUhnit3alGUE0OS5x3VxhBE9+YNPyWoMUsGCbXjALySNeIpce
         ou4bvXUd+3/r3dDOw1zqKtb3J8fvZs4nzqJ2JdyYC0F5ytfJIaHCXXLxYD2S53dQL0u5
         HHn/SVQjzBBtwqfSt/GhfHug2ZyCpzcKhrc7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUp7h+veODMik8pQbwsoI+ANQjqMfD2BY5Z1tO2egIk=;
        b=U4Wo8CZx0loU158TmJecdG6zBp8JLRy30zTYEvuRfpTPJtQx7BUPHgWgdfcVPNPvXa
         zCWXtGz+BLcZKFKyVyFFwfaADMI7/9kjxJkGSEyht3MAz5SHDd+aV6RXSZd/Fuy21Ymq
         VdAzCqbA7eQLWPv/tDcN258CJLr4f0Kh/4D5HlqtdcCiJU46SWKTFIAB2V9ubuMakG7+
         sU1Afo+u/Jn5eFwXiK1Ymq+49+UDMnzXqKbQFSL0/sn3MjI53p3gkOZVfUcugZwymrjR
         L81sSK5CVw1k49V23xmGvZWCl10iEDWo66x4QXSrSPL6cxb60KaRa89cSVVHSTryHU9s
         G0WA==
X-Gm-Message-State: APjAAAUOgUrUAm8m6D4Q4jbkMCerAOMBD5AcfEgRjx6jxiOenfbMnFdP
        fl82X71ayL1hYbk3M1Vqi10gTg==
X-Google-Smtp-Source: APXvYqxZvosE5VL2EAa7oXmOy44sIwa7slDqyct+ZjKBUYXSHUP+00BfL05ei7a/jO9W3McW0eCCkg==
X-Received: by 2002:aa7:820c:: with SMTP id k12mr5517004pfi.177.1556819056848;
        Thu, 02 May 2019 10:44:16 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id w38sm48319600pgk.90.2019.05.02.10.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 10:44:15 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] loop: Report EOPNOTSUPP properly
Date:   Thu,  2 May 2019 10:44:08 -0700
Message-Id: <20190502174409.74623-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502174409.74623-1-evgreen@chromium.org>
References: <20190502174409.74623-1-evgreen@chromium.org>
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

Changes in v4: None
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

