Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66378C4CED2
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 14:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7AC20650
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 14:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfIPOJR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:09:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57160 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387788AbfIPOJR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 10:09:17 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f4:d32a:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5869E28D44E;
        Mon, 16 Sep 2019 15:09:13 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v3 1/3] null_blk: do not fail the module load with zero devices
Date:   Mon, 16 Sep 2019 11:07:57 -0300
Message-Id: <20190916140759.52491-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916140759.52491-1-andrealmeid@collabora.com>
References: <20190916140759.52491-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The module load should fail only if there is something wrong with the
configuration or if an error prevents it to work properly. The module
should be able to be loaded with (nr_device == 0), since it will not
trigger errors or be in malfunction state. Preventing loading with zero
devices also breaks applications that configures this module using
configfs API. Remove the nr_device check to fix this.

Fixes: f7c4ce890dd2 ("null_blk: validate the number of devices")
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes since v2:
- None

Changes since v1:
- None
---
 drivers/block/null_blk_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index ab4b87677139..be32cb5ed339 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1758,10 +1758,6 @@ static int __init null_init(void)
 		pr_err("null_blk: legacy IO path no longer available\n");
 		return -EINVAL;
 	}
-	if (!nr_devices) {
-		pr_err("null_blk: invalid number of devices\n");
-		return -EINVAL;
-	}
 	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
 		if (g_submit_queues != nr_online_nodes) {
 			pr_warn("null_blk: submit_queues param is set to %u.\n",
-- 
2.23.0

