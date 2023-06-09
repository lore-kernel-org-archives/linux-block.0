Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE625C7EE29
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 18:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFISI4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFISI4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 14:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F343586
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686334089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OgLUI49R4BzjOlw54BaHHTPcDlb20jeY7Ns7msS4H+8=;
        b=G/PDxmF1rMnm/oGLfNBLCdrE1ZE8iKICAfXGQv6PADJCmKjOlE0uiBs3XCurKHD1c3mT82
        TRLUn7RBrV0DyVlbCHgLGQQ9PhTWHoMrjqxvL4GcjG3dW7id/+mIkWHkEv5s0B3citpTBm
        xEaXVuSbqqJm4+seFKz9wzWvHTx41+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-AYDdVwSyMM-9rsO_liRF6g-1; Fri, 09 Jun 2023 14:08:08 -0400
X-MC-Unique: AYDdVwSyMM-9rsO_liRF6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A92C6101A531;
        Fri,  9 Jun 2023 18:08:07 +0000 (UTC)
Received: from host.redhat.com (unknown [10.22.16.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B8C040D1B66;
        Fri,  9 Jun 2023 18:08:07 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     axboe@kernel.dk
Cc:     djeffery@redhat.com, loberman@redhat.com, emilne@redhat.com,
        minlei@redhat.com, linux-block@vger.kernel.org,
        John Pittman <jpittman@redhat.com>
Subject: [PATCH] block: set reasonable default for discard max
Date:   Fri,  9 Jun 2023 14:08:05 -0400
Message-Id: <20230609180805.736872-1-jpittman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some drive manufacturers export a very large supported max discard size.
However, when the operating system sends I/O of the max size to the
device, extreme I/O latency can often be encountered. Since hardware
does not provide an optimal discard value in addition to the max, and
there is no way to foreshadow how well a drive handles the large size,
take the method from max_sectors setting, and use BLK_DEF_MAX_SECTORS to
set a more reasonable default discard max. This should avoid the extreme
latency while still allowing the user to increase the value for specific
needs.

Signed-off-by: John Pittman <jpittman@redhat.com>
Suggested-by: David Jeffery <djeffery@redhat.com>
---
 Documentation/ABI/stable/sysfs-block | 4 +++-
 block/blk-settings.c                 | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index c57e5b7cb532..158a1e6f1f6d 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -235,7 +235,9 @@ Description:
 		large latencies when large discards are issued, setting this
 		value lower will make Linux issue smaller discards and
 		potentially help reduce latencies induced by large discard
-		operations.
+		operations. For this reason, the max is currently defaulted to
+		four times BLK_DEF_MAX_SECTORS, but can be increased via sysfs
+		as needed.
 
 
 What:		/sys/block/<disk>/queue/discard_max_hw_bytes
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 4dd59059b788..4401c0b8477e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -179,7 +179,8 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors)
 {
 	q->limits.max_hw_discard_sectors = max_discard_sectors;
-	q->limits.max_discard_sectors = max_discard_sectors;
+	q->limits.max_discard_sectors = min(max_discard_sectors,
+						BLK_DEF_MAX_SECTORS * 4);
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
-- 
2.38.1

