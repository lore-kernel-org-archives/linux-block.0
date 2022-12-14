Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45311C4332F
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 02:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiLNCwd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 21:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiLNCwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 21:52:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93E22532
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 18:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670986290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYOjfeiBRlo83yXPXn1TZ8OQl1UZe5v7B1C1yln8/XY=;
        b=W4GYjbyu3o+FAp6/iO7b7tMJAVf3nLarRQVI5BwllOD7hByuMqz5Im3y8b3l/pdgaWUk6u
        0xRS2ROvDVZI22cW66wWgMY8UkRUI46eoAhAUbwltNT69eYWq0A/FuB8JnD2WOX1qGPKA+
        38w4G+SQFrUoH6a/zaHBJ0jICDHt1sM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-TswRycF3MN-7n1xDGsI2kQ-1; Tue, 13 Dec 2022 21:51:27 -0500
X-MC-Unique: TswRycF3MN-7n1xDGsI2kQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 787843832781;
        Wed, 14 Dec 2022 02:51:26 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6B51121314;
        Wed, 14 Dec 2022 02:51:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Dennis Zhou <dennis@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] lib/percpu-refcount: apply PERCPU_REF_AUTO_EXIT
Date:   Wed, 14 Dec 2022 10:51:00 +0800
Message-Id: <20221214025101.1268437-3-ming.lei@redhat.com>
In-Reply-To: <20221214025101.1268437-1-ming.lei@redhat.com>
References: <20221214025101.1268437-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Apply the added new flag of PERCPU_REF_AUTO_EXIT, so that users needn't
to call percpu_ref_exit() in ->release() any more.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
 mm/memcontrol.c                        | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 22d7ba05e9fe..07d1af3fad28 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -122,7 +122,6 @@ static inline void rtrs_srv_inflight_ref_release(struct percpu_ref *ref)
 						      struct rtrs_srv_path,
 						      ids_inflight_ref);
 
-	percpu_ref_exit(&srv_path->ids_inflight_ref);
 	complete(&srv_path->complete_done);
 }
 
@@ -147,7 +146,8 @@ static int rtrs_srv_alloc_ops_ids(struct rtrs_srv_path *srv_path)
 	}
 
 	ret = percpu_ref_init(&srv_path->ids_inflight_ref,
-			      rtrs_srv_inflight_ref_release, 0, GFP_KERNEL);
+			      rtrs_srv_inflight_ref_release,
+			      PERCPU_REF_AUTO_EXIT, GFP_KERNEL);
 	if (ret) {
 		pr_err("Percpu reference init failed\n");
 		goto err;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 266a1ab05434..eaca7d16b143 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -294,7 +294,6 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	list_del(&objcg->list);
 	spin_unlock_irqrestore(&objcg_lock, flags);
 
-	percpu_ref_exit(ref);
 	kfree_rcu(objcg, rcu);
 }
 
@@ -307,8 +306,8 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	if (!objcg)
 		return NULL;
 
-	ret = percpu_ref_init(&objcg->refcnt, obj_cgroup_release, 0,
-			      GFP_KERNEL);
+	ret = percpu_ref_init(&objcg->refcnt, obj_cgroup_release,
+			PERCPU_REF_AUTO_EXIT, GFP_KERNEL);
 	if (ret) {
 		kfree(objcg);
 		return NULL;
-- 
2.38.1

