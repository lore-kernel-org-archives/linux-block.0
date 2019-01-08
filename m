Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1892C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 20:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A83820827
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 20:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfAHUYj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:24:39 -0500
Received: from gateway36.websitewelcome.com ([50.116.125.2]:14460 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728469AbfAHUYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 15:24:39 -0500
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 15:24:39 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id D56AE40164968
        for <linux-block@vger.kernel.org>; Tue,  8 Jan 2019 12:49:20 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id gxBegwCYi2PzOgxBegaqts; Tue, 08 Jan 2019 13:37:18 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=57412 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ggxBd-003gLX-F1; Tue, 08 Jan 2019 13:37:17 -0600
Date:   Tue, 8 Jan 2019 13:37:14 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] bio-integrity: use struct_size() in kmalloc()
Message-ID: <20190108193714.GA24832@embeddedor>
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
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ggxBd-003gLX-F1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:57412
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = kmalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 block/bio-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 1b633a3526d4..ae8c68ecc0ca 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -57,8 +57,8 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 	unsigned inline_vecs;
 
 	if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
-		bip = kmalloc(sizeof(struct bio_integrity_payload) +
-			      sizeof(struct bio_vec) * nr_vecs, gfp_mask);
+		bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs),
+			      gfp_mask);
 		inline_vecs = nr_vecs;
 	} else {
 		bip = mempool_alloc(&bs->bio_integrity_pool, gfp_mask);
-- 
2.20.1

