Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B97C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 22:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A9620989
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545259439;
	bh=pI7jlgVHa9JKU5XzHnm6nLWNx7I0QIs+J/Gj8rRW2a0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=U9S6mKNsfw9NFkQsO4BqEoGeF5093rkMuPv6JpVSv31d+nGk1jBWtZy99Eng6sczj
	 NW7qspHR4f4dQ/OkB8Yx3ECvtPeTPe8pIx4Xkc8YQovCQSgxuLQ3xpAb2pc8pKkBFr
	 6lGQy3i+nZXtLxSs+OeV8uz3KWw+F++HicNVJEEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeLSWn7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:43:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34233 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLSWn6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 17:43:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so24218693qtp.1;
        Wed, 19 Dec 2018 14:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aMlWOxxanyWGhdz+rklKQu8J3FMqqWnFQG+OHWd/InI=;
        b=pvAzb+ARhosBn3v55ja8uY+Z27mpa5cQ95De7L4VNhplM9AeSl/WwcMvRXo4FQ8hsp
         ea6w4K+apAG3oRdiab2wfLOuVbh0GsEcTmRBUtYuv/Cysazr7bnKARY3yWrWF3UjXEoe
         68BTpjGY/NMisc1sEWhDGj5ChGwQX/FTWS+LibvJG/voqsHPea2rK/sbcrQD3IQGQsew
         tb4RRiU9R7TcerwfyNN9gAk0GBsKXinq49XwzWiLCJdYO4AlCEgVS3s95rTVugLHpHFI
         6fNiJoq0YsyJc3o+vle9PQmYDnjf7i89ExZ7kOqQ0H+084ZPqlNXvBPve+x+AFNSAN6y
         UhQg==
X-Gm-Message-State: AA+aEWaM24nspCIzYKEoLSKqHwg2jjN3O6ikB5pLgOfFjg8yFkJrYmIu
        ULmiYlNYOXPeGRl6k/pyZ00=
X-Google-Smtp-Source: AFSGD/UY2NF/Fie5jPrNxh2ePUj+s+uTUxFTHiJkwIP1cYO+5i86vv0dqjAf/BTZgmaLkluDUv4/Kw==
X-Received: by 2002:a0c:8ecc:: with SMTP id y12mr23292996qvb.41.1545259437865;
        Wed, 19 Dec 2018 14:43:57 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.2])
        by smtp.gmail.com with ESMTPSA id 83sm3524638qkz.73.2018.12.19.14.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 14:43:57 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] blkcg: remove unused __blkg_release_rcu()
Date:   Wed, 19 Dec 2018 16:43:53 -0600
Message-Id: <20181219224353.32763-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

An earlier commit 7fcf2b033b84 ("blkcg: change blkg reference counting
to use percpu_ref") moved around the release call from blkg_put() to be
a part of the percpu_ref cleanup. Remove the additional unused code
which should have been removed earlier.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 block/blk-cgroup.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c8cc1cbb6370..2bed5725aa03 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -438,29 +438,6 @@ static void blkg_destroy_all(struct request_queue *q)
 	spin_unlock_irq(&q->queue_lock);
 }
 
-/*
- * A group is RCU protected, but having an rcu lock does not mean that one
- * can access all the fields of blkg and assume these are valid.  For
- * example, don't try to follow throtl_data and request queue links.
- *
- * Having a reference to blkg under an rcu allows accesses to only values
- * local to groups like group stats and group rate limits.
- */
-void __blkg_release_rcu(struct rcu_head *rcu_head)
-{
-	struct blkcg_gq *blkg = container_of(rcu_head, struct blkcg_gq, rcu_head);
-
-	/* release the blkcg and parent blkg refs this blkg has been holding */
-	css_put(&blkg->blkcg->css);
-	if (blkg->parent)
-		blkg_put(blkg->parent);
-
-	wb_congested_put(blkg->wb_congested);
-
-	blkg_free(blkg);
-}
-EXPORT_SYMBOL_GPL(__blkg_release_rcu);
-
 static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			     struct cftype *cftype, u64 val)
 {
-- 
2.17.1

