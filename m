Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B117C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170C320866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AIejgRFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEAE3h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:37 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27525 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEAE3h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685061; x=1588221061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wkb1CJ1VII7+Njrh32D+O8w2t5E/FaDUJHERlVXbyJM=;
  b=AIejgRFe13W0ERgS9JuhKyz8KvVsCc20XvHzcqh8iLTPcED6jEOFFB2c
   2bU3EjqhNCVzFDs+732qMY4zLKJI52HW/a70GbEu3EPKAHWj/bEPNYZ1D
   BIUHGQ8aayyA5mJsVMBw67iyAe/mm4MDK7WeXD/JsVdGnGSFKZtduibVj
   XV9F69L+9zdQWryaWzzkQtA00Ba5cLVwV7lHYuQKsTfKJZYw913qxE8Mh
   55oI8o12F65AMLOAzj42axy8d/mGwmbDZzHZCoujo/QkchmQcLfBDPt07
   TudDXclgB6o0NEpIgOug0v03tkaGOvWsKE3c9KNt0n058ulU4psZeDSDb
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432303"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:31:01 +0800
IronPort-SDR: BIaEILFZsXTxe7yz9vMgpquEWOBbcj+ov4hqtvmNcOM4QBfWwgwk+xVdJJbfG4GsRdSZZG4z5A
 U5V6vFzbNwB1qosWxb3a1ylumnPh0dFhBfeBHL+JZnlT+ZC0LidwsapLSIXcvCX0aZJQ9r4ktC
 TjLBAs7T52zIxRJBZq9AweQBnxmlZ4n19zWyhwmGEb77nMRep6wIkUU5yIUhDy2QTuS4QIDo5/
 ybbV8a7PAxyZp6pO5xqYu6ki5pJNBQ3owh10hYLirO6yYbh0SbbVelJSUZnZ/JwIWGqE53WMY8
 lged9xIo1SGeE1R7hd7AMkBr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:08:06 -0700
IronPort-SDR: v5ch9qDX7CXP2Lu3OKrQiUSnGp3LnIkETjJ4NAabwngPMCTcfVBx2L68D0gfZ53sXbG7aJlV+7
 SkQiNac7WXBDx2B+mau+w4PDUmgRUKvTYsKCkX7cY57H+jxvO8tMjyWSZ2na90GmIxRSBI+rPw
 A8TT+xnIw6zHWdRFoj6PEllS50iidZWLwmIQZUx1GBHppaMhOErEaAoQUMjiik+V5jlUS63NsE
 rZwKWPA9ZlN0+9j03xsrncvWLkyiH0tzV7OJJEPAwVtW1VVrQ50fti+8z19NtRZuNzeYGDo18D
 nIg=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:37 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 17/18] null_blk: add write-zeroes flag to nullb_device
Date:   Tue, 30 Apr 2019 21:28:30 -0700
Message-Id: <20190501042831.5313-18-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a new write-zeroes flag just like discard under
struct null_blk to enable REQ_OP_WRITE_ZEROES operation on the null_blk.

This is needed for testing the blktrace extension with different
priorities on write-zeroes operation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..ecd1e45f6eb9 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -63,6 +63,7 @@ struct nullb_device {
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
+	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
 };
 
-- 
2.19.1

