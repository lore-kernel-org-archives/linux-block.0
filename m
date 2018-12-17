Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFBC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B10A206BA
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 01:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeLQBqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:46:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeLQBqS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 20:46:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BF3758E43;
        Mon, 17 Dec 2018 01:46:18 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29857600D7;
        Mon, 17 Dec 2018 01:46:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH V2 2/2] blk-wbt: export internal state via debugfs
Date:   Mon, 17 Dec 2018 09:46:01 +0800
Message-Id: <20181217014601.11823-3-ming.lei@redhat.com>
In-Reply-To: <20181217014601.11823-1-ming.lei@redhat.com>
References: <20181217014601.11823-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 17 Dec 2018 01:46:18 +0000 (UTC)
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
index 463e4eb80287..f0c56649775f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -715,6 +715,94 @@ void wbt_disable_default(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
+#ifdef CONFIG_BLK_DEBUG_FS
+static int wbt_curr_win_nsec_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+
+	seq_printf(m, "%llu\n", rwb->cur_win_nsec);
+	return 0;
+}
+
+static int wbt_enabled_show(void *data, struct seq_file *m)
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
+static int wbt_min_lat_nsec_show(void *data, struct seq_file *m)
+{
+	struct rq_qos *rqos = data;
+	struct rq_wb *rwb = RQWB(rqos);
+
+	seq_printf(m, "%lu\n", rwb->min_lat_nsec);
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
+	{"curr_win_nsec", 0400, wbt_curr_win_nsec_show},
+	{"enabled", 0400, wbt_enabled_show},
+	{"id", 0400, wbt_id_show},
+	{"inflight", 0400, wbt_inflight_show},
+	{"min_lat_nsec", 0400, wbt_min_lat_nsec_show},
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

