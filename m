Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBECC433E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 02:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EB021775
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 02:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i60spSY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgJNCqW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 22:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727373AbgJNCqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 22:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602643581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=EHiTeL5M4ChyyQvTM24QJ3ZdvVQg+RJ4DomUC+fe9jU=;
        b=i60spSY1U12Q8oC/oKPDnV8DIaxD4G2d9P+U1Lti9013lvfQWjoCclErO0Mf9cT1YE3FWq
        xqwsZU000VzaGvjEf3T+gJl3Rs2maucM6V0n34knHVwFbanFrA3PRSz7ly9lYnFAKh7YDN
        82VX/BGhMKWhhq0LXeksRJK7bO5ZL6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-yETc-PgbNcqyr3qPfzFppA-1; Tue, 13 Oct 2020 22:46:19 -0400
X-MC-Unique: yETc-PgbNcqyr3qPfzFppA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4148218C35A8;
        Wed, 14 Oct 2020 02:46:17 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-120.gsslab.pek2.redhat.com [10.72.37.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 676C760C07;
        Wed, 14 Oct 2020 02:46:15 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] nbd: make the config put is called before the notifying the waiter
Date:   Tue, 13 Oct 2020 22:45:14 -0400
Message-Id: <20201014024514.112822-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

There has one race case for ceph's rbd-nbd tool. When do mapping
it may fail with EBUSY from ioctl(nbd, NBD_DO_IT), but actually
the nbd device has already unmaped.

It dues to if just after the wake_up(), the recv_work() is scheduled
out and defers calling the nbd_config_put(), though the map process
has exited the "nbd->recv_task" is not cleared.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index edf8b632e3d2..f46e26c9d9b3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -801,9 +801,9 @@ static void recv_work(struct work_struct *work)
 		if (likely(!blk_should_fake_timeout(rq->q)))
 			blk_mq_complete_request(rq);
 	}
+	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
-	nbd_config_put(nbd);
 	kfree(args);
 }
 
-- 
2.18.4

