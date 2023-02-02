Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05745C05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 02:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBBCYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 21:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBBCYX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 21:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228035AB50
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 18:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675304613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Y6Hzln3eoR0ZWnW5WoWP5rZBVhLlvi5sLbqA7xx2Og=;
        b=B2OLyABCNsCsvYFaEnAEpdtYCAbI69GeQEfcTn6M9HlQ44Cxlc3XPTXqOEZYYyL2Q90FWb
        qFiKGN8QhlfikEzIvozEygyGCbAUmSbIy5V5w5A0EkcREljsnqYxfDYgtW097/P26zZfUL
        JnV6k7hiHq+f9pQMGuJcKRZTp3TaWt8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-D2UxTb7yMm-1y57v3V1iwA-1; Wed, 01 Feb 2023 21:23:29 -0500
X-MC-Unique: D2UxTb7yMm-1y57v3V1iwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 849D585A5A3;
        Thu,  2 Feb 2023 02:18:21 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8375B2026D4B;
        Thu,  2 Feb 2023 02:18:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH] blk-cgroup: don't update io stat for root cgroup
Date:   Thu,  2 Feb 2023 10:18:04 +0800
Message-Id: <20230202021804.278582-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We source root cgroup stats from the system-wide stats, see blkcg_print_stat
and blkcg_rstat_flush, so don't update io state for root cgroup.

Fixes blkg leak issue introduced in commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
which starts to grab blkg's reference when adding iostat_cpu into percpu
blkcg list, but this state won't be consumed by blkcg_rstat_flush() where
the blkg reference is dropped.

Tested-by: Bart van Assche <bvanassche@acm.org>
Reported-by: Bart van Assche <bvanassche@acm.org>
Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cb110fc51940..78f855c34746 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2034,6 +2034,10 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
+	/* Root-level stats are sourced from system-wide IO stats */
+	if (!cgroup_parent(blkcg->css.cgroup))
+		return;
+
 	cpu = get_cpu();
 	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
 	flags = u64_stats_update_begin_irqsave(&bis->sync);
-- 
2.31.1

