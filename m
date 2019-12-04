Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1948FC2D0B1
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32DE207DD
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VKo6egvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfLDLfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:35:00 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:19986 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfLDLe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 06:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575459299; x=1606995299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hFszrM7KiTbnME9EGJrfhQofskCo55+99bwJF65SxQo=;
  b=VKo6egvd72nO/10EAgpu5ZDJnu7ihtJbi7xqAzuJuCJgtKzNFdyu3sXn
   axcW77xQcaDYhOsANcKFtWvw8mM0oMnZJMutUrId1AUxtdf0dXvJ9m/yn
   yLNECJx3x7f79oTbMhdULQ/Bi3Z0uyRu/G1KKaKnCD5JpjPc3sM15GVs0
   Y=;
IronPort-SDR: qhYuRtZ0Yol5ruY3wIPQVvj8V7PP7DvXuyvJIH0Dg4IB71EmrDNKQjPBTijP9FyR4jjk/XWup5
 68gfq8Di2HhQ==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="6142138"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 04 Dec 2019 11:34:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id A586EA2641;
        Wed,  4 Dec 2019 11:34:46 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 11:34:45 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.249) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 11:34:42 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <axboe@kernel.dk>
CC:     <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 2/2] blkback: Add a module parameter for aggressive pool shrinking duration
Date:   Wed, 4 Dec 2019 12:34:19 +0100
Message-ID: <20191204113419.2298-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204113419.2298-1-sjpark@amazon.com>
References: <20191204113419.2298-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.249]
X-ClientProxiedBy: EX13D21UWB003.ant.amazon.com (10.43.161.212) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

As discussed by the previous commit ("xen/blkback: Aggressively shrink
page pools if a memory pressure is detected"), the aggressive pool
shrinking duration should be carefully selected:
``If it is too long, free pages pool shrinking overhead can reduce the
I/O performance.  If it is too short, blkback will not free enough pages
to reduce the memory pressure.``

That said, the proper duration would depends on given configurations and
workloads.  For the reason, this commit allows users to set it via a
module parameter interface.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Suggested-by: Amit Shah <aams@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index aa1a127093e5..88c011300ee9 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -137,9 +137,13 @@ module_param(log_stats, int, 0644);
 
 /*
  * Once a memory pressure is detected, keep aggressive shrinking of the free
- * page pools for this time (msec)
+ * page pools for this time (milliseconds)
  */
-#define AGGRESSIVE_SHRINKING_DURATION	1
+static int xen_blkif_aggressive_shrinking_duration = 1;
+module_param_named(aggressive_shrinking_duration,
+		xen_blkif_aggressive_shrinking_duration, int, 0644);
+MODULE_PARM_DESC(aggressive_shrinking_duration,
+"Duration to do aggressive shrinking when a memory pressure is detected");
 
 static unsigned long xen_blk_mem_pressure_end;
 
@@ -147,7 +151,7 @@ static unsigned long blkif_shrink_count(struct shrinker *shrinker,
 				struct shrink_control *sc)
 {
 	xen_blk_mem_pressure_end = jiffies +
-		msecs_to_jiffies(AGGRESSIVE_SHRINKING_DURATION);
+		msecs_to_jiffies(xen_blkif_aggressive_shrinking_duration);
 	return 0;
 }
 
-- 
2.17.1

