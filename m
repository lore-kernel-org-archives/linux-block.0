Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43427 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbeHOGNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Aug 2018 02:13:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so10148058pfi.10
        for <linux-block@vger.kernel.org>; Tue, 14 Aug 2018 20:23:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:1501:200:5efe:a66f:53fa])
        by smtp.gmail.com with ESMTPSA id a15-v6sm35956157pfe.32.2018.08.14.20.23.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Aug 2018 20:23:19 -0700 (PDT)
From: Jiecheng Wu <jasonwood2031@gmail.com>
To: linux-block@vger.kernel.org
Subject: [PATCH] pktcdvd.c: Fix wrong return code when alloc_disk() fails.
Date: Wed, 15 Aug 2018 11:22:51 +0800
Message-Id: <20180815032251.32136-1-jasonwood2031@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Function pkt_setup_dev() defined in drivers/block/pktcdvd.c calls alloc_disk(). However, it forgets to set the error return code when alloc_disk() fails. Instead, when alloc_disk() fails, it simply jumps to label 'out_mem' leaving the variable ret unchanged.
---
 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b3f83cd..f63fa1f 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2716,8 +2716,10 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	pd->write_congestion_off = write_congestion_off;
 
 	disk = alloc_disk(1);
-	if (!disk)
+	if (!disk) {
+		ret = -ENOMEM;
 		goto out_mem;
+	}
 	pd->disk = disk;
 	disk->major = pktdev_major;
 	disk->first_minor = idx;
-- 
2.6.4
