Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC2C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 11:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA04C61BF4
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 11:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhKQL7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233746AbhKQL7B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 06:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637150163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c2eoe8/OATGWCJDnyPGzeUF0YG8XAgNlQoF+hqsMRKE=;
        b=bsM2l93AwHq42pLL/VqJq9B3oaNLbnpdd+sVdNkI0G2k4+8oR/eAfhY8Y5spAfKbgG1L7H
        7vyVMXHv4PHVaojyD5qDp0j6baoNHGxMSk7NnnlSLTQ36EqkNttY60A8v1E34CtqkaxdSE
        GA4sruu5/MHjMr94ZWuW/acvXPuFQ54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17--l1wWKmROi-R2aRrk6VExg-1; Wed, 17 Nov 2021 06:55:59 -0500
X-MC-Unique: -l1wWKmROi-R2aRrk6VExg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 838681851723;
        Wed, 17 Nov 2021 11:55:58 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4120210023AB;
        Wed, 17 Nov 2021 11:55:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] block: avoid to quiesce queue in elevator_init_mq
Date:   Wed, 17 Nov 2021 19:55:02 +0800
Message-Id: <20211117115502.1600950-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

elevator_init_mq() is only called before adding disk, when there isn't
any FS I/O, only passthrough requests can be queued, so freezing queue
plus canceling dispatch work is enough to drain any dispatch activities,
then we can avoid synchronize_srcu() in blk_mq_quiesce_queue().

Long boot latency issue can be fixed in case of lots of disks added
during booting.

Fixes: 737eb78e82d5 ("block: Delay default elevator initialization")
Reported-by: yangerkun <yangerkun@huawei.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 1f39f6e8ebb9..19a78d5516ba 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -694,12 +694,18 @@ void elevator_init_mq(struct request_queue *q)
 	if (!e)
 		return;
 
+	/*
+	 * We are called before adding disk, when there isn't any FS I/O,
+	 * so freezing queue plus canceling dispatch work is enough to
+	 * drain any dispatch activities originated from passthrough
+	 * requests, then no need to quiesce queue which may add long boot
+	 * latency, especially when lots of disks are involved.
+	 */
 	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
+	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q);
 
 	if (err) {
-- 
2.31.1

