Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11921C43610
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF23D2245E
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ECfCL234"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF23D2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbeKPDZM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbeKPDZM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y3vDuo8eDqJWr3msBCN4Dvbty54IvpiZQ34Zaclf5KM=; b=ECfCL234a2ZHV7Obw6HKGYgHI
        EYXa/p5AJYiusR20C66exTpak1oYtb3csbHc3CYSze3xXy3XuxfqwLtQEUb21ifoK/nVapiV8k/Gr
        1Pz6TT/mZURZ1D1l5QVOdO/iC5EaqdpKHpUtcOPh5+/aiWAx4IF3n1Fy9vMLTMt/kwPN+4UsMB+A4
        wbq2B362iuLn0UToIbGzSzTEklADJCkJyAbOKBU5Nu4/ReTX7Js4U4PilFgXKiY+eD3cvJm4KNc1T
        TaN/S468dSR3eNhu6IrngeoUcRt2D14BIbbNmkwL2hzoUtpXwSKwqgWtzCnt1fzlI1hG51yQWrIto
        eqDAGMniQ==;
Received: from [52.119.64.114] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNLFm-0002LK-5f; Thu, 15 Nov 2018 17:16:30 +0000
From:   Sagi Grimberg <sagi@lightbitslabs.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 03/11] datagram: introduce skb_copy_and_hash_datagram_iter helper
Date:   Thu, 15 Nov 2018 09:16:15 -0800
Message-Id: <20181115171626.9306-4-sagi@lightbitslabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a helper to copy datagram into an iovec iterator
but also update a predefined hash. This is useful for
consumers of skb_copy_datagram_iter to also support inflight
data digest without having to finish to copy and only then
traverse the iovec and calculate the digest hash.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 include/linux/skbuff.h |  3 ++
 net/core/datagram.c    | 90 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0ba687454267..4d89bb14c2fc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3311,6 +3311,9 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
+int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+			   struct iov_iter *to, int len,
+			   struct ahash_request *hash);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 void __skb_free_datagram_locked(struct sock *sk, struct sk_buff *skb, int len);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 57f3a6fcfc1e..9c81741c1bae 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -497,6 +497,96 @@ int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_datagram_iter);
 
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
+	int start = skb_headlen(skb);
+	int i, copy = start - offset, start_off = offset, n;
+	struct sk_buff *frag_iter;
+
+	/* Copy header. */
+	if (copy > 0) {
+		if (copy > len)
+			copy = len;
+		n = hash_and_copy_to_iter(skb->data + offset, copy, to, hash);
+		offset += n;
+		if (n != copy)
+			goto short_copy;
+		if ((len -= copy) == 0)
+			return 0;
+	}
+
+	/* Copy paged appendix. Hmm... why does this look so complicated? */
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		int end;
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		WARN_ON(start > offset + len);
+
+		end = start + skb_frag_size(frag);
+		if ((copy = end - offset) > 0) {
+			if (copy > len)
+				copy = len;
+			n = hash_and_copy_page_to_iter(skb_frag_page(frag),
+					      frag->page_offset + offset -
+					      start, copy, to, hash);
+			offset += n;
+			if (n != copy)
+				goto short_copy;
+			if (!(len -= copy))
+				return 0;
+		}
+		start = end;
+	}
+
+	skb_walk_frags(skb, frag_iter) {
+		int end;
+
+		WARN_ON(start > offset + len);
+
+		end = start + frag_iter->len;
+		if ((copy = end - offset) > 0) {
+			if (copy > len)
+				copy = len;
+			if (skb_copy_and_hash_datagram_iter(frag_iter,
+					offset - start, to, copy, hash))
+				goto fault;
+			if ((len -= copy) == 0)
+				return 0;
+			offset += copy;
+		}
+		start = end;
+	}
+	if (!len)
+		return 0;
+
+	/* This is not really a user copy fault, but rather someone
+	 * gave us a bogus length on the skb.  We should probably
+	 * print a warning here as it may indicate a kernel bug.
+	 */
+
+fault:
+	iov_iter_revert(to, offset - start_off);
+	return -EFAULT;
+
+short_copy:
+	if (iov_iter_count(to))
+		goto fault;
+
+	return 0;
+}
+EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
+
 /**
  *	skb_copy_datagram_from_iter - Copy a datagram from an iov_iter.
  *	@skb: buffer to copy
-- 
2.17.1

