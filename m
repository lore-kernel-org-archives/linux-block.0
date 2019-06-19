Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1171FC43613
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38112085A
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 22:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lWIuuKPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfFSWCA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 18:02:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3312 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSWCA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 18:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560981719; x=1592517719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlYi9Gd8YGlV34Ummeh1jSWI/pFfwkHWOYrKfb0A/yM=;
  b=lWIuuKPMZtLkPdbADuM1u2ontE+BuGWVa7TyhB5QAw21htcX+G3eMi7s
   /3ucOgm9puXBLopHWcsFydOT6eYoSegvStZHqqcpmXT8nfzFHJOvT9TFK
   BrL+pBt0AA2kEEqolXkXkk0JKJ/EPHGdodKl4S4BcKIOhJ2pemHxDqGXA
   0a8zFCrq+vq21U4P2CEQvfxCn8q+29PovLOllJK0VAQptk3MFwAdN5TkW
   RjBw6WjXx5A9q2eJ32eL6qKia/AdA10qmj+2pCnL5IG+NwtYSI0rNhI2I
   uPqao58v8ygr/0ZTe1CMagdCJxpVNKCviwCmIo1JOIRVf7E8u+ynrHxQT
   A==;
X-IronPort-AV: E=Sophos;i="5.63,394,1557158400"; 
   d="scan'208";a="112236315"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 06:01:59 +0800
IronPort-SDR: u5OOWluertQ2NZFLPnQVSHKsc4fWzdo5LJ48VzaiZIwFyIr45PfeqU9EL0IuUBG+LhvvvQ7opY
 J6+9kDfE4zHjRlMisyzzePfaqbFdi2B1s+IEtqtQ8/VJybsFysuzAjMAOohHvGDfLY9wvvoJM2
 hIAl4hdlkr+ot4nKjRS4rS8mMAzt3Q+CABpDneY9hZDdmG3ElQfg4AHBI/E1sh+nj84nph+0tv
 3mgX93ertNgdeQHWL9l9wWCpDE/wNLEA7R0MmWaMC+fCgV/fFsGyx/Ne/sTczCdwmIRVM7TUkQ
 KU+k59AAn6vemPQ0itIj59bK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Jun 2019 15:01:26 -0700
IronPort-SDR: cdgZbE7KcHsyqQ1scyjyC3WsC7KA5hh/zi1UAbTPi+lX64RqmEFfiG4kJq9f7mfDdIsBBAvfG+
 OQ6aEFnPRccV8f8E5S6OTFlYcQHgOy990XRGvLdQzCpvXJjBL4+C+cEFwCDHlRO0uEk94RreqU
 04+l9SXAgf2pnfAI+xiwmTeVZMJs03d0ZaOtiQ1jIGNII3OTGklzdOuOFlDnoJRczOE+ock1kZ
 hifAXDF1Ij0aGxGUZTzRrR0TttiTiYUFt+GN2y4k8n9B3ZTCwG3rxqGGYi3WDqhyA6aiwYCWLA
 xIU=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 15:01:59 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/3] block: use right format specifier for op
Date:   Wed, 19 Jun 2019 15:01:49 -0700
Message-Id: <20190619220150.6271-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
References: <20190619220150.6271-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In function __blk_mq_debugfs_rq_show variable op has unsigned int type.
Since op can never be negative use %u format specifier to match the
variable type.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 84394835e2b0..03b6aabbe602 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -347,7 +347,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	if (op < ARRAY_SIZE(op_name) && op_name[op])
 		seq_printf(m, "%s", op_name[op]);
 	else
-		seq_printf(m, "%d", op);
+		seq_printf(m, "%u", op);
 	seq_puts(m, ", .cmd_flags=");
 	blk_flags_show(m, rq->cmd_flags & ~REQ_OP_MASK, cmd_flag_name,
 		       ARRAY_SIZE(cmd_flag_name));
-- 
2.19.1

