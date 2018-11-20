Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F23C43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269F42089F
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XLigWByW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269F42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbeKTMTV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:19:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40409 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbeKTMTV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542678765; x=1574214765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdPQ51DBHO9uAZOn50XLl5Jxrk4reQVutmFr+jpaWRY=;
  b=XLigWByWi6R6QckkB7I4NPSywBCM9DhKPNF0AjEiMOHncR1yZqK3YzgE
   HxN76zEDxmMeMItljF+YnwGCqYBZ120ZKblEs6uwLV+x3VNIKIzRT/Jx/
   tnYVLyFDK3YTO9tfw9Xwmx3M5K6Sr/FEprAyZYmTxPp6KvD2dHIEoACIB
   i3HRay5q7si71/qwXTDtAgZXj2MMQfMSjNx700ricoMRa1+qOfXZpHYEK
   pZfcqtPVpBhUSUuL/pPOFWpZHtZ6Tta6Gn2EwMS69jNhHb05OlGFKDmy9
   lhdm6o/iXsOHYpw9Np3si7uPqcYrfqBxin347/chLOUzpvKtxRYAuzOSS
   A==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="95813256"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 09:52:44 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Nov 2018 17:35:59 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 17:52:42 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/6] aio: Comment use of IOCB_FLAG_IOPRIO aio flag
Date:   Tue, 20 Nov 2018 10:52:33 +0900
Message-Id: <20181120015238.26467-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120015238.26467-1-damien.lemoal@wdc.com>
References: <20181120015238.26467-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Comment the use of the IOCB_FLAG_IOPRIO aio flag similarly to the
IOCB_FLAG_RESFD flag.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/uapi/linux/aio_abi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index ce43d340f010..8387e0af0f76 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -50,6 +50,8 @@ enum {
  *
  * IOCB_FLAG_RESFD - Set if the "aio_resfd" member of the "struct iocb"
  *                   is valid.
+ * IOCB_FLAG_IOPRIO - Set if the "aio_reqprio" member of the "struct iocb"
+ *                    is valid.
  */
 #define IOCB_FLAG_RESFD		(1 << 0)
 #define IOCB_FLAG_IOPRIO	(1 << 1)
-- 
2.19.1

