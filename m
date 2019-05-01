Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7CCC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8FC20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gxKBSXzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfEAE3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27525 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEAE3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685056; x=1588221056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LhJYIZ3SYC/hqcvf5LDzCKrgZc+X0IY4SLeeHcwgZFE=;
  b=gxKBSXzXhHhCQPot1wNItNjmbR8LBZQ0jB3ULPY+IBCzMKDf/38gwwC9
   cAKte+5CWhP2VkD9Umdv+FTN4Bl0hsln1mM8SVe9rVGxSQtJiFpGjLgba
   6SlllZRMORzdx3SSQFRR0o/NE1BUTzKjCS7jt+jXOtHvrARumg/9kUyly
   q78R9v7wpDPRqZ75M+P9POmvoJw9YGAy/jXS66TbRVUWwuVaYQK4em1lm
   SSkFkkdvJ9NMaizElcsGBVvLDBzJDr1EaYJfyIxn3bbpyte9HWmgrs8kx
   zhvJWg7eiLWVPVp2gL3E9ec+bjMPUMpjOvMjDltyajMZGm81rfwmem3EG
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432300"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:56 +0800
IronPort-SDR: H6gI+ve//mPQwWcaNw8NLyZA7svo3h0S61sVWbPo7+M2mAkgCdk0oSYnQQNjxp2cmwG5rbQULk
 YxThPJde4UO3meH02+4Pozg8vI+ijtLr+dwykrf9XPVkqF0Chy/tYWCDftz0HCWC+ceaH8vY7D
 ipF0XWZCEzMEUdsGNAU6ai2uy4GEiIolRVnKHDd1e/CgSslQCpGd6EAwdmsDWUs03wBSqYgptK
 26Pnz8GY45FbPO79EmAj08htCcM2YSpsw08UvO7KmEKrw8O/xhor6Ni0kzc81QR+GsdG8VbER9
 yJ9Z0h9BIMG0Xuz4zz5eXZUT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:08:02 -0700
IronPort-SDR: VpVO5KUNzqacnmrwqJVZlzauAcg+YHOZcjp8egcLsipUF6vTD8zPQLWnB/xHQItTaRWic0ZtO+
 m42E/qSCyX9DUZyi5se8+0yqaq9INXgiSUsqpbo9pZBY2sXVZMznD3h7+dVq5smA40SfBxWX3E
 tm8Q7wfQ1pEwu+XrCuFLllt1/GKaE7Y/il7/iQky/kdK0ooLix/53QXeMKLlBo4ODZnz6W6+6r
 n/U0NG/MnuYE40BVQoIMqWNXmBeVcKZRL5vAq6gP92fmd+n9QysI6CvOTkmIBjcamk9YYZ1tP9
 Hqo=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:34 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 16/18] mm: set bio iopriority field
Date:   Tue, 30 Apr 2019 21:28:29 -0700
Message-Id: <20190501042831.5313-17-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 mm/page_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index 2e8019d0e048..950cc002f60a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -24,6 +24,7 @@
 #include <linux/blkdev.h>
 #include <linux/uio.h>
 #include <linux/sched/task.h>
+#include <linux/ioprio.h>
 #include <asm/pgtable.h>
 
 static struct bio *get_swap_bio(gfp_t gfp_flags,
@@ -40,6 +41,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
 		bio->bi_end_io = end_io;
+		bio_set_prio(bio, get_current_ioprio());
 
 		for (i = 0; i < nr; i++)
 			bio_add_page(bio, page + i, PAGE_SIZE, 0);
-- 
2.19.1

