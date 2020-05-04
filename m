Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F752C47254
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2BA2075B
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 13:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="wbZzOWD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgEDNa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 09:30:56 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:47022 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgEDNa4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 09:30:56 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 5C7352E1460;
        Mon,  4 May 2020 16:30:53 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id p37YMl27Y5-UqbWRbWb;
        Mon, 04 May 2020 16:30:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588599053; bh=Spta+i/oO8BEvGD3BvlYBGUTfw/bm1sIiGx2AOg3kHw=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=wbZzOWD0J1vut19Iy8vO2yMXcjAexNO0wnK6JSkxfdqMgkmuxWsuRrt4q+oe4tTBF
         sacTDHlJSNqEj9NBtCtARAnk1kxnK/4g4YED+IrJxbnAQnVGMeSRSGIbiZa9P5UWfj
         LTRfvy42yQsKrBnDVNWiiDbAHzMOb920G2agr5TA=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id lOjei5J8xC-UqWWBwFp;
        Mon, 04 May 2020 16:30:52 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH 3/4] block/part_stat: account merge of two requests
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Date:   Mon, 04 May 2020 16:30:52 +0300
Message-ID: <158859904278.19926.1357797452754171976.stgit@buzz>
In-Reply-To: <158859896942.19836.15240144203131230746.stgit@buzz>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Also rename blk_account_io_merge() into blk_account_io_merge_request() to
distinguish it from merging request and bio.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-merge.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a04e991b5ded..37bced39bae8 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -662,20 +662,23 @@ void blk_rq_set_mixed_merge(struct request *rq)
 	rq->rq_flags |= RQF_MIXED_MERGE;
 }
 
-static void blk_account_io_merge(struct request *req)
+static void blk_account_io_merge_request(struct request *req)
 {
 	if (blk_do_io_stat(req)) {
+		const int sgrp = op_stat_group(req_op(req));
 		struct hd_struct *part;
 
 		part_stat_lock();
 		part = req->part;
 
+		part_stat_inc(part, merges[sgrp]);
 		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
 		part_stat_unlock();
 	}
 }
+
 /*
  * Two cases of handling DISCARD merge:
  * If max_discard_segments > 1, the driver takes every bio
@@ -787,7 +790,7 @@ static struct request *attempt_merge(struct request_queue *q,
 	/*
 	 * 'next' is going away, so update stats accordingly
 	 */
-	blk_account_io_merge(next);
+	blk_account_io_merge_request(next);
 
 	/*
 	 * ownership of bio passed from next to req, return 'next' for

