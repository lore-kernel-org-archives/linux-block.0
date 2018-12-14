Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830CCC6786C
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 11:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AF320892
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 11:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AF320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeLNLjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:39:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNLjp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 06:39:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77F0A80F7B;
        Fri, 14 Dec 2018 11:39:45 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B263F17C6F;
        Fri, 14 Dec 2018 11:39:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/2] blk-wbt: export internal state via debugfs
Date:   Fri, 14 Dec 2018 19:39:26 +0800
Message-Id: <20181214113926.7451-3-ming.lei@redhat.com>
In-Reply-To: <20181214113926.7451-1-ming.lei@redhat.com>
References: <20181214113926.7451-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 14 Dec 2018 11:39:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This information is helpful to either investigate issues, or understand
wbt's internal behaviour.

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-wbt.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 463e4eb80287..2684bf2d112f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -715,6 +715,94 @@ void wbt_disable_default(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
+#ifdef CONFIG_BLK_DEBUG_FS
+static int wbt_curr_window_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+
+	seq_printf(m, "%llu ns\n", rwb->cur_win_nsec);
+	return 0;
+}
+
+static int wbt_enable_state_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+
+	seq_printf(m, "%d\n", rwb->enable_state);
+	return 0;
+}
+
+static int wbt_id_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+
+	seq_printf(m, "%u\n", rqos->id);
+	return 0;
+}
+
+static int wbt_inflight_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+	int i;
+
+	for (i = 0; i < WBT_NUM_RWQ; i++)
+		seq_printf(m, "%d: inflight %d\n", i,
+			   atomic_read(&rwb->rq_wait[i].inflight));
+	return 0;
+}
+
+static int wbt_min_latency_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+
+	seq_printf(m, "%luns\n", rwb->min_lat_nsec);
+	return 0;
+}
+
+static int wbt_unknown_cnt_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+
+	seq_printf(m, "%u\n", rwb->unknown_cnt);
+	return 0;
+}
+
+static int wbt_normal_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+
+	seq_printf(m, "%u\n", rwb->wb_normal);
+	return 0;
+}
+
+static int wbt_background_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+
+	seq_printf(m, "%u\n", rwb->wb_background);
+	return 0;
+}
+
+static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
+	{"curr_window", 0400, wbt_curr_window_show},
+	{"enable_state", 0400, wbt_enable_state_show},
+	{"id", 0400, wbt_id_show},
+	{"inflight", 0400, wbt_inflight_show},
+	{"min_latency", 0400, wbt_min_latency_show},
+	{"unknown_cnt", 0400, wbt_unknown_cnt_show},
+	{"wb_normal", 0400, wbt_normal_show},
+	{"wb_background", 0400, wbt_background_show},
+	{},
+};
+#endif
+
 static struct rq_qos_ops wbt_rqos_ops = {
 	.throttle = wbt_wait,
 	.issue = wbt_issue,
@@ -723,6 +811,9 @@ static struct rq_qos_ops wbt_rqos_ops = {
 	.done = wbt_done,
 	.cleanup = wbt_cleanup,
 	.exit = wbt_exit,
+#ifdef CONFIG_BLK_DEBUG_FS
+	.debugfs_attrs = wbt_debugfs_attrs,
+#endif
 };
 
 int wbt_init(struct request_queue *q)
-- 
2.9.5

