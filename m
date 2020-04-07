Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6FDC2BB1D
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326E12078A
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BidS1jBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGBHx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33151 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbgDGBHw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9Mom4OhtTxtDHxzUnnXxvRU3zaONixqwgs5hBxczCA=;
        b=BidS1jBIpd+5Cg0iQZqflYOERPVIFORW1fQk1ajjsQG2CQgHUdPM/lXtkxzKDmYyaZIijS
        /+cQ+aluZ29i8a5r5QuJ8ddcWvYcryKbenW5QZU9fdiM5Fhxr5TFwaIHtEsPeKle6hb3ww
        sbHlsMpQB25Vl0pFvGfRC+6M6EnpZbo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-DHjcJjp_OUm97hjEJP5FRA-1; Mon, 06 Apr 2020 21:07:48 -0400
X-MC-Unique: DHjcJjp_OUm97hjEJP5FRA-1
Received: by mail-wr1-f72.google.com with SMTP id u16so849880wrp.14
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2020 18:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s9Mom4OhtTxtDHxzUnnXxvRU3zaONixqwgs5hBxczCA=;
        b=oycu3xs1AU/QelpNJs6bWYNyhWrQeZTtNxmLJwCW5wefsTpwFHRGbzoZGzSl4/bJZp
         wMbOw4xGkt4WG5OY3cTb+FcfOSNpmxT/3eT+SXZGH9dAlsum+njFMBOaa+VWRA8ACpef
         U9TKC22IeaK3gs8Of18anWuRq4AbQ9D0pP4PeahEzZE3MlkCFL1xVGUGl/96TFMuJmbD
         PF38v4J6PSetKnBuh15JBfaDdYQKqTxn9MnCH9/F4aPz99/roGMjzmKnb+nNptUoXJNf
         qbZ2B9mpNCSOxWjrAKNjbOQ1l/s3iQhatdwi7MOCcFcWCxbL+GcPGPqsvlEdo1A4aa+p
         TSLA==
X-Gm-Message-State: AGi0Publg+VnMnS38Jh56pQhvLUqWR77xhWU1k0ZOVaKnc6wZhP99emI
        bB2fFTpTbNNhE3/D140lno365dHr8/d3PcCVuQAVzbipDGb3kBf6JPNidnPkgYLCcNKMG6x0iJX
        EWZptGhyVf9ylfjEvDO77gEI=
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr2011209wmf.5.1586221667501;
        Mon, 06 Apr 2020 18:07:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2kbXjpwa81pslGC91wSJV93qqpn7rHzCxCLN6d5M/mFdqTlYs1aMMNlbk/4ocXf6OPo/tow==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr2011192wmf.5.1586221667224;
        Mon, 06 Apr 2020 18:07:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id l185sm66782wml.44.2020.04.06.18.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:46 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH v7 09/19] virtio: stop using legacy struct vring in kernel
Message-ID: <20200407010700.446571-10-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

struct vring (in the uapi directory) and supporting APIs are kept
around to solely avoid breaking old userspace builds.
It's not actually part of the UAPI - it was kept in the UAPI
header by mistake, and using it in kernel isn't necessary
and prevents us from making changes safely.
In particular, the APIs actually assume the legacy layout.

Add an internal kernel-only struct vring and
switch everyone to use that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c       |  1 +
 include/linux/virtio.h           |  1 -
 include/linux/virtio_ring.h      | 10 ++++++++++
 include/linux/vringh.h           |  1 +
 include/uapi/linux/virtio_ring.h | 26 ++++++++++++++++----------
 5 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0736248999b0..dd5732dc4b07 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -15,6 +15,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-virtio.h>
 #include <linux/numa.h>
+#include <uapi/linux/virtio_ring.h>
 
 #define PART_BITS 4
 #define VQ_NAME_LEN 16
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 15f906e4a748..a493eac08393 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,7 +9,6 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
-#include <linux/vringh.h>
 
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 3dc70adfe5f5..11680e74761a 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -60,6 +60,16 @@ static inline void virtio_store_mb(bool weak_barriers,
 struct virtio_device;
 struct virtqueue;
 
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
  * may_reduce_num is set, then this may allocate a smaller ring than
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 9e2763d7c159..d71b3710f58e 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_VRINGH_H
 #define _LINUX_VRINGH_H
 #include <uapi/linux/virtio_ring.h>
+#include <linux/virtio_ring.h>
 #include <linux/virtio_byteorder.h>
 #include <linux/uio.h>
 #include <linux/slab.h>
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 9223c3a5c46a..8961a4adda5c 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -118,16 +118,6 @@ struct vring_used {
 	struct vring_used_elem ring[];
 };
 
-struct vring {
-	unsigned int num;
-
-	struct vring_desc *desc;
-
-	struct vring_avail *avail;
-
-	struct vring_used *used;
-};
-
 /* Alignment requirements for vring elements.
  * When using pre-virtio 1.0 layout, these fall out naturally.
  */
@@ -166,6 +156,21 @@ struct vring {
 #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
 #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
 
+#ifndef __KERNEL__
+/*
+ * The following definitions have been put in the UAPI header by mistake. We
+ * keep them around to avoid breaking old userspace builds.
+ */
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			      unsigned long align)
 {
@@ -182,6 +187,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 		 + align - 1) & ~(align - 1))
 		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
+#endif
 
 #endif /* VIRTIO_RING_NO_LEGACY */
 
-- 
MST

