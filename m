Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B6C31E49
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 22:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092B121721
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560465071;
	bh=n4TBcWceCnhEJTEHhRL/pEG5SXwLENizO5kYs405jXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WtWfm0pb0u81HkFMr6Qop04WfRhETOeJXksiT2f1eHitmAur3RCfvsVO4Qt7UmDic
	 iAbh98TkhrFdsvAk5jfDHLmvd/9Y+ExYAHI9hNWzag5ka4sj6tUOBm77Sh6NoxEPwd
	 A46duvom7Ov9xCwT65ivZx7eCYhsUJVCHpdVGmqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfFMWa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:30:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47091 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFMWaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 18:30:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so290548pgr.13;
        Thu, 13 Jun 2019 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ATSPMY1LycdMuuen2+FGO8unSu2r280Z+V2tABkqPms=;
        b=jd4bLITKkEvMA8EMVkFOd9Ei4BxXWQzDCuwF62Q8ZBCnX0Mk2AgZ6mXhMpphlt5gai
         9+m+18b0dpK42LncKcfIVTRr+OZXfr6RjfPx78oCyVZpJ0ZuDU6vU38kEnzVHTD/M+Td
         b+7Qx8HWfW4ETnpyfylVcf/RWC0pTQKEUb25HfUhhntRDuLMzbmfvLKuHhxS5dSSmLnX
         lpxAicyhV8QJWZ5lQU19bkCDYaxIftr5AJM2U4pitEmiZwd2HRnQrP3559QxCwNF/3UM
         EeDu1oZRlfb0V4Mk380crYwB2gp6EJV86S1vmrpT0DwW/PvbHGGGN9EF8dFIIp17KpDq
         IoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ATSPMY1LycdMuuen2+FGO8unSu2r280Z+V2tABkqPms=;
        b=KTxa2AEtvxL/VtWHYOl2CsDfZ3z91dZrsB3VcE7l6EBV3b37zdnX/boZKnO18EvMUP
         3nBSbXegO4lC6hoek/MlhYYMRGbrpFm+RuMyHs+vYk/fzHtrqKox5abV42kOVvsJtQ7G
         TwYIdrAGFAA6Mvlv9Zcg92Vggq+dKMNxK/15vbHxVbUCudGQmpGUmUomuBXyy84/q+KP
         5ObDnGLC54p4Ms/DglytCZc9uUiIASSQBxl6g5RIj9eWRn8HkTn+UNWjOIyIfPer9wLd
         Iu6MJzJMI/NklH7GrKY23bOlfFXdoY8Y/RpsjfuY1stfbQ+FzeLU1MtQxxKpRnp25uN7
         hirA==
X-Gm-Message-State: APjAAAUa1LqtCj6e/sK77aTZaV5/JztOc0VA3CmWzE8cVgwLlU/mbxH8
        QFz6XW8fDfDJz1hEGh8XUbbA/F9u
X-Google-Smtp-Source: APXvYqyK2zbQUJL2C2z9RaburcdsweakiappBQN09wYA5twY4SnBy5L+EqyxVwbbPtSjyAmS/XOxxQ==
X-Received: by 2002:a63:fc61:: with SMTP id r33mr32782404pgk.294.1560465054306;
        Thu, 13 Jun 2019 15:30:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id f3sm740516pjo.31.2019.06.13.15.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 15:30:53 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jbacik@fb.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, dennis@kernel.org, jack@suse.cz,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] blkcg: perpcu_ref init/exit should be done from blkg_alloc/free()
Date:   Thu, 13 Jun 2019 15:30:39 -0700
Message-Id: <20190613223041.606735-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613223041.606735-1-tj@kernel.org>
References: <20190613223041.606735-1-tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkg alloc is performed as a separate step from the rest of blkg
creation so that GFP_KERNEL allocations can be used when creating
blkgs from configuration file writes because otherwise user actions
may fail due to failures of opportunistic GFP_NOWAIT allocations.

While making blkgs use percpu_ref, 7fcf2b033b84 ("blkcg: change blkg
reference counting to use percpu_ref") incorrectly added unconditional
opportunistic percpu_ref_init() to blkg_create() breaking this
guarantee.

This patch moves percpu_ref_init() to blkg_alloc() so makes it use
@gfp_mask that blkg_alloc() is called with.  Also, percpu_ref_exit()
is moved to blkg_free() for consistency.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 7fcf2b033b84 ("blkcg: change blkg reference counting to use percpu_ref")
Cc: Dennis Zhou <dennis@kernel.org>
---
 block/blk-cgroup.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e4715b35d42c..04d286934c5e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -79,6 +79,7 @@ static void blkg_free(struct blkcg_gq *blkg)
 
 	blkg_rwstat_exit(&blkg->stat_ios);
 	blkg_rwstat_exit(&blkg->stat_bytes);
+	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
 }
 
@@ -86,8 +87,6 @@ static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
 
-	percpu_ref_exit(&blkg->refcnt);
-
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
 	if (blkg->parent)
@@ -132,6 +131,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	if (!blkg)
 		return NULL;
 
+	if (percpu_ref_init(&blkg->refcnt, blkg_release, 0, gfp_mask))
+		goto err_free;
+
 	if (blkg_rwstat_init(&blkg->stat_bytes, gfp_mask) ||
 	    blkg_rwstat_init(&blkg->stat_ios, gfp_mask))
 		goto err_free;
@@ -244,11 +246,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		blkg_get(blkg->parent);
 	}
 
-	ret = percpu_ref_init(&blkg->refcnt, blkg_release, 0,
-			      GFP_NOWAIT | __GFP_NOWARN);
-	if (ret)
-		goto err_cancel_ref;
-
 	/* invoke per-policy init */
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -281,8 +278,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
-err_cancel_ref:
-	percpu_ref_exit(&blkg->refcnt);
 err_put_congested:
 	wb_congested_put(wb_congested);
 err_put_css:
-- 
2.17.1

