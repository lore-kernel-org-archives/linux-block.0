Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E01C433B4
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 02:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6098F6108D
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 02:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhDACVD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 22:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233015AbhDACUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 22:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617243635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvWqpbllbfryEqZc6LAj0m2tPBHP2hi740lO6vs4L6U=;
        b=ek/o4I0Fub1bJ/zm+RyDJCdoeNMfH6gh1VkH+rulOFwXJ7OLTZfEUFeTCWsxHotEMUWcrr
        wDmEeQ/06Zzcu/DHdRpu3FCSAMPWbDGjchTUMsyqgOV3BRX+6ZYvbBeK/EKTH5Y5qr4QyJ
        eZBhcnvdLH5MHgTgtoX+iiE2Ea7r8gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-CadOyOHLMU6UyzmUKWuBOw-1; Wed, 31 Mar 2021 22:20:31 -0400
X-MC-Unique: CadOyOHLMU6UyzmUKWuBOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0078281744F;
        Thu,  1 Apr 2021 02:20:30 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E149B19C44;
        Thu,  1 Apr 2021 02:20:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 02/12] block: add one helper to free io_context
Date:   Thu,  1 Apr 2021 10:19:17 +0800
Message-Id: <20210401021927.343727-3-ming.lei@redhat.com>
In-Reply-To: <20210401021927.343727-1-ming.lei@redhat.com>
References: <20210401021927.343727-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for putting bio poll queue into io_context, so add one helper
for free io_context.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-ioc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 57299f860d41..b0cde18c4b8c 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -17,6 +17,11 @@
  */
 static struct kmem_cache *iocontext_cachep;
 
+static inline void free_io_context(struct io_context *ioc)
+{
+	kmem_cache_free(iocontext_cachep, ioc);
+}
+
 /**
  * get_io_context - increment reference count to io_context
  * @ioc: io_context to get
@@ -129,7 +134,7 @@ static void ioc_release_fn(struct work_struct *work)
 
 	spin_unlock_irq(&ioc->lock);
 
-	kmem_cache_free(iocontext_cachep, ioc);
+	free_io_context(ioc);
 }
 
 /**
@@ -164,7 +169,7 @@ void put_io_context(struct io_context *ioc)
 	}
 
 	if (free_ioc)
-		kmem_cache_free(iocontext_cachep, ioc);
+		free_io_context(ioc);
 }
 
 /**
@@ -278,7 +283,7 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
 	    (task == current || !(task->flags & PF_EXITING)))
 		task->io_context = ioc;
 	else
-		kmem_cache_free(iocontext_cachep, ioc);
+		free_io_context(ioc);
 
 	ret = task->io_context ? 0 : -EBUSY;
 
-- 
2.29.2

