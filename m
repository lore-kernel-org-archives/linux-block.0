Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD6C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 09:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbhLBJLN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 04:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231655AbhLBJLM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Dec 2021 04:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638436070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v+k8pdJBak3oYRQppvBNAIgu4tzDjk5s659PenQPp8s=;
        b=U29lb5mG3bzgITvYDEsVM2Pw/UgtYoPuP/CyxMODITg+miqAthPIA+k7yDuFC5GW81jQAY
        CMFtuj+a6/9GHPych9hE3/n0UD1ezvw3ZI+xVX2UZJhT8cno+zwk1GOQxHDSF3P9pag0Vr
        tvEq4z+AD1tENyRASeYsqJBzB9MoQ3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-EtPPsDcGMYOYnYGaawJ8Ng-1; Thu, 02 Dec 2021 04:07:46 -0500
X-MC-Unique: EtPPsDcGMYOYnYGaawJ8Ng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFAE61934100;
        Thu,  2 Dec 2021 09:07:45 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4D475D9CA;
        Thu,  2 Dec 2021 09:07:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: check q->poll_stat in queue_poll_stat_show
Date:   Thu,  2 Dec 2021 17:07:16 +0800
Message-Id: <20211202090716.3292244-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Without checking q->poll_stat in queue_poll_stat_show(), kernel panic
may be caused if q->poll_stat isn't allocated.

Fixes: 48b5c1fbcd8c ("block: only allocate poll_stats if there's a user of them")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7f27dca3a45e..3a790eb4995c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -30,6 +30,9 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
 	struct request_queue *q = data;
 	int bucket;
 
+	if (!q->poll_stat)
+		return 0;
+
 	for (bucket = 0; bucket < (BLK_MQ_POLL_STATS_BKTS / 2); bucket++) {
 		seq_printf(m, "read  (%d Bytes): ", 1 << (9 + bucket));
 		print_stat(m, &q->poll_stat[2 * bucket]);
-- 
2.31.1

