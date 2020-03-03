Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373BAC3F2D7
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A61E20674
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 11:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgCCLJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:09:22 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:35497 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgCCLJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 06:09:22 -0500
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DE573240020;
        Tue,  3 Mar 2020 11:07:41 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     kbusch@kernel.org
Cc:     Chaitanya.Kulkarni@wdc.com, axboe@kernel.dk, helgaas@kernel.org,
        jack@suse.cz, linux-block@vger.kernel.org, stable@vger.kernel.org,
        tristmd@gmail.com, Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH] blktrace: Protect q->blk_trace with RCU
Date:   Tue,  3 Mar 2020 14:07:32 +0300
Message-Id: <20200303110731.65552-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302220639.GA2393@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200302220639.GA2393@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Added a reassignment into the NULL check block to fix the issue.

Fixes: c780e86dd48 ("blktrace: Protect q->blk_trace with RCU")

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 kernel/trace/blktrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4560878f0bac..29ea88f10b87 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1896,8 +1896,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	}

 	ret = 0;
-	if (bt == NULL)
+	if (bt == NULL) {
 		ret = blk_trace_setup_queue(q, bdev);
+		bt = q->blk_trace;
+	}

 	if (ret == 0) {
 		if (attr == &dev_attr_act_mask)
--
2.25.1

