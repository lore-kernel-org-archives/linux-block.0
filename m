Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3052AC10F1B
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 22:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiLHWEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 17:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiLHWD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 17:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F880A20
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670536917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3VQJPU/3HC+t8N1wzyewiUON5nIdBJkilNRlkYPV+o=;
        b=C46WpCFE2tlO/WF/+cF40ha66UDto72z7/HTjk+EPgMybEZfyNNHi49NJVsreYE3uHtYux
        xT1yAB0lWotXbYmCy9B4cWAzawXWRJfcA3Y6DhQY7k7in+INB/P52Sv57sCEqJyKCjISty
        NP7dz0JJb9oSvyCeKnX/gTuDSAPjNn8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-RBCKYMz_NCKOObEEZe_ADg-1; Thu, 08 Dec 2022 17:01:52 -0500
X-MC-Unique: RBCKYMz_NCKOObEEZe_ADg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE113806001;
        Thu,  8 Dec 2022 22:01:51 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6968842222;
        Thu,  8 Dec 2022 22:01:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-block 2/3] blk-cgroup: Don't flush a blkg if destroyed
Date:   Thu,  8 Dec 2022 17:01:40 -0500
Message-Id: <20221208220141.2625775-3-longman@redhat.com>
In-Reply-To: <20221208220141.2625775-1-longman@redhat.com>
References: <20221208220141.2625775-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
blkg's stats is only flushed if they are online. In addition, the
stat flushing of blkgs in blkcg_rstat_flush() includes propagating
the rstat data to its parent. However, if a blkg has been destroyed
(offline), the validity of its parent may be questionable. For safety,
revert back to the old behavior by ignoring offline blkg's.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 21cc88349f21..c466aef0d467 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -885,6 +885,12 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 		WRITE_ONCE(bisc->lqueued, false);
 
+		/* Don't flush its stats if blkg is offline */
+		if (unlikely(!blkg->online)) {
+			percpu_ref_put(&blkg->refcnt);
+			continue;
+		}
+
 		/* fetch the current per-cpu values */
 		do {
 			seq = u64_stats_fetch_begin(&bisc->sync);
-- 
2.31.1

