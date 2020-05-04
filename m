Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D8C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 16:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53471206A4
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UONfpzmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEDQKK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgEDQKK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 12:10:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB3C061A0E
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IIGYnujbUjOP6Ca3tu+jdAjGkH250qvDplGhSMY5VmM=; b=UONfpzmRAf+mZv2Sk+gREhSn1y
        409xdODnTCqFT82/+3gLMqnBWDkEgQdLrcOaBKsAbvzrvUOrrRv96naJ9vV4OJ26gBRbNUMSsmWjT
        uyZ2LRWg4JnRY2iZlwdvK1bvrajwGMcDJIoJnakr3s/hJ+3Mo8qKpade7HgKt2hRgVJ/Il7xGZx1h
        Fa7nS0ojl8Rf79dDbliYx3DlGZtmT2j4+UOw8Ck8klEqdm6kNCtDyOOVt4MxTCg2aYmumKgFgC0vy
        3W8BGWTGonKxqrCqa3BK0FICGdCaybXo2Y4VVHYYRwtZ84RdXpHJ3hk3seYdzcsf8y/LxiQudjQSh
        G9yPmdXQ==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVdfW-00059n-3F; Mon, 04 May 2020 16:10:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove the REQ_NOWAIT_INLINE flag
Date:   Mon,  4 May 2020 18:10:05 +0200
Message-Id: <20200504161005.2841033-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 90895d594e647..7443e474cdad5 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -323,7 +323,6 @@ enum req_flag_bits {
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NOWAIT,           /* Don't wait if request will block */
-	__REQ_NOWAIT_INLINE,	/* Return would-block error inline */
 	/*
 	 * When a shared kthread needs to issue a bio for a cgroup, doing
 	 * so synchronously can lead to priority inversions as the kthread
@@ -358,7 +357,6 @@ enum req_flag_bits {
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
-#define REQ_NOWAIT_INLINE	(1ULL << __REQ_NOWAIT_INLINE)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
-- 
2.26.2

