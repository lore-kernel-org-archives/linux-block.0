Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B67C4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 12:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3AB60F00
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 12:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbhHNMgZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 08:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234030AbhHNMgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 08:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628944556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0LQ6rWqTTuwFhPm/Zv527LH1J+bxCy6taa5DtK8apw=;
        b=goSR6a65O+c3ZO0vNhNBv/Vb5G576Zpn245cu/mnP2B96lu0EI8aC9AdOL9VIsUMgkkxxZ
        ITx6mHZ5GsPqsx2fMG3csjLVBYEM2a6VXWr6+d4UHYxhXYVukF5u1PEgX8f+cnxYkdZMjp
        EIXEBRNWBJcLGNSCsXCflN/caLYSB+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-mKVvREj5NUCxQnI6Q6qesw-1; Sat, 14 Aug 2021 08:35:54 -0400
X-MC-Unique: mKVvREj5NUCxQnI6Q6qesw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9D1D8799EC;
        Sat, 14 Aug 2021 12:35:53 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ABD327CA2;
        Sat, 14 Aug 2021 12:35:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/7] genirq/affinity: remove the 'firstvec' parameter from irq_build_affinity_masks
Date:   Sat, 14 Aug 2021 20:35:26 +0800
Message-Id: <20210814123532.229494-2-ming.lei@redhat.com>
In-Reply-To: <20210814123532.229494-1-ming.lei@redhat.com>
References: <20210814123532.229494-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'firstvec' parameter is always same with the parameter of
'startvec', so use 'startvec' directly inside irq_build_affinity_masks().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f7ff8919dc9b..856ab6d39c05 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -336,10 +336,10 @@ static int __irq_build_affinity_masks(unsigned int startvec,
  *	2) spread other possible CPUs on these vectors
  */
 static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
-				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
 	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
+	unsigned int firstvec = startvec;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -462,8 +462,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(curvec, this_vecs,
-					       curvec, masks);
+		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;
-- 
2.31.1

