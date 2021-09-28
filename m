Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFD6C433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA36611C7
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhI1A6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238425AbhI1A6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 20:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632790584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBx6waBIZNJVbIvGd2j8SwTPGTcFkECh8iFDNjjSiFA=;
        b=Tv8tA6c0uWwkatCfDpsrufgva4vRuiY4BLASml7YUYsu1JFQSn6sGniiixOg2lo6+htZi3
        S76grmmfwOBQep3WTlP17DXMVA6E0kIQkoTfU2x42YKapE/lOsYQH0+earOCW4+crMYbIn
        dwjPoxQw36j47WNG58Hg9S2JFRDP+t8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-cBktqAetPF-2RL9C6pTOSA-1; Mon, 27 Sep 2021 20:56:23 -0400
X-MC-Unique: cBktqAetPF-2RL9C6pTOSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2702A3FAB;
        Tue, 28 Sep 2021 00:56:22 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB5A15E255;
        Tue, 28 Sep 2021 00:56:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/7] genirq/affinity: remove the 'firstvec' parameter from irq_build_affinity_masks
Date:   Tue, 28 Sep 2021 08:55:52 +0800
Message-Id: <20210928005558.243352-2-ming.lei@redhat.com>
In-Reply-To: <20210928005558.243352-1-ming.lei@redhat.com>
References: <20210928005558.243352-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'firstvec' parameter is always same with the parameter of
'startvec', so use 'startvec' directly inside irq_build_affinity_masks().

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

