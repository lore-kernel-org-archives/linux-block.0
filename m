Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBCEC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 04:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B377D21655
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 04:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rm/tZaGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgEHEow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 00:44:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbgEHEov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 00:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588913090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Yg3mtnBZlEMX2Q3h3gaf+uOD+kLSGxth7jwMUbwN5A=;
        b=Rm/tZaGqPP1XxAsA9qz/E++UmX38G6dtXfUeqGGcY/9cisBf1Zdr5UkNcYw5y1cX3JzCsc
        ohkkk3GfY3P0cEt6tW2CpsKdsugGh29IiCjrlt8j7xtZhhuhDmYilmg2o2Q2Myq6mAX2zY
        gCgPN1K9Fs8DOv0er793WrAtGtbj74k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-btPvrZWOPySOjTaMSMf8zg-1; Fri, 08 May 2020 00:44:49 -0400
X-MC-Unique: btPvrZWOPySOjTaMSMf8zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6EE3107ACF4;
        Fri,  8 May 2020 04:44:47 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FE3F5C1B0;
        Fri,  8 May 2020 04:44:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH V2 4/4] block: don't hold part0's refcount in IO path
Date:   Fri,  8 May 2020 12:44:07 +0800
Message-Id: <20200508044407.1371907-5-ming.lei@redhat.com>
In-Reply-To: <20200508044407.1371907-1-ming.lei@redhat.com>
References: <20200508044407.1371907-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

gendisk can't be gone when there is IO activity, so not hold
part0's refcount in IO path.

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c  | 3 ++-
 block/blk-merge.c | 3 ++-
 block/genhd.c     | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 826a8980997d..56cc61354671 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1343,7 +1343,8 @@ void blk_account_io_done(struct request *req, u64 now)
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
-		hd_struct_put(part);
+		if (part->partno)
+			hd_struct_put(part);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index a04e991b5ded..b44caa28ec04 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -672,7 +672,8 @@ static void blk_account_io_merge(struct request *req)
 
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
-		hd_struct_put(part);
+		if (part->partno)
+			hd_struct_put(part);
 		part_stat_unlock();
 	}
 }
diff --git a/block/genhd.c b/block/genhd.c
index bf8cbb033d64..d97b95d1a2fd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -345,7 +345,8 @@ static inline int sector_in_part(struct hd_struct *part, sector_t sector)
  *
  * CONTEXT:
  * RCU read locked.  The returned partition pointer is always valid
- * because its refcount is grabbed.
+ * because its refcount is grabbed except for part0, which lifetime
+ * is same with the disk.
  *
  * RETURNS:
  * Found partition on success, part0 is returned if no partition matches
@@ -378,7 +379,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 			return part;
 		}
 	}
-	hd_struct_get(&disk->part0);
 	return &disk->part0;
 }
 
-- 
2.25.2

