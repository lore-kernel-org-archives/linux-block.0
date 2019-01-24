Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0BCC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689B02184C
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IGuSsU+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfAXJUT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:20:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11671 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXJUS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 04:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548321645; x=1579857645;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=FmMKUdPhVcSHIrq/aoz74ugEjHRHopclwJy78syYUdU=;
  b=IGuSsU+iOOsr1KYasZVEs+E/QZ050ZQ8ffMHXb9V6TXXNB4BdwKhS+CQ
   keOb9vGxBflcGXfJ38TEm5J7hJph40bp05Bb+laql/4KfstU9eMzsTz7c
   MBnDQrfYtlh6YSE3au0AR1hrHdrSO4XU06g5dHyFTKjuirVe3dWmeh9mS
   u3ebLqHIxOCzMMAf2VTQoTwXss5xI6OPW+HimP3rD4oJ9fFFrfyzpCbv3
   AGMll+2EWJmVY/h5N+gDki/AeQJ1i02sZWvBOT3qkxuN+GpTkZkfKam+L
   7QdIg409TYBA+yUJ1FyNZ4nV/l9ph+hPNhg66ouJU4UXHOam4eWrbke3d
   g==;
X-IronPort-AV: E=Sophos;i="5.56,515,1539619200"; 
   d="scan'208";a="197760772"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2019 17:20:45 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Jan 2019 01:01:26 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jan 2019 01:20:18 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Fix comment typo
Date:   Thu, 24 Jan 2019 18:20:14 +0900
Message-Id: <20190124092014.28656-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124092014.28656-1-damien.lemoal@wdc.com>
References: <20190124092014.28656-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix typo in REQ_OP_ZONE_RESET description.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5c7e7f859a24..d66bf5f32610 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -287,7 +287,7 @@ enum req_opf {
 	REQ_OP_DISCARD		= 3,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= 5,
-	/* seset a zone write pointer */
+	/* reset a zone write pointer */
 	REQ_OP_ZONE_RESET	= 6,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
-- 
2.20.1

