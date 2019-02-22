Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27764C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB158206C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 19:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfBVTAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:00:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBVTAH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 14:00:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAFC03007E53;
        Fri, 22 Feb 2019 19:00:06 +0000 (UTC)
Received: from o.ww.redhat.com (ovpn-117-19.ams2.redhat.com [10.36.117.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EEC467676;
        Fri, 22 Feb 2019 19:00:02 +0000 (UTC)
From:   Heinz Mauelshagen <heinzm@redhat.com>
To:     heinzm@redhat.com, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] null_blk: fix checking for REQ_FUA
Date:   Fri, 22 Feb 2019 20:00:01 +0100
Message-Id: <154589c8c1b22879dfc03aec4555793329d5ce83.1550861849.git.heinzm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 22 Feb 2019 19:00:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

null_handle_bio() erroneously uses the bio_op macro
which masks respective request flag bits including REQ_FUA
out thus failing the check.

Fix by checking bio->bi_opf directly.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
---
 drivers/block/null_blk_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654b9ce8..04b9d415511b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1104,7 +1104,7 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 		len = bvec.bv_len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
 				     op_is_write(bio_op(bio)), sector,
-				     bio_op(bio) & REQ_FUA);
+				     bio->bi_opf & REQ_FUA);
 		if (err) {
 			spin_unlock_irq(&nullb->lock);
 			return err;
-- 
2.20.1

