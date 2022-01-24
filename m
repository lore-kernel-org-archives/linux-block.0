Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101CAC433F5
	for <linux-block@archiver.kernel.org>; Mon, 24 Jan 2022 10:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiAXKGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jan 2022 05:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236992AbiAXKGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643018799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yg3cgoV/zyQ42JYHeKjjY0I1MgzLhx2Zq07mA7oR+cg=;
        b=IF6FyRHG/LXPF/jpWNKZilaBuKUtCz5qwWyIV8WaK4LhGzzvFGl6O3/A9toaJFIhO4oSvr
        UH3VMZYX4do9jKtgIBmuekNAq3FopIFVXTOnT8ZhrnaFRJb0IvXdY5HGq9SzZsTZ6I/miT
        q69I2KIUZpb4dE8iXLeN79+MRX9OKmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-OlfgF5WtP-CaTxXSTUU0wQ-1; Mon, 24 Jan 2022 05:06:35 -0500
X-MC-Unique: OlfgF5WtP-CaTxXSTUU0wQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A73192CC41;
        Mon, 24 Jan 2022 10:06:34 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26AF96D03D;
        Mon, 24 Jan 2022 10:06:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, Pei Zhang <pezhang@redhat.com>
Subject: [PATCH] block: loop: set discard_granularity as PAGE_SIZE if sb->s_blocksize is 0
Date:   Mon, 24 Jan 2022 18:06:28 +0800
Message-Id: <20220124100628.1327718-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If backing file's filesystem has implemented ->fallocate(), we think the
loop device can support discard, then pass sb->s_blocksize as
discard_granularity. However, some underlying FS, such as overlayfs,
doesn't set sb->s_blocksize, and causes discard_granularity to be set as
zero, then the warning in __blkdev_issue_discard() is triggered.

Fix the issue by setting discard_granularity as PAGE_SIZE in this case
since PAGE_SIZE is the most common data unit for FS.

Cc: Vivek Goyal <vgoyal@redhat.com>
Reported-by: Pei Zhang <pezhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..8c15bfab7e1a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -776,6 +776,10 @@ static void loop_config_discard(struct loop_device *lo)
 	} else {
 		max_discard_sectors = UINT_MAX >> 9;
 		granularity = inode->i_sb->s_blocksize;
+
+		/* Take PAGE_SIZE if the FS doesn't provide us one hint */
+		if (!granularity)
+			granularity = PAGE_SIZE;
 	}
 
 	if (max_discard_sectors) {
-- 
2.31.1

