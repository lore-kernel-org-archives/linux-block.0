Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D338ACCA473
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 21:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiFAVSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFAVSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 17:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA7486EB34
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654118318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXLuT1Yk9DAXTYl5NoX/oMeS35ik4rQo8uu3jun7bK8=;
        b=GsjHjqI+bbWkfkmBN4bHlWdaZxIn6D8Y9xpiYrxyi3Ko28vFjG/Z+E+jmIIzlCp1hW32gT
        Ck5N0cCYg65eDxUdP3Kn1n981/g+vwi3gApvNu6zuWYWAHNK0nmo4V7jjlwGE+R05kF4W5
        KB6N7Mu1XbX9n+QApsMwCEp1Vz8qCn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-zPI8cbarPQGIcchXo8gl-A-1; Wed, 01 Jun 2022 17:18:37 -0400
X-MC-Unique: zPI8cbarPQGIcchXo8gl-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EE8880159B;
        Wed,  1 Jun 2022 21:18:37 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8C91406AD49;
        Wed,  1 Jun 2022 21:18:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 1/2] blk-cgroup: Correctly free percpu iostat_cpu in blkg on error exit
Date:   Wed,  1 Jun 2022 17:18:23 -0400
Message-Id: <20220601211824.89626-2-longman@redhat.com>
In-Reply-To: <20220601211824.89626-1-longman@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup
rstat") changes block cgroup IO stats to use the rstat APIs. It added
a new percpu iostat_cpu field into blkg. The blkg_alloc() was modified
to allocate the new percpu iostat_cpu but didn't free it when an error
happened. Fix this by freeing the percpu iostat_cpu on error exit.

Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 40161a3f68d0..acd9b0aa8dc8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -219,11 +219,11 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 		return NULL;
 
 	if (percpu_ref_init(&blkg->refcnt, blkg_release, 0, gfp_mask))
-		goto err_free;
+		goto err_free_blkg;
 
 	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
 	if (!blkg->iostat_cpu)
-		goto err_free;
+		goto err_free_blkg;
 
 	if (!blk_get_queue(q))
 		goto err_free;
@@ -259,6 +259,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	return blkg;
 
 err_free:
+	free_percpu(blkg->iostat_cpu);
+
+err_free_blkg:
 	blkg_free(blkg);
 	return NULL;
 }
-- 
2.31.1

