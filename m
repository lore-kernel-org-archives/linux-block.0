Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A92C4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 12:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiLTMqB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiLTMpW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 07:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E218413F2D
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671540120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=a9dphcXJKbDgaDzxRRBiVFA9p7kE9yji17UDhT5ug+8=;
        b=jDlbCVx5ASW9WXd/pM0qM3JKtx5JDLczj05mZ/T2tx3j0JEJLNlBevQSTFkX69JY6oVB/1
        b4dITTT2oSk8ueGT+FDcKRgoHHg+EdroInniqMs45LSF6jleOztdCILOUBTeG3O3WVGOx8
        UD/5q+Kq63GELU0sYr2RDhIJh1veFRs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-mMr3UUqOO52Xp2kyVHf2QQ-1; Tue, 20 Dec 2022 07:41:59 -0500
X-MC-Unique: mMr3UUqOO52Xp2kyVHf2QQ-1
Received: by mail-qt1-f198.google.com with SMTP id fg11-20020a05622a580b00b003a7eaa5cb47so5434353qtb.15
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 04:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9dphcXJKbDgaDzxRRBiVFA9p7kE9yji17UDhT5ug+8=;
        b=BDyM5ZbHeJ+Dv+GwtqJGxJ0V4EppuBwwZdqgV0XicY8hEnR/GrrYv9X9KfIw5pnSSa
         EsncsDwN0aWdoIWfdKGKuO4d++rfYFZYy205T5TCvG7ZdnG9IyySg8GbP12LjMAikdwd
         8DkNGrtUlz6cKisZQAeI9DAqbmK9QoqmTPlSS17zrS0rEa5uqSYc4K4H8q4HtWkGllZ6
         jTWmL8rvw7TU4O9fvOZXGjDtwVsp0l5mFG5msjY67sS6SdMKm22x2Xo6jKLGCgYk10Ax
         X3nddBsdImb3767A2ClX/5aNkJ40/L/3kfiz0t3hz5lrsGLU4UrKmhMICRf482+IQrx8
         fqBw==
X-Gm-Message-State: AFqh2kq8ukDP2PYu/24xvIvhecqdMonlE13YuAtwPqJoNBIkMO/9/rEU
        EWbmPhsJEVzh0vMZBrAJ22V3aoQwszN9ZW67AIXn0eg+oxQy55p3ZHDdGyNJZhUGA5NLRpbUuGb
        EjAvoGRCDxA/KVlui65K09T0=
X-Received: by 2002:ac8:6904:0:b0:3a9:6b48:a130 with SMTP id bt4-20020ac86904000000b003a96b48a130mr25323877qtb.34.1671540119051;
        Tue, 20 Dec 2022 04:41:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSZ+R1ipZB7Pp5jlH4N4rO4W1kiXyv4dXazNe/fcZv+aCknM6mHWYUdqpnkHeBoyJ3nTFEpA==
X-Received: by 2002:ac8:6904:0:b0:3a9:6b48:a130 with SMTP id bt4-20020ac86904000000b003a96b48a130mr25323850qtb.34.1671540118802;
        Tue, 20 Dec 2022 04:41:58 -0800 (PST)
Received: from redhat.com ([37.19.199.118])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006fbaf9c1b70sm8781028qko.133.2022.12.20.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:41:58 -0800 (PST)
Date:   Tue, 20 Dec 2022 07:41:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: temporary variable type tweak
Message-ID: <20221220124152.523531-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

virtblk_result returns blk_status_t which is a bitwise restricted type,
so we are not supposed to stuff it in a plain int temporary variable.
All we do with it is pass it on to a function expecting blk_status_t so
the generated code is ok, but we get warnings from sparse:

drivers/block/virtio_blk.c:326:36: sparse: sparse: incorrect type in initializer (different base types) @@     expected int status @@
+got restricted blk_status_t @@
drivers/block/virtio_blk.c:334:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted
+blk_status_t [usertype] error @@     got int status @@

Make sparse happy by using the correct type.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 88d8410ecc5e..73cd5db0d7d5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -336,7 +336,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	int status = virtblk_result(vbr->status);
+	blk_status_t status = virtblk_result(vbr->status);
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
-- 
MST

