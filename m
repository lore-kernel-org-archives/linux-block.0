Return-Path: <SRS0=FZnh=BK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF8C433E0
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 01:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBA72083E
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 01:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wwhI4gCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgGaBmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbgGaBmv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 21:42:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734A9C061574;
        Thu, 30 Jul 2020 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sJun623wP9tiatqkoyf8KZ4hG2tqljak3ONGna65MJc=; b=wwhI4gCIaXYbuMSBuECaMjZN3p
        CtlT6Cx9HxmNZZpe5tv4w8+poWUoDx2fSYY9L5VSFgYo6ibXrxKiLRHbmUlHMrEq1DlEy1hX301dL
        F08B/u269RJyVfzHvMuAP/Rc5gqhGvPB9pRQNX6WDoogpdZRj5V6AYrLdJZLuOCFlt0ZcMlSGYm/w
        /ARy4TyPliCe1w2oJjeUM5O2hvkE2DKc6UTnK90mC/MpGk0pwOYiWxhDDMIV0aD3kY4Ae7sZyOHsp
        nolAAFfXqDLZcxA7lyUylMlJVIbHaslSKBp5XKQrr3r+L/I/9vRpQuLVlnssQy7mKFei5LaJRHzJE
        FwQCD2lA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1K4P-0006bc-39; Fri, 31 Jul 2020 01:42:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 5/7] block: blk-mq: delete duplicated word
Date:   Thu, 30 Jul 2020 18:42:31 -0700
Message-Id: <20200731014233.6418-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731014233.6418-1-rdunlap@infradead.org>
References: <20200731014233.6418-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/blk-mq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/block/blk-mq.c
+++ linux-next-20200730/block/blk-mq.c
@@ -388,7 +388,7 @@ retry:
 		/*
 		 * Give up the CPU and sleep for a random short time to ensure
 		 * that thread using a realtime scheduling class are migrated
-		 * off the the CPU, and thus off the hctx that is going away.
+		 * off the CPU, and thus off the hctx that is going away.
 		 */
 		msleep(3);
 		goto retry;
