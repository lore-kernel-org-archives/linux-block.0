Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B188EC433E9
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807C121D94
	for <linux-block@archiver.kernel.org>; Wed, 30 Dec 2020 00:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgL3Aep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 19:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgL3Aeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 19:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L655SkM+WbIqVs4mTheDHWzwhYB5oaZbWXpdwXtduMM=;
        b=Zxl0zTQ9cV5+mlhMwDZhFmk4nK6IzHOK/iHhoYtGlunYhk8Kf8GdmB3YagiPG6FzrevAIQ
        9ghqf3H1XxaKeBRGxdCydwPhbT6v9mtI4wHier2zeXw3NFwTFR6I025wGxgZFnu5EowA9x
        uOd53iHb77gIcbOmMqA9EHWBUN6Ha2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-U0CwkETmMbCxYqjbUTDX0Q-1; Tue, 29 Dec 2020 19:33:17 -0500
X-MC-Unique: U0CwkETmMbCxYqjbUTDX0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D605D180A08A;
        Wed, 30 Dec 2020 00:33:15 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2061010013C1;
        Wed, 30 Dec 2020 00:33:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/6] block: don't pass BIOSET_NEED_BVECS for q->bio_split
Date:   Wed, 30 Dec 2020 08:32:51 +0800
Message-Id: <20201230003255.3450874-3-ming.lei@redhat.com>
In-Reply-To: <20201230003255.3450874-1-ming.lei@redhat.com>
References: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->bio_split is only used by bio_split() for fast cloning bio, and no
need to allocate bvecs, so remove this flag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 96e5fcd7f071..3480ca037d3f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -530,7 +530,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (q->id < 0)
 		goto fail_q;
 
-	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (ret)
 		goto fail_id;
 
-- 
2.28.0

