Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C5C433DF
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 00:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C81522B2D
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 00:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592613865;
	bh=x87LbaFrFJto/yHBB5B97Vdy4r803vIa4c0OJE/HMm8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qA3y7NPhEgAqJg55l77/xEvrWbHBSIgbZJJL5bQONwJItzh2I10luOhdQHn+d5onQ
	 shaNrVe0NuDarbp6fXa5uZ6HPKwWWq6VsllwW24cBSBqQkMkipSHkfDEioi3R7NoNy
	 1yg+biZXTp7zS22Zj8ol8Y34PrOmKY44i+ciLa0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgFTAoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731020AbgFTAoY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 20:44:24 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE97522B2A;
        Sat, 20 Jun 2020 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592613864;
        bh=x87LbaFrFJto/yHBB5B97Vdy4r803vIa4c0OJE/HMm8=;
        h=Date:From:To:Cc:Subject:From;
        b=ICBb9ezuh9lX4fp9XXSnl88KHCEgk1bxNLtCRVm/bpB5iM5g/ZKxuE9c/mMPpr1V3
         3Jp0/t+REPJeYQRm18ihpRMrsPNIk+pPAWDz9hDl2/Ms0jrOvNZdfe4kU6wnk6vAJA
         y2RhBjdTY9NeduvQO7Yb9TSJ8siAJHNgBZhNuqrY=
Date:   Fri, 19 Jun 2020 19:49:49 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] block: bio: Use struct_size() in kmalloc()
Message-ID: <20200620004949.GA30923@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 block/bio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a7366c02c9b5..fb5533416fa6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -444,9 +444,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 		if (nr_iovecs > UIO_MAXIOV)
 			return NULL;
 
-		p = kmalloc(sizeof(struct bio) +
-			    nr_iovecs * sizeof(struct bio_vec),
-			    gfp_mask);
+		p = kmalloc(struct_size(bio, bi_inline_vecs, nr_iovecs), gfp_mask);
 		front_pad = 0;
 		inline_vecs = nr_iovecs;
 	} else {
-- 
2.27.0

