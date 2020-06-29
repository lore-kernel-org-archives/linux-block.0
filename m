Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1CEC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C48120780
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 23:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KBRK5fMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgF2Xoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:44:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21893 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgF2Xob (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 19:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593474272; x=1625010272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6GUmPvWUi4EC1ipsj6q7XUj5o6fMzooGGjrXcT0iTt0=;
  b=KBRK5fMJtWWkaWvCxWUnhVPaKtFYw31WYv8e4XeUezbYLsQUVeXn0HmL
   NAUZX+rMKxxXTzaspNJEDuH7lqT5xwfF5hy606OQ1MYT2ZGEXPmOKmlF+
   M55arxAGIdVNmfLotjEI9Ta6ZzC2ozmOAwL8DCcu5+iPL1vgowk9zxe5K
   U2qF965TTStUUMLDD3cia26wtlN+3lUruJFNrY7uhRpAFxMJcWh+PxG2A
   kVqvbDi+KCyolGwaDtK7YXpNNL+KvlwAMun0Qv8BqvglzYohJo+45zMOI
   r9wPwH7WlkIv1wJa2nOY//laMAzTm48N4qeXZIov+eUADCY+gRj5pgoL1
   w==;
IronPort-SDR: FEO4hF6Ph6zB8qbV4DOu0A9xalHyRS+PFxr3BYig8WThEPrbwC76kv8/Vzmi6gKJdTG0s+eJx2
 uv+VF0IEeqty1AnB9sSdNMztE3osCvUg8dhTdgaVsGwjhG8AJUqcQ7d3qiCctvUUQ06BvpnRAZ
 /z9sGcidqZvmoM6MjIpbclU9RPhg8GCgHvd1yKhC8Y28uhP/7x1YGAdbERPDlsZquqPjjeoBHd
 qRIi2+Gm04HkbEBH6XTorzacwz6WBHweBET+LN9FcDm7KBFENeFK976U6GBVlzPrlgE82f4GCs
 uo8=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="142577148"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 07:44:31 +0800
IronPort-SDR: YfyfAq65ybpZ38TJ3lHU4kkF9c98Sn7nkmFZ/JBGIVseqTVHW5OewoxRJGLKtzBZeVQLEQ11Om
 P+ZyMgZaqkKgZVTpESUbxg+CY3RYpYzxU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:33:23 -0700
IronPort-SDR: ZSdzI9vxkzz1tOehmS7qpaytmCk5G6bJUtY9juZKJEfzT0tB+0d518YlIGIFXkDRR/2aHlo+9/
 9Lze0F0Ur6GQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jun 2020 16:44:30 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, dm-devel@redhat.com
Cc:     jack@suse.czi, rdunlap@infradead.org, sagi@grimberg.me,
        mingo@redhat.com, rostedt@goodmis.org, snitzer@redhat.com,
        agk@redhat.com, axboe@kernel.dk, paolo.valente@linaro.org,
        ming.lei@redhat.com, bvanassche@acm.org, fangguoju@gmail.com,
        colyli@suse.de, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 08/11] block: fix the comments in the trace event block.h
Date:   Mon, 29 Jun 2020 16:43:11 -0700
Message-Id: <20200629234314.10509-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is purely cleanup patch which fixes the comment in trace event
header for block_rq_issue() and block_rq_merge() events.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/block.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 3d8923062fc4..6a74fb9f4dba 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -195,7 +195,7 @@ DEFINE_EVENT(block_rq, block_rq_insert,
 
 /**
  * block_rq_issue - issue pending block IO request operation to device driver
- * @rq: block IO operation operation request
+ * @rq: block IO operation request
  *
  * Called when block operation request @rq from queue @q is sent to a
  * device driver for processing.
@@ -209,7 +209,7 @@ DEFINE_EVENT(block_rq, block_rq_issue,
 
 /**
  * block_rq_merge - merge request with another one in the elevator
- * @rq: block IO operation operation request
+ * @rq: block IO operation request
  *
  * Called when block operation request @rq from queuei is merged to another
  * request queued in the elevator.
-- 
2.26.0

