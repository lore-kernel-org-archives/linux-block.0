Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD7FC433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 02:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9460F20B7C
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 02:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eHIFGG2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfHHCGM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:06:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40150 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfHHCGM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 22:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565229972; x=1596765972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2CkeJX6kyd7jnlMdFoIQy0PKnwSIIvXdEH/jB/rk5iE=;
  b=eHIFGG2ye1HWBz2Y6+BPbjYIhm4spA2RRRp6c9lqGAIgf7TZVKbPEEjr
   NW0d7llybZkAUKgvxDqFq06HU2szHet6WDizTc6ueUX0Vg26W7QuhvP+D
   1ozNXFplYFEpCZG07OSbm45GAqpt0yD8/MAGqfFI4JJj95eIy35qfcxWb
   vq+hPfmflwSaodh7mr+CKvm278fTNMEpcC4mf//km01wuBOeIgookD30I
   tdRzHXqV6TcGifrt787Cw/A89oS0n0CHKalrrAHKxsoM+wmzg1Jq8TPpY
   yNEG90Az4WPvBtQU2WRG1nUCpw7otMzptUnnOCScVb9KhR/+JoCxs0e8L
   w==;
IronPort-SDR: sSpsFZSmKIIbwZZ0srGqv9n+fm6RBe0utoG89PA7+A+gijDxmtEDM4Cy2dSXzwvSawuVK/toJO
 4aq1Rvgf4UzpAzb/AtXr/SBSOn05zMCDRtzaJzSSxf6lpvysDjhY3RNUgziOD1QMf/iuLJXdZ5
 DSpMaL9ZDeKD7B7uoPSMQ2zObvvypvnEYWXhNNrRGfaKcbyxhlTr8twJ6WVtvTS/qWzDttWr2Y
 TR5sod5+vAojw9sLyNU2peymxg3Z/qNnBWNnYYkhJBYcr1pDSzuK31GcrvL1gxMEh+UL7+7pqA
 Jks=
X-IronPort-AV: E=Sophos;i="5.64,358,1559491200"; 
   d="scan'208";a="221800548"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 10:06:11 +0800
IronPort-SDR: lG1ICQi5ZEUD4CDK2CXD2Eqjwo7TaDs9bidZrCpbGEZYI+Cs9f9RQTGXq5KMsZQ5DlAU8ZvDr2
 q6i0V3eJGyobXe9HVbZ8JLeuBHFI8NsDtUGNoty9nWUxPdkSSTfvLILmBkR2H1OVVPQGQ1edNY
 ZjO9ybKDdxSeQghMVZMuUpEgGe0AEjZ1ksZyF/FFhain1Ht6H00tkoKWO5AZ4Yy/xxTLb23HWy
 fxOwdBmKSkLT8xJgbM3RNUs063tKxj0sXkgQc5EqfhIT7n8oOOit0oIkiaVaU8+cRx4ikgD8kP
 HQydQT3x6G2tlMoA1nEDkDa+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 19:03:56 -0700
IronPort-SDR: JYK02IEyXHrHCHIuUEdSX2S6Qg7AUx5+lMyN1iBhhDcxBoHxVnGwmPkn5nGuA2xMQV/xeVTOn2
 QuIbAz1IIsq1j4K1iQcrhmPVs8Ol1Ja4JFWyEKvTskJUCuH/9tCvirgFdLxDiAnW1yJqACTGfZ
 K7C3zbK/5IPr+HgX+PWD9zpp8WKHHBlzy9eXgCOJl+jxvXyAopmLJErvJ5mXVdF0g/WacPDEyx
 2ieV7fTY6Ifxpm7pWCy0T9evdRnwGek0XvYryPIVkXjnQSWJW9JSKqHH667O0F7SOIo2JopgjA
 ATE=
Received: from dhcp-10-88-173-43.hgst.com (HELO localhost.localdomain) ([10.88.173.43])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2019 19:06:11 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] block: only set DYING flag once in blk_cleanup_queue()
Date:   Wed,  7 Aug 2019 19:06:10 -0700
Message-Id: <20190808020610.23121-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This commit removes the statement in blk_cleanup_queue() function that
marks the queue as dying. QUEUE_FLAG_DYING is already set inside
blk_set_queue_dying() a few lines above, no need to do it again.

No functional change.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e14d2f0..0822acc423a3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -339,7 +339,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 	mutex_unlock(&q->sysfs_lock);
 
 	/*
-- 
2.21.0

