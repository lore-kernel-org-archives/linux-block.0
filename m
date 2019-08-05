Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39945C0650F
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132262086D
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="wIkzzujg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfHEGiT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:38:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44393 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfHEGiT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 02:38:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so39181033pgl.11
        for <linux-block@vger.kernel.org>; Sun, 04 Aug 2019 23:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CBE2RxQAGoG3LaBnrWD40VvQ1s3Zc1p2YNjhDaVQZYE=;
        b=wIkzzujgXkOVi7Ki0cOf1lHqXj2TsWK0iWppP0cX5E3NgPSgD8LmlqqnGfCdKrmOiW
         YC/5558MPEGyzGrLSZ/odKYU7SfqvwQFsv0QK1xirJeTtwA3ZmCKproGKzoWSM7MgYoL
         K0npL84yKbwslvnXFud6giJKc+gi9NEoBx2fNCqY4fj2B7BUGQzEQSU/hIUcR/xVX/uP
         w0ezOuEvrOWAUqFBppcVxdk1fgWYqqXd6Z80d6FzzQ7Spsk5x8FZuRUW4cSlYw2ZVyi7
         FT9nGH7wXkDm+naORN+RByCHNchfJqSW62DZyHPvHzUR7FFNS+zpMBdGpmE5rm6xB8Pk
         74DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CBE2RxQAGoG3LaBnrWD40VvQ1s3Zc1p2YNjhDaVQZYE=;
        b=g89+TaUqoPVf2pisb9qEjGuBoCZ/V631JuZc0R1AQl5ZGo9cvG3LXAIdQ1ySYoO/Pb
         PcTNRnyolM7m1vsooP6I0kllyITHcM0h8SNnxUEcUQFQ5Or+luZLYeH//pcOuIRNi852
         Zlu51H1SUJkjEXtUdpycF2+HhxyltdhR7+17uviPPZgwWLdMlwz03h1XNtyJX/6iFBU+
         6eywefHT5CoGkBgrpsKCW20Ixbc/lVGMCDnTZj9bNp+ZWL3DTnJT8qjGoHRG54TAVgRc
         I4Urbc8RHR35tOtufG5/4HOG3/XYP/qm4dBREy95k8HNdUpc5r514T3lthN+THam7PRK
         5Txw==
X-Gm-Message-State: APjAAAWsz4c1nXTVPwiUnjrFtVMyQ6Vh8LjkpdYreTh0Rz/9eHxcLpam
        LokiBY92XIdJg+Bis1Cr8kqWHA==
X-Google-Smtp-Source: APXvYqxrDgdZFYrMxcKjIromxiq2TaMO++88ERtAXgo2iUcKdNBh/yFnVEf+6gcNSAoVDfjhziuWEw==
X-Received: by 2002:a62:f250:: with SMTP id y16mr71199579pfl.50.1564987098995;
        Sun, 04 Aug 2019 23:38:18 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id i124sm150930671pfe.61.2019.08.04.23.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Aug 2019 23:38:18 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, fam@euphon.net, paolo.valente@linaro.org,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        tj@kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
Subject: [PATCH v2 2/3] bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
Date:   Mon,  5 Aug 2019 14:38:06 +0800
Message-Id: <20190805063807.9494-3-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190805063807.9494-1-zhengfeiran@bytedance.com>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function will be useful when we update weight from the soon-coming
per-device interface.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
---
 block/bfq-cgroup.c | 60 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 0f6cd688924f..28e5a9241237 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -918,6 +918,36 @@ static int bfq_io_show_weight(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight)
+{
+	/*
+	 * Setting the prio_changed flag of the entity
+	 * to 1 with new_weight == weight would re-set
+	 * the value of the weight to its ioprio mapping.
+	 * Set the flag only if necessary.
+	 */
+	if ((unsigned short)weight != bfqg->entity.new_weight) {
+		bfqg->entity.new_weight = (unsigned short)weight;
+		/*
+		 * Make sure that the above new value has been
+		 * stored in bfqg->entity.new_weight before
+		 * setting the prio_changed flag. In fact,
+		 * this flag may be read asynchronously (in
+		 * critical sections protected by a different
+		 * lock than that held here), and finding this
+		 * flag set may cause the execution of the code
+		 * for updating parameters whose value may
+		 * depend also on bfqg->entity.new_weight (in
+		 * __bfq_entity_update_weight_prio).
+		 * This barrier makes sure that the new value
+		 * of bfqg->entity.new_weight is correctly
+		 * seen in that code.
+		 */
+		smp_wmb();
+		bfqg->entity.prio_changed = 1;
+	}
+}
+
 static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 				    struct cftype *cftype,
 				    u64 val)
@@ -936,34 +966,8 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
-		if (!bfqg)
-			continue;
-		/*
-		 * Setting the prio_changed flag of the entity
-		 * to 1 with new_weight == weight would re-set
-		 * the value of the weight to its ioprio mapping.
-		 * Set the flag only if necessary.
-		 */
-		if ((unsigned short)val != bfqg->entity.new_weight) {
-			bfqg->entity.new_weight = (unsigned short)val;
-			/*
-			 * Make sure that the above new value has been
-			 * stored in bfqg->entity.new_weight before
-			 * setting the prio_changed flag. In fact,
-			 * this flag may be read asynchronously (in
-			 * critical sections protected by a different
-			 * lock than that held here), and finding this
-			 * flag set may cause the execution of the code
-			 * for updating parameters whose value may
-			 * depend also on bfqg->entity.new_weight (in
-			 * __bfq_entity_update_weight_prio).
-			 * This barrier makes sure that the new value
-			 * of bfqg->entity.new_weight is correctly
-			 * seen in that code.
-			 */
-			smp_wmb();
-			bfqg->entity.prio_changed = 1;
-		}
+		if (bfqg)
+			bfq_group_set_weight(bfqg, val);
 	}
 	spin_unlock_irq(&blkcg->lock);
 
-- 
2.11.0

