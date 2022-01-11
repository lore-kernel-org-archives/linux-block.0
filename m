Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C001C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 11:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiAKL4t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:56:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239321AbiAKL4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 06:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641902208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rF5Blvd+F3+NeGbfb4YjwUVi4Snj3WyD6uxGjo96tdE=;
        b=iocu3jOxTiJiyu38CXAGY9FJpz70y057Mr5uCI2Ot2IH886UcM/Gj8v+g76uF7y2ZMFpJv
        tBuz7rspGQUIwoH8gcSMWSJrf/4u0V8rpA8vqi238BpJh8VAoV4tNmx0wkXIXkW08n2yyU
        uffnsyFc/POQYiAljO1MXepUs2O3MTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-gb_6Pw3VMcGimlyGk1NJsw-1; Tue, 11 Jan 2022 06:56:40 -0500
X-MC-Unique: gb_6Pw3VMcGimlyGk1NJsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB9FA185302A;
        Tue, 11 Jan 2022 11:56:36 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3CC176110;
        Tue, 11 Jan 2022 11:56:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 4/7] block: don't check bio in blk_throtl_dispatch_work_fn
Date:   Tue, 11 Jan 2022 19:55:29 +0800
Message-Id: <20220111115532.497117-5-ming.lei@redhat.com>
In-Reply-To: <20220111115532.497117-1-ming.lei@redhat.com>
References: <20220111115532.497117-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bio has been checks already before throttling, so no need to check
it again before dispatching it from throttle queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c462c006b26..8ba08425db06 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1219,7 +1219,7 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
 	if (!bio_list_empty(&bio_list_on_stack)) {
 		blk_start_plug(&plug);
 		while ((bio = bio_list_pop(&bio_list_on_stack)))
-			submit_bio_noacct(bio);
+			__submit_bio_noacct(bio, false);
 		blk_finish_plug(&plug);
 	}
 }
-- 
2.31.1

