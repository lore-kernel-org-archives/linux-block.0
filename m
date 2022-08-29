Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A37ECAAA2
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 04:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiH2EAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Aug 2022 00:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH2EAa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 00:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525EAA44F
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 21:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661745628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eQVsuwgc8uXKILvzGyvbWtTjg/syLvD78qexD18++Io=;
        b=ZKD7gDiQXkPVR020BNzew7J+NWO3RT+R1BLOkhRQ9yhck2M4l4GElfps+SlGczumjxHUJO
        MIEIvGFdSIM9cXFKlDE/1xWpLv0DuWqN1b2+IpaCa3bU3z+Y9n7HuxEuGHNSY3nBEi9d6k
        6ezxV/ZPH/RkJEnyooWDXFl0GhXlBGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-MGX3IdgNPZqK4dLJHzLY1A-1; Mon, 29 Aug 2022 00:00:21 -0400
X-MC-Unique: MGX3IdgNPZqK4dLJHzLY1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4935185A7B2;
        Mon, 29 Aug 2022 04:00:20 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0001E1121314;
        Mon, 29 Aug 2022 04:00:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] kernel: export task_work_add
Date:   Mon, 29 Aug 2022 12:00:13 +0800
Message-Id: <20220829040013.549212-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Firstly task_work_add() is used in several drivers. In ublk driver's
usage, request batching submission can only be applied with task_work_add,
and usually get better IOPS.

Secondly from this API's definition, the added work is always run in
the task context, and when task is exiting, either the work is rejected
to be added, or drained in do_exit(). In this way, not see obvious
disadvantage or potential issue by exporting it for module's usage.

So export it, then ublk driver can get simplified, meantime with better
performance.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/task_work.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index dff75bcde151..5f9a42a388f1 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -73,6 +73,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(task_work_add);
 
 /**
  * task_work_cancel_match - cancel a pending work added by task_work_add()
-- 
2.31.1

