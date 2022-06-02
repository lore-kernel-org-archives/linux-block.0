Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7912C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 18:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiFBSy1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbiFBSyY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 14:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBA731339C4
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654196056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1q/cIPahB7x9FEDPxFfUSaoR08YIuoc7nswOzy1p8SY=;
        b=Luj8ZxFf0vow/vAZnUf3eU2xLEUMQX4aAvMG1DLTWcb+lcBu537tDTYr+61Z0ViPiAIS+k
        i4at7hVouAbpzddEkJbJdX1e8rYZcA3qihIkvN5YmtoeoMXGf7/Mncxs4HUvT+A3VupVJp
        aKU+1kBTtISTTZaDHI49xGe20w7N2bs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-HDguoosZNKaZD2O6D2Drww-1; Thu, 02 Jun 2022 14:54:14 -0400
X-MC-Unique: HDguoosZNKaZD2O6D2Drww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FB43101043B;
        Thu,  2 Jun 2022 18:54:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 325581121314;
        Thu,  2 Jun 2022 18:54:14 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 4/4] blk-cgroup: Document the design of new lockless iostat_cpu list
Date:   Thu,  2 Jun 2022 14:54:01 -0400
Message-Id: <20220602185401.162937-1-longman@redhat.com>
In-Reply-To: <20220602133543.128088-2-longman@redhat.com>
References: <20220602133543.128088-2-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A set of percpu lockless lists per block cgroup (blkcg) is added to
track the set of recently updated iostat_cpu structures. Add comment
in the code to document the design of this new set of lockless lists.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8af97f3b2fc9..f8f27551c16a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -60,6 +60,21 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
 #define BLKG_DESTROY_BATCH_SIZE  64
 
 /*
+ * Lockless lists for tracking IO stats update
+ *
+ * New IO stats are stored in the percpu iostat_cpu within blkcg_gq (blkg).
+ * There are multiple blkg's (one for each block device) attached to each
+ * blkcg. The rstat code keeps track of which cpu has IO stats updated,
+ * but it doesn't know which blkg has the updated stats. If there are many
+ * block devices in a system, the cost of iterating all the blkg's to flush
+ * out the IO stats can be high. To reduce such overhead, a set of percpu
+ * lockless lists (lhead) per blkcg are used to track the set of recently
+ * updated iostat_cpu's since the last flush. An iostat_cpu will be put
+ * onto the lockless list on the update side [blk_cgroup_bio_start()] if
+ * not there yet and then removed when being flushed [blkcg_rstat_flush()].
+ * References to blkg are gotten and then put back in the process to
+ * protect against blkg removal.
+ *
  * lnode.next of the last entry in a lockless list is NULL. To enable us to
  * use lnode.next as a boolean flag to indicate its presence in a lockless
  * list, we have to make it non-NULL for all. This is done by using a
-- 
2.31.1

