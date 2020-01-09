Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F46C32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F025206ED
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HU6p1ANG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgAIGVo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:21:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgAIGVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jan 2020 01:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578550903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VDpRehaaX2VwZ6C6bv0cU3CdbWdM8MhHbEZNbnXnC8=;
        b=HU6p1ANGoOYtnrA76gl4Muc7bbkw0JJ0xmjYHfIitYJA6MwGG0Fj35rXY2KVVQQt0vPTDg
        cdgzcjGEQRTFA/Z0EHQoFK+TzGNMoEk7wmtkuvIwCde3ZANXgDI4BxgyXNr/ubh2JQyZzu
        7UiY+8YU9g8ue99KVDAeQYYfykNvw2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-FGycPvs2OJ-WAGZrbB7J0Q-1; Thu, 09 Jan 2020 01:21:42 -0500
X-MC-Unique: FGycPvs2OJ-WAGZrbB7J0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 994A0107ACC7;
        Thu,  9 Jan 2020 06:21:40 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2DC05DA32;
        Thu,  9 Jan 2020 06:21:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 4/4] block: don't hold part0's refcount in IO path
Date:   Thu,  9 Jan 2020 14:21:09 +0800
Message-Id: <20200109062109.2313-5-ming.lei@redhat.com>
In-Reply-To: <20200109062109.2313-1-ming.lei@redhat.com>
References: <20200109062109.2313-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 79599f5fd5b7..a1184a59819a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1345,7 +1345,8 @@ void blk_account_io_done(struct request *req, u64 n=
ow)
 		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start=
_time_ns));
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
=20
-		hd_struct_put(part);
+		if (part->partno)
+			hd_struct_put(part);
 		part_stat_unlock();
 	}
 }
diff --git a/block/genhd.c b/block/genhd.c
index bfc4148ec341..8c7c32b5dcc0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -300,7 +300,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk =
*disk, sector_t sector)
 		}
 	}
  exit:
-	hd_struct_get(&disk->part0);
 	return &disk->part0;
 }
 EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
--=20
2.20.1

