Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:29020 "EHLO
        BJEXMBX011.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753040AbdJaKib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2017 06:38:31 -0400
Date: Tue, 31 Oct 2017 18:38:24 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 2/3] bdi: add error handle for bdi_debug_register
Message-ID: <100ecef9a09dc2a95feb5f6fac21c8bfa26be4eb.1509415695.git.zhangweiping@didichuxing.com>
References: <cover.1509415695.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1509415695.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In order to make error handle more cleaner we call bdi_debug_register
before set state to WB_registered, that we can avoid call bdi_unregister
in release_bdi().

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 mm/backing-dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index b5f940ce0143..84b2dc76f140 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -882,10 +882,13 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
+	if (bdi_debug_register(bdi, dev_name(dev))) {
+		device_destroy(bdi_class, dev->devt);
+		return -ENOMEM;
+	}
 	cgwb_bdi_register(bdi);
 	bdi->dev = dev;
 
-	bdi_debug_register(bdi, dev_name(dev));
 	set_bit(WB_registered, &bdi->wb.state);
 
 	spin_lock_bh(&bdi_lock);
-- 
2.14.2
