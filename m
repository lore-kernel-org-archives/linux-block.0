Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC71C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 19:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8D0206B7
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 19:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfAGTX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:23:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfAGTX4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Jan 2019 14:23:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DA4888E57;
        Mon,  7 Jan 2019 19:23:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-164.rdu2.redhat.com [10.10.125.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF2E268870;
        Mon,  7 Jan 2019 19:23:55 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, John Pittman <jpittman@redhat.com>
Subject: [PATCH] null_blk: enable discard support by default
Date:   Mon,  7 Jan 2019 14:23:52 -0500
Message-Id: <20190107192352.3129-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 07 Jan 2019 19:23:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support for discard was added to the null_blk driver in 'commit
306eb6b4ad4f ("nullb: support discard")'.  For ease of use in
benchmarking and target testing, enable this support by default.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 drivers/block/null_blk_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654b9ce8..c4a1db0fb336 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -527,6 +527,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
 	dev->zone_nr_conv = g_zone_nr_conv;
+	dev->discard = true;
 	return dev;
 }
 
-- 
2.17.2

