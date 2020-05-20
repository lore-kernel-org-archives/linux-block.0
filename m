Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CDAC433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 23:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5C120873
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 23:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aUOolwmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgETXCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 19:02:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7017 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgETXCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 19:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590015722; x=1621551722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bWMZiFoqSUL/3acCdJU4JlzT00LV/k5w2vpIEvv48ug=;
  b=aUOolwmgoE0V7rc6LNGzSM5W0Je6hpjvpXTGCFOtiOfWWuWZuuFzg6qU
   dQTe6QuqdnXDNMcLh1th7+0moiEps7oGwhw1/u5L3UovcyF8/sGPAbSQT
   G22RVVALQs2/+PM3HrTkQtPEeDZeYP5uI3NWijU1+IRXGWDH+gVgEKa87
   h2TdgHPH3QIJzHC9VGsqgrV4Y45tEp3cOzZ4duRqpbi72MQnFuNMcM8li
   p5uXqS33939pWIs6aE4MC24UXxWGp5Hq4D2+fDmWDed/Lz+5gKUXpuur9
   vqd7PSefWbB7yqzOtUEhcTDJ8aT4bIs9fxRSyuDtMEzHFyt2Ek0giDRBO
   g==;
IronPort-SDR: AhoI9/ycKpW4vnDlFfagplDPfEzEc7zDB32MbLzu2MZ63dTpRwxmOv5yUDRzh97fwmxHlx6z+v
 7aAM8iVXrOr5spM+iz7ULh96qvNXstNL1EJcg+DS5Ta8FGkR9hCSE1r18arxRkrrrMaW3CNGIM
 UNRY3CvNVjXcyy83ks/XzLwXVTQMXF39gaZ69cRe4TdGP7ID6LlCwUm5ysOyNAqcTyiNFgmMd1
 DELs6ymruGBZI8+QL7G+Bqn1ZT9vOZYYWdh5BODGCkhOGXNLUzkz1IDEpQaosBP8AvA0CbUEIZ
 1mE=
X-IronPort-AV: E=Sophos;i="5.73,415,1583164800"; 
   d="scan'208";a="142501782"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 07:02:02 +0800
IronPort-SDR: jnFY+/w9Qwg2Shfm5lbaDMIHheOEtXfyAoWU2+o+t5lwQdRWQUJEIliIknTgz8jNZzZ85JQkZi
 yDEr1v3U2bikMOEDVlme4AyZ4BHxrVv5o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 15:51:30 -0700
IronPort-SDR: SEE2uupmrcZbQopvI+kjFc/eujRT2nmhF72H62hHzIv4JHfJdJVFRcCxqxOmprLUGRKi94xNoT
 /6Vc/miTcppg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 May 2020 16:02:01 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/2] null_blk: return error for invalid zone size
Date:   Wed, 20 May 2020 16:01:51 -0700
Message-Id: <20200520230152.36120-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200520230152.36120-1-chaitanya.kulkarni@wdc.com>
References: <20200520230152.36120-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In null_init_zone_dev() check if the zone size is larger than device
capacity, return error if needed.

This also fixes the following oops :-

null_blk: changed the number of conventional zones to 4294967295
BUG: kernel NULL pointer dereference, address: 0000000000000010
PGD 7d76c5067 P4D 7d76c5067 PUD 7d240c067 PMD 0
Oops: 0002 [#1] SMP NOPTI
CPU: 4 PID: 5508 Comm: nullbtests.sh Tainted: G OE 5.7.0-rc4lblk-fnext0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e4
RIP: 0010:null_init_zoned_dev+0x17a/0x27f [null_blk]
RSP: 0018:ffffc90007007e00 EFLAGS: 00010246
RAX: 0000000000000020 RBX: ffff8887fb3f3c00 RCX: 0000000000000007
RDX: 0000000000000000 RSI: ffff8887ca09d688 RDI: ffff888810fea510
RBP: 0000000000000010 R08: ffff8887ca09d688 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8887c26e8000
R13: ffffffffa05e9390 R14: 0000000000000000 R15: 0000000000000001
FS:  00007fcb5256f740(0000) GS:ffff888810e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000081e8fe000 CR4: 00000000003406e0
Call Trace:
 null_add_dev+0x534/0x71b [null_blk]
 nullb_device_power_store.cold.41+0x8/0x2e [null_blk]
 configfs_write_file+0xe6/0x150
 vfs_write+0xba/0x1e0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x60/0x250
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7fcb51c71840

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_zoned.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 9c19f747f394..cc47606d8ffe 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -23,6 +23,10 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		pr_err("zone_size must be power-of-two\n");
 		return -EINVAL;
 	}
+	if (dev->zone_size > dev->size) {
+		pr_err("Zone size larger than device capacity\n");
+		return -EINVAL;
+	}
 
 	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
 	dev->nr_zones = dev_size >>
-- 
2.22.1

