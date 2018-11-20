Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1891CC43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CF92089F
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 03:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FKJyuCoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CF92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbeKTN1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:27:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbeKTN1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 08:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fvbYiB+jCvMKt3IgP7RC3RcB6dGDGabdlVKmfY+nD9k=; b=FKJyuCoCgByAbMqROPvUPd1R6
        IHD/pSs2VesS/P3XsA2pc3zo0dQKMpa8Bt4WhfjRLxUY2V+g4I7YtiC1csRTrKU7IU6uB7V3jbZAe
        dUavMBDNIvRcDVJv77VBwmOWY+811thsv4/W2ytYgbcmW/4m97h6Axgz4N6oQFjqt6Ov3HD/O7F7B
        jE3DelfD/fkcM/baloDkyV1JeslBr3gvxeHjl5pcNIQ0zbzAmHqyaih4mPC/mW7NKDV4skMcn5y6B
        ZS06niGW5o3rrtmjVnPnzs611DkoQgvXTZ7HcdGSPFlT+0keScu3JQBrICqrVfpddv3pmTc5MflsR
        hz85lWV4g==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOwH5-0000FW-7H; Tue, 20 Nov 2018 03:00:27 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 06/14] datagram: introduce skb_copy_and_hash_datagram_iter helper
Date:   Mon, 19 Nov 2018 19:00:08 -0800
Message-Id: <20181120030019.31738-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a helper to copy datagram into an iovec iterator
but also update a predefined hash. This is useful for
consumers of skb_copy_datagram_iter to also support inflight
data digest without having to finish to copy and only then
traverse the iovec and calculate the digest hash.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/skbuff.h |  3 +++
 net/core/datagram.c    | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

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
index 382543302ae5..e6a4fc845f72 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -492,6 +492,23 @@ int __skb_datagram_iter(const struct sk_buff *skb, int offset,
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
+
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
-- 
2.17.1

