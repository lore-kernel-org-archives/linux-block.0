Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE4DC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1CF2086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXAjVO/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1CF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeLMUc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:32:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeLMUc3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=likLTNRuy07YNr+3DsCKMIvkmnT5SkcVrhBTwBOXXKY=; b=GXAjVO/WuMVUzfmXA5EcsqYcgL
        Pe13XQlGblfeTPz9Rg2Bl4lWK4Nga0lLdNXBpW6gfI/qYEcDvAofgLSK88xIt06hjpBXnH+RIgw6w
        xk8sXBInmR3oTYhtK/N0zkFqMBsOhtkPADES10YPBJspaszyJJLrbMNZMzqaIHh41ZjSi+idvX/Uy
        GlTW3hipAnyvsvtipf7WTOjH19Ph4f37b5fuOOj7Ut4szgiSLrm1jjsbmSNHfgbSi5o3VLRDY4eSa
        7t7ikHL0zrJEva6MvEiIMjB2eBnFqpzJsqRPGCLAcidXhk/JuSpOYfvVOBC9aiPWdHf0utJiNCmeo
        Dyt1iQfg==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXem-0005tE-S0; Thu, 13 Dec 2018 20:32:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/7] block: remove the unused bio_iov_iter_get_pages export
Date:   Thu, 13 Dec 2018 21:32:11 +0100
Message-Id: <20181213203214.10650-5-hch@lst.de>
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
 block/bio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index fa1ea2ac66a8..e9c6f1d6fcbd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -901,7 +901,6 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
-- 
2.19.2

