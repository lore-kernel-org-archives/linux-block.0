Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1FBC10F1E
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 12:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiLTMw6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiLTMw4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 07:52:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817D110B63
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 04:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671540728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=k0FAg6XXcHdMfc8oVO4atET5WnhQYSLiwHFy9PK81fE=;
        b=TuqQSVhGLDXNhqVlsVPL5rU0XOqt3bZpqyBAiEOoM8DzRZrMRgRNoEHvGfeUgt7ykBBTky
        JRg9YqQLLvZ1j1ye+wkbmkowZ32fUyVdvdI0IAYqCXhPu/SrgU5xNkcMirJLZoYDsAeVxW
        pq4T5LX7brNwK+8lCyLZEcK9a87Evuc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-KF7SxTNdOAC_QxfpeUY2Xw-1; Tue, 20 Dec 2022 07:52:07 -0500
X-MC-Unique: KF7SxTNdOAC_QxfpeUY2Xw-1
Received: by mail-qt1-f199.google.com with SMTP id p20-20020ac84614000000b003a977d7a2ecso4371156qtn.23
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 04:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0FAg6XXcHdMfc8oVO4atET5WnhQYSLiwHFy9PK81fE=;
        b=ifMY2teKQjrx2Dnw80Ts1Hs5WuUxUPY6lgVa383YWCbqfIYuenRU7TED8HX11tA8qy
         Uq/4Z6m0P+ZN24txw1R4MlzAcT3QuJUHGv6xPQq4HcLZv8b5I3pD6QVBtSbecAOHrLKl
         D/zSDoUPgl2faxEvOiFybmsolcVKD3OYva2/rBmQ0m8BmklHCUouQXN1s+NnpQNxJxYb
         5eT9Bm/knkowZFzM9WZihLQQ3+ZTjVE1as5IsGJIgRYAisNlOWld6SZwk268tmnQJ1kY
         rOW/sy+C/ecTg5I+MnRV45+LJ4/X3IF1dS6dCjP3fqjHMI2lI59yThwDWVJQKxvC8nnn
         Gdtw==
X-Gm-Message-State: ANoB5pmLAk7Js2rzCyJon7hSRfPxVi4mqWmeyHfdmURkaygoTsExddfS
        uZRBK9c1cJ5zJRKII1C4iFLyWBWudu4o0U9DA9J+ArxMAWLDT0Ag8aeLrXQy4Vvv9Qh977KJSK9
        dpOhQWhX9bZZKglAjQydsDtg=
X-Received: by 2002:ac8:6bc4:0:b0:3a8:1d3c:47e9 with SMTP id b4-20020ac86bc4000000b003a81d3c47e9mr43531119qtt.48.1671540726781;
        Tue, 20 Dec 2022 04:52:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OPTSizknvCW8hT8hFc92s3UWJz2R3Fi5ZFpNOvn/FDZ7TfsX9i098IAGzf0JLhm5JkP5L8A==
X-Received: by 2002:ac8:6bc4:0:b0:3a8:1d3c:47e9 with SMTP id b4-20020ac86bc4000000b003a81d3c47e9mr43531096qtt.48.1671540726541;
        Tue, 20 Dec 2022 04:52:06 -0800 (PST)
Received: from redhat.com ([37.19.199.118])
        by smtp.gmail.com with ESMTPSA id r17-20020ac84251000000b003a50ef44a77sm7507788qtm.28.2022.12.20.04.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:52:06 -0800 (PST)
Date:   Tue, 20 Dec 2022 07:52:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: zone append in header type tweak
Message-ID: <20221220125154.564265-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

virtio blk returns a 64 bit append_sector in an input buffer,
in LE format. This field is not tagged as LE correctly, so
even though the generated code is ok, we get warnings from sparse:

drivers/block/virtio_blk.c:332:33: sparse: sparse: cast to restricted __le64

Make sparse happy by using the correct type.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 73cd5db0d7d5..dc577e8bfa30 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -104,7 +104,7 @@ struct virtblk_req {
 		struct {
 			u8 status;
 			u8 reserved[7];
-			u64 append_sector;
+			__le64 append_sector;
 		} zone_append_in_hdr;
 	};
 
-- 
MST

