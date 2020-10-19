Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA1BC433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 14:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B8D222B8
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lBHJJuMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgJSOGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 10:06:15 -0400
Received: from m12-15.163.com ([220.181.12.15]:44691 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgJSOGP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 10:06:15 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 10:06:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=z5YJ8
        q3sjAt0NsS310V0zZIOMgHG+DxOWwMJx21y6pc=; b=lBHJJuMqufHWZMODOPJ+6
        kYijA760F1LmItPuNLOfq++58BA1ihuB4kC/vL4FaQBD7FE8oaVGjPy8gcE5UW5M
        gSQp1wSbReaKUf0pCO8nVnH6pdVp6Madb12z0kEIKZVvj0GEe8wsiGQoP+4MNGM4
        mT3Dke/33hYpOz3T7SN64o=
Received: from localhost (unknown [101.86.214.18])
        by smtp11 (Coremail) with SMTP id D8CowAAHhcbDmY1fxoDUDg--.9286S2;
        Mon, 19 Oct 2020 21:50:59 +0800 (CST)
Date:   Mon, 19 Oct 2020 21:50:59 +0800
From:   Hui Su <sh_def@163.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sh_def@163.com
Subject: [PATCH] blk: use REQ_OP_WRITE instead of hard code
Message-ID: <20201019135059.GA16475@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowAAHhcbDmY1fxoDUDg--.9286S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFEfoUUUUU
X-Originating-IP: [101.86.214.18]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJgPCX1v2ep-rvwAAsk
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

use REQ_OP_WRITE instead of hard code in
op_is_write().

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 7d7c13238fdb..7b9b02378c24 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -440,7 +440,7 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
 
 static inline bool op_is_write(unsigned int op)
 {
-	return (op & 1);
+	return (op & REQ_OP_WRITE);
 }
 
 /*
-- 
2.25.1


