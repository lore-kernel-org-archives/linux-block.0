Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5099EC76188
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72321911
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 14:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfGVOMy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:12:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729068AbfGVOMy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 10:12:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 617E8AEFD;
        Mon, 22 Jul 2019 14:12:52 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>, Coly Li <colyli@suse.de>
Subject: [PATCH 1/1] bcache: fix possible memory leak in bch_cached_dev_run()
Date:   Mon, 22 Jul 2019 22:12:36 +0800
Message-Id: <20190722141236.103967-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190722141236.103967-1-colyli@suse.de>
References: <20190722141236.103967-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

memory malloced in bch_cached_dev_run() and should be freed before
leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: 0b13efecf5f2 ("bcache: add return value check to bch_cached_dev_run()")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 26e374fbf57c..20ed838e9413 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -931,6 +931,9 @@ int bch_cached_dev_run(struct cached_dev *dc)
 	if (dc->io_disable) {
 		pr_err("I/O disabled on cached dev %s",
 		       dc->backing_dev_name);
+		kfree(env[1]);
+		kfree(env[2]);
+		kfree(buf);
 		return -EIO;
 	}
 
-- 
2.16.4

