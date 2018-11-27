Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA7CC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77D620851
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZEpbhRmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77D620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeK1KPy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:15:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1KPy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hmyY1uqBh6uOBpkppi0IFFhh2x7374DU2saM9uG0/ws=; b=ZEpbhRmDi5To4A4Us2bujPEYD
        gHmzTvibc8Jv42KQoaEVXIgvmW0eVIez06/obnemF4pGdnZJe+PaacxGk73sox2R94u9T87Z7D9zf
        aUZsx4iTHyI8zA7Ew/1qjzB5eeGrcuP75A4aX8YeXhFZiB1xnXzpNgUrOnx2/2Vkyy1Bqz9GQGd53
        TFPW3IopoRZusOJTEpwWM7tPHwjHjSHZ2n9RiGbpEnfmbgwNK/C17K1HVAbK4TM8p6PesffE9VTWc
        +Pz9w5aSpcioKKg0hzrwveEyLv/GnQmusiu4xXwAZdVyDw8gQjWRYWcJ4U+4viT6+hUiprhQVfHeR
        sR4eL7aDA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRmab-0007cp-4T; Tue, 27 Nov 2018 23:16:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 02/13] datagram: open-code copy_page_to_iter
Date:   Tue, 27 Nov 2018 15:16:04 -0800
Message-Id: <20181127231615.9446-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127231615.9446-1-sagi@grimberg.me>
References: <20181127231615.9446-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

This will be useful to consolidate skb_copy_and_hash_datagram_iter and
skb_copy_and_csum_datagram to a single code path.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
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

