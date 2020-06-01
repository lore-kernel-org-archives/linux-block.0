Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CCBC433DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99CF2077D
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 20:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GEZD3M7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cmLtqVki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgFAULv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:11:51 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40643 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728182AbgFAULu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jun 2020 16:11:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 289675800B4;
        Mon,  1 Jun 2020 16:11:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 01 Jun 2020 16:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=qxemTamNQobuO
        Kq3+wMebkDk3hWSHYuE0KPekOlLSrY=; b=GEZD3M7gBNU23IFf8/x5/DDejqbuI
        TPchaOSVdRXpAxik19mY2LMboQkMQV0rgCzils68pOGiYWxwgtnIOMPbTaaMUWS7
        F7FH68QF1Eg3CaUl89ww9YofLfx0N26o65EoPVuO+TB8oUVOsRYw57BhQ9cSsNyM
        PQXv+5dn2uKEkAGNkHAU/PVV3xBmM1TOdL7BEEuiNJZl2h53vP2GqlHw0bVDHHrM
        mOt4KOlVzuFn2tcBl76z/kIA+oUAAwzQT4GU0i4c6DSoRGz8bgGz/CtxX1/jCc/9
        jjn8VNFTaZ+G8i+C202mXLfW7yLDkT604SpPJvuJcoXv4hWr0WTI62qYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=qxemTamNQobuOKq3+wMebkDk3hWSHYuE0KPekOlLSrY=; b=cmLtqVki
        vcWwFpqDCN+3Ukhlwt7HM/RkPtXSTReiZEjCMMUHf+vL28dlPziqGSdlJEYiSgJy
        Qz8AawcEWhuW/7vI5VBbuYsl0u/SCVdQC1C/ml82N8np/OMiRPNbOQZGT9fnM5bD
        zmIBpqt+SJHa1V26dtcPYcAHmE2avMTtSXit6DzQhMIthYWbiDK0NxNQEkGidpCD
        dpr05y8yGL4Bz+QrG3RY8L1POQvqRZnEg6tErilNgN0n8PVM6xXvBWI0w4rVL92e
        U+SJaxRuF+KcEViRfbo0fbkr2HNDs6GKvYMUkTgMi/U1Nfskuf8evz2RR0Wczhrk
        WmZnb/NV3v9Wow==
X-ME-Sender: <xms:BGHVXv5ei4sNehx4RsAhWeBt7TFS-gdQ2eE2IzCX5RhSq55Nwplv9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefhedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eiueffuedvieeujefhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:BGHVXk7Czb-CKAJTP-3lus-kVWpyigO-JQdFa7DdnaAQ-g038kRISA>
    <xmx:BGHVXmcndkIwpo2pp0Nh3Bx35ZnaQkz5EphcmgkR-Y2sRfi7awMXFA>
    <xmx:BGHVXgK9jF11hcFW7Wkimhvz9sLG_GQOTX-qPLLGNgxRPU_v_pQkYQ>
    <xmx:BGHVXr0ctmtKzBHvnaxvudbNJHXL3XgzkvRAfxMrGe9eKR0TEMmJnvyVxHA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id E44783061CB6;
        Mon,  1 Jun 2020 16:11:47 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Boris Burkov <boris@bur.io>
Subject: [PATCH 1/2 blk-cgroup/for-5.8] blk-cgroup: make iostat functions visible to stat printing
Date:   Mon,  1 Jun 2020 13:11:43 -0700
Message-Id: <20200601201143.1657414-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200601154351.GD31548@mtj.thefacebook.com>
References: <20200601154351.GD31548@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previously, the code which printed io.stat only needed access to the
generic rstat flushing code, but since we plan to write some more
specific code for preparing root cgroup stats, we need to manipulate
iostat structs directly. Since declaring static functions ahead does not
seem like common practice in this file, simply move the iostat functions
up. We only plan to use blkg_iostat_set, but it seems better to keep them
all together.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 block/blk-cgroup.c | 142 ++++++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ecc897b225c..1606f419255c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -739,6 +739,77 @@ void blkg_conf_finish(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
+static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] = src->bytes[i];
+		dst->ios[i] = src->ios[i];
+	}
+}
+
+static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] += src->bytes[i];
+		dst->ios[i] += src->ios[i];
+	}
+}
+
+static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] -= src->bytes[i];
+		dst->ios[i] -= src->ios[i];
+	}
+}
+
+static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+
+	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+		struct blkcg_gq *parent = blkg->parent;
+		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
+		struct blkg_iostat cur, delta;
+		unsigned int seq;
+
+		/* fetch the current per-cpu values */
+		do {
+			seq = u64_stats_fetch_begin(&bisc->sync);
+			blkg_iostat_set(&cur, &bisc->cur);
+		} while (u64_stats_fetch_retry(&bisc->sync, seq));
+
+		/* propagate percpu delta to global */
+		u64_stats_update_begin(&blkg->iostat.sync);
+		blkg_iostat_set(&delta, &cur);
+		blkg_iostat_sub(&delta, &bisc->last);
+		blkg_iostat_add(&blkg->iostat.cur, &delta);
+		blkg_iostat_add(&bisc->last, &delta);
+		u64_stats_update_end(&blkg->iostat.sync);
+
+		/* propagate global delta to parent */
+		if (parent) {
+			u64_stats_update_begin(&parent->iostat.sync);
+			blkg_iostat_set(&delta, &blkg->iostat.cur);
+			blkg_iostat_sub(&delta, &blkg->iostat.last);
+			blkg_iostat_add(&parent->iostat.cur, &delta);
+			blkg_iostat_add(&blkg->iostat.last, &delta);
+			u64_stats_update_end(&parent->iostat.sync);
+		}
+	}
+
+	rcu_read_unlock();
+}
+
 static int blkcg_print_stat(struct seq_file *sf, void *v)
 {
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
@@ -1114,77 +1185,6 @@ static int blkcg_can_attach(struct cgroup_taskset *tset)
 	return ret;
 }
 
-static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
-{
-	int i;
-
-	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
-		dst->bytes[i] = src->bytes[i];
-		dst->ios[i] = src->ios[i];
-	}
-}
-
-static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
-{
-	int i;
-
-	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
-		dst->bytes[i] += src->bytes[i];
-		dst->ios[i] += src->ios[i];
-	}
-}
-
-static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
-{
-	int i;
-
-	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
-		dst->bytes[i] -= src->bytes[i];
-		dst->ios[i] -= src->ios[i];
-	}
-}
-
-static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
-{
-	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg_gq *blkg;
-
-	rcu_read_lock();
-
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct blkcg_gq *parent = blkg->parent;
-		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
-		struct blkg_iostat cur, delta;
-		unsigned seq;
-
-		/* fetch the current per-cpu values */
-		do {
-			seq = u64_stats_fetch_begin(&bisc->sync);
-			blkg_iostat_set(&cur, &bisc->cur);
-		} while (u64_stats_fetch_retry(&bisc->sync, seq));
-
-		/* propagate percpu delta to global */
-		u64_stats_update_begin(&blkg->iostat.sync);
-		blkg_iostat_set(&delta, &cur);
-		blkg_iostat_sub(&delta, &bisc->last);
-		blkg_iostat_add(&blkg->iostat.cur, &delta);
-		blkg_iostat_add(&bisc->last, &delta);
-		u64_stats_update_end(&blkg->iostat.sync);
-
-		/* propagate global delta to parent */
-		if (parent) {
-			u64_stats_update_begin(&parent->iostat.sync);
-			blkg_iostat_set(&delta, &blkg->iostat.cur);
-			blkg_iostat_sub(&delta, &blkg->iostat.last);
-			blkg_iostat_add(&parent->iostat.cur, &delta);
-			blkg_iostat_add(&blkg->iostat.last, &delta);
-			u64_stats_update_end(&parent->iostat.sync);
-		}
-	}
-
-	rcu_read_unlock();
-}
-
 static void blkcg_bind(struct cgroup_subsys_state *root_css)
 {
 	int i;
-- 
2.24.1

