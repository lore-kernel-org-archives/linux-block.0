Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4823FC001B0
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 16:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjHHQYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjHHQWu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 12:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D09EE6
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691509756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9r/GcSpKKC2dt0ISzH0rvZ1VrInscXGexGqDsV7Zgfk=;
        b=ZyTdwg/4IiOUYZxFYz/47uzuCMYqdoq3Or7stz2alILwts9mojUHe7z6BuasrPX++KI2Bp
        y2BSLnoB5vGi0n7/9teV3h05+wmAoai0eKBuj4iu+gFk2X6csG7MyVvNEQ3F+/Htpk1qus
        ml914Ckps2bNkZ6RlwyrCIY0mDMSqdY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-MBMMJmWsMYifeEoAwq7xkg-1; Tue, 08 Aug 2023 06:48:09 -0400
X-MC-Unique: MBMMJmWsMYifeEoAwq7xkg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 354F4185A7A5;
        Tue,  8 Aug 2023 10:43:02 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62944401061;
        Tue,  8 Aug 2023 10:43:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH V3 04/14] virtio-blk: limit max allowed submit queues
Date:   Tue,  8 Aug 2023 18:42:29 +0800
Message-Id: <20230808104239.146085-5-ming.lei@redhat.com>
In-Reply-To: <20230808104239.146085-1-ming.lei@redhat.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Take blk-mq's knowledge into account for calculating io queues.

Fix wrong queue mapping in case of kdump kernel.

On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
`Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
still returns all CPUs because 'maxcpus=1' just bring up one single
cpu core during booting.

blk-mq sees single queue in kdump kernel, and in driver's viewpoint
there are still multiple queues, this inconsistency causes driver to apply
wrong queue mapping for handling IO, and IO timeout is triggered.

Meantime, single queue makes much less resource utilization, and reduce
risk of kernel failure.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 1fe011676d07..4ba79fe2a1b4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1047,7 +1047,8 @@ static int init_vq(struct virtio_blk *vblk)
 
 	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
 
-	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
+	vblk->io_queues[HCTX_TYPE_DEFAULT] = min_t(unsigned,
+			num_vqs - num_poll_vqs, blk_mq_max_nr_hw_queues());
 	vblk->io_queues[HCTX_TYPE_READ] = 0;
 	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
 
-- 
2.40.1

