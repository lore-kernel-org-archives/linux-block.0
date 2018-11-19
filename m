Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E3CC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288312086B
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OJNtPItS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288312086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeKSOOP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:14:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62740 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeKSOOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 09:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542599519; x=1574135519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZIIjB7gNVpAOpRwCqgvSYsejmZ9E4J4t+YZiNAL7w7c=;
  b=OJNtPItSLtcFEoda6vmOWP9Y9R0PUUV6q+jKlkTXOeGADMEMyw4jnoLs
   jF66TVzA+ct5/cDOCguSfT7CKT7/evxWvsIqiCI48PWIvxpDw0qVEBpus
   YAiURgewuQoo60qbmek0Dhcy9Fi3ruyuxvl2JJ7W6+I9+FLgZJ7IQo9i2
   PH0kRJMEfDm6DmNC8eVp6bekrkkWC6SsJFZ3cCN23vpZHNnM6Gh3exT6T
   YZ5zZWYvAyCWWXMjvkqRc/avhAfZe+96m+NMXuQO4qTChATAK+bAlGInh
   wL77q2on5vXKcV3238YssicsAlNstmVIjEkAjOL3M49FtMgHKkIEBfs62
   A==;
X-IronPort-AV: E=Sophos;i="5.56,250,1539619200"; 
   d="scan'208";a="96272451"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 11:51:42 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Nov 2018 19:34:41 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2018 19:51:40 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] block: Fix get_task_ioprio() default return value
Date:   Mon, 19 Nov 2018 12:51:27 +0900
Message-Id: <20181119035131.11255-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119035131.11255-1-damien.lemoal@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As explained in ioprio_get() and ionice man pages, the default I/O
priority class for processes which have not set an I/O priority using
ioprio_set() is IOPRIO_CLASS_BE and not IOPRIO_CLASS_NONE.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/ioprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index f9821080c92c..ea5be206eb26 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -163,7 +163,7 @@ static int get_task_ioprio(struct task_struct *p)
 	ret = security_task_getioprio(p);
 	if (ret)
 		goto out;
-	ret = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, IOPRIO_NORM);
+	ret = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
 	task_lock(p);
 	if (p->io_context)
 		ret = p->io_context->ioprio;
-- 
2.19.1

