Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23486C433FE
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 08:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0635561075
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 08:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhJ0I1D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240757AbhJ0I1D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 04:27:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5FE2610A3;
        Wed, 27 Oct 2021 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635323077;
        bh=fuavJKqTEMQa7JoG2X+Zzm2ZacR6svyusTomZQKHh3E=;
        h=From:To:Cc:Subject:Date:From;
        b=WbP3g+TK25VTPrqzzH9TVDCF/ln0RUu0iXFf83tTRZHjrg6OlsFzHIzU0cCk5dwd9
         SLs1ZGtogfN5lTPq+pQYr0J3N32Rp7NsE0DHtDzwQuNBthwgClgS/N+pfHD62OxC9b
         gQyCOeLWbc2ocdr33u4Gk+7Kt9vQ2r3Xq7fFuh+q0vtUbENYBoOd9C8JnPt87xPwok
         TQH6K7EpsDy5GMJQcqUaWKSyKD1nt0juFPAgWIvA89r+UDQPgNPGLLCCpH7ylGEMNN
         XzGnLnn6dVfGyf7zBLfoCrGvL4u1t2/KuAba0hzh+zHBulaI8bZ81EKlegisDHooDv
         qNEyJBPw0mHqA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Feng Li <lifeng1519@gmail.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-blk: select CONFIG_SG_POOL
Date:   Wed, 27 Oct 2021 10:24:13 +0200
Message-Id: <20211027082433.52616-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Switching virtio-blk to the sg_pool interfaces causes a build
failures when they are not part of the kernel:

drivers/block/virtio_blk.c:182:3: error: implicit declaration of function 'sg_free_table_chained' [-Werror,-Wimplicit-function-declaration]
                sg_free_table_chained(&vbr->sg_table,
                ^
drivers/block/virtio_blk.c:195:8: error: implicit declaration of function 'sg_alloc_table_chained' [-Werror,-Wimplicit-function-declaration]
        err = sg_alloc_table_chained(&vbr->sg_table,
              ^

Select this symbol through Kconfig, as is done for all other
users.

Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index d97eaf6adb6d..2a51dfb09c8f 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -371,6 +371,7 @@ config XEN_BLKDEV_BACKEND
 config VIRTIO_BLK
 	tristate "Virtio block driver"
 	depends on VIRTIO
+	select SG_POOL
 	help
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
-- 
2.29.2

