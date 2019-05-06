Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF9C04AAB
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F112082F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 18:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dNSKDUXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEFSaX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 14:30:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35673 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfEFSaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 14:30:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so6794599plp.2
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4fAKuH/byVNhylCS+A6U39gO11PXacps3u7CzHGthA=;
        b=dNSKDUXF2oZSIiYLphUbNUQDSbjx83YCVELTwCDErbC7zdeU0NBLzprYH4IWfSBwRc
         58wL4Yzryf+zRobhFJ//WBRL7i0WJ+HTgQZbdJk50dWzazix94IbKZyQbCvBjp7yQ+jB
         ueO4NgyjTDCmL1u4yaMpujTc3Wqy63pV8WkNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4fAKuH/byVNhylCS+A6U39gO11PXacps3u7CzHGthA=;
        b=fyShq4iqEtaW5OGy9VZbwfOoQUzdtSWETEstAyokzm7UD2gaVxVIS2nivW3CJ060Kv
         iev2sqTPIBvOJ+bn7PFyYkMAM+4enhDUNseriSvnjwa6bHXGd9ZOdt8oQT5Usd9T+HLJ
         hb3cb4h8anPAHiz4tA4Amudwt7YZMSYOREthlZv5HnbEi93ON1SVX2kkXspIefFyvAGo
         yUnxwOaTgfz7JEkuNVo7yvmXgv1023Ba4/bXQ75A6Q1UsZXBML4pSY+xH/Cc5K/kKSF2
         03B1tOVUQqOPdRxW9avn0tEd6dChzQgQQWKb3V7BSFH4uS7TY1DnsKWFiV8y3ul3v0TQ
         CjWA==
X-Gm-Message-State: APjAAAWmj1DqexgCudCrg3U/KZLohxZofpB6oyUgUzknn3oMgD4qv4oC
        j9A2cJJfPHgEG09is715tbOy/g==
X-Google-Smtp-Source: APXvYqxZOm72vl0eWsFna1xWIPu80i8z2lHBi28o1Kv41r+YVXTalThuFqrYphk6KLaVhUsaytlrGA==
X-Received: by 2002:a17:902:12f:: with SMTP id 44mr34438223plb.193.1557167421854;
        Mon, 06 May 2019 11:30:21 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id o81sm18858033pfa.156.2019.05.06.11.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 11:30:21 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] loop: Report EOPNOTSUPP properly
Date:   Mon,  6 May 2019 11:27:35 -0700
Message-Id: <20190506182736.21064-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506182736.21064-1-evgreen@chromium.org>
References: <20190506182736.21064-1-evgreen@chromium.org>
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

Changes in v5: None
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

