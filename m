Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADD8C28EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA2E2089E
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jyjUMcjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfFFK0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:26:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFFK0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 06:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Uku4X1NuSYOSYwe5/8VxCfVwayC53Kz39W46rZr6FMs=; b=jyjUMcjKtlmDS6MuQDI0Cem2ZQ
        J15PJwpYIyAkxKU3IjxHvJV9MbWP3qg6yrYgpX/VWd+Iqj0NwcTpo4VEnp2sorXMzPXnDav8cB9fN
        OqwfX9nV3xscLwreTSp45yY1fAp4KxgRHPrM0aLPZghvg+Fmb8USmritRYrjEvCpkkRYh24WM/xoT
        aPCpUM+Hj8nUdzU4SrsCEus+XH6Did6p3toEVhpCvdBRMNcAKqXBd3O9aAMGpB2XpOQ7SBelgDlZG
        8HTMzToYYb0F3qJvyPp9Yx0+KNj7LlpjwiFoofbzvDEqWcLmU5nBaQSv/05h3hAmECT86ViNsoOjs
        VBWnhpnw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpbK-0007gl-26; Thu, 06 Jun 2019 10:26:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] blk-cgroup: factor out a helper to read rwstat counter
Date:   Thu,  6 Jun 2019 12:26:19 +0200
Message-Id: <20190606102624.3847-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606102624.3847-1-hch@lst.de>
References: <20190606102624.3847-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Trying to break up the crazy statements to something readable.
Also switch to an unsigned counter as it can't ever turn negative.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         | 5 ++---
 include/linux/blk-cgroup.h | 7 +++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b97b479e4f64..6f79ace02be4 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -750,7 +750,7 @@ struct blkg_rwstat blkg_rwstat_recursive_sum(struct blkcg_gq *blkg,
 	struct blkcg_gq *pos_blkg;
 	struct cgroup_subsys_state *pos_css;
 	struct blkg_rwstat sum = { };
-	int i;
+	unsigned int i;
 
 	lockdep_assert_held(&blkg->q->queue_lock);
 
@@ -767,8 +767,7 @@ struct blkg_rwstat blkg_rwstat_recursive_sum(struct blkcg_gq *blkg,
 			rwstat = (void *)pos_blkg + off;
 
 		for (i = 0; i < BLKG_RWSTAT_NR; i++)
-			atomic64_add(atomic64_read(&rwstat->aux_cnt[i]) +
-				percpu_counter_sum_positive(&rwstat->cpu_cnt[i]),
+			atomic64_add(blkg_rwstat_read_counter(rwstat, i),
 				&sum.aux_cnt[i]);
 	}
 	rcu_read_unlock();
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 76c61318fda5..06236f56a840 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -198,6 +198,13 @@ int blkcg_activate_policy(struct request_queue *q,
 void blkcg_deactivate_policy(struct request_queue *q,
 			     const struct blkcg_policy *pol);
 
+static inline u64 blkg_rwstat_read_counter(struct blkg_rwstat *rwstat,
+		unsigned int idx)
+{
+	return atomic64_read(&rwstat->aux_cnt[idx]) +
+		percpu_counter_sum_positive(&rwstat->cpu_cnt[idx]);
+}
+
 const char *blkg_dev_name(struct blkcg_gq *blkg);
 void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       u64 (*prfill)(struct seq_file *,
-- 
2.20.1

