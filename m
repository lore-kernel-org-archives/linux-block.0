Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346C6EB64DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGDQwY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGDQwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 12:52:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAE9E41
        for <linux-block@vger.kernel.org>; Tue,  4 Jul 2023 09:52:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso6919574a12.1
        for <linux-block@vger.kernel.org>; Tue, 04 Jul 2023 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688489537; x=1691081537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN7i8sOpMipC40cVjppg9yu+Ps/zil9DAOK5KLDUw0M=;
        b=YnGaH5q+0mIaDQVxcj8VDtedKRiYHSnb62uFMjDO2iLG4NGLiHnr37a9E/mkOlwqZO
         kgloe5K90mNkLAHoxxm2I/boPTp3Og+Q21xzBYrOhPZ4W1OH0zlmbMA1R4z9IGn7j6zb
         Gmoxe2x4OEcQCw1KRgL1BPGouhgFIy9UmxP8RqbYvWq4xHTuW0Ij+nz9bjjx+E2oQIWw
         Ihbu7uO3ua087o1mZ0W8ShexOzdxsWkljy3b2yTBwq+NwhL/J/hqXUKq/gfb7V0DZg+b
         CMJORX2P6hCknhGJNGt6vfSBBw/eINF8eKZyE14NSWhLwwM2dr0XozOc/efnuPu0foU/
         6bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489537; x=1691081537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN7i8sOpMipC40cVjppg9yu+Ps/zil9DAOK5KLDUw0M=;
        b=fOafmaqT1Kx2boE+le5Z67ewXNbyxtJbfoMx2vbGQwDBcfoh/Vn6bIMS71LaOz2XyO
         dzldZduFhpifQh5pkUDMCU+3IpdQX4JzmtUh5AZYlJ1Cb5VP9XLPVetv/qwnuWzUtXx4
         Rc85rXw0XvcCRu2oY7zrqJkFxLS9osV3b28PDL4tnyiRFjU7KRmFjhtGGPWX58BttYla
         qdwflfuAeu0PSTVKKICCJ/Up5z+J7gc4cb/jKWE0Uh4mTCU+pTKrxvWcVIgBR0hYt0w7
         r1+iw4N2roLB3GNSBgJtI+0cRmB6a2HCIHaw0Q0EAZsOd7AGy+5I+QjcJu61r7yV8Q8r
         busg==
X-Gm-Message-State: ABy/qLaunTjvN+vhZ2v0rz16NaEMMY9gwXvqCukmgO6XaIg/YUYdvhAy
        jtyb7k7iInpi7GPeWtUNo9+pYQ==
X-Google-Smtp-Source: APBJJlGKx4vy34xIBpHc/A5jn10VM2QYpTMPqPR5bUEH3ebXZEdtKg7qV2KbKs0un+Z5iCbNtnQAiw==
X-Received: by 2002:aa7:c489:0:b0:51d:eb90:4928 with SMTP id m9-20020aa7c489000000b0051deb904928mr10924266edq.30.1688489537566;
        Tue, 04 Jul 2023 09:52:17 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id g25-20020aa7c859000000b0050cc4461fc5sm11872717edt.92.2023.07.04.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:52:17 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v5 3/5] ublk: rename driver files to prepare for multiple translation units
Date:   Tue,  4 Jul 2023 18:52:07 +0200
Message-ID: <20230704165209.514591-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704165209.514591-1-nmi@metaspace.dk>
References: <20230704165209.514591-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

The zoned storage support for ublk adds a translation unit to the module.
In order to be able to keep the existing name for the module, rename the
currently only translation unit. Also rename the header to align with the C
file name.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS                          | 4 ++--
 drivers/block/Makefile               | 1 +
 drivers/block/{ublk_drv.c => ublk.c} | 2 +-
 drivers/block/{ublk_drv.h => ublk.h} | 0
 4 files changed, 4 insertions(+), 3 deletions(-)
 rename drivers/block/{ublk_drv.c => ublk.c} (99%)
 rename drivers/block/{ublk_drv.h => ublk.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ace71c90751c..1f193cd43958 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21553,8 +21553,8 @@ M:	Ming Lei <ming.lei@redhat.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	Documentation/block/ublk.rst
-F:	drivers/block/ublk_drv.c
-F:	drivers/block/ublk_drv.h
+F:	drivers/block/ublk.c
+F:	drivers/block/ublk.h
 F:	include/uapi/linux/ublk_cmd.h
 
 UCLINUX (M68KNOMMU AND COLDFIRE)
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..38f2229623a8 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -38,5 +38,6 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
+ublk_drv-$(CONFIG_BLK_DEV_UBLK)			+= ublk.o
 
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk.c
similarity index 99%
rename from drivers/block/ublk_drv.c
rename to drivers/block/ublk.c
index bca0c4e1cfd8..a0453619bf67 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk.c
@@ -45,7 +45,7 @@
 #include <linux/namei.h>
 #include <linux/kref.h>
 #include <uapi/linux/ublk_cmd.h>
-#include "ublk_drv.h"
+#include "ublk.h"
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk.h
similarity index 100%
rename from drivers/block/ublk_drv.h
rename to drivers/block/ublk.h
-- 
2.41.0

