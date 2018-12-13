Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A096C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6B020851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eb++H4ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6B020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeLMUch (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:32:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMUch (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G0Vhd7QrrbRmleus/JLdOfn3TMutHJabjTVUCBKmi+Q=; b=Eb++H4ibAYvTDuuVqNiBWgVoRF
        1Lk+Cv7mvOggsl9Ks30kzZqRIn8Lbui3M64X2fpsDCrR+iKPPOB7VcjSbyUr6SEh0DWrSKE6XJMNm
        azbi8vxBcupefKkCftzD50b1VL9J8gVfZUzc4et/3MoZ8SzzIRU2DNm4nLlvOl0CC/wYay54JOucy
        p07GB3zVp2vQU+DZCiIi2zxrayMFuJZ2BGHVuQ9Nwdz71s4a9yZu+odIrE2JNQjuBXBZm0cFxYwFb
        licNpgvH6451QhBdxWnMlo1/Q3Rt2SNm/SH/eaDMruMbrtV4X7jnrscEiKNSzu/58ffpQUdaCrbd7
        jIMQbh6g==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXeu-0005uG-I6; Thu, 13 Dec 2018 20:32:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/7] block: remove the bio_integrity_advance export
Date:   Thu, 13 Dec 2018 21:32:14 +0100
Message-Id: <20181213203214.10650-8-hch@lst.de>
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
 block/bio-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 7b30ff5b3af4..1b633a3526d4 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -390,7 +390,6 @@ void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
 	bip->bip_iter.bi_sector += bytes_done >> 9;
 	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
 }
-EXPORT_SYMBOL(bio_integrity_advance);
 
 /**
  * bio_integrity_trim - Trim integrity vector
-- 
2.19.2

