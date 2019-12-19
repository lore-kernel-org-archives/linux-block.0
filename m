Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1863C2D0C1
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 14:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D48824672
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 14:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QphHCkA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLSOLI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:11:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbfLSOLH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 09:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576764666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=WlonMw7NFax0nq3q57rMGzI9C+PLmfR9Tn95zyh24xo=;
        b=QphHCkA6FsqZg/OMKTwyd1n1L7RYvevqM1PXvfKwcjLanX2VQ8+0IhMViHh2gKmXUrBvf0
        81BiIQT7870Q9f7eVjza8F4obyOxh/fkrMmg/8a3AAdGxJnWfCwYFWe7jRjC/oaT1fbNoF
        DLVw2d0VMa9H53ZJCiIbsdTXOqmtalU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-19niAshBOuuAqA1o5CJNVQ-1; Thu, 19 Dec 2019 09:11:03 -0500
X-MC-Unique: 19niAshBOuuAqA1o5CJNVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE6DD107ACC5;
        Thu, 19 Dec 2019 14:11:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-188.rdu2.redhat.com [10.10.121.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B16A10013A1;
        Thu, 19 Dec 2019 14:11:02 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, John Pittman <jpittman@redhat.com>
Subject: [PATCH] block: kyber: correct minor comment typo
Date:   Thu, 19 Dec 2019 09:10:59 -0500
Message-Id: <20191219141059.21908-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In kyber-iosched.c there is a minor typo in a comment regarding
the kyber_ctx_queue struct.  Correct the typo and make a couple
minor grammar adjustments.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 block/kyber-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 34dcea0ef637..02ed98a0217f 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -140,8 +140,8 @@ struct kyber_cpu_latency {
  */
 struct kyber_ctx_queue {
 	/*
-	 * Used to ensure operations on rq_list and kcq_map to be an atmoic one.
-	 * Also protect the rqs on rq_list when merge.
+	 * Used to ensure atomicity of operations on rq_list and kcq_map.
+	 * Also protect the rqs on rq_list during merge.
 	 */
 	spinlock_t lock;
 	struct list_head rq_list[KYBER_NUM_DOMAINS];
-- 
2.17.2

