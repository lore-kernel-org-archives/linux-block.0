Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B9C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB0520747
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kzKaQIqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725272AbgGAE04 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:26:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48864 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGAE04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 00:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593577616; x=1625113616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6cc78oiWu0VLdGWGdIJhM2ghW2QUab8wiXWlbiWn4kQ=;
  b=kzKaQIqu2j4ZulcA+VdKdSaQwEq4oHF5+PChc9yNQfFLf8sD0cNJqIjQ
   /xWYJyKPygPj48RaYiSTzp+ivbXTdNM07+sz5zy9ImVq//yIcdZI1jt1i
   VJHhfN9MXAzhHz7c683iKoRmL/jhlbA8aLa0/V2KdqHrxaK/Z5IUNh9ce
   RBMCfV16cHSFr48gvPVkHUdJjKmqQ4920Eu3e0TnUyFwIxnATBvyeQbDD
   u/m05cpjiwZK/NPfI5FdM1V3Ixo8kknJ2EOCKv/N5bqwNVSJEr7M4YBh2
   Kp8XUsuOAOfolBciKePHdgnVDxxce6ljXJjOuvN1K5rfNm0kqzOuy7/nz
   w==;
IronPort-SDR: L1YM3uOebIawj6MMjkv1Jc6C8+2Z8uoNNXMsuFC3r86Fzf5Ojc0BKs8tJFcT+HMuKP4KkvYRs8
 nhyOKUNjGGaT8JqzHwGHQJuLxwVZLK7Kr1zgyXxvokYuPuG9XTlgXh7rfPY6wbDGs4teYIIBeb
 /KQiiQvXYWJXZDJ8fJ2OUpU3BRlRBNZICKNQ1cFpilk5hsm8bK03BxyMK/eJNohKndKh66zI3u
 2cB+tp/QBD+uTFka8rcTu9KfBiYujwBjGf1hL+Lm+cTYwYXT0EwnQTlYWowMdZzyaprmjLeXFJ
 yOE=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="141545165"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 12:26:56 +0800
IronPort-SDR: bq65FfinFkn2UBAWSBdgkVbdeyr71TXaq946Zs/83SQU+lxEySsD4zyPuaAbOrdqIBAZRajRum
 JMxgDeXWWsMnRE7EYYy41gW+68iMDy82E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 21:15:13 -0700
IronPort-SDR: rbhK05fuCbLbM6LKGhnDz/zTv9t0EYAhf31WtgoZXOviLxX4v8mp0OGx4by6pd5v+1f755h/Ov
 6zTaRgt/oSjg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2020 21:26:55 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: add helper for deleting the nullb_list
Date:   Tue, 30 Jun 2020 21:26:53 -0700
Message-Id: <20200701042653.26207-1-chaitanya.kulkarni@wdc.com>
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
---
 drivers/block/null_blk_main.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 82259242b9b5..870290f686ae 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1859,11 +1859,23 @@ static int null_add_dev(struct nullb_device *dev)
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
@@ -1930,12 +1942,7 @@ static int __init null_init(void)
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
@@ -1947,21 +1954,12 @@ static int __init null_init(void)
 
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

