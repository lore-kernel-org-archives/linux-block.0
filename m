Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC53DC31E40
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BB72085A
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbfFJPZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:25:07 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.62]:23751 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389293AbfFJPZH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 11:25:07 -0400
X-Greylist: delayed 1251 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 11:25:07 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id EC64FE1528
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2019 10:04:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aLqJhGFXn90onaLqJhH3l0; Mon, 10 Jun 2019 10:04:15 -0500
X-Authority-Reason: nr=8
Received: from [189.250.75.107] (port=58560 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1haLqI-000U5a-FH; Mon, 10 Jun 2019 10:04:15 -0500
Date:   Mon, 10 Jun 2019 10:04:12 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] block: bio: Use struct_size() in kmalloc()
Message-ID: <20190610150412.GA8430@embeddedor>
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
X-Source-IP: 189.250.75.107
X-Source-L: No
X-Exim-ID: 1haLqI-000U5a-FH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.75.107]:58560
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct bio_map_data {
	...
        struct iovec iov[];
};

instance = kmalloc(sizeof(sizeof(struct bio_map_data) + sizeof(struct iovec) *
                          count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, iov, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 block/bio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 683cbb40f051..4bcdcd3f63f4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1120,8 +1120,7 @@ static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
 	if (data->nr_segs > UIO_MAXIOV)
 		return NULL;
 
-	bmd = kmalloc(sizeof(struct bio_map_data) +
-		       sizeof(struct iovec) * data->nr_segs, gfp_mask);
+	bmd = kmalloc(struct_size(bmd, iov, data->nr_segs), gfp_mask);
 	if (!bmd)
 		return NULL;
 	memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
-- 
2.21.0

