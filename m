Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E3C28CF5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 03:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiAZD6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 22:58:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237419AbiAZD6y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 22:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643169533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=91314JZqRhrjuvOcnpfxlrkTdGDpukXQ9zKVaU9KX+k=;
        b=RtmP+24OnQa5YPz+MzoBKVSe6P+YXoOZmWJlWV2KFC7LW4sKqkKhusXJgLp8N7c4kL8iLY
        htJUvf9dE9UrlnNZO/y9SLwsNBxaPtvywI1LAybU1rTMB+fiXWvGJueW4c7Jc5eo9/J0H3
        XJcTfizPjO3A8K9r0gw/AsQFmNzOo+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-sBZuEwfFPOG5PxfDq1PCvQ-1; Tue, 25 Jan 2022 22:58:52 -0500
X-MC-Unique: sBZuEwfFPOG5PxfDq1PCvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142AA8143FD;
        Wed, 26 Jan 2022 03:58:51 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFBDC5DB8A;
        Wed, 26 Jan 2022 03:58:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Vivek Goyal <vgoyal@redhat.com>, Pei Zhang <pezhang@redhat.com>
Subject: [PATCH V3] block: loop:use kstatfs.f_bsize of backing file to set discard granularity
Date:   Wed, 26 Jan 2022 11:58:30 +0800
Message-Id: <20220126035830.296465-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If backing file's filesystem has implemented ->fallocate(), we think the
loop device can support discard, then pass sb->s_blocksize as
discard_granularity. However, some underlying FS, such as overlayfs,
doesn't set sb->s_blocksize, and causes discard_granularity to be set as
zero, then the warning in __blkdev_issue_discard() is triggered.

Christoph suggested to pass kstatfs.f_bsize as discard granularity, and
this way is fine because kstatfs.f_bsize means 'Optimal transfer block
size', which still matches with definition of discard granularity.

So fix the issue by setting discard_granularity as kstatfs.f_bsize if it
is available, otherwise claims discard isn't supported.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Vivek Goyal <vgoyal@redhat.com>
Reported-by: Pei Zhang <pezhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- following Christoph's suggestion to not claim discard support if
	vfs_statfs() fails 
V2:
	- take Christoph's suggestion to use kstatfs.f_bsize

 drivers/block/loop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..8b56eeb7e144 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -79,6 +79,7 @@
 #include <linux/ioprio.h>
 #include <linux/blk-cgroup.h>
 #include <linux/sched/mm.h>
+#include <linux/statfs.h>
 
 #include "loop.h"
 
@@ -774,8 +775,13 @@ static void loop_config_discard(struct loop_device *lo)
 		granularity = 0;
 
 	} else {
+		struct kstatfs sbuf;
+
 		max_discard_sectors = UINT_MAX >> 9;
-		granularity = inode->i_sb->s_blocksize;
+		if (!vfs_statfs(&file->f_path, &sbuf))
+			granularity = sbuf.f_bsize;
+		else
+			max_discard_sectors = 0;
 	}
 
 	if (max_discard_sectors) {
-- 
2.31.1

