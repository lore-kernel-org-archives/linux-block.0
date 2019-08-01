Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB3C433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150A820838
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FOCAfLTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfHAR1R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:27:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50984 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfHAR1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 13:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564680437; x=1596216437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Mvy1iTjx2yZ5G9ARlRidklLCeyu3cbc66p6imiUTEB4=;
  b=FOCAfLTE1toX0kYN7jj6e2NwVDr75EGPSgGno2WqeqlYna1lpSuYY+f4
   YTyYZ8xq72sPGZMDwbreZMXUwhGpI33M3ndbIvldtXDqfy6F/X08wH7cu
   gwnk/5c+qQg+ZYTL4Srw8hm/DqdUYapLFr+KQLYlt+T9Z2R0ZuUZiEmEH
   2NYzfT1inaJ+7bCNdILAOuDe0f+MOPtQRuozA7zBEnr6z8GWY4MzFm4Gy
   JROxXVdi8buBOCQ5mxCyyT9sPk2l7kN9didthRAckhVoR781Rqjv652LC
   J77xQpR2+q468xs3sEV6PeparEUggDrz/Tyv0fw0LZaffmDaE2xcimxcm
   A==;
IronPort-SDR: WZPqu/nSH7YxEm1eqwSqLLTc0fV04oZLWYdhhBuBZAI8WHb286Pp94FV6DQyS39mU3ifKxtfLI
 uELIqFSfoODN81r7ww3B0B7t52YHbfg6MA8WXNco2CKWmAZlJQRGU20IHs8d9dJ4D/jQPsiCO5
 QUraJWz4tPW750DmXUX85udLBptUTZYgH6qp/PW9OqdSwCUi6EjjxLsxWxae05WVAqELKV/MYN
 1v/9XaGx8dj7LCeWMn0Ty27WJI97cf4jgHIDj914Ghrpvd+bLapp7Bhv3BaBEakgC0Nc5OLQwX
 QWQ=
X-IronPort-AV: E=Sophos;i="5.64,334,1559491200"; 
   d="scan'208";a="116323226"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 01:27:07 +0800
IronPort-SDR: SOSuLcWdPRdqx2Rqa7WQnr8GE/KtF5bVMG+ZzFRC5ylTiVRYmEmfBElk6r653kk65iBMXYZZ9F
 8S5V/aa/HjcxLh/gDUL9gV5F4q5R+3NPsBKRfiIhvDqCwkixrWx8acQRUsUnApT7mGN6cDgz1W
 1d2XursPbm54ksKJgoOBaaeIZdlKWs+Ds5S50cjjEI2C8enfStolZXbJjihQziRth50cNX1jGN
 SIF7dopMmicDicoaZpw+Z887mPDeMXzsKe12wGQv38zw+7ctayPKDAj15wI7B959ejTsf+yHY4
 hNuDcTpmdJP0cMck2SKhTaoP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 10:25:06 -0700
IronPort-SDR: nV8qtY4XPDj0N/iW1mPkGGi7wlvLeP87GeAYecaGLRsTHM4uQBWclabSUWHg4ThDymdMoe+PB8
 VQ+24EpkQwhgQwS/UpOT3Pm38WdR15Kif5uREjEdXrwhPlOzORQ8a5atlkEFKV7+7y7yyQlNRi
 x+jpcvAlyMX6lvI36qLF7OCD810aRi6+7NX5NGnNlgLwbuT/pze4zBX5bOENUoTVVW3vnkcGXo
 Zyd6jQiKOJf0kPcFayo5/zg7OJ3UGhinUMo0rFqdIItfjhdJDicVrlacwk16sAu8c1zDsg9wUF
 2uU=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2019 10:27:07 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/4] block: add req op to reset all zones and flag
Date:   Thu,  1 Aug 2019 10:26:35 -0700
Message-Id: <20190801172638.4060-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch introduces a new request operation REQ_OP_ZONE_RESET_ALL.
This is useful for the applications like mkfs where it needs to reset
all the zones present on the underlying block device. As part for this
patch we also introduce new QUEUE_FLAG_ZONE_RESETALL which indicates the
queue zone reset all capability and corresponding helper macro.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blk_types.h | 2 ++
 include/linux/blkdev.h    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index feff3fe4467e..3991b580d6bd 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -282,6 +282,8 @@ enum req_opf {
 	REQ_OP_ZONE_RESET	= 6,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
+	/* reset all the zone present on the device */
+	REQ_OP_ZONE_RESET_ALL	= 8,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= 9,
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ef375dafb1c..474008bffee2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -611,6 +611,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
+#define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -630,6 +631,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
+#define blk_queue_zone_resetall(q)	\
+	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_secure_erase(q) \
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
-- 
2.17.0

