Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167BEC73C66
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13B320645
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 17:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ck8RoSHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfGKRxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:53:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3393 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfGKRxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 13:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562867628; x=1594403628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WhqEzSaKJFKWtttgBwqSQfhUHuC0WynErfx6eW0N6w4=;
  b=ck8RoSHkwYveQB6sSicsGOVKTGfcjfFd7yHyK2/M4FdvYVNajGEA7ldQ
   AqmoN+g8mDdSDTmjfdTkduwPumjRVMGSo9CMK/NWmyLBTZbFc6kab18bv
   HPQud/3xPU2Ux3nHUbnCxFKVud+3BgOZfQe5rObqHMJjT0a35ab1rMc2O
   eGMWs3wDcJwJwrlhD4g67MFYYkyg3VMHzCXxqwpYAiBejh5u5mTdJR8lg
   Bwt7pkGo+Wei2qaOwskHY83PEkfk8TO5M7HO7EQLNw+m2iqTzkeL0VIZ5
   SA1ePXHgrJ7ELbPLbd4hp3RNG8Cpr6BM3EwMT5k+fvwH8LYjdJ9RQ6jWq
   Q==;
IronPort-SDR: D8Om1/2aR6x/Xo2V4TnFMj5Mb4aZ3BEg9Gq+d9aCzFVYrV2+nRSJNTvZzBIN3/oRM8DB+Tn+8b
 gi3IyjeWhbqvjoN+Zatec4U/GepKyw6uztkcZCKLK3J+apy7fZCjQC4p52PELg5AqqFwuSVzv/
 DUfPxM7RcHCudZM0SCE15/fNCWiYqGqdppfaGI5+p/48oJGPY7iCwh5BxfahjhMLc0ArD2JxUc
 3RFIe8MNfGx+eCbMzs2FYJSQTtXtPuuzI85c+hxwOjUIAOtatEjRBBNIY6CEVjUxasjiyHJMpj
 xyw=
X-IronPort-AV: E=Sophos;i="5.63,479,1557158400"; 
   d="scan'208";a="113960838"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 01:53:47 +0800
IronPort-SDR: xv2VaYJh7uPCX2nMmjk8T+SGWIfk1uiMsWGeYsotiI0fFmpO7W3TSKl4/ikk0ALg219IjMr35C
 182dbVI1ZWOmhyJVHQnJtIzEIkjWO0FHnU/O6ySRtlh+U6nBk5pxMrzt8A2h7mKb0C5J8c0aLL
 LiFd3B4CxL2V9GxZ9knKG7fv34WhZfQ2a8c3s0CPchDE2iy4xJwYj5vXQfiqV/lJ1HpkHPnZHT
 i5+vHAbMGuotBS+W03nNMkid6VJophItoByYTZ3hrEU6xOkYlm4B3ATnTMOzPoAIg62hogEXK5
 9FqX5QRueB9GOmPQ2c7wt4O3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jul 2019 10:52:24 -0700
IronPort-SDR: yHeHuJWxlc4jPwPshYROlAXREPbvXs2XXtHxcIwC4kt/ojQO+2RX7DSDrqnCz+dx/Fb4vgNhVx
 +0rIMuYFwdyMe9R8masB6ltRKQzZ23x+rR19hS2OMUnsdCQXCBiTf4m7S47ja03Nz0liAQaQZk
 eSfsVH5Nje/G3YG6NqBsa3tlNZCKFc3AwzTTAomEcce7PfAwH/nG4y05hRSvoppoAfZqsBR7fV
 ORRKQdR8GNWxFlovqie8f9qLD+K5Kr7LKx26hKA8l5REgc5C+d69+RgPdx/iZ7MiV+M65fojA/
 LAA=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2019 10:53:47 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/8] null_blk: add module parameter for REQ_OP_DISCARD
Date:   Thu, 11 Jul 2019 10:53:21 -0700
Message-Id: <20190711175328.16430-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a module parameter to configure the REQ_OP_DISCARD
handling support when null_blk module is not memory-backed. This support
is useful in the various scenarios such as examining REQ_OP_DISCARD path
tests, blktrace and discard with priorities.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 99328ded60d1..20d60b951622 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -3,6 +3,7 @@
  * Add configfs and memory store: Kyungchan Koh <kkc6196@fb.com> and
  * Shaohua Li <shli@fb.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 
 #include <linux/moduleparam.h>
@@ -193,6 +194,10 @@ static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
 
+static bool g_discard;
+module_param_named(discard, g_discard, bool, 0444);
+MODULE_PARM_DESC(discard, "Allow REQ_OP_DISCARD processing. Default: false");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -529,6 +534,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
 	dev->zone_nr_conv = g_zone_nr_conv;
+	dev->discard = g_discard;
+	pr_info("discard : %s\n", dev->discard ? "TRUE" : "FALSE");
 	return dev;
 }
 
-- 
2.17.0

