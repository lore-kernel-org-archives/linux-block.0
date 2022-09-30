Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70645C433F5
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiI3PD5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiI3PDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 11:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90401100F
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664550228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=76yskqT9X9S1AEEPxFEnQ3q6+/m3ccuz+K4Lp+qim1I=;
        b=Q/k9/7MwcewDM1vHVPsZJ1hDH0wqk2rglr13CRAXQyXwU962L+SyDmEHYw0KAA8vLxeN0w
        +Zd0qwBV20S2XZz0s9hA82hAoat6/k25DBDINVx8X4fdgeMDSmyCRG7haTH76UBNxwfvRO
        52qG7PAgyrpc2S1dQEwkoHCwI9Jx6gg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-8dhjANkBN2SJ9KSAcXhuQQ-1; Fri, 30 Sep 2022 11:03:47 -0400
X-MC-Unique: 8dhjANkBN2SJ9KSAcXhuQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1DB43C0E217
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 15:03:46 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84AE6111F3D9;
        Fri, 30 Sep 2022 15:03:46 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Nico Pache <npache@redhat.com>, Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH] block: avoid sign extend problem with default queue flags mask
Date:   Fri, 30 Sep 2022 11:03:45 -0400
Message-Id: <20220930150345.854021-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

request_queue->queue_flags is an 8-byte field. Most queue flag
modifications occur through bit field helpers, but default flags can
be logically OR'd via the QUEUE_FLAG_MQ_DEFAULT mask. If this mask
happens to include bit 31, the assignment can sign extend the field
and set all upper 32 bits.

This exact problem has been observed on a downstream kernel that
happens to use bit 31 for QUEUE_FLAG_NOWAIT. This is not an
immediate problem for current upstream because bit 31 is not
included in the default flag assignment (and is not used at all,
actually). Regardless, fix up the QUEUE_FLAG_MQ_DEFAULT mask
definition to avoid the landmine in the future.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Just to elaborate, I ran a quick test to change QUEUE_FLAG_NOWAIT to use
bit 31. With that change but without this patch, I see the following
queue state:

# cat /sys/kernel/debug/block/vda/state
SAME_COMP|IO_STAT|INIT_DONE|WC|STATS|REGISTERED|30|NOWAIT|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63

And then with the patch applied:

# cat /sys/kernel/debug/block/vda/state
SAME_COMP|IO_STAT|INIT_DONE|WC|STATS|REGISTERED|30|NOWAIT

Thanks.

Brian

 include/linux/blkdev.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 84b13fdd34a7..28c3037cb25c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -580,9 +580,9 @@ struct request_queue {
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 
-#define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
-				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-				 (1 << QUEUE_FLAG_NOWAIT))
+#define QUEUE_FLAG_MQ_DEFAULT	((1ULL << QUEUE_FLAG_IO_STAT) |		\
+				 (1ULL << QUEUE_FLAG_SAME_COMP) |	\
+				 (1ULL << QUEUE_FLAG_NOWAIT))
 
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
-- 
2.37.2

