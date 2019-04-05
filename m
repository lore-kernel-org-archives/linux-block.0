Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6683C282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 21:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6DB20651
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 21:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDEVmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEVmw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 17:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 950973082206;
        Fri,  5 Apr 2019 21:42:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-50.rdu2.redhat.com [10.10.122.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C236136E;
        Fri,  5 Apr 2019 21:42:52 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, John Pittman <jpittman@redhat.com>
Subject: [PATCH] null_blk: prevent crash from bad home_node value
Date:   Fri,  5 Apr 2019 17:42:45 -0400
Message-Id: <20190405214245.19834-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 05 Apr 2019 21:42:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

At module load, if the selected home_node value is greater than
the available numa nodes, the system will crash in
__alloc_pages_nodemask() due to a bad paging request.  Prevent this
user error crash by detecting the bad value, logging an error, and
setting g_home_node back to the default of NUMA_NO_NODE.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 drivers/block/null_blk_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 417a9f15c116..c7fb7a133c8d 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1748,6 +1748,11 @@ static int __init null_init(void)
 		return -EINVAL;
 	}
 
+	if (g_home_node >= nr_online_nodes) {
+		pr_err("null_blk: invalid home_node value\n");
+		g_home_node = NUMA_NO_NODE;
+	}
+
 	if (g_queue_mode == NULL_Q_RQ) {
 		pr_err("null_blk: legacy IO path no longer available\n");
 		return -EINVAL;
-- 
2.17.2

