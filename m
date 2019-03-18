Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8DFC10F0D
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E066F20989
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QQza5uEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCRTsi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfCRTs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RPkeFIWpFer9xbM+mmvwrTZv7i0Ua6lxJAjpp1KHriA=; b=QQza5uEgj43uWAmVOe5qrnATq
        m85X7+XOQpX3NP2XMscCn4Pv4oENCzRn+9VE8djVr2m5RpnxxKHMIgHKyy7sxupZVF8O/1eSJYSS/
        wdv4NAqToCeHfjEAqU0rpdrWbXj41cmyRsuoR83A9ZxWSOcduaKcyAzdh63CFzPeR4fR1kKm19JDx
        HR9f4LYXUX0SgB/r+vWML/koyvsmIRWpWf7O4lYGENwmWv9TWh7xVvJUkAQJWKV5BUjMokiMawF/J
        GCvE+8O2FjvHeNKZoRaQXHvnzKYlB75JvxTy/FysxxyvVnDXjtv6AQxy5IDJLb6HLpYeSZTok06Gz
        GbiMThO4A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFH-0000vC-Va; Mon, 18 Mar 2019 19:48:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 02/14] blk-cgroup: Remove blkg_list hlist
Date:   Mon, 18 Mar 2019 12:48:09 -0700
Message-Id: <20190318194821.3470-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can iterate over all blkcgs using the XArray iterator instead of
maintaining a separate hlist.  This removes a nasty locking inversion
in blkcg_destroy_blkgs().

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 block/bfq-cgroup.c         |  3 ++-
 block/blk-cgroup.c         | 38 ++++++++++++++------------------------
 include/linux/blk-cgroup.h |  2 --
 3 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9d25e490f9fa..13e5c7edde7a 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -857,6 +857,7 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 	struct blkcg *blkcg = css_to_blkcg(css);
 	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
 	struct blkcg_gq *blkg;
+	unsigned long index;
 	int ret = -ERANGE;
 
 	if (val < BFQ_MIN_WEIGHT || val > BFQ_MAX_WEIGHT)
@@ -865,7 +866,7 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 	ret = 0;
 	xa_lock_irq(&blkcg->blkg_array);
 	bfqgd->weight = (unsigned short)val;
-	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
+	xa_for_each(&blkcg->blkg_array, index, blkg) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
 		if (!bfqg)
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 90deb5445332..bd6eea0587fb 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -258,7 +258,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 
 	xa_lock(&blkcg->blkg_array);
 	__xa_store(&blkcg->blkg_array, q->id, blkg, 0);
-	hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
 	list_add(&blkg->q_node, &q->blkg_list);
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
@@ -372,7 +371,6 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 
 	/* Something wrong if we are trying to remove same group twice */
 	WARN_ON_ONCE(list_empty(&blkg->q_node));
-	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -390,7 +388,6 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 
 	__xa_erase(&blkcg->blkg_array, blkg->q->id);
 	list_del_init(&blkg->q_node);
-	hlist_del_init_rcu(&blkg->blkcg_node);
 
 	/*
 	 * Both setting lookup hint to and clearing it from @blkg are done
@@ -435,6 +432,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
 	struct blkcg_gq *blkg;
+	unsigned long index;
 	int i;
 
 	mutex_lock(&blkcg_pol_mutex);
@@ -445,7 +443,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	 * stat updates.  This is a debug feature which shouldn't exist
 	 * anyway.  If you get hit by a race, retry.
 	 */
-	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
+	xa_for_each(&blkcg->blkg_array, index, blkg) {
 		blkg_rwstat_reset(&blkg->stat_bytes);
 		blkg_rwstat_reset(&blkg->stat_ios);
 
@@ -495,16 +493,15 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       bool show_total)
 {
 	struct blkcg_gq *blkg;
+	unsigned long index;
 	u64 total = 0;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+	xa_for_each(&blkcg->blkg_array, index, blkg) {
 		spin_lock_irq(&blkg->q->queue_lock);
 		if (blkcg_policy_enabled(blkg->q, pol))
 			total += prfill(sf, blkg->pd[pol->plid], data);
 		spin_unlock_irq(&blkg->q->queue_lock);
 	}
-	rcu_read_unlock();
 
 	if (show_total)
 		seq_printf(sf, "Total %llu\n", (unsigned long long)total);
@@ -924,10 +921,10 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 {
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct blkcg_gq *blkg;
+	unsigned long index;
 
 	rcu_read_lock();
-
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+	xa_for_each(&blkcg->blkg_array, index, blkg) {
 		const char *dname;
 		char *buf;
 		struct blkg_rwstat rwstat;
@@ -1076,24 +1073,18 @@ static void blkcg_css_offline(struct cgroup_subsys_state *css)
  */
 void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
-	xa_lock_irq(&blkcg->blkg_array);
+	struct blkcg_gq *blkg;
+	unsigned long index;
 
-	while (!hlist_empty(&blkcg->blkg_list)) {
-		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
-						struct blkcg_gq, blkcg_node);
+	xa_for_each(&blkcg->blkg_array, index, blkg) {
 		struct request_queue *q = blkg->q;
 
-		if (spin_trylock(&q->queue_lock)) {
-			blkg_destroy(blkg);
-			spin_unlock(&q->queue_lock);
-		} else {
-			xa_unlock_irq(&blkcg->blkg_array);
-			cpu_relax();
-			xa_lock_irq(&blkcg->blkg_array);
-		}
+		spin_lock_irq(&q->queue_lock);
+		xa_lock(&blkcg->blkg_array);
+		blkg_destroy(blkg);
+		xa_unlock(&blkcg->blkg_array);
+		spin_unlock_irq(&q->queue_lock);
 	}
-
-	xa_unlock_irq(&blkcg->blkg_array);
 }
 
 static void blkcg_css_free(struct cgroup_subsys_state *css)
@@ -1159,7 +1150,6 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	}
 
 	xa_init_flags(&blkcg->blkg_array, XA_FLAGS_LOCK_IRQ);
-	INIT_HLIST_HEAD(&blkcg->blkg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&blkcg->cgwb_list);
 	refcount_set(&blkcg->cgwb_refcnt, 1);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 51530ac5451f..0b2929195a0f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -49,7 +49,6 @@ struct blkcg {
 
 	struct xarray			blkg_array;
 	struct blkcg_gq	__rcu		*blkg_hint;
-	struct hlist_head		blkg_list;
 
 	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
 
@@ -110,7 +109,6 @@ struct blkcg_gq {
 	/* Pointer to the associated request_queue */
 	struct request_queue		*q;
 	struct list_head		q_node;
-	struct hlist_node		blkcg_node;
 	struct blkcg			*blkcg;
 
 	/*
-- 
2.20.1

