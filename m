Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D310C433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035D42083E
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fknm3khb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgHaSMD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgHaSLY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2BC061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=C5BnBOHmZC67nL6sYTdu/Z7Lf9QFPOkf2Rs3DgMwiHE=; b=Fknm3khbpvn1P4uwQ9tp7kC4zD
        YctwTx5/ZIanXTOgNdUcsuJSB4i7oGCc+/tNeKg3HDpK2algJNOizjZiwp88jvV+sZK+mZjawtvPG
        AhpbWxh2kZa7wfyftHBTHdYdEch4BV25Xv99sb5b/H/cHgDmTN3PhnYQdIC/18IgnbUwNTY7FU8Zx
        o3HpU6ZIqdxxVxRpJQo1iHGNpSrtM0Js0iSAY57MUM2OzvejQPYFoJ9CmbYrjW2STkxsDntSkPr6p
        OAjHil3P6OobxnQrDe3qQuHva3vgCJnEiH9gbmIKlqqOCUarPyAISgaAVVH9QvgTmS5415SGDR8jp
        CsCBzAOg==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCoH4-0002Fq-Pz; Mon, 31 Aug 2020 18:11:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/7] block: remove an outdated comment on the bd_dev field
Date:   Mon, 31 Aug 2020 20:02:35 +0200
Message-Id: <20200831180239.2372776-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831180239.2372776-1-hch@lst.de>
References: <20200831180239.2372776-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kdev_t is long gone, so we don't need to comment a field isn't one..

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 63a39e47fc6047..59d9150165c490 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -20,7 +20,7 @@ typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
 struct block_device {
-	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
+	dev_t			bd_dev;
 	int			bd_openers;
 	struct inode *		bd_inode;	/* will die */
 	struct super_block *	bd_super;
-- 
2.28.0

