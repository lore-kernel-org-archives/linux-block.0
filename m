Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF1AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3ABE61260
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbhI1A6j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238454AbhI1A6h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 20:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632790618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2bS5vXfZioW/ha8BY5Ib70bYqfF2A57K9G9K5QgSkM=;
        b=OJ7KxVoTe7dDMQJM8CIgbRWz3+vpWvk9j/1lvXs7fo3bT8c9JwvtWPTzTCIO7/MaLqaDwa
        3eqYr8/Ens7bOKQ7Jv2N3Si71yJQDS81KnpjM258xHmhyTqFjAQ3+3ArJXD/AGu1eaKRD0
        Vb8Lt5mNNM/fn8e4xSQ0jQmQl2Y3he0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-fDW32QO7NN2d2JbZATkwiw-1; Mon, 27 Sep 2021 20:56:55 -0400
X-MC-Unique: fDW32QO7NN2d2JbZATkwiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28318108087A;
        Tue, 28 Sep 2021 00:56:54 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B038160C13;
        Tue, 28 Sep 2021 00:56:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 6/7] lib/group_cpus: allow to group cpus in case of !CONFIG_SMP
Date:   Tue, 28 Sep 2021 08:55:57 +0800
Message-Id: <20210928005558.243352-7-ming.lei@redhat.com>
In-Reply-To: <20210928005558.243352-1-ming.lei@redhat.com>
References: <20210928005558.243352-1-ming.lei@redhat.com>
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
 lib/Makefile     |  2 +-
 lib/group_cpus.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index ff1cbe4958a1..3dbdc7f01215 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -338,7 +338,7 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
 
 obj-$(CONFIG_PARMAN) += parman.o
 
-obj-$(CONFIG_SMP) += group_cpus.o
+obj-y += group_cpus.o
 
 # GCC library routines
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
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

