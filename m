Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21205C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E989E60F39
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhHRJfK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232979AbhHRJ3p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 05:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629278945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tok9wTM/eOgd5G8LxY5ZsW25iRLAwauiPNkTN03s15Y=;
        b=XVgPNxO8j+1/FD012+rLlBQ6v27+LfHNWcfs7me/mW5zVyHqT4lDpsO0/037Cw4r+J47Iw
        gc7P4bKT9ILiQSkP+aUgDtjaiBtj54gy6pwl4h5kWdXahq8HKLam9lCm0hluc26HMAWkd0
        YQc+hS/GkhnOUCLZxHdMRW2pzZW0/2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-w4lvWBeeOgWcGsdZJ1-FiQ-1; Wed, 18 Aug 2021 05:29:04 -0400
X-MC-Unique: w4lvWBeeOgWcGsdZJ1-FiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05CBA18C89CC;
        Wed, 18 Aug 2021 09:29:03 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00978100EB3D;
        Wed, 18 Aug 2021 09:29:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 6/7] lib/group_cpus: allow to group cpus in case of !CONFIG_SMP
Date:   Wed, 18 Aug 2021 17:28:11 +0800
Message-Id: <20210818092812.787558-7-ming.lei@redhat.com>
In-Reply-To: <20210818092812.787558-1-ming.lei@redhat.com>
References: <20210818092812.787558-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allows group_cpus_evenly() to be called in case of !CONFIG_SMP by simply
assigning all CPUs into the 1st group.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/group_cpus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index f7165b38c9d0..b34f7d309f9c 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -327,6 +327,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	return done;
 }
 
+#ifdef CONFIG_SMP
 /**
  * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
  * @numgrps: number of groups
@@ -411,4 +412,17 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	}
 	return masks;
 }
+#else
+struct cpumask *group_cpus_evenly(unsigned int numgrps)
+{
+	struct cpumask *masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+
+	if (!masks)
+		return NULL;
+
+	/* assign all CPUs(cpu 0) to the 1st group only */
+	cpumask_copy(&masks[0], cpu_possible_mask);
+	return masks;
+}
+#endif
 EXPORT_SYMBOL_GPL(group_cpus_evenly);
-- 
2.31.1

