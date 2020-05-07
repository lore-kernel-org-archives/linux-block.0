Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B7C38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DCE2073A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9GwmTHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgEGIxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 04:53:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59098 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbgEGIxQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 04:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588841595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtPs2Z2LGt+uXMHPHshKI6EDCxbKqjV9DuksI24yVzg=;
        b=I9GwmTHGIiaenlACv4p2Yirk3eMZKtAAlKpqIxbbKObSypJTm+67Sjt/H+APHqPXjsVeVA
        KbhnQl4w/ORGC1dUhMHGYUMXkVOBLr5J64LggTsGI/y88UHKMyp6Q8ievtXylb0aRjSl4b
        qWIMaIwmN+grUEGuCCk0ESeS7tLEXaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-wScemm7bM3WVImUTQhjiQQ-1; Thu, 07 May 2020 04:53:12 -0400
X-MC-Unique: wScemm7bM3WVImUTQhjiQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75921835B47;
        Thu,  7 May 2020 08:53:11 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F04670545;
        Thu,  7 May 2020 08:53:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 4/4] block: don't hold part0's refcount in IO path
Date:   Thu,  7 May 2020 16:52:39 +0800
Message-Id: <20200507085239.1354854-5-ming.lei@redhat.com>
In-Reply-To: <20200507085239.1354854-1-ming.lei@redhat.com>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
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
 block/blk-core.c | 3 ++-
 block/genhd.c    | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 826a8980997d..56cc61354671 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1343,7 +1343,8 @@ void blk_account_io_done(struct request *req, u64 n=
ow)
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
=20
-		hd_struct_put(part);
+		if (part->partno)
+			hd_struct_put(part);
 		part_stat_unlock();
 	}
 }
diff --git a/block/genhd.c b/block/genhd.c
index c0288b89a7ad..af8641351510 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -373,7 +373,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk =
*disk, sector_t sector)
 		}
 	}
  exit:
-	hd_struct_get(&disk->part0);
 	return &disk->part0;
 }
=20
--=20
2.25.2

