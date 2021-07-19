Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D833DC636C9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB6161182
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhGSJRs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 05:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236177AbhGSJRr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 05:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626688707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkVnOqhWBDK86TEgwnT4AMVMZ/AmzLG4Gwzg6EJEcmQ=;
        b=exvuA7SLy1HEGbKgVC1JSOpFYXdsOgi33FGALWdEvrpElpAfIlx8YBJl8Cgy9Z6g0yse+r
        A5sLyIvK8fmIkxkYGutDtW4T2GGTLFHjkpFd3GDnnduiJClxJB9kqXn2YlXXh2hbm/+gk4
        qadOHY1QQnGGEtkmV+okGeL9BOru7NU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-D4-NEdTWOj6oDMywRkGLRQ-1; Mon, 19 Jul 2021 05:58:23 -0400
X-MC-Unique: D4-NEdTWOj6oDMywRkGLRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D70B100C612;
        Mon, 19 Jul 2021 09:58:22 +0000 (UTC)
Received: from localhost (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3368060E1C;
        Mon, 19 Jul 2021 09:58:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 6/7] lib/group_cpus: allow to group cpus in case of !CONFIG_SMP
Date:   Mon, 19 Jul 2021 17:57:28 +0800
Message-Id: <20210719095729.834332-7-ming.lei@redhat.com>
In-Reply-To: <20210719095729.834332-1-ming.lei@redhat.com>
References: <20210719095729.834332-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allows group_cpus_evenly() to be called in case of !CONFIG_SMP by simply
assigning all CPUs into the 1st group.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/group_cpus.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
index e42807ec61f6..79e5cc15bd96 100644
--- a/include/linux/group_cpus.h
+++ b/include/linux/group_cpus.h
@@ -9,6 +9,20 @@
 #include <linux/kernel.h>
 #include <linux/cpu.h>
 
+#ifdef CONFIG_SMP
 struct cpumask *group_cpus_evenly(unsigned int numgrps);
+#else
+static inline struct cpumask *group_cpus_evenly(unsigned int numgrps)
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
 
 #endif
-- 
2.31.1

