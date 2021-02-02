Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B8FC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A935D64EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBBFjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:39:25 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61659 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhBBFjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244364; x=1643780364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJVVyt+ZPivAtc76C1nI9owyC0Ff5319BZC4lKhOGIk=;
  b=lgCczbERwwAOLMOCAbOMr0zhKXwx5lvh0o5hSW2NfogMZTi3ln1HF/pd
   vLLLwsmv6cO1iQs2hOBSjJfxf7+KmruVDIRiiy1v1x1eysU6PbLu7KiDn
   1T2dHLDUrg6O19NNwX+icgKcqqWJNOrOgJT0fFUdSmFfuXBRu7F54qbmD
   jyVcS6Gq87M7Qn0I0M3BymE9OH7/wuGpZNE/MR3XgyoTt6Lqd5mlKwOOn
   PwtX/dUkZtdcDy+M4Yfu9+AAZ4VFcnkI6v+sIpp/Y/1EVTt62+aN+EiGA
   RDF12RMP8royNdpvy/GU6pJ+a1Pg77hLJ7qXRUliCFgYE8AK8dXgivGL4
   Q==;
IronPort-SDR: pAd/r1oF8mCnZS+nyC+lhuJcfHlGsce2JqCWpGHgCSJFdgfr5HjbFO0oM3v877vy+kgu5P/qKT
 WyLIuGiGZzUkcPiKGNNW/jJFvHOivmzaCYx6TSuUdoVFxhspEV1GSLd7qSe4AH8IShmVgcMSyY
 SfH7stkmgI/Q6kjOJ4WMnlUpSNOgLYn7/SwjcawnH3e+xyz/DHnfoaQLYaBQCj9wzbEB3PC0+y
 hhaGDu+KAnzLUZAimCI2RVl61C5FHXKqNaQQ/H4Ogf4IZcfNyhUvAMcYWInF766mcYmxiZzmRB
 Hgs=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158885310"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:38:29 +0800
IronPort-SDR: q8D9t0JtKwwMYCl3JfM8WQu1L9n0I6A1SKnI/bL1mPTqnwXbROO8/onl+kfgDqgj0uOmVQBgEU
 OdWwyxdyO63Qj6t3LmPMPO3baJB7eV7yVCYw9kQmg7MKPe6bWzvwGv7sZ5VCbwtcFNncf54bKG
 +iv+PkEaHRTEPEf1Ly8gbuCMUl7oC9VJGaxe/1zy+vfAZZD2H3V4UqM2uFHWrkZGsql6ydpCDl
 PsrgJLBKMu8/wrCNLX28HUXVmNJ0cEuEB40rD/4igzc7Td35yMp6GkgA84nRiPDR1dzOyf+Zfz
 nZO/kp9GH3K/RRS7AJG3iZF9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:20:39 -0800
IronPort-SDR: PyYOk4TefLy5M2xByp3EsELWltBszA9fzJI5c1s8Q+Vhv29xbkXfPOyxzrkJVIBjc9veuySyjZ
 EOVIndrjuZeksTQNpUcybfMWdOt5YCrlR9/gUJdY0Ur4HeZ5+YzMqPGVNVpJ5HnvgFwFf1qeXu
 Q95lv09UriSWMQCf9Z4xI5vLSBL48Jm+ETJOl5ggT8ymCwR7sK6yEN+mDoeiKAauwv081w11Ev
 Ue15ccvMtG70tGI8rnmNLZ3hAyW2hzVqvd2bCIOcv59jBUinlzytp8AsRdhgkzDceTpS/4IcD8
 udk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:38:30 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 19/20] loop: set error value in case of actual error
Date:   Mon,  1 Feb 2021 21:35:51 -0800
Message-Id: <20210202053552.4844-20-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function add loop_add() set err = -ENOMEM before the call to
kzalloc(), err = -ENOMEM before the call to alloc_disk(). None of these
error number values are shared. That requires err to be set explicitly
before actual error happens.

Conditionally set the error after we actually know that error condition
is true insted of setting it before the if check.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d99ae348e4e2..ef70795e36ab 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2062,10 +2062,11 @@ static int loop_add(struct loop_device **l, int i)
 
 	lockdep_assert_held(&loop_ctl_mutex);
 
-	err = -ENOMEM;
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
-	if (!lo)
+	if (!lo) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	lo->lo_state = Lo_unbound;
 
@@ -2081,7 +2082,6 @@ static int loop_add(struct loop_device **l, int i)
 		goto out_free_dev;
 	i = err;
 
-	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
 	lo->tag_set.queue_depth = hw_queue_depth;
@@ -2091,8 +2091,10 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
-	if (err)
+	if (err) {
+		err = -ENOMEM;
 		goto out_free_idr;
+	}
 
 	lo->lo_queue = blk_mq_init_queue(&lo->tag_set);
 	if (IS_ERR(lo->lo_queue)) {
@@ -2111,10 +2113,11 @@ static int loop_add(struct loop_device **l, int i)
 	 */
 	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, lo->lo_queue);
 
-	err = -ENOMEM;
 	disk = lo->lo_disk = alloc_disk(1 << part_shift);
-	if (!disk)
+	if (!disk) {
+		err = -ENOMEM;
 		goto out_free_queue;
+	}
 
 	/*
 	 * Disable partition scanning by default. The in-kernel partition
-- 
2.22.1

