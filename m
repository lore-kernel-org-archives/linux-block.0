Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E409FC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A251420851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FTU8pGs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A251420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeLMUcc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:32:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMUcc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wPeuZ+/Q4TwiH/PKOW1+X4EEQGV/iZxo8fANZXADAUc=; b=FTU8pGs816YyWjfQbdjOBuB6NV
        bKgdtz30UsrwAl1tVvHR4P3dDMN/8FYnN1HcIpw3o7oebKqervzkdTQcw6u/8FCa1dv9uaY6MVmVX
        Xpxa5SNM3GHfbEyfdQ4+JIfntb2T69pfIBMVpkIEesPF8nyAfV19RltClckrU1h4TTIFHkgkyokcP
        Y565dC34+mxDw8Xi4UprYoDtzpkvRpQVbOajcPDeEJnL9gxfnVTWyXR6EaI1GA1ruZofCuWd7GNAZ
        Q4cPYhZYPMj1ecZbhvpE6m0us3z7Fuag4cBm7a7VYF+x9/mTvR6/B694BX4aMkhVe4AGl3vgreOVd
        KH+IHb7Q==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXep-0005tP-DV; Thu, 13 Dec 2018 20:32:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/7] block: remove the unused bio_set_pages_dirty and bio_check_pages_dirty exports
Date:   Thu, 13 Dec 2018 21:32:12 +0100
Message-Id: <20181213203214.10650-6-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e9c6f1d6fcbd..c288b9057042 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1590,7 +1590,6 @@ void bio_set_pages_dirty(struct bio *bio)
 			set_page_dirty_lock(bvec->bv_page);
 	}
 }
-EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
 static void bio_release_pages(struct bio *bio)
 {
@@ -1660,7 +1659,6 @@ void bio_check_pages_dirty(struct bio *bio)
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
 	schedule_work(&bio_dirty_work);
 }
-EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
 void update_io_ticks(struct hd_struct *part, unsigned long now)
 {
-- 
2.19.2

