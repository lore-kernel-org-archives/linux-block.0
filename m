Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A535CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75900207E8
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 08:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9LMmKaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgFSIme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:42:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34856 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731047AbgFSImd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 04:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592556151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iq0rHnfPgcmC77jHDimukJCx3eWJP/wGx+ZmcsksRnw=;
        b=S9LMmKaMffs46T4Hx0KidJ9jboHT6v5Nb0Okz38YdEH5SOcDM4K8/UmxDuvwyJa6NDXlbL
        qO2pG7PKkO4pbNRx62s4RzTFKvn9uJX4NPfMkausRgZTq224LrHW476Ufx66Bsa21pL9Ea
        c3xHN7yVRVaOcH5N1xrTNod9z6tF4NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-VE6IAFvcPAiZ3CtBNp5WUQ-1; Fri, 19 Jun 2020 04:42:29 -0400
X-MC-Unique: VE6IAFvcPAiZ3CtBNp5WUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 982618015CE
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 08:42:28 +0000 (UTC)
Received: from localhost (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A3AF5BACA;
        Fri, 19 Jun 2020 08:42:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH] dm-rq: don't call blk_mq_queue_stopped in dm_stop_queue()
Date:   Fri, 19 Jun 2020 16:42:14 +0800
Message-Id: <20200619084214.337449-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm-rq won't stop queue, meantime blk-mq won't stop one queue too, so
remove the check.

dm_stop_queue() actually tries to quiesce hw queues via blk_mq_quiesce_queue(),
we can't check via blk_queue_quiesced for avoiding unnecessary queue
quiesce because the flag is set before synchronize_rcu() and dm_stop_queue
may be called when synchronize_rcu from another blk_mq_quiesce_queue is
in-progress.

Cc: linux-block@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-rq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index f60c02512121..ed4d5ea66ccc 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -70,9 +70,6 @@ void dm_start_queue(struct request_queue *q)
 
 void dm_stop_queue(struct request_queue *q)
 {
-	if (blk_mq_queue_stopped(q))
-		return;
-
 	blk_mq_quiesce_queue(q);
 }
 
-- 
2.25.2

