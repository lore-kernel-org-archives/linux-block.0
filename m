Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8971FC433DB
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 12:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C2F229C5
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 12:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbhAEMny (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728532AbhAEMnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jan 2021 07:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609850547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5K5X/RaZpT+CgPadRJDATcqPMVFDQG1b7rxg/tR3lQ=;
        b=B37S3T+YYPrihJ2bpZo2IOAUTm7yO7J1mVJae8imMvf0Bm093wAmmTktXr+XS3CYc4Ilrq
        5+LziJ8OG0C47FU+XF8j0u1N0p0mFDG3paPdVqQTdx7FC7VHmNfNZ8s43Fw7s9+XwN+Eb/
        1z4JfHa/j+znRUynWyg0c+RO3DHd98U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-HlP-pOcvNn-fbXNJD5RLsw-1; Tue, 05 Jan 2021 07:42:25 -0500
X-MC-Unique: HlP-pOcvNn-fbXNJD5RLsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8C46802B48;
        Tue,  5 Jan 2021 12:42:24 +0000 (UTC)
Received: from localhost (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD9D05D6CF;
        Tue,  5 Jan 2021 12:42:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/6] block: don't pass BIOSET_NEED_BVECS for q->bio_split
Date:   Tue,  5 Jan 2021 20:41:59 +0800
Message-Id: <20210105124203.3726599-3-ming.lei@redhat.com>
In-Reply-To: <20210105124203.3726599-1-ming.lei@redhat.com>
References: <20210105124203.3726599-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->bio_split is only used by bio_split() for fast cloning bio, and no
need to allocate bvecs, so remove this flag.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7663a9b94b80..00d415be74e6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -531,7 +531,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (q->id < 0)
 		goto fail_q;
 
-	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (ret)
 		goto fail_id;
 
-- 
2.28.0

