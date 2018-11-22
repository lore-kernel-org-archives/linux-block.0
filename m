Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A552C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A0320645
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FvIKJpHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A0320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391629AbeKVMdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391623AbeKVMdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=efGn1soh43TdZZoOO70FVPJNadeYGJ0RRfisArm2dRw=; b=FvIKJpHItWb6S0hwBJ25ODv7U
        cloYwrpd2oLVxQvl7Jqdkz+0B/TxbrdSVIkuPJezT+7ezsSH9lEPfBQWZ2+FyzvaKQDe/YRUj8oK5
        PgZUN+oPdEU9Oiwvxwc0ehNASFFDZsGi/JzcVugMNMIjh8i0/lDUpJqMpWgKgXD8M3pVEVoy4T3dQ
        KjxwGv+UWOYP9FWfnmfaAjRPDFYdaOjZjThDObfLh2t5nnHMWaNXPuKLfzJZhPwebQR3ueCvDOrjW
        NQk/idkh2AmlxFSqz1Ta9pmpjU12MyLBR0OD4qdJmMqaJuPQ17Zyy83Eer08/9i6VEJ/hfne/uzoO
        Xomt2dK7w==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE6-0006v0-HX; Thu, 22 Nov 2018 01:56:18 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 04/13] datagram: consolidate datagram copy to iter helpers
Date:   Wed, 21 Nov 2018 17:56:02 -0800
Message-Id: <20181122015615.15763-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

skb_copy_datagram_iter and skb_copy_and_csum_datagram are essentialy
the same but with a couple of differences: The first is the copy
operation used which either a simple copy or a csum_and_copy, and the
second are the behavior on the "short copy" path where simply copy
needs to return the number of bytes successfully copied while csum_and_copy
needs to fault immediately as the checksum is partial.

Introduce __skb_datagram_iter that additionally accepts:
1. copy operation function pointer
2. private data that goes with the copy operation
3. fault_short flag to indicate the action on short copy

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 net/core/datagram.c | 136 ++++++++++++++------------------------------
 1 file changed, 42 insertions(+), 94 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index abe642181b64..382543302ae5 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -408,27 +408,20 @@ int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags)
 }
 EXPORT_SYMBOL(skb_kill_datagram);
 
-/**
- *	skb_copy_datagram_iter - Copy a datagram to an iovec iterator.
- *	@skb: buffer to copy
- *	@offset: offset in the buffer to start copying from
- *	@to: iovec iterator to copy to
- *	@len: amount of data to copy from buffer to iovec
- */
-int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
-			   struct iov_iter *to, int len)
+int __skb_datagram_iter(const struct sk_buff *skb, int offset,
+			struct iov_iter *to, int len, bool fault_short,
+			size_t (*cb)(const void *, size_t, void *, struct iov_iter *),
+			void *data)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset, start_off = offset, n;
 	struct sk_buff *frag_iter;
 
-	trace_skb_copy_datagram_iovec(skb, len);
-
 	/* Copy header. */
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
-		n = copy_to_iter(skb->data + offset, copy, to);
+		n = cb(skb->data + offset, copy, data, to);
 		offset += n;
 		if (n != copy)
 			goto short_copy;
@@ -450,8 +443,8 @@ int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
 
 			if (copy > len)
 				copy = len;
-			n = copy_to_iter(vaddr + frag->page_offset +
-					 offset - start, copy, to);
+			n = cb(vaddr + frag->page_offset +
+				offset - start, copy, data, to);
 			kunmap(page);
 			offset += n;
 			if (n != copy)
@@ -471,8 +464,8 @@ int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
 		if ((copy = end - offset) > 0) {
 			if (copy > len)
 				copy = len;
-			if (skb_copy_datagram_iter(frag_iter, offset - start,
-						   to, copy))
+			if (__skb_datagram_iter(frag_iter, offset - start,
+						to, copy, short_copy, cb, data))
 				goto fault;
 			if ((len -= copy) == 0)
 				return 0;
@@ -493,11 +486,32 @@ int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
 	return -EFAULT;
 
 short_copy:
-	if (iov_iter_count(to))
+	if (fault_short || iov_iter_count(to))
 		goto fault;
 
 	return 0;
 }
+
+static size_t simple_copy_to_iter(const void *addr, size_t bytes,
+		void *data __always_unused, struct iov_iter *i)
+{
+	return copy_to_iter(addr, bytes, i);
+}
+
+/**
+ *	skb_copy_datagram_iter - Copy a datagram to an iovec iterator.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: iovec iterator to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ */
+int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
+			   struct iov_iter *to, int len)
+{
+	trace_skb_copy_datagram_iovec(skb, len);
+	return __skb_datagram_iter(skb, offset, to, len, false,
+			simple_copy_to_iter, NULL);
+}
 EXPORT_SYMBOL(skb_copy_datagram_iter);
 
 /**
@@ -648,87 +662,21 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(zerocopy_sg_from_iter);
 
+/**
+ *	skb_copy_and_csum_datagram_iter - Copy datagram to an iovec iterator
+ *          and update a checksum.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: iovec iterator to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ *      @csump: checksum pointer
+ */
 static int skb_copy_and_csum_datagram(const struct sk_buff *skb, int offset,
 				      struct iov_iter *to, int len,
 				      __wsum *csump)
 {
-	int start = skb_headlen(skb);
-	int i, copy = start - offset, start_off = offset;
-	struct sk_buff *frag_iter;
-	int pos = 0;
-	int n;
-
-	/* Copy header. */
-	if (copy > 0) {
-		if (copy > len)
-			copy = len;
-		n = csum_and_copy_to_iter(skb->data + offset, copy, csump, to);
-		offset += n;
-		if (n != copy)
-			goto fault;
-		if ((len -= copy) == 0)
-			return 0;
-		pos = copy;
-	}
-
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-		int end;
-		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-
-		WARN_ON(start > offset + len);
-
-		end = start + skb_frag_size(frag);
-		if ((copy = end - offset) > 0) {
-			__wsum csum2 = 0;
-			struct page *page = skb_frag_page(frag);
-			u8  *vaddr = kmap(page);
-
-			if (copy > len)
-				copy = len;
-			n = csum_and_copy_to_iter(vaddr + frag->page_offset +
-						  offset - start, copy,
-						  &csum2, to);
-			kunmap(page);
-			offset += n;
-			if (n != copy)
-				goto fault;
-			*csump = csum_block_add(*csump, csum2, pos);
-			if (!(len -= copy))
-				return 0;
-			pos += copy;
-		}
-		start = end;
-	}
-
-	skb_walk_frags(skb, frag_iter) {
-		int end;
-
-		WARN_ON(start > offset + len);
-
-		end = start + frag_iter->len;
-		if ((copy = end - offset) > 0) {
-			__wsum csum2 = 0;
-			if (copy > len)
-				copy = len;
-			if (skb_copy_and_csum_datagram(frag_iter,
-						       offset - start,
-						       to, copy,
-						       &csum2))
-				goto fault;
-			*csump = csum_block_add(*csump, csum2, pos);
-			if ((len -= copy) == 0)
-				return 0;
-			offset += copy;
-			pos += copy;
-		}
-		start = end;
-	}
-	if (!len)
-		return 0;
-
-fault:
-	iov_iter_revert(to, offset - start_off);
-	return -EFAULT;
+	return __skb_datagram_iter(skb, offset, to, len, true,
+			csum_and_copy_to_iter, csump);
 }
 
 __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
-- 
2.17.1

