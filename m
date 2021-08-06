Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549F6C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 02:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C084611C2
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 02:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhHFCfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 22:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238326AbhHFCfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Aug 2021 22:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628217286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaHhZdld2uT9t1jzd/55yboqLAJcBICUO4soO6lmV0I=;
        b=b3YtCZR7inrLCEPHNktiNywwE4xLRQp01ZodLHNXo2Eu6eub9RP6gGOIDi/96cLPV9ulbT
        CIKvasPuXeTaoJboOh+gmn0x7KyZ29ZT6B7+peFFHNyJsJS1JyT6uUkJoJnGubhVaMJir/
        hr6ahgCDxLPH90dkR3FnNW+79Bj49lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-m0Gn-IuIOg6eCZjdURwqtQ-1; Thu, 05 Aug 2021 22:34:44 -0400
X-MC-Unique: m0Gn-IuIOg6eCZjdURwqtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67BA7871803;
        Fri,  6 Aug 2021 02:34:43 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 258445C1B4;
        Fri,  6 Aug 2021 02:34:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH V3 1/7] mm: memcontrol: add helper of memcg_get_e_css
Date:   Fri,  6 Aug 2021 10:34:17 +0800
Message-Id: <20210806023423.131060-2-ming.lei@redhat.com>
In-Reply-To: <20210806023423.131060-1-ming.lei@redhat.com>
References: <20210806023423.131060-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

And helper of memcg_get_e_css() so that the consumer needn't to
call cgroup_get_e_css(cgroup, &memory_cgrp_subsys) directly, since
&memory_cgrp_subsys has to be used in case that MEMCG is enabled.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/memcontrol.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..67c35793fdce 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1101,6 +1101,10 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
+static inline struct cgroup_subsys_state *memcg_get_e_css(struct cgroup *cgrp)
+{
+	return cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
+}
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1456,6 +1460,10 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+static inline struct cgroup_subsys_state *memcg_get_e_css(struct cgroup *cgrp)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
-- 
2.31.1

