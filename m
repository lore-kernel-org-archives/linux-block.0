Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1A6C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 00:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1467120748
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 00:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GOqqzAgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgGBAtX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:49:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9937 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgGBAtX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 20:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593650963; x=1625186963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2mE728bmsvHyQ812gN/5CisKb2i/dG2E5a8C6v2+4Z4=;
  b=GOqqzAgB0THwi93DQr/a1sG1GIJe7IVwcuU0fz2q3V35xw7SRru8Y5FB
   n0wyM/oG30LznYpPCgIVZZztdFQGG8hR/IdtXOnOaPbQGJm+Si/DsP3yk
   8IdlFPoWvdoiB93NNA8QylvP/P5tTpNCLy4wYnyn6eW4duxBA2K/tediN
   WFlekCtvXd8SdKK9wABaPyruqwox4ZlGKmRh5iF3oF6eeu5xBCezRyy7o
   G4Qq7zPiiGp/goUY34odzvx5S2RGS2DZ/YeIj0TG28LlBc8jPxB5RIiCd
   hqa7RP6u8IfcsrOoF5S0JdHuZdoh8W3jr/nEzmqn+mim07gbMX5STzA9Q
   w==;
IronPort-SDR: /seqFUziD2Jc0fqavQIK1+OW+1ioLp88fVsKNKz0Xma8sHYW3yl5g7wjI5lA7bJ2Qa1O28V3F4
 ThCJpwDAfE8wZ7LU/vKO1218c+cqDkbQpDUjE1csRO8UFb8krDmR3xgMQ7p5dfFiE52UjmI7xr
 51ecMpEgyDdZELZsUp4yLR900BXIH7cL6ndDqq9TPg8byv9BXZrh3RbwLOf590qz/KDdVUyABB
 i9tVOv0bZTqpOjNYz9zZ+zN10nqHDDmUQnBGj94DBbEhquTtmGfHM2gtlRlRLIHQyQtAjmnO+2
 /Ts=
X-IronPort-AV: E=Sophos;i="5.75,302,1589212800"; 
   d="scan'208";a="142783249"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 08:49:22 +0800
IronPort-SDR: BqljRPRKhBIN+1n1P3qV6NnQicSo+CJdMeYpfcmXJ5KgXIBt+MtYdi7nbv0Enyrty2eOJrviOv
 XRYQCLB7AqFjrWBFdQgz9Z6NNHEZ1wFI4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 17:37:38 -0700
IronPort-SDR: M/rJu84hnzT9bsCi5PCYAEGeGbdFes3u3Q31yD7dVU5sqFUklIYYLWKfPQ6F33RB77ERJqKM6J
 HlIYGtd+r/kA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2020 17:49:23 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V2] null_blk: add helper for deleting the nullb_list
Date:   Wed,  1 Jul 2020 17:49:14 -0700
Message-Id: <20200702004914.9017-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nullb_list is destroyed when error occurs in the null_init() and
when removing the module in null_exit(). The identical code is repeated
in those functions which can be a part of helper function. This also
removes the extra variable struct nullb *nullb in the both functions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

* Changes from V1: -
--------------------

1. Add missing sign-off and reviewed-by tag.

---
 drivers/block/null_blk_main.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 907c6858aec0..3f5ff75fcb3d 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1868,11 +1868,23 @@ static int null_add_dev(struct nullb_device *dev)
 	return rv;
 }
 
+static void null_delete_nullb_list(void)
+{
+	struct nullb_device *dev;
+	struct nullb *nullb;
+
+	while (!list_empty(&nullb_list)) {
+		nullb = list_entry(nullb_list.next, struct nullb, list);
+		dev = nullb->dev;
+		null_del_dev(nullb);
+		null_free_dev(dev);
+	}
+}
+
 static int __init null_init(void)
 {
 	int ret = 0;
 	unsigned int i;
-	struct nullb *nullb;
 	struct nullb_device *dev;
 
 	if (g_bs > PAGE_SIZE) {
@@ -1939,12 +1951,7 @@ static int __init null_init(void)
 	return 0;
 
 err_dev:
-	while (!list_empty(&nullb_list)) {
-		nullb = list_entry(nullb_list.next, struct nullb, list);
-		dev = nullb->dev;
-		null_del_dev(nullb);
-		null_free_dev(dev);
-	}
+	null_delete_nullb_list();
 	unregister_blkdev(null_major, "nullb");
 err_conf:
 	configfs_unregister_subsystem(&nullb_subsys);
@@ -1956,21 +1963,12 @@ static int __init null_init(void)
 
 static void __exit null_exit(void)
 {
-	struct nullb *nullb;
-
 	configfs_unregister_subsystem(&nullb_subsys);
 
 	unregister_blkdev(null_major, "nullb");
 
 	mutex_lock(&lock);
-	while (!list_empty(&nullb_list)) {
-		struct nullb_device *dev;
-
-		nullb = list_entry(nullb_list.next, struct nullb, list);
-		dev = nullb->dev;
-		null_del_dev(nullb);
-		null_free_dev(dev);
-	}
+	null_delete_nullb_list();
 	mutex_unlock(&lock);
 
 	if (g_queue_mode == NULL_Q_MQ && shared_tags)
-- 
2.26.0

