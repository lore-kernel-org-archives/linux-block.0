Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65307C64E7B
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317BF2224A
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doACJUTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgKUOQX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Nov 2020 09:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728307AbgKUOQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42Modz9lzLK9PgNIzmKcsfAc59EtrxVIzllSBW53iIs=;
        b=doACJUTBh9QaCGN4yuORYYHpXwvakOXA+ssuaoLL9fQnrX3JE6qgcwmJ8nnK3A8XzzF2Qu
        Zyr3WSdYFP2Avdp+h/Do4yXPDF9P1b4sfsuvekyXDcL1HObUXQLw8EU7MmOcJVXKqNDRL0
        /cyOlvjHylLfB+vdthyhLQRYXVsNKRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-zJzT5r59Ohu6bqsLNumyOA-1; Sat, 21 Nov 2020 09:16:17 -0500
X-MC-Unique: zJzT5r59Ohu6bqsLNumyOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4435F1005D6D;
        Sat, 21 Nov 2020 14:16:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 758F56085D;
        Sat, 21 Nov 2020 14:16:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/29] iov_iter: Split iov_iter_get_pages_alloc()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:16:13 +0000
Message-ID: <160596817368.154728.12568762587413499390.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split iov_iter_get_pages_alloc() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a2de201b947f..a038bfbbbd53 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1690,6 +1690,8 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	unsigned int iter_head, npages;
 	ssize_t n;
 
+	if (maxsize > i->count)
+		maxsize = i->count;
 	if (!maxsize)
 		return 0;
 
@@ -1715,7 +1717,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	return n;
 }
 
-static ssize_t xxx_get_pages_alloc(struct iov_iter *i,
+static ssize_t iovec_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
 {
@@ -1724,12 +1726,7 @@ static ssize_t xxx_get_pages_alloc(struct iov_iter *i,
 	if (maxsize > i->count)
 		maxsize = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_get_pages_alloc(i, pages, maxsize, start);
-	if (unlikely(iov_iter_is_discard(i)))
-		return -EFAULT;
-
-	iterate_all_kinds(i, maxsize, v, ({
+	iterate_over_iovec(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
 		int n;
@@ -1748,7 +1745,20 @@ static ssize_t xxx_get_pages_alloc(struct iov_iter *i,
 		}
 		*pages = p;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
-	0;}),({
+	0;}));
+	return 0;
+}
+
+static ssize_t bvec_get_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   size_t *start)
+{
+	struct page **p;
+
+	if (maxsize > i->count)
+		maxsize = i->count;
+
+	iterate_over_bvec(i, maxsize, v, ({
 		/* can't be more than PAGE_SIZE */
 		*start = v.bv_offset;
 		*pages = p = get_pages_array(1);
@@ -1756,13 +1766,17 @@ static ssize_t xxx_get_pages_alloc(struct iov_iter *i,
 			return -ENOMEM;
 		get_page(*p = v.bv_page);
 		return v.bv_len;
-	}),({
-		return -EFAULT;
-	})
-	)
+	}));
 	return 0;
 }
 
+static ssize_t no_get_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   size_t *start)
+{
+	return -EFAULT;
+}
+
 static size_t xxx_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
@@ -2192,7 +2206,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.alignment			= iovec_alignment,
 	.gap_alignment			= iovec_gap_alignment,
 	.get_pages			= iovec_get_pages,
-	.get_pages_alloc		= xxx_get_pages_alloc,
+	.get_pages_alloc		= iovec_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
@@ -2226,7 +2240,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.alignment			= kvec_alignment,
 	.gap_alignment			= kvec_gap_alignment,
 	.get_pages			= no_get_pages,
-	.get_pages_alloc		= xxx_get_pages_alloc,
+	.get_pages_alloc		= no_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
@@ -2260,7 +2274,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.alignment			= bvec_alignment,
 	.gap_alignment			= bvec_gap_alignment,
 	.get_pages			= bvec_get_pages,
-	.get_pages_alloc		= xxx_get_pages_alloc,
+	.get_pages_alloc		= bvec_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
@@ -2294,7 +2308,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.alignment			= pipe_alignment,
 	.gap_alignment			= no_gap_alignment,
 	.get_pages			= pipe_get_pages,
-	.get_pages_alloc		= xxx_get_pages_alloc,
+	.get_pages_alloc		= pipe_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,
@@ -2328,7 +2342,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.alignment			= no_alignment,
 	.gap_alignment			= no_gap_alignment,
 	.get_pages			= no_get_pages,
-	.get_pages_alloc		= xxx_get_pages_alloc,
+	.get_pages_alloc		= no_get_pages_alloc,
 	.npages				= xxx_npages,
 	.dup_iter			= xxx_dup_iter,
 	.for_each_range			= xxx_for_each_range,


