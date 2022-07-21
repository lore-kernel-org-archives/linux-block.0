Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00224CCA488
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiGUNJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiGUNJZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72A11A
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gs3gxv7YI30wcMrn3hKT8kRkLYOeC85Hk4qn2bIHk7Y=; b=SGp0H93lCIfb+TGBvjMc2dnCID
        wz89b0thndHkfbs2Ee1bhpI7S/0R4i9PDmaMvT2Ae0OW/WUEdahyol5dT/L2vLBX8Ps0K81DTTeqA
        THdtFYskZBg2CcHcmgfAx+mhkWSCRq5xYH+J1P3rjlk0fVRJTw5qOvE9fMm/pkGkXxij8L6iyBjkG
        C/ThjxP0axb3DECwMbdwcq/qqk3dFr1/h4VT8ApL09yDFMUpFdfY8RFwKT4I627rk8lCcVAL2MZRW
        acdYtmx4zRe2h65ZYWufryhUXovjhkEQfE2jgdc0XjYOULf9IRXtPpFAj3Jp52J6r7H2kX7HHUYdX
        YGyFXatQ==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEVvd-006mkB-QX; Thu, 21 Jul 2022 13:09:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/8] ublk: add a MAINTAINERS entry
Date:   Thu, 21 Jul 2022 15:09:09 +0200
Message-Id: <20220721130916.1869719-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721130916.1869719-1-hch@lst.de>
References: <20220721130916.1869719-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make get_maintainers.pl work for ublk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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

