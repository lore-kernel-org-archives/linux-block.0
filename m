Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E65CC433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 09:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1D820772
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 09:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddVNXDvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHKJWS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728391AbgHKJWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 05:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597137735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVqfpMDFk/4d/p9ID3knz3EzVfg+BMH2vcJY1OefzbA=;
        b=ddVNXDvphmq11e0elv0MIGLkUeWyUErQgHxWm6pKu03NjXY2Vk5qtl6uKiLKaS6YUHFY/K
        u44FeYjubzYFTfyJbU9GkIoaF4FCSYtUPWsopK09PRmmUTM5ecv8qdio9l1yE994glaUjR
        K7eATygubpV7vqVRF/ZRrdnW5nO6nP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-SiVGq5duMLCn3R567AJnaA-1; Tue, 11 Aug 2020 05:22:12 -0400
X-MC-Unique: SiVGq5duMLCn3R567AJnaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB7DC57;
        Tue, 11 Aug 2020 09:22:10 +0000 (UTC)
Received: from localhost (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 596C81002391;
        Tue, 11 Aug 2020 09:21:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/2] block: virtio_blk: fix handling single range discard request
Date:   Tue, 11 Aug 2020 17:21:34 +0800
Message-Id: <20200811092134.2256095-3-ming.lei@redhat.com>
In-Reply-To: <20200811092134.2256095-1-ming.lei@redhat.com>
References: <20200811092134.2256095-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
---
 drivers/block/virtio_blk.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 63b213e00b37..05b01903122b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -126,14 +126,21 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
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
 
 	req->special_vec.bv_page = virt_to_page(range);
-- 
2.25.2

