Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A39C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 23:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64E820729
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 23:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="khW/Eiyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKNXub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 18:50:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36327 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfKNXub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 18:50:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id d7so3407809pls.3
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xiAHPGc8Aj14Y5MdGFh9g/Het9kcprPusIL8MfH+JWo=;
        b=khW/Eiyte9ISt39PSZD+XyzsM8rumPfd6TQnOUOJhx0OMJAUC7Xvoinrf6RwwC+E9x
         KqvvKr9k0zjwX8wthQowSXO1EvojyovYbatrMlfGDM50J1UJ1bu2U/VIkyBkfXm+QHZH
         DUehIhiBlRTqy2NNG8NuZIk759/RsT4IDPWA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xiAHPGc8Aj14Y5MdGFh9g/Het9kcprPusIL8MfH+JWo=;
        b=BwuYh9IBuZ4CZKwVvM7SbHA/uEoQtqoAMmPtWkAeYzWzMhx3OTa+QWcJYpuSFeKsxM
         V2koIqqt7WO2aKPkpDpKCxnM/7/83oUlzY83rdPiZYT34E+hFhe0GoG+Cg9mQ2n2PK8U
         11njoVh2idrk1ekpnqfkssl2/FrmwWcfE5h+hhczoofrk4qEz0rcFwldEMaji+/hhB3g
         9GZ5Bn1sYizYc+7VLl2kKFAivwnl2w+HHHCzxOl8pbvZ+qnIsmtFo5txF8ayYhtdkBVq
         HTdDCDmto1e1QwJkoQDrdHrCAbYJgU0MzB3FZYAUhfk/C4yhzvlxRjS8oqMID0xTfcRr
         qCXA==
X-Gm-Message-State: APjAAAX6ZRRa61WUxcbk0FbQS/TBGkDkISIvSDbKPNWZTJE/HI+RBv2d
        jqqtDuAFgsOja90mHPjoxBCo4A==
X-Google-Smtp-Source: APXvYqyYi/SRj9gi6E7CV6msdyJoApX9Kf2sO6Ltr9WIuThT6DUA6wqm/Tylvd5TtFCqMKsxJkcYpw==
X-Received: by 2002:a17:902:9a8e:: with SMTP id w14mr12617831plp.215.1573775430712;
        Thu, 14 Nov 2019 15:50:30 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v63sm7904458pfb.181.2019.11.14.15.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Nov 2019 15:50:30 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] loop: Report EOPNOTSUPP properly
Date:   Thu, 14 Nov 2019 15:50:07 -0800
Message-Id: <20191114154903.v7.1.I0b2734bafaa1bd6831dec49cdb4730d04be60fc8@changeid>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191114235008.185111-1-evgreen@chromium.org>
References: <20191114235008.185111-1-evgreen@chromium.org>
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
---

Changes in v7:
- Use errno_to_blk_status() (Christoph)

Changes in v6:
- Updated tags

Changes in v5: None
Changes in v4: None
Changes in v3:
- Updated tags

Changes in v2:
- Unnested error if statement (Bart)

 drivers/block/loop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef6e251857c8..6a9fe1f9fe84 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -461,7 +461,7 @@ static void lo_complete_rq(struct request *rq)
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
 		if (cmd->ret < 0)
-			ret = BLK_STS_IOERR;
+			ret = errno_to_blk_status(cmd->ret);
 		goto end_io;
 	}
 
@@ -1950,7 +1950,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
2.21.0

