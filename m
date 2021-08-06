Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752BFC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 08:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3B061165
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 08:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242353AbhHFIEB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242370AbhHFID6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Aug 2021 04:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628237022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gPHHs8MbH520QxIgjlPv9PCQ2p3YtdLkQzVBf2lnwQ=;
        b=jNauto3SMgfCFMhmtbLc7XsyQXfkzeGviZsTwWZXwO6BBPiw9yvq/Gw8qkYbR/N4nJnbea
        HlE/DKcrhV92tSq90bBDaUzVZx6P778NjZqWi1vJk8vGpwL4kIIUH94yAeCQz8C74PTj7G
        BJ190PrsBIZztMv396opDFVXzcKLBxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-bAVyXKMnOOe3KlkksB7QbQ-1; Fri, 06 Aug 2021 04:03:38 -0400
X-MC-Unique: bAVyXKMnOOe3KlkksB7QbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3601F804037;
        Fri,  6 Aug 2021 08:03:37 +0000 (UTC)
Received: from localhost (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C55A5D9DE;
        Fri,  6 Aug 2021 08:03:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH V4 1/7] mm: memcontrol: add helper of memcg_get_e_css
Date:   Fri,  6 Aug 2021 16:02:56 +0800
Message-Id: <20210806080302.298297-2-ming.lei@redhat.com>
In-Reply-To: <20210806080302.298297-1-ming.lei@redhat.com>
References: <20210806080302.298297-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

And helper of memcg_get_e_css() so that the consumer needn't to
call cgroup_get_e_css(cgroup, &memory_cgrp_subsys) directly, since
&memory_cgrp_subsys has to be used in case that MEMCG is enabled.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/memcontrol.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..741852addbd7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1101,6 +1101,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
+static inline
+struct cgroup_subsys_state *memcg_get_e_css(struct cgroup_subsys_state *css)
+{
+	return cgroup_get_e_css(css->cgroup, &memory_cgrp_subsys);
+}
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1456,6 +1461,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+static inline
+struct cgroup_subsys_state *memcg_get_e_css(struct cgroup_subsys_state *css)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
-- 
2.31.1

