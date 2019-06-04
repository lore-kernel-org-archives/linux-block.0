Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8694DC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BC12498F
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 14:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfFDO2J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:28:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54860 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfFDO2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 10:28:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hYAPh-0007mb-2k; Tue, 04 Jun 2019 14:27:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] blktrace: remove redundant assignment to ret
Date:   Tue,  4 Jun 2019 15:27:44 +0100
Message-Id: <20190604142744.15330-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ret is being assigned a value that is never read, hence
the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/trace/blktrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2d6e93ab0478..ae7c63d6782c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -507,8 +507,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->msg_data)
 		goto err;
 
-	ret = -ENOENT;
-
 	dir = debugfs_lookup(buts->name, blk_debugfs_root);
 	if (!dir)
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-- 
2.20.1

