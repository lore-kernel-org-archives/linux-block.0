Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E68CC0650F
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A60E2086D
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="oOQBrs12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfHEGiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:38:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39416 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfHEGiY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 02:38:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so36111050pls.6
        for <linux-block@vger.kernel.org>; Sun, 04 Aug 2019 23:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MuVYHrlXRDGRQL1cMnPZM826RHR8kEr3M58QLGT7l6o=;
        b=oOQBrs12OopXCz7nK2i2nem3bftqhB7645AkBg0ImN6CVvW2lFbZstYRhFAHDIA+tV
         GbDlO/gHxhAeTdEo73cZoyqmMT0zgXH7WTXEnu//hj1eKBgThaGQl7o+8Cxoiu2qWecO
         D8LKIRg0PktmBPfDG/X//TIsTZtL1nmLBcKSb030DOvsD2rPQJtrKgSt5ZUoeqrD5O9h
         iSjjK171swVL4dpo5X8NL/I93IGWfQroEcc+EuuJNLJqvPnpcxkI3+lxCSovuum/3l/3
         H2HWPry5YzDsHdK2dr3B59xsPdwwAn91ooqYuLaKK7sbgty11UzEWSz0jDavzAb5Fj0u
         gj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MuVYHrlXRDGRQL1cMnPZM826RHR8kEr3M58QLGT7l6o=;
        b=I1ekZHsQYtIjocRcyWRb9haZQ0Qen5StHPlXSnbhz2ktj2JByu/qA3X3lig+anKPXR
         NcU49hPt4ucsV3YTswRzIevWvCxJnJ3hhuMwV3O+rrIXTDtSEjd06JQt0VYXFFk7+bm4
         QkMtjWL1uoizVPyWJ1Hxzb6cOgH0QsJrpXk1Ki6OQ7mc7vdbRJ/EP4XvDkevUW+gKy9U
         FfbjBIktOPVB1oCuVRo3G/EpK0yQCkWAhhwIftsSUfrC3bA1C2U1wvw5rBxd1dSSFFg5
         ZBDpOMrU8qMZsS+gg3LWbDVKNjfgyznk+++yxGt4VqLkUOW2LDiL4yW5R3HzzaewUvxu
         ChKg==
X-Gm-Message-State: APjAAAVZijvCfJSZPPIOoFBrfgEBmfmoCmQOkyGhcPbnP6OGTqFQjQly
        0SWDtpQ0u60P9ZIO3ya7gHOrgw==
X-Google-Smtp-Source: APXvYqyhlzIJ9VjR93pVAFfcUHzonu6+OfVYXlc34pKN37u8dvT7OL8OKZgve6cNtHqXzs16VfYv1g==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr144683356ple.192.1564987102993;
        Sun, 04 Aug 2019 23:38:22 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id q126sm40687394pfb.56.2019.08.04.23.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Aug 2019 23:38:22 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, fam@euphon.net, paolo.valente@linaro.org,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        tj@kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
Subject: [PATCH v2 3/3] bfq: Add per-device weight
Date:   Mon,  5 Aug 2019 14:38:07 +0800
Message-Id: <20190805063807.9494-4-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190805063807.9494-1-zhengfeiran@bytedance.com>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
---
 block/bfq-cgroup.c  | 95 ++++++++++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h |  3 ++
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 28e5a9241237..de4fd8b725aa 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -904,7 +904,7 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
 }
 
-static int bfq_io_show_weight(struct seq_file *sf, void *v)
+static int bfq_io_show_weight_legacy(struct seq_file *sf, void *v)
 {
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
@@ -918,8 +918,32 @@ static int bfq_io_show_weight(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight)
+static u64 bfqg_prfill_weight_device(struct seq_file *sf,
+				     struct blkg_policy_data *pd, int off)
+{
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+
+	if (!bfqg->entity.dev_weight)
+		return 0;
+	return __blkg_prfill_u64(sf, pd, bfqg->entity.dev_weight);
+}
+
+static int bfq_io_show_weight(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+
+	seq_printf(sf, "default %u\n", bfqgd->weight);
+	blkcg_print_blkgs(sf, blkcg, bfqg_prfill_weight_device,
+			  &blkcg_policy_bfq, 0, false);
+	return 0;
+}
+
+static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight, u64 dev_weight)
 {
+	weight = dev_weight ?: weight;
+
+	bfqg->entity.dev_weight = dev_weight;
 	/*
 	 * Setting the prio_changed flag of the entity
 	 * to 1 with new_weight == weight would re-set
@@ -967,28 +991,71 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
 		if (bfqg)
-			bfq_group_set_weight(bfqg, val);
+			bfq_group_set_weight(bfqg, val, 0);
 	}
 	spin_unlock_irq(&blkcg->lock);
 
 	return ret;
 }
 
-static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
-				 char *buf, size_t nbytes,
-				 loff_t off)
+static ssize_t bfq_io_set_device_weight(struct kernfs_open_file *of,
+					char *buf, size_t nbytes,
+					loff_t off)
 {
-	u64 weight;
-	/* First unsigned long found in the file is used */
-	int ret = kstrtoull(strim(buf), 0, &weight);
+	int ret;
+	struct blkg_conf_ctx ctx;
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
+	struct bfq_group *bfqg;
+	u64 v;
 
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_bfq, buf, &ctx);
 	if (ret)
 		return ret;
 
-	ret = bfq_io_set_weight_legacy(of_css(of), NULL, weight);
+	if (sscanf(ctx.body, "%llu", &v) == 1) {
+		/* require "default" on dfl */
+		ret = -ERANGE;
+		if (!v)
+			goto out;
+	} else if (!strcmp(strim(ctx.body), "default")) {
+		v = 0;
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	bfqg = blkg_to_bfqg(ctx.blkg);
+
+	ret = -ERANGE;
+	if (!v || (v >= BFQ_MIN_WEIGHT && v <= BFQ_MAX_WEIGHT)) {
+		bfq_group_set_weight(bfqg, bfqg->entity.weight, v);
+		ret = 0;
+	}
+out:
+	blkg_conf_finish(&ctx);
 	return ret ?: nbytes;
 }
 
+static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
+				 char *buf, size_t nbytes,
+				 loff_t off)
+{
+	char *endp;
+	int ret;
+	u64 v;
+
+	buf = strim(buf);
+
+	/* "WEIGHT" or "default WEIGHT" sets the default weight */
+	v = simple_strtoull(buf, &endp, 0);
+	if (*endp == '\0' || sscanf(buf, "default %llu", &v) == 1) {
+		ret = bfq_io_set_weight_legacy(of_css(of), NULL, v);
+		return ret ?: nbytes;
+	}
+
+	return bfq_io_set_device_weight(of, buf, nbytes, off);
+}
+
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 static int bfqg_print_stat(struct seq_file *sf, void *v)
 {
@@ -1145,9 +1212,15 @@ struct cftype bfq_blkcg_legacy_files[] = {
 	{
 		.name = "bfq.weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = bfq_io_show_weight,
+		.seq_show = bfq_io_show_weight_legacy,
 		.write_u64 = bfq_io_set_weight_legacy,
 	},
+	{
+		.name = "bfq.weight_device",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_weight,
+		.write = bfq_io_set_weight,
+	},
 
 	/* statistics, covers only the tasks in the bfqg */
 	{
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index e80adf822bbe..5d1a519640f6 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -168,6 +168,9 @@ struct bfq_entity {
 	/* budget, used also to calculate F_i: F_i = S_i + @budget / @weight */
 	int budget;
 
+	/* device weight, if non-zero, it overrides the default weight of
+	 * bfq_group_data */
+	int dev_weight;
 	/* weight of the queue */
 	int weight;
 	/* next weight if a change is in progress */
-- 
2.11.0

