Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A82C433FE
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 04:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbiAYE4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jan 2022 23:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240932AbiAYEkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 23:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643085638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=//gd3MlJOe9KhwhDkvV5hXClhf54wEmDqKiRtLDICzw=;
        b=M2dm6WuJCOyoJbWkZcUJuIxtQRGXmskxTeCv4nj6OROJ9Q7CI6I+JlIhJ8y1nBfHh7eH+f
        beEZDulkpkp8yxaewBHElzEAVO/Id9C/WYRXKrU4uOTvk2XO1HOIiQ38aKuLs2r7paArR2
        /+KJsHoAGYJJzgGoAg1WpgngxncioCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-FMIA0xT7MdqVCPq07K3rBQ-1; Mon, 24 Jan 2022 23:40:35 -0500
X-MC-Unique: FMIA0xT7MdqVCPq07K3rBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511E9802926;
        Tue, 25 Jan 2022 04:40:34 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E713655F4A;
        Tue, 25 Jan 2022 04:40:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Vivek Goyal <vgoyal@redhat.com>, Pei Zhang <pezhang@redhat.com>
Subject: [PATCH V2] block: loop:use kstatfs.f_bsize of backing file to set discard granularity
Date:   Tue, 25 Jan 2022 12:40:05 +0800
Message-Id: <20220125044005.211943-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
is available, otherwise fackback to PAGE_SIZE.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Vivek Goyal <vgoyal@redhat.com>
Reported-by: Pei Zhang <pezhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- take Christoph's suggestion to use kstatfs.f_bsize

 drivers/block/loop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..0991f08f79d7 100644
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
+			granularity = PAGE_SIZE;
 	}
 
 	if (max_discard_sectors) {
-- 
2.31.1

