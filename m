Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D3C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1522080F
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mHA0eQ2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1522080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeKVMdX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391635AbeKVMdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sUe3caG67P7jm+s/FywSA7J7IV+HYAo3Rozd8gCXxZw=; b=mHA0eQ2pjjKYW7L1/SIreBNn3
        xVnEXRSkSbLQQwSQpOJz0sTtLxjkAGyb4twVEg/6J4d48KdQnU4JBzdiaejrqW8pRudi3yTH1dpCZ
        k/52IgylqCdF/qUlHGOMiKlfOlvrHMWcUz5LTTViwAn6v580mUC6v1prT/oa7GOpT2DAmBud+QVqw
        khrty4j0kVLYMEQ/CXFFMj6peOEjIIl9rle19boDZ4Cz5+Je5TZ+dHu1Zj7jmBzC7uWDNJjHq66vP
        OKxt/KCbcjAGPVcoIY8fO5jbrdRUZtbU4rEU2jB7gj0fU2q4L1DeH10D79gDnphf5ZLSE/LaPCwIp
        xkvHFn+RA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE6-0006v0-PU; Thu, 22 Nov 2018 01:56:18 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 05/13] iov_iter: introduce hash_and_copy_to_iter helper
Date:   Wed, 21 Nov 2018 17:56:03 -0800
Message-Id: <20181122015615.15763-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Allow consumers that want to use iov iterator helpers and also update
a predefined hash calculation online when copying data. This is useful
when copying incoming network buffers to a local iterator and calculate
a digest on the incoming stream. nvme-tcp host driver that will be
introduced in following patches is the first consumer via
skb_copy_and_hash_datagram_iter.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 include/linux/uio.h |  3 +++
 lib/iov_iter.c      | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 41d1f8d3313d..ecf584f6b82d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/thread_info.h>
+#include <crypto/hash.h>
 #include <uapi/linux/uio.h>
 
 struct page;
@@ -269,6 +270,8 @@ static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump, struct iov_iter *i);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+		struct iov_iter *i);
 
 int import_iovec(int type, const struct iovec __user * uvector,
 		 unsigned nr_segs, unsigned fast_segs,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index db93531ca3e3..8a5f7b2ae346 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -6,6 +6,7 @@
 #include <linux/vmalloc.h>
 #include <linux/splice.h>
 #include <net/checksum.h>
+#include <linux/scatterlist.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -1475,6 +1476,21 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 }
 EXPORT_SYMBOL(csum_and_copy_to_iter);
 
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+		struct iov_iter *i)
+{
+	struct ahash_request *hash = hashp;
+	struct scatterlist sg;
+	size_t copied;
+
+	copied = copy_to_iter(addr, bytes, i);
+	sg_init_one(&sg, addr, copied);
+	ahash_request_set_crypt(hash, &sg, NULL, copied);
+	crypto_ahash_update(hash);
+	return copied;
+}
+EXPORT_SYMBOL(hash_and_copy_to_iter);
+
 int iov_iter_npages(const struct iov_iter *i, int maxpages)
 {
 	size_t size = i->count;
-- 
2.17.1

