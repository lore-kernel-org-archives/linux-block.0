Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2AC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0CA20851
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdUXsNvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0CA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeK1KP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:15:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeK1KP5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bR7RP+lntTBKCIkonfUSbr8y60GQQq5+R78uSVwWIUQ=; b=gdUXsNvVT7Eo3ud0j6TNkOAe2
        ZE5ElnBQAKqtGT0SPzceR0/M9L2Dm3cdSq2MbiMn1lj3bhdtEmkLfiB1eSd9krmunTCoXZbYCOkha
        aHhil1luAwS6yKEZn537fS/VEyKa6/BbCNlPUEh3vZERXZRkMZ2OHPtw0qgM/nYl25/jRAwuENU7D
        OeB8lu1LMBNY2tLfYe8lgHn6KW7kUXsZE1HlZ5p2h4hfnDIEa+gMMhL4le8jJfwvhmrHOwb9SJWRi
        9b0tPBZSMLxYsw+dn0RJAmQ+VvUEgNlFgHNyHPJl8fuFE6bqCIh8NYX+sYQGp3YVKQUdHmSvFv+y3
        WQj4iT9Vw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRmac-0007cp-Gq; Tue, 27 Nov 2018 23:16:22 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 06/13] datagram: introduce skb_copy_and_hash_datagram_iter helper
Date:   Tue, 27 Nov 2018 15:16:08 -0800
Message-Id: <20181127231615.9446-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127231615.9446-1-sagi@grimberg.me>
References: <20181127231615.9446-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Introduce a helper to copy datagram into an iovec iterator
but also update a predefined hash. This is useful for
consumers of skb_copy_datagram_iter to also support inflight
data digest without having to finish to copy and only then
traverse the iovec and calculate the digest hash.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 include/linux/skbuff.h |  3 +++
 net/core/datagram.c    | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0ba687454267..b0b8d5653f0d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3309,6 +3309,9 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 }
 int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
+int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+			   struct iov_iter *to, int len,
+			   struct ahash_request *hash);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 382543302ae5..ef262282c8be 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -465,7 +465,7 @@ int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			if (copy > len)
 				copy = len;
 			if (__skb_datagram_iter(frag_iter, offset - start,
-						to, copy, short_copy, cb, data))
+						to, copy, fault_short, cb, data))
 				goto fault;
 			if ((len -= copy) == 0)
 				return 0;
@@ -492,6 +492,24 @@ int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	return 0;
 }
 
+/**
+ *	skb_copy_and_hash_datagram_iter - Copy datagram to an iovec iterator
+ *          and update a hash.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: iovec iterator to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ *      @hash: hash request to update
+ */
+int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+			   struct iov_iter *to, int len,
+			   struct ahash_request *hash)
+{
+	return __skb_datagram_iter(skb, offset, to, len, true,
+			hash_and_copy_to_iter, hash);
+}
+EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
+
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
-- 
2.17.1

