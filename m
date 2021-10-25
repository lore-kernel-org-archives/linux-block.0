Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AAFC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE3360F92
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhJYIBZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231469AbhJYIBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 04:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dK/mYm1FrF9rRdNv3QxeLeadP1lFYA8IS+ck5qZJT8M=;
        b=bm6TNLNof5zDpICi7sVDSlGJkRw4/oB/eQNN8mhffcKg+5urd3CNNbLQxlVX/i3RJdAe0N
        nsD8lmhHw0NlI0Z5Hs7C27TCnKLTKmsb8bUN+gja6fxYv065FhCuITnQ2+lyMFIwgiLZrQ
        6zeNwtnbt6trxOOF4r6v2Ei+o+cAIDk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-SzexpkbyMtiyppdNX0Ee9w-1; Mon, 25 Oct 2021 03:58:59 -0400
X-MC-Unique: SzexpkbyMtiyppdNX0Ee9w-1
Received: by mail-ed1-f70.google.com with SMTP id x13-20020a05640226cd00b003dd4720703bso3124935edd.8
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 00:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dK/mYm1FrF9rRdNv3QxeLeadP1lFYA8IS+ck5qZJT8M=;
        b=51npIG/VcO7jCKILNXdVWqES6xlLQhu31AhJbC1mlIqP5xxGUtqnQeTY/bjMtoVO7F
         HXtDBjCaDcBsRPb8WhXdb61Ln/doerV8v88JBDbO5DYeMkeFybHmDtCzoOirvjBK6MT3
         IXgxfjHfXRksjV5efpVUTzOM7z5IeElu9R60BwPZrz+HieMRLvpHRC9fqOhfFxVORb0/
         iwFW9N1C7eaw2rnsAH+xVlhQ24UxF7XICguzYu4bAZXi1tuF2tfIFf+1C4NJvSkziAsj
         CXqnhY714J5ncimWtamdUh+AdcBqZoGWXoY8Fi/QyxfO1sg+MOWd1f0La7TOphKVKmdo
         RckQ==
X-Gm-Message-State: AOAM533iUIxwSoEF9pganUBtP7LIgIW9p7PbiHZyFS4dkp3uewwCvGim
        msjnjcbsepOv4SFgQS5tMxcP+cGNU7b72DPtl/G+QL9Y2OobOfQN8io5CioSFprVoIVjurFYb9c
        SPFv135Ax9fJ9a9ZrKlQN1T4=
X-Received: by 2002:a17:906:2a06:: with SMTP id j6mr20748787eje.401.1635148738307;
        Mon, 25 Oct 2021 00:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8iS3IW2Yyq5Wb5XfIh0GRJczmyMiooQOgTEZEvApX2TIFLEIbhNiwxogw2Hx7VOkTSCCg/A==
X-Received: by 2002:a17:906:2a06:: with SMTP id j6mr20748761eje.401.1635148738124;
        Mon, 25 Oct 2021 00:58:58 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
        by smtp.gmail.com with ESMTPSA id u14sm8581172edj.74.2021.10.25.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 00:58:57 -0700 (PDT)
Date:   Mon, 25 Oct 2021 03:58:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: corrent types for status handling
Message-ID: <20211025075825.1603118-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
back to a blk_status_t variable. blk_status_t is either u32 or (more
typically) u8 so it works, but is inelegant and causes sparse warnings.

Pass the status in blk_status_t in a consistent way.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c336d9bb9105..c7d05ff24084 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -208,8 +208,9 @@ static void virtblk_cleanup_cmd(struct request *req)
 		kfree(bvec_virt(&req->special_vec));
 }
 
-static int virtblk_setup_cmd(struct virtio_device *vdev, struct request *req,
-		struct virtblk_req *vbr)
+static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
+				      struct request *req,
+				      struct virtblk_req *vbr)
 {
 	bool unmap = false;
 	u32 type;
@@ -317,14 +318,15 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	unsigned long flags;
 	unsigned int num;
 	int qid = hctx->queue_num;
-	int err;
 	bool notify = false;
+	blk_status_t status;
+	int err;
 
 	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
 
-	err = virtblk_setup_cmd(vblk->vdev, req, vbr);
-	if (unlikely(err))
-		return err;
+	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	if (unlikely(status))
+		return status;
 
 	blk_mq_start_request(req);
 
-- 
MST

