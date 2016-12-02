Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:64215 "EHLO
        mgwym03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbcLBFJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2016 00:09:47 -0500
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 54F7EAC0180
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2016 14:09:40 +0900 (JST)
Message-ID: <584101D2.4090200@jp.fujitsu.com>
Date: Fri, 2 Dec 2016 14:08:34 +0900
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-mm@kvack.org>, <linux-block@vger.kernel.org>
Subject: [PATCH v2] block: avoid incorrect bdi_unregiter call
Content-Type: text/plain; charset="iso-2022-jp"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bdi_unregister() should be called after bdi_register() is called,
so we should check whether WB_registered flag is set.

For example of the situation, error path in device driver may call
blk_cleanup_queue() before the driver calls bdi_register().

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 mm/backing-dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8fde443..f8b07d4 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -853,6 +853,9 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 
 void bdi_unregister(struct backing_dev_info *bdi)
 {
+	if (!test_bit(WB_registered, &bdi->wb.state))
+		return;
+
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
-- 
1.8.3.1
