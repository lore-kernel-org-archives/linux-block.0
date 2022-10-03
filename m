Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AAAC433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 13:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJCNfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJCNfl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 09:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9E29C9B
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664804136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+2QEALrW8krioYVO+5TL2nVVckXP80vNueDJFGODLFI=;
        b=dxYSyxYBQBGYutze5V77ejdqeBp946AylMfOtKVjm0jMlSwS04CHeBh9xZ8AYc/HcNg0Kh
        wLZg2wy6SWuH9o/VHcvfvUG6U3PrSFF4y69qReitXS1ArRBNJA/n8wKbSxc1/HpH117RiO
        XHYGp+ePAzvT+x2hcKnxFKb2IH+d4FM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-zTvuNjFRMCCwGxyhA5XGzQ-1; Mon, 03 Oct 2022 09:35:35 -0400
X-MC-Unique: zTvuNjFRMCCwGxyhA5XGzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35389858F13
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 13:35:35 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ACEE1121320;
        Mon,  3 Oct 2022 13:35:35 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Nico Pache <npache@redhat.com>, Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH v2] block: avoid sign extend problem with default queue flags mask
Date:   Mon,  3 Oct 2022 09:35:34 -0400
Message-Id: <20221003133534.1075582-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

request_queue->queue_flags is unsigned long, which is 8-bytes on
64-bit architectures. Most queue flag modifications occur through
bit field helpers, but default flags can be logically OR'd via the
QUEUE_FLAG_MQ_DEFAULT mask. If this mask happens to include bit 31,
the assignment can sign extend the field and set all upper 32 bits.

This exact problem has been observed on a downstream kernel that
happens to use bit 31 for QUEUE_FLAG_NOWAIT. This is not an
immediate problem for current upstream because bit 31 is not
included in the default flag assignment (and is not used at all,
actually). Regardless, fix up the QUEUE_FLAG_MQ_DEFAULT mask
definition to avoid the landmine in the future.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

v2:
- Jens points out queue_flags is unsigned long (not ull).
v1: https://lore.kernel.org/linux-block/20220930150345.854021-1-bfoster@redhat.com/

 include/linux/blkdev.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 84b13fdd34a7..5cd419e84560 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -580,9 +580,9 @@ struct request_queue {
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
 
-#define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
-				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-				 (1 << QUEUE_FLAG_NOWAIT))
+#define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
+				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
+				 (1UL << QUEUE_FLAG_NOWAIT))
 
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
-- 
2.37.2

