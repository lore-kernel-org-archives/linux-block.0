Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B830C74A2B
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA22064A
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WQBpPcoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfGJP4O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:56:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16878 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJP4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 11:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562774174; x=1594310174;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8GgE56wd3g+Ymp3kg9iNwAzAB1LJNJfXdZVXkUg/UJQ=;
  b=WQBpPcoioZrfaHsdzr0uHsy8GEUsVhSMfsz5fNPkMuggMg3p0GOf7Tmi
   Lr4QBDfqIISpnKX7lfKjII5mXGxZzYCqA7Ih8ljlubeO1WnudzCwaNyRL
   v7MqmicvjrQ77+1J2kyZtRvSF1PqSmKlBnCo2OgbhmuPbAt260u7tW69f
   rc4M2+FQXo3d0gZvoRtWFS97Kb5f4FatZxBpo/bND12w1elIH2kKhmCfZ
   o/hi69XOrSBPeV8CBKmFwk2wcw1SaSG0qX++1qE5RQt/nv2WSiD8DTCml
   3eYTbddStB9YHrlnkfuESkIr7OnUT8TUHkLIwqBya7Wc/rZ62WTZEbEwL
   g==;
IronPort-SDR: Q4qwL2lD45dIx6ooGvOqqgNNkcmyrbehfhWDNK6CfgCRiHHpXBrrsnen09vmyaEHzQcgvE4M0v
 aKM1P+z+mSFJYsi0WfwAwP84T/67RyrmVfPuvB1ZEdFSRf2q5GHS2XCw5Egrvfuua7REGc4bsa
 ZcYwR2Kb5XWzirY2I1qMNEz6zPGOhEU1c0+t9g4PZyFeCA39P1MDdyrUaDUv10AQ69ycAwUWpF
 dRkkWN/U+Y/92qrBXpf5EDfDfEiBMuYNeEviVn5nbvq99afQAyQcv/rqOYvMBjdzRBvjmiLGzl
 wRM=
X-IronPort-AV: E=Sophos;i="5.63,475,1557158400"; 
   d="scan'208";a="114296289"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 23:56:10 +0800
IronPort-SDR: 9tKhmA5A1elgJGx6oNY4HM/moLEVfnPsMYxmoP3eanfXz6Bby7wCEPskKYIl/F1mPu9gvKX7S2
 msxtf6e6jbdfIqDnav52v5g/uAj+nT4pNV+eb666ylEK65MF16e2vUtFg3GzVfdOMR97C/6jCi
 c7GVR6kqLUCCzlo7cshh+N0qCeLhGF9mbOxnO28606n+GLeVvQKPnJOOqBxzPvsNcvru/7Q4PG
 TEwCWT6Qz1SlzvgGnZBWiHLdDLRIt/8kMW93Tlx2zhtaowHW9HaK2DhcuWTE7C5qPCEWTYsyig
 rIZ0iEES7ylcI7S1puVGJvAg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 10 Jul 2019 08:54:51 -0700
IronPort-SDR: DPxj78hureI1gt3X0XLWgUalEUyUcRFtkVAmsdqEcKaNitd/Qaecad51IEXv3bgK/nAbrp2VQd
 zXCND8ZfRbiJvovhDPtzltrghjA76CTdndBQLITCVE3y2dTeaW3ePPnvesmU6kNNGr/va+B8Hp
 YyrnkY+rZQJnQ03v1FbQQhLJgRa3zkDkIlu8DfkARRkxwCJGPtWvbLP4qzjcyaOo7mebdA0C4+
 WqqAOH4qp0vHkSiEDD1o8+ol/iD2KrekZPDbYqxCMk6qpabnZ6N8PMEPapc0KDqX+L2vwfZkKj
 lv0=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2019 08:56:10 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Remove unused definitions
Date:   Thu, 11 Jul 2019 00:56:08 +0900
Message-Id: <20190710155608.11227-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ELV_MQUEUE_XXX definitions in include/linux/elevator.h are unused
since the removal of elevator_may_queue_fn in kernel 5.0. Remove these
definitions and also remove the documentation of elevator_may_queue_fn
in Documentiation/block/biodoc.txt.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/block/biodoc.txt | 5 -----
 include/linux/elevator.h       | 9 ---------
 2 files changed, 14 deletions(-)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index ac18b488cb5e..f0d15b0cb3c0 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -844,11 +844,6 @@ elevator_latter_req_fn		These return the request before or after the
 
 elevator_completed_req_fn	called when a request is completed.
 
-elevator_may_queue_fn		returns true if the scheduler wants to allow the
-				current context to queue a new request even if
-				it is over the queue limit. This must be used
-				very carefully!!
-
 elevator_set_req_fn
 elevator_put_req_fn		Must be used to allocate and free any elevator
 				specific storage for a request.
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 6e8bc53740f0..9842e53623f3 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -160,15 +160,6 @@ extern struct request *elv_rb_find(struct rb_root *, sector_t);
 #define ELEVATOR_INSERT_FLUSH	5
 #define ELEVATOR_INSERT_SORT_MERGE	6
 
-/*
- * return values from elevator_may_queue_fn
- */
-enum {
-	ELV_MQUEUE_MAY,
-	ELV_MQUEUE_NO,
-	ELV_MQUEUE_MUST,
-};
-
 #define rq_end_sector(rq)	(blk_rq_pos(rq) + blk_rq_sectors(rq))
 #define rb_entry_rq(node)	rb_entry((node), struct request, rb_node)
 
-- 
2.21.0

