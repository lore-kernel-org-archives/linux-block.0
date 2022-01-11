Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844D8C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 12:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiAKMeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 07:34:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238836AbiAKMeT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 07:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641904459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zUeA9ed2au43CPrMJ3+8Jhx7IowZrQ0z21wcP/1ht+E=;
        b=V1DMGCOi71xN6XcrlH8IJb2aHTbdBFQGaHGaQMwub+gBjcjlN6G2MGJd46wEmlEEd+V/L9
        JduwBXd7G1Rm+IDnahIUjEVU+C166N+ITfEZfpYDpWOmB7GqhbVBzARhfYSMyqtpLJzLv/
        /urL1f7rsuMRkGpYk6Yt6a3Kd3VKiT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-B56HBIZgPriD35J_WHwuxw-1; Tue, 11 Jan 2022 07:34:18 -0500
X-MC-Unique: B56HBIZgPriD35J_WHwuxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BB2E1083F67;
        Tue, 11 Jan 2022 12:34:17 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4F137241D;
        Tue, 11 Jan 2022 12:34:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com
Subject: [PATCH] block: cleanup q->srcu
Date:   Tue, 11 Jan 2022 20:34:01 +0800
Message-Id: <20220111123401.520192-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

srcu structure has to be cleanup via cleanup_srcu_struct(), so fix it.

Reported-by: syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com
Fixes: 704b914f15fb ("blk-mq: move srcu from blk_mq_hw_ctx to request_queue")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e20eadfcf5c8..8d8549f71311 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -811,6 +811,9 @@ static void blk_release_queue(struct kobject *kobj)
 
 	bioset_exit(&q->bio_split);
 
+	if (blk_queue_has_srcu(q))
+		cleanup_srcu_struct(q->srcu);
+
 	ida_simple_remove(&blk_queue_ida, q->id);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
-- 
2.31.1

