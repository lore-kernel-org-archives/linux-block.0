Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEADC433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 23:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B04220774
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 23:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgzP5RtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgHKXoy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:44:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56260 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgHKXoy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 19:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597189492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qlldUuOqRxxKcsaaFzCdUKLS97dh9RJhLd02RjeJuU=;
        b=FgzP5RtOCn+rKCpGn48r72MxFu4s29obZVZGxu9eTYNx4eLIQnRpUykJzH+KWJBG4hDvMP
        hAxhDNpzsxvXDbVTHacnu9U5hnZ2apleKRoF0jEvxs/av17UrljWv00bezebQJkWLO4vqZ
        42jCywAloVSUriyofItT5N+40jV5HEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-C1qZBALVNX-lKZKw6r-14Q-1; Tue, 11 Aug 2020 19:44:51 -0400
X-MC-Unique: C1qZBALVNX-lKZKw6r-14Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE11B102C7ED;
        Tue, 11 Aug 2020 23:44:49 +0000 (UTC)
Received: from localhost (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39D717C0F5;
        Tue, 11 Aug 2020 23:44:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH V2 2/3] block: virtio_blk: fix handling single range discard request
Date:   Wed, 12 Aug 2020 07:44:19 +0800
Message-Id: <20200811234420.2297137-3-ming.lei@redhat.com>
In-Reply-To: <20200811234420.2297137-1-ming.lei@redhat.com>
References: <20200811234420.2297137-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
to support multi-range discard for virtio-blk. However, the virtio-blk
disk may report max discard segment as 1, at least that is exactly what
qemu is doing.

So far, block layer switches to normal request merge if max discard segment
limit is 1, and multiple bios can be merged to single segment. This way may
cause memory corruption in virtblk_setup_discard_write_zeroes().

Fix the issue by handling single max discard segment in straightforward
way.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Changpeng Liu <changpeng.liu@intel.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/block/virtio_blk.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 63b213e00b37..b2e48dac1ebd 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -126,16 +126,31 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 	if (!range)
 		return -ENOMEM;
 
-	__rq_for_each_bio(bio, req) {
-		u64 sector = bio->bi_iter.bi_sector;
-		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
-
-		range[n].flags = cpu_to_le32(flags);
-		range[n].num_sectors = cpu_to_le32(num_sectors);
-		range[n].sector = cpu_to_le64(sector);
-		n++;
+	/*
+	 * Single max discard segment means multi-range discard isn't
+	 * supported, and block layer only runs contiguity merge like
+	 * normal RW request. So we can't reply on bio for retrieving
+	 * each range info.
+	 */
+	if (queue_max_discard_segments(req->q) == 1) {
+		range[0].flags = cpu_to_le32(flags);
+		range[0].num_sectors = cpu_to_le32(blk_rq_sectors(req));
+		range[0].sector = cpu_to_le64(blk_rq_pos(req));
+		n = 1;
+	} else {
+		__rq_for_each_bio(bio, req) {
+			u64 sector = bio->bi_iter.bi_sector;
+			u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+
+			range[n].flags = cpu_to_le32(flags);
+			range[n].num_sectors = cpu_to_le32(num_sectors);
+			range[n].sector = cpu_to_le64(sector);
+			n++;
+		}
 	}
 
+	WARN_ON_ONCE(n != segments);
+
 	req->special_vec.bv_page = virt_to_page(range);
 	req->special_vec.bv_offset = offset_in_page(range);
 	req->special_vec.bv_len = sizeof(*range) * segments;
-- 
2.25.2

