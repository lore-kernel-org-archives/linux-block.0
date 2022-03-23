Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC02C433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 01:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiCWBO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiCWBOy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 21:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 941F55DA7F
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 18:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647998004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AoJUMY1gnuYARnnG8r/5NaqPtN8gcbCf6nDg18qn9Ls=;
        b=acxmtFOQlILjZgxJFFQeirIon/as0HDULd31CYHFYKf7mCIdtkDN/jejcWmtps95enTzzI
        dT8c1xRwu8DxUuSeTBipa+tQZTdEt7fwducHz42+zlQXF7HujHj6Q+TWQhiPZnUK1TLclz
        YDwl/hv7/bxGDtQ4fOxohsFYSrri48Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557--wR3CaF2Niq-nGuwGWCb7Q-1; Tue, 22 Mar 2022 21:13:21 -0400
X-MC-Unique: -wR3CaF2Niq-nGuwGWCb7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8C361C05AAE;
        Wed, 23 Mar 2022 01:13:20 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E973A778B;
        Wed, 23 Mar 2022 01:13:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2] block: avoid to call blkg_free() in atomic context
Date:   Wed, 23 Mar 2022 09:13:08 +0800
Message-Id: <20220323011308.2010380-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkg_free() may be called in atomic context, either spin lock is held,
or run in rcu callback. Meantime either request queue's release handler
or ->pd_free_fn can sleep.

Fix the issue by scheduling work function for freeing blkcg_gq instance.

[  148.553894] BUG: sleeping function called from invalid context at block/blk-sysfs.c:767
[  148.557381] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/13
[  148.560741] preempt_count: 101, expected: 0
[  148.562577] RCU nest depth: 0, expected: 0
[  148.564379] 1 lock held by swapper/13/0:
[  148.566127]  #0: ffffffff82615f80 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire+0x0/0x1b
[  148.569640] Preemption disabled at:
[  148.569642] [<ffffffff8123f9c3>] ___slab_alloc+0x554/0x661
[  148.573559] CPU: 13 PID: 0 Comm: swapper/13 Kdump: loaded Not tainted 5.17.0_up+ #110
[  148.576834] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[  148.579768] Call Trace:
[  148.580567]  <IRQ>
[  148.581262]  dump_stack_lvl+0x56/0x7c
[  148.582367]  ? ___slab_alloc+0x554/0x661
[  148.583526]  __might_resched+0x1af/0x1c8
[  148.584678]  blk_release_queue+0x24/0x109
[  148.585861]  kobject_cleanup+0xc9/0xfe
[  148.586979]  blkg_free+0x46/0x63
[  148.587962]  rcu_do_batch+0x1c5/0x3db
[  148.589057]  rcu_core+0x14a/0x184
[  148.590065]  __do_softirq+0x14d/0x2c7
[  148.591167]  __irq_exit_rcu+0x7a/0xd4
[  148.592264]  sysvec_apic_timer_interrupt+0x82/0xa5
[  148.593649]  </IRQ>
[  148.594354]  <TASK>
[  148.595058]  asm_sysvec_apic_timer_interrupt+0x12/0x20

Cc: Tejun Heo <tj@kernel.org>
Fixes: 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt")
Reported-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-block/20220322093322.GA27283@lst.de/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- fix document
	- move 'blkg' check into blkg_free()
	- make sure no warning in clang build
	- add call trace in commit log as suggested by Tejun

 block/blk-cgroup.c         | 32 ++++++++++++++++++++++----------
 include/linux/blk-cgroup.h |  5 ++++-
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d53b0d69dd73..6ed43fc0e6ab 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -65,19 +65,12 @@ static bool blkcg_policy_enabled(struct request_queue *q,
 	return pol && test_bit(pol->plid, q->blkcg_pols);
 }
 
-/**
- * blkg_free - free a blkg
- * @blkg: blkg to free
- *
- * Free @blkg which may be partially allocated.
- */
-static void blkg_free(struct blkcg_gq *blkg)
+static void blkg_free_workfn(struct work_struct *work)
 {
+	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
+					     free_work);
 	int i;
 
-	if (!blkg)
-		return;
-
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
@@ -89,6 +82,25 @@ static void blkg_free(struct blkcg_gq *blkg)
 	kfree(blkg);
 }
 
+/**
+ * blkg_free - free a blkg
+ * @blkg: blkg to free
+ *
+ * Free @blkg which may be partially allocated.
+ */
+static void blkg_free(struct blkcg_gq *blkg)
+{
+	if (!blkg)
+		return;
+
+	/*
+	 * Both ->pd_free_fn() and request queue's release handler may
+	 * sleep, so free us by scheduling one work func
+	 */
+	INIT_WORK(&blkg->free_work, blkg_free_workfn);
+	schedule_work(&blkg->free_work);
+}
+
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index f2ad8ed8f777..652cd05b0924 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -95,7 +95,10 @@ struct blkcg_gq {
 
 	spinlock_t			async_bio_lock;
 	struct bio_list			async_bios;
-	struct work_struct		async_bio_work;
+	union {
+		struct work_struct	async_bio_work;
+		struct work_struct	free_work;
+	};
 
 	atomic_t			use_delay;
 	atomic64_t			delay_nsec;
-- 
2.31.1

