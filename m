Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8624DC4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679D760F36
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 12:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbhHNMhI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 08:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238496AbhHNMg6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 08:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628944590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkVnOqhWBDK86TEgwnT4AMVMZ/AmzLG4Gwzg6EJEcmQ=;
        b=OF/AsOIZQrgrdv6K9SY+VkhVbuflv79Omfzg0Gn0SBZeZg/EiQq1HpdcfEjRg365BbW5Bt
        zA+bjsiLxExZBREu4+a4lY0vMx/Z6BhDS0mFGcya9sytQpCCWtyIEzIEGiTUlSLygYamu3
        rZRbY/dFBDyDt0LPrQKEI3KszG42zuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-6dwPMSAmN7i1KmCeIk3Q7A-1; Sat, 14 Aug 2021 08:36:29 -0400
X-MC-Unique: 6dwPMSAmN7i1KmCeIk3Q7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B051818B613F;
        Sat, 14 Aug 2021 12:36:27 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CEC610372D0;
        Sat, 14 Aug 2021 12:36:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/7] lib/group_cpus: allow to group cpus in case of !CONFIG_SMP
Date:   Sat, 14 Aug 2021 20:35:31 +0800
Message-Id: <20210814123532.229494-7-ming.lei@redhat.com>
In-Reply-To: <20210814123532.229494-1-ming.lei@redhat.com>
References: <20210814123532.229494-1-ming.lei@redhat.com>
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

