Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D26C4161B
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3346A2087A
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bQYPnSiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3346A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbeKPDZL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbeKPDZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZdbKJXAfsV7pw39f8Z3XLmfAJa5CtZOpt7Jt0PjERHw=; b=bQYPnSiGWtcQiKidpkTsTQnZJ
        lc+/tbIWIqJVFYriBdTQTtWwoPESU+NkkI6uOSVzJQU/vrZuD+eWLF4WLhEfXWKShH3m0XLVxcA2G
        dLVCSxiWBrwD2vCfMyCeKQ2CkZwyXvdmGj+Nsjuxk7faL0Q7h1ImU87XmaTG+1XIAlNgEpi8iB+vu
        n2P9WnmC5A3ZKMb/rZTgH8CxUnF1rwovG4N2MZfwnrpHPk8YcnJH1fKJxRsNV6GrHvHh2ug4XYuuh
        xkIy2Ym9QPkuvtR21eQ+ovQo8HzbVfv5mSDhumydGIoRmjmznAOlrul4LIZg4aTssWgG0t6QUdeaA
        Z/tBNe5mQ==;
Received: from [52.119.64.114] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNLFl-0002LK-Ef; Thu, 15 Nov 2018 17:16:29 +0000
From:   Sagi Grimberg <sagi@lightbitslabs.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 02/11] iov_iter: introduce hash_and_copy iter helpers
Date:   Thu, 15 Nov 2018 09:16:14 -0800
Message-Id: <20181115171626.9306-3-sagi@lightbitslabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow consumers that want to use iov iterator helpers and also update
a predefined hash calculation online when copying data. This is useful
when copying incoming network buffers to a local iterator and calculate
a digest on the incoming stream. nvme-tcp host driver that will be
introduced in following patches is the first consumer via
skb_copy_and_hash_datagram_iter.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 include/linux/uio.h |  5 +++++
 lib/iov_iter.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 55ce99ddb912..c299ea1037a7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/thread_info.h>
+#include <crypto/hash.h>
 #include <uapi/linux/uio.h>
 
 struct page;
@@ -127,6 +128,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+size_t hash_and_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i, struct ahash_request *hash);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
@@ -269,6 +272,8 @@ static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes,
+		struct iov_iter *i, struct ahash_request *hash);
 
 int import_iovec(int type, const struct iovec __user * uvector,
 		 unsigned nr_segs, unsigned fast_segs,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7ebccb5c1637..f15cc4f93ecc 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -6,6 +6,7 @@
 #include <linux/vmalloc.h>
 #include <linux/splice.h>
 #include <net/checksum.h>
+#include <linux/scatterlist.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -850,6 +851,22 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
+size_t hash_and_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i, struct ahash_request *hash)
+{
+	struct scatterlist sg;
+	size_t copied;
+
+	copied = copy_page_to_iter(page, offset, bytes, i);
+	sg_init_marker(&sg, 1);
+	sg_set_page(&sg, page, bytes, offset);
+	ahash_request_set_crypt(hash, &sg, NULL, copied);
+	crypto_ahash_update(hash);
+
+	return copied;
+}
+EXPORT_SYMBOL(hash_and_copy_page_to_iter);
+
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
@@ -1474,6 +1491,20 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 }
 EXPORT_SYMBOL(csum_and_copy_to_iter);
 
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes,
+		struct iov_iter *i, struct ahash_request *hash)
+{
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

