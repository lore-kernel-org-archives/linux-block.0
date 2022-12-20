Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DD6C4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 11:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLTLYf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 06:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLTLYe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 06:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA410B4A
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 03:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671535432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=duDj4IDqPGRqUxwsqTLICchzA0MOp+dg3mI/1yy26NU=;
        b=Vc0RNxdolc8/3tBeJL9v+86U54s9le3QtQMqhfTUg8xG85C7UGVufKbxflvKPzfgh3SX65
        Zv38CBV6NnvhOu8dIMCBddXxoxsrtJ5XlvjLHdpVs9ODBqaQuwN08xRkWfAAMOYQJQ96K1
        J0/cAi6eZ08iY203FvvPXvZ+u8k/ce0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-47S-PkmnPBOzlAmYLSKyPg-1; Tue, 20 Dec 2022 06:23:50 -0500
X-MC-Unique: 47S-PkmnPBOzlAmYLSKyPg-1
Received: by mail-qt1-f199.google.com with SMTP id a13-20020ac8610d000000b003a8151cadebso5402218qtm.10
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 03:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duDj4IDqPGRqUxwsqTLICchzA0MOp+dg3mI/1yy26NU=;
        b=kq17Z0bUkIsoojNqHAI2beHoIGj1XwQIWeC0DkvJREosH+zl7AaYU6wEstI8R9Q5Wr
         R3QucxrDuUmvyIuUuiBYxxjZO9NH2puDDkARHxd6EpZNNdASs0848rtCrvY0oPNmKJ7y
         pwqtMd0WpKmbsktk/OBugRIgmuZynSrC9hX8kD9DKqFnAO1SdJWf0tE7lenKa2DGmgwW
         cyH6ISkvbbL6lNr9RJBnel7mP02ejZ2rX/5AfOEqtlSjeeA74Vv87+V15as/qSdkN4pM
         nSf0ciFX+O97iJQ4UvX/Zaf0NjF0g60D8MVfCdHoW0ckW1/kvIQGbh5LeOdTXz4i0k2b
         /r4g==
X-Gm-Message-State: ANoB5pmXTu3lT/s1QXdocX5RRiIrwdvuTIYU8KWvOxaJWXp8DPkvRUAd
        riemJVOQqYHk0yRzE2KuvKwTf2zDG6Qpd6+DVUCGMmnPvU9RwATqe0to4Sg7T0op34LHPl4DJFz
        QHw9wgsFZt+nZFOljawxkDX4=
X-Received: by 2002:a05:622a:248c:b0:39c:da20:f700 with SMTP id cn12-20020a05622a248c00b0039cda20f700mr61864402qtb.36.1671535430243;
        Tue, 20 Dec 2022 03:23:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4bP41rEY68a1GRVkDxLGY+6MlclsHX3KN6pGPekhSNI+eQBndsuGUO2k0JwSQpg38SoIdbVg==
X-Received: by 2002:a05:622a:248c:b0:39c:da20:f700 with SMTP id cn12-20020a05622a248c00b0039cda20f700mr61864385qtb.36.1671535429995;
        Tue, 20 Dec 2022 03:23:49 -0800 (PST)
Received: from redhat.com ([37.19.199.118])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a444800b006fc92cf4703sm8722506qkp.132.2022.12.20.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:23:49 -0800 (PST)
Date:   Tue, 20 Dec 2022 06:23:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
Message-ID: <20221220112340.518841-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When building without CONFIG_BLK_DEV_ZONED, VIRTIO_BLK_F_ZONED
is excluded from array of driver features.
As a result virtio_has_feature panics in virtio_check_driver_offered_feature
since that by design verifies that a feature we are checking for
is listed in the feature array.

To fix, replace the call to virtio_has_feature with a stub.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 88b3639f8536..5ea1dc882a80 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -760,6 +760,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 	return ret;
 }
 
+static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
+{
+	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
+}
 #else
 
 /*
@@ -775,6 +779,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 /* return id (s/n) string for *disk to *id_str
@@ -1480,7 +1489,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
-	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
+	if (virtblk_has_zoned_feature(vdev)) {
 		err = virtblk_probe_zoned_device(vdev, vblk, q);
 		if (err)
 			goto out_cleanup_disk;
-- 
MST

