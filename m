Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4564C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4F220652
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 15:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYAtPv+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfFXPY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:24:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38371 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbfFXPYZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 11:24:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so4689241pgz.5;
        Mon, 24 Jun 2019 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lgND2Ln1TBQQyZCEAnGKpymz91Liq3socwltmWkX9XY=;
        b=dYAtPv+90C/VZ7Prob7WQ5L59If12of+wMC6Hzb+7Dxwqz1ZgnNyG3pu8E4fGOUchx
         drEImF0lbTOnCDOkUHGSZ7wbgkQYOSfBftt5Q2NIikF4PEKMSJOdhOUCOptP29vcLORw
         4CctNYGVzXWa36/or8Mi3nVXspD7250Hy5k7ZffISYCusmRjAFkrze+gc227HLVWP4bC
         DSO1o7pkfyEsrudhx5FZh3kbAJMRR1JBcozhBJN02fwQZFo4HwEq5u2nzCXIWxHSt25H
         ycz2LRsZ58khQZoxbwBOK+QXlgmm393SvEZ7K8z1sKW6gnzzibIBjVLReb9U/sBvDyct
         JUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lgND2Ln1TBQQyZCEAnGKpymz91Liq3socwltmWkX9XY=;
        b=CvRBx8XtBlAYaVsBwUpUMaUwA8AyDxkG0oGZuxibhrvdUeYu0pptsv7vIBZS2Hpu7Q
         wVoOysE+pW4/6xpNWg0C8ZO8wf0E4LH7HbVFYmCgMV62ZXeyk6vExIuW22xqYjTFT6iF
         QTnsDF3RjoR17MgN0Hc/2fLvjrrBCHDBMNXdHhHCose5KaIf3Ayy+vOKsQPYktjGp8V3
         GLHWZAl4K7xr8bB/cElilIZcTTLB+UKWHl1JHWNiaXezvuWlbt4r9SkkQsQIUXb1mFku
         ncYntF5h4PnpWsgYjEYsDicMkgzqUFW9t+ybHjunWBuUiHLxBMotyflzA5EFxoZlka6m
         Emzw==
X-Gm-Message-State: APjAAAXYXJVUTIqsMSvXWQusIxiNsGL+AG/1T6Zi9Mb6MijpXS/2JmGI
        JxNiroCqGcTY0EVFjuBiAfDSogEm
X-Google-Smtp-Source: APXvYqzU0xboNWcd1kQ0aKYSSAhpeljyXHqy7joHYSYu4QAPkAdS78BDlsinBHJX48WO1Ly5IHRJlA==
X-Received: by 2002:a17:90b:d8a:: with SMTP id bg10mr25646706pjb.92.1561389865084;
        Mon, 24 Jun 2019 08:24:25 -0700 (PDT)
Received: from bridge.tencent.com ([119.28.31.106])
        by smtp.gmail.com with ESMTPSA id e63sm20066869pgc.62.2019.06.24.08.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:24:24 -0700 (PDT)
From:   Wenbin Zeng <wenbin.zeng@gmail.com>
X-Google-Original-From: Wenbin Zeng <wenbinzeng@tencent.com>
To:     axboe@kernel.dk, keith.busch@intel.com, hare@suse.com,
        ming.lei@redhat.com, osandov@fb.com, sagi@grimberg.me,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenbin Zeng <wenbinzeng@tencent.com>
Subject: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug
Date:   Mon, 24 Jun 2019 23:24:07 +0800
Message-Id: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently hctx->cpumask is not updated when hot-plugging new cpus,
as there are many chances kblockd_mod_delayed_work_on() getting
called with WORK_CPU_UNBOUND, workqueue blk_mq_run_work_fn may run
on the newly-plugged cpus, consequently __blk_mq_run_hw_queue()
reporting excessive "run queue from wrong CPU" messages because
cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) returns false.

This patch added a cpu-hotplug handler into blk-mq, updating
hctx->cpumask at cpu-hotplug.

Signed-off-by: Wenbin Zeng <wenbinzeng@tencent.com>
---
 block/blk-mq.c         | 29 +++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ce0f5f4..2e465fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -39,6 +39,8 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
+static enum cpuhp_state cpuhp_blk_mq_online;
+
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -2215,6 +2217,21 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return -ENOMEM;
 }
 
+static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_online);
+
+	if (!cpumask_test_cpu(cpu, hctx->cpumask)) {
+		mutex_lock(&hctx->queue->sysfs_lock);
+		cpumask_set_cpu(cpu, hctx->cpumask);
+		mutex_unlock(&hctx->queue->sysfs_lock);
+	}
+
+	return 0;
+}
+
 /*
  * 'cpu' is going away. splice any existing rq_list entries from this
  * software queue to the hw queue dispatch list, and ensure that it
@@ -2251,6 +2268,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 
 static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
 {
+	if (cpuhp_blk_mq_online > 0)
+		cpuhp_state_remove_instance_nocalls(cpuhp_blk_mq_online,
+						    &hctx->cpuhp_online);
 	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
 					    &hctx->cpuhp_dead);
 }
@@ -2310,6 +2330,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 {
 	hctx->queue_num = hctx_idx;
 
+	if (cpuhp_blk_mq_online > 0)
+		cpuhp_state_add_instance_nocalls(cpuhp_blk_mq_online,
+						 &hctx->cpuhp_online);
 	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
 
 	hctx->tags = set->tags[hctx_idx];
@@ -3544,6 +3567,12 @@ unsigned int blk_mq_rq_cpu(struct request *rq)
 
 static int __init blk_mq_init(void)
 {
+	cpuhp_blk_mq_online = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+					"block/mq:online",
+					blk_mq_hctx_notify_online, NULL);
+	if (cpuhp_blk_mq_online <= 0)
+		pr_warn("blk_mq_init: failed to setup cpu online callback\n");
+
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
 	return 0;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15d1aa5..5241659 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -58,6 +58,7 @@ struct blk_mq_hw_ctx {
 
 	atomic_t		nr_active;
 
+	struct hlist_node	cpuhp_online;
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
 
-- 
1.8.3.1

