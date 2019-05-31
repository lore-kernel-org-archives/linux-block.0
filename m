Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D00C04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C6B26995
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 19:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfEaTIu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 15:08:50 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.96]:47375 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726807AbfEaTIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 15:08:50 -0400
X-Greylist: delayed 1253 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 15:08:50 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 6D74C41430
        for <linux-block@vger.kernel.org>; Fri, 31 May 2019 13:47:56 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id WmZIhJD3tiQerWmZIhtFMH; Fri, 31 May 2019 13:47:56 -0500
X-Authority-Reason: nr=8
Received: from [189.250.123.250] (port=50534 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hWmZH-0034R7-BG; Fri, 31 May 2019 13:47:55 -0500
Date:   Fri, 31 May 2019 13:47:54 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] block: genhd: Use struct_size() helper
Message-ID: <20190531184754.GA26040@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.123.250
X-Source-L: No
X-Exim-ID: 1hWmZH-0034R7-BG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.123.250]:50534
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(*new_ptbl) + target * sizeof(new_ptbl->part[0])

with:

struct_size(new_ptbl, part, target)

Also, notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 block/genhd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ad6826628e79..c674d9090f40 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1281,7 +1281,6 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
 	struct disk_part_tbl *new_ptbl;
 	int len = old_ptbl ? old_ptbl->len : 0;
 	int i, target;
-	size_t size;
 
 	/*
 	 * check for int overflow, since we can get here from blkpg_ioctl()
@@ -1298,8 +1297,8 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
 	if (target <= len)
 		return 0;
 
-	size = sizeof(*new_ptbl) + target * sizeof(new_ptbl->part[0]);
-	new_ptbl = kzalloc_node(size, GFP_KERNEL, disk->node_id);
+	new_ptbl = kzalloc_node(struct_size(new_ptbl, part, target), GFP_KERNEL,
+				disk->node_id);
 	if (!new_ptbl)
 		return -ENOMEM;
 
-- 
2.21.0

