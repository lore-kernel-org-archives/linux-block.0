Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7299C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 01:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiCPB2c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 21:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiCPB2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 21:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5F555DE40
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 18:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647394037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5ZcBS9GArmhx5wk2dVoh3Ew/DRuQIoEp8kLsV4gOy8g=;
        b=FUIeHGxklsOdYkNCpiSAdI3c/+3L+ePuXc3+IXlY57OK+you508cqVaJCzWSeht4Ax8R/R
        JmuTp5+CAQ/z2+sHr/Al8lyZzE6ZiVjzLAXPZXvy1QVL+i0VsxjlG4a4HjlcempE2T02jI
        ngDENjLuds2SgxO9f+wAVi5u63OCrJ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-DGiqOlO1PRiTIAlGf8m1DA-1; Tue, 15 Mar 2022 21:27:14 -0400
X-MC-Unique: DGiqOlO1PRiTIAlGf8m1DA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 630CF381AA03;
        Wed, 16 Mar 2022 01:27:14 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66389400F752;
        Wed, 16 Mar 2022 01:27:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH] lib/sbitmap: allocate sb->map via kvzalloc_node
Date:   Wed, 16 Mar 2022 09:27:08 +0800
Message-Id: <20220316012708.354668-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sbitmap has been used in scsi for replacing atomic operations on
sdev->device_busy, so IOPS on some fast scsi storage can be improved.

However, sdev->device_busy can be changed in fast path, so we have to
allocate the sb->map statically. sdev->device_busy has been capped to 1024,
but some drivers may configure the default depth as < 8, then
cause each sbitmap word to hold only one bit. Finally 1024 * 128(
sizeof(sbitmap_word)) bytes is needed for sb->map, given it is order 5
allocation, sometimes it may fail.

Avoid the issue by using kvzalloc_node() for allocating sb->map.

Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/sbitmap.h | 2 +-
 lib/sbitmap.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index dffeb8281c2d..8f5a86e210b9 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -174,7 +174,7 @@ static inline unsigned int __map_depth(const struct sbitmap *sb, int index)
 static inline void sbitmap_free(struct sbitmap *sb)
 {
 	free_percpu(sb->alloc_hint);
-	kfree(sb->map);
+	kvfree(sb->map);
 	sb->map = NULL;
 }
 
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 2eb3de18ded3..ae4fd4de9ebe 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -110,7 +110,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		sb->alloc_hint = NULL;
 	}
 
-	sb->map = kcalloc_node(sb->map_nr, sizeof(*sb->map), flags, node);
+	sb->map = kvzalloc_node(sb->map_nr * sizeof(*sb->map), flags, node);
 	if (!sb->map) {
 		free_percpu(sb->alloc_hint);
 		return -ENOMEM;
-- 
2.31.1

