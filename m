Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C2C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGUFQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGUFQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:16:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84079ECA
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=H72h2JvByxb5W1o2dtY465ID2BKO/juYzUUuupKE3ec=; b=A6JJaTW7+mjSDyb+yT3l0FV4A1
        d4tgXjH5Fwl3nwvLcbn3DaY4I6XZsQKe3HfWIWtHKt6+Zp+1e6xTitYOrPxJdQ/x29I+6ed8x9h8M
        SLckSWSUpn/Xr493gQKjRkQn3D3l57ZZzYQ62/lZ6i75V9ok/S5vR4gxYDn6qL1+LGHpmKL3YK/bZ
        9R3DYa5pW8FJ9DELg49kFSMlwBpEBhGl0lSA8LujQ1RX2YUjl1SLpvFWSRXIiBMOo7PgPm+kWTKZO
        jdT7hGIChIy1mHfVYNiH9MZVKurxFWAM/6OAv5AjwLJ7J4QgnBJlL6p7TDLIkEiO8w4tFtB7/ycfE
        jyJDlt0w==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEOYB-00HDRr-8t; Thu, 21 Jul 2022 05:16:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/8] ublk: add a MAINTAINERS entry
Date:   Thu, 21 Jul 2022 07:16:25 +0200
Message-Id: <20220721051632.1676890-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721051632.1676890-1-hch@lst.de>
References: <20220721051632.1676890-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make get_maintainers.pl work for ublk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf1415013..8a4bbca9f28f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20415,6 +20415,13 @@ F:	Documentation/filesystems/ubifs-authentication.rst
 F:	Documentation/filesystems/ubifs.rst
 F:	fs/ubifs/
 
+UBLK USERSPACE BLOCK DRIVER
+M:	Ming Lei <ming.lei@redhat.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/ublk_drv.c
+F:	include/uapi/linux/ublk_cmd.h
+
 UCLINUX (M68KNOMMU AND COLDFIRE)
 M:	Greg Ungerer <gerg@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org
-- 
2.30.2

