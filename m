Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86023C3A5A1
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 03:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6FB21883
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 03:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aQ2B4fFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfH1DzJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:55:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39236 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfH1DzH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 23:55:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id y200so768457pfb.6
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2019 20:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Spd8tWh4JGn3fBDEW8q9V28IkZ0ZVpCm4ISnu3nMaQM=;
        b=aQ2B4fFB6wrF6qbAgHFZWLIJBhdhVTA/hv4KAiq7MVYvRbBqWjbP6CrvRB/d4Ulqx1
         tRKuf+FbiNADlKz00WPw49rPF4mULQpIOTB+kw/E2Y6UwD9re9KqwiCxrBa3LvPOQZxB
         CRFelNFwgRThHt/CP9knGc0RrVtZSieKNJrnXkTRCah08mW/Q9Najk8yXZ9lyN05ivTL
         3SXFC3gQHIkTVYriMvQtHHPhHv5EmY5AmL0qwbYs99S9wjJAi8i+NqkhVRSzcgKlLbhX
         lhKWX4P7PqsksULwa+wWvhUYYh/yIn+RxNYVaBrtxNgLQki5OHp17zyR+AGns9sF50HT
         auHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Spd8tWh4JGn3fBDEW8q9V28IkZ0ZVpCm4ISnu3nMaQM=;
        b=pj7FojxkaEV46A7BlS3FVj8EwlXWnxIXlnorCD/ABJP8zLwWIB4pPVOzq9ZvcnVPxk
         cKgDQt/EeOhJWDKup95f872CMmePfuM92q/wIk6ziUrISomUEp4+3v9l/P1iLX3BpUNa
         CkXUJJWbBx3aZpCej3mklPCAxbCJuSmCO6jcN3qUZeS0XckPIlmGhJ4ozSCiR7vpfY8I
         EPj5EndzhIstzRWa4hCHtoNVQz7jGUkqHZdrHacvGb6iIUKxfNTYWn1AkxnQ6TAkT8ub
         twYIk349HwZKU0THh/MsPF/sL1biHwKb45nku9LPvncsF8gicsUKjnzetRLZM3daDa8X
         k0Nw==
X-Gm-Message-State: APjAAAX+J6YLWmXV9ddFyFsvwe9u9XDyWzLE7zeAxc5ps+7Kk+k8LjaK
        L0zfIaRX2CCmOscc2x4qCqQf1g==
X-Google-Smtp-Source: APXvYqy+6Ftbx8LvBpqhPjKILebxq24WFzWwB/gDOQ9g3NCj3QSvlR1tmVSPJXa8Ir3vxCUxmkJFEA==
X-Received: by 2002:a65:608e:: with SMTP id t14mr1619143pgu.373.1566964506583;
        Tue, 27 Aug 2019 20:55:06 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id q10sm944776pfl.8.2019.08.27.20.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 20:55:06 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, fam@euphon.net,
        duanxiongchun@bytedance.com, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com, tj@kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 2/3] bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
Date:   Wed, 28 Aug 2019 11:54:52 +0800
Message-Id: <20190828035453.18129-3-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190828035453.18129-1-zhengfeiran@bytedance.com>
References: <20190828035453.18129-1-zhengfeiran@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function will be useful when we update weight from the soon-coming
per-device interface.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
Reviewed-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 60 ++++++++++++++++++++++++----------------------
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
2.22.1

