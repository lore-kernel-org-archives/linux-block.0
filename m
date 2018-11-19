Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA8C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDDB20817
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zc2FFtxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDDB20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeKSONx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:13:53 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62727 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeKSONx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 09:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542599497; x=1574135497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MdGOl0NUx0ZiANgGuUGhQRcuAwTeVGsY7Kq8hiZZ72A=;
  b=Zc2FFtxlW3xunGA7P1Mu5s2ueEn9X5Vs6tA7Rxka6OsVxP6LvmtmS5yS
   VbMNGQaW+xbaq74a/LgC932AA23bBYTAx1QdCFch1j9xljUhxTEd7IYOI
   Ap3/8zfLGwBUt/AzwnQhd/tHVfk0CA5tz5BKtts1hkU+AcsGV9INUbmQL
   bpnF30wiQku32wsZ97Lqz3QGPOHHN3OG5OGUu2uJbuoI6rfqQDeMl2Tp7
   fYdf6rMLvrG1K9wm2opDdgs6Vmicd6dWzrA9liL+Mv/D8DIkiufs83twj
   iGeOqpPCIXbSzLN3ip5VBozRHAwIhNfekjYOrpSgORwBWScY7ETmc3w7n
   A==;
X-IronPort-AV: E=Sophos;i="5.56,250,1539619200"; 
   d="scan'208";a="96272447"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 11:51:37 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Nov 2018 19:34:36 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2018 19:51:36 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] aio: Comment use of IOCB_FLAG_IOPRIO aio flag
Date:   Mon, 19 Nov 2018 12:51:25 +0900
Message-Id: <20181119035131.11255-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119035131.11255-1-damien.lemoal@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Comment the use of the IOCB_FLAG_IOPRIO aio flag similarly to the
IOCB_FLAG_RESFD flag.

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

