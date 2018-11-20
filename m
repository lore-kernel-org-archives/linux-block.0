Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833CAC43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EDD20870
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tPDvFQok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EDD20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeKTN1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:27:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58258 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeKTN1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 08:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t7DGCZr7caKTnGY4GjwMgyKsRzcfVhbKnFgS635u4qY=; b=tPDvFQokOGWuGLPmbNCSTkurs
        qhT2vrP2yXeCwdd39El5VzDgs24x/dj7dpH8Axjf8PBy64g1iFt/INUejG7ADdP3QJn0qPmR9g4D9
        wvpZ+L6k/18FDSumh6ocNndJjfMgTJ2EDk6AUZWmP8NCBd19j4RhYp5eswn86wOlSxFupdRYLN9Yx
        25zIxVbZ4UMQVv93rLhC6yu5Stwfmx1wZzpQBAuvVedbad3eGTOjaD1NiYUWESPA9zKL2Qp+YoUBj
        iBZ96k8UQrdPaUbwJpHXtqOjcMuKkMK9QOD8jDs2qG+A8pqiuF3Q2foB4E4R6BlysKBUPzABILuIo
        xcV/m4Wtg==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOwH4-0000FW-1D; Tue, 20 Nov 2018 03:00:26 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 02/14] datagram: open-code copy_page_to_iter
Date:   Mon, 19 Nov 2018 19:00:03 -0800
Message-Id: <20181120030019.31738-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This will be useful to consolidate skb_copy_and_hash_datagram_iter and
skb_copy_and_csum_datagram to a single code path.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 net/core/datagram.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 57f3a6fcfc1e..abe642181b64 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -445,11 +445,14 @@ int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
 
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
+			struct page *page = skb_frag_page(frag);
+			u8 *vaddr = kmap(page);
+
 			if (copy > len)
 				copy = len;
-			n = copy_page_to_iter(skb_frag_page(frag),
-					      frag->page_offset + offset -
-					      start, copy, to);
+			n = copy_to_iter(vaddr + frag->page_offset +
+					 offset - start, copy, to);
+			kunmap(page);
 			offset += n;
 			if (n != copy)
 				goto short_copy;
-- 
2.17.1

