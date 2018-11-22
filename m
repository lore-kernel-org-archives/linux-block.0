Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C7FC43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E30D20645
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I0K2ghvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E30D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391622AbeKVMdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391621AbeKVMdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hmyY1uqBh6uOBpkppi0IFFhh2x7374DU2saM9uG0/ws=; b=I0K2ghvDEaiL/XZ7KH0thGTqc
        IuQffT9YgY22O6JVOV+m8xa9EoCJ7ENyJ859hZa5ZJOEABxJ5/pYe3g9JMQ5SFu6AhjgMgk4yDI8k
        3EO04W3igg065yK80zuK9buXYteJAOCxMEB4ynorfTCALSyDQNuebQ4GO8sRr5SlDwzstI0D3QcQB
        Brd7epvTkFlEWw7eal6JXARpfn2owF3IYQUD8HxUA1TN1VwhqrWQRhvHbI/t6/0+nyO9dimY/pTli
        YiFvqzYNAc4WaX2+Gc/udA8k9/wDuw5B7nLdbkAt72L7f09zGeOYSK8yr2QvvO43ip5fZFoa41Lci
        EOc3WtadQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE6-0006v0-26; Thu, 22 Nov 2018 01:56:18 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 02/13] datagram: open-code copy_page_to_iter
Date:   Wed, 21 Nov 2018 17:56:00 -0800
Message-Id: <20181122015615.15763-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
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

