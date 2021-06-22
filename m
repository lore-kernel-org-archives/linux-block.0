Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC251C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B68A600EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFVXXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:23:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20440 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFVXXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624404060; x=1655940060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZpDFB6Gpfr8TaRMuM24DVDTZp0S08wtIDr6hUfkIAAI=;
  b=HuYivQT6T2pQQJz3NfkGGIobs05lzk+7BOgxbt3rZc4zvlPaPrbSWiRT
   OAuJWet/ahs2njnILt/szBi1QW3GCTP4L37vFuHUkAMcyTU6RoXxEc7++
   wdTRuLuFkAhKBk6PWh4o+WQGm9urrNKaJ3iHbJ68WIRwGY7+Q8QiDv6vh
   QJ+2RDaj0Y2kI4+rKqdW66XzADPi1mr6PnhZ1yzMoBEhAz/2T5S1CBiRV
   d2uYYOvKbs/8p2wTC7uFzGw1J7lR0WxuXHuh7f3P+Op440NlqcLnbP04+
   2v5XJQRWFfUDKx5FwLOOczf96fw2MlhHOOmzNkxSD5WZ6wOnARhrawUwq
   Q==;
IronPort-SDR: 5KHDzmRhey9LcB2/M3aUJ6XCHzoSVTLBhgkLVvmRFYQQV4xGzdHw3/c6F682BZbY0CHoeyjnqA
 GINuiyUmcq6Dzq7lsBs2wCNFGQNQZfRZPkgnZ/4+bFgRCCKFGx2rQ82Ohbgk257AZoBdoX1smI
 0HJY8yOa/W3Xg/R08QwG80vqyKVTuQF9I6vXhBz4cnrDI3ubC/MEElkcG0FvZ70gm0rj/tK6TA
 jmVw0YmrPGHZbi7u5xEqWub75Tp23VoARiShUSWKHnHBeOAHmZBhiPrblYQ1hZOeFYWcCvDyX5
 VLg=
X-IronPort-AV: E=Sophos;i="5.83,292,1616428800"; 
   d="scan'208";a="172632959"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2021 07:21:00 +0800
IronPort-SDR: OYo6Nrc9NN0aemBGeClxlN7oxtsaiEXMpji0cTTr7UdxmF9SHtFIk3dEh8FXfxH2ix5jkx1+Tk
 gpzWzkQ9b4DnFg/eQ+I1geBUXI0PnULdsY8BxRV9p4UglCmOycZYH/ncoYM58xR4HNQedoYWhg
 Iza1U0ilFaLkmLqJn4Vlyno3olhocN5hEn9X3TQ6tAo+xaJM7ff7cOshGOkuNn2bM0ixGKrudz
 LvGFqf/sU/8YA+ad1cWX1u4gZ436Td0MRF4srj4iskaFjb6v54yiWz48fP1GOpEHGh5lIMvgwu
 iStkRBHWi/8emYlUigSHAee1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:58:17 -0700
IronPort-SDR: L21GhuGJV3SA9BU2o3e0IBLKsAg1K1zS/fBo8W/WK12ujLAgr+6fJ4Yp3pWN0dr1z8GKx6zE5N
 QiSDTDJ/4yWel4FmK6mORB1Zzz8lSqwS6wo0gdRuEVAGZRDibYuuTNn9zK9rHE1QX+MfYkSXhk
 datC46KxhSUn67qIXDRS2muitiSPAqEnecUO/NP5Yi9mgxcvA9NyMuggq9TYDEpAxCoA8OGgIt
 EuMBh4UO1tkSTCfKyVlk5XiJHqiXRCM54TW4TFtKRqYLQewW7YrEwcv0oxALse3noyFytxUO0I
 tSo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2021 16:21:00 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 6/9] loop: remove extra variable in lo_fallocate()
Date:   Tue, 22 Jun 2021 16:19:48 -0700
Message-Id: <20210622231952.5625-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable q is used to pass it to the blk_queue_discard(). We
can get away with using lo->lo_queue instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index abb9f05e5a53..52f0b68466c0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -437,12 +437,11 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * information.
 	 */
 	struct file *file = lo->lo_backing_file;
-	struct request_queue *q = lo->lo_queue;
 	int ret;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!blk_queue_discard(q)) {
+	if (!blk_queue_discard(lo->lo_queue)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.22.1

