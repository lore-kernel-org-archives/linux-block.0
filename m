Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73BAC43334
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 13:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiFBNf7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiFBNf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 09:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 006446C57A
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654176956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIFIquhWxRW8zi5j5Mk86JmeILvcLaTEEhtXEaVuk6Y=;
        b=NRlfiKmLt790STaLwm29z5ceYJieJ2R+lvwu1polF39QbGM/yIntolBkr31d5ncOcFU4FM
        qqkAnLStA+qi03bAKOyORE7idI75NE0eKbSc+GOUv5FczYNCcYkMgUibiuPcsMwYUTrd0i
        k2N5aB4fX+dKHjVCUQh9BCCEjY8hf+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-wyNoR1d5PEaXsdclR8ldVg-1; Thu, 02 Jun 2022 09:35:53 -0400
X-MC-Unique: wyNoR1d5PEaXsdclR8ldVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81A21811E75;
        Thu,  2 Jun 2022 13:35:52 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC8E2166B26;
        Thu,  2 Jun 2022 13:35:52 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 2/3] blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
Date:   Thu,  2 Jun 2022 09:35:42 -0400
Message-Id: <20220602133543.128088-3-longman@redhat.com>
In-Reply-To: <20220601211824.89626-1-longman@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For blkcg_css_alloc(), the only error that will be returned is -ENOMEM.
Simplify error handling code by returning this error directly instead
of setting an intermediate "ret" variable.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index acd9b0aa8dc8..9021f75fc752 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1177,7 +1177,6 @@ static struct cgroup_subsys_state *
 blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct blkcg *blkcg;
-	struct cgroup_subsys_state *ret;
 	int i;
 
 	mutex_lock(&blkcg_pol_mutex);
@@ -1186,10 +1185,8 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		blkcg = &blkcg_root;
 	} else {
 		blkcg = kzalloc(sizeof(*blkcg), GFP_KERNEL);
-		if (!blkcg) {
-			ret = ERR_PTR(-ENOMEM);
+		if (!blkcg)
 			goto unlock;
-		}
 	}
 
 	for (i = 0; i < BLKCG_MAX_POLS ; i++) {
@@ -1206,10 +1203,9 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 			continue;
 
 		cpd = pol->cpd_alloc_fn(GFP_KERNEL);
-		if (!cpd) {
-			ret = ERR_PTR(-ENOMEM);
+		if (!cpd)
 			goto free_pd_blkcg;
-		}
+
 		blkcg->cpd[i] = cpd;
 		cpd->blkcg = blkcg;
 		cpd->plid = i;
@@ -1238,7 +1234,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		kfree(blkcg);
 unlock:
 	mutex_unlock(&blkcg_pol_mutex);
-	return ret;
+	return ERR_PTR(-ENOMEM);
 }
 
 static int blkcg_css_online(struct cgroup_subsys_state *css)
-- 
2.31.1

