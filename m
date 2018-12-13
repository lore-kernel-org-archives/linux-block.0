Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B140C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3951F20851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XzS6i4E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3951F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeLMUce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:32:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMUce (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LUPK7pfinFVyczWou9udQ20+S9wBgZLsSrMjOJfGFXo=; b=XzS6i4E0X3pBMk/td5djLERl+S
        sNircS9HSgEGIlI063Yyk9cnJpnmwVPkX++FU6Ba1HqYDFujnzb4daGSFdNOmrfgL9oKVcwIn6jsI
        +MB2RIPyv6dgvZ19qm38KSdkXWN525PznyH23picxqgrswiLExo13cZTJ1qEwhwR9U8DCpq0FLhSR
        lsdDXLsDbI8vH++8cpKlgusF299Kg9fQDRg1O8j7ZO40QAINR9CNbFwg5DKuyFlWQlwB2rc6U5RSe
        3E8mfunpibrQBCdI0BuMc4o62BzW56jSbnmgU76HE0Sxu+guuyu2UmiWjNQewCVj4K1C34+v5EsgU
        CYFEsW8w==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXer-0005tu-Vs; Thu, 13 Dec 2018 20:32:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/7] block: remove the bioset_integrity_free export
Date:   Thu, 13 Dec 2018 21:32:13 +0100
Message-Id: <20181213203214.10650-7-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213203214.10650-1-hch@lst.de>
References: <20181213203214.10650-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 290af497997b..7b30ff5b3af4 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -460,7 +460,6 @@ void bioset_integrity_free(struct bio_set *bs)
 	mempool_exit(&bs->bio_integrity_pool);
 	mempool_exit(&bs->bvec_integrity_pool);
 }
-EXPORT_SYMBOL(bioset_integrity_free);
 
 void __init bio_integrity_init(void)
 {
-- 
2.19.2

