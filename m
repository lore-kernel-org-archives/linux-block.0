Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FFC433E1
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93FA20663
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbgF3Pyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:54:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50838 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389385AbgF3Pyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 11:54:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jqIan-00061G-GZ; Tue, 30 Jun 2020 15:54:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] blk-cgroup: clean up indentation
Date:   Tue, 30 Jun 2020 16:54:41 +0100
Message-Id: <20200630155441.518850-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a statement that is indented one level too deeply, fix it
by removing a tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1ce94afc03bc..748c4b2a9273 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1837,7 +1837,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	 */
 	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
 		bio_set_flag(bio, BIO_CGROUP_ACCT);
-			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
+		bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
 	}
 	bis->cur.ios[rwd]++;
 
-- 
2.27.0

