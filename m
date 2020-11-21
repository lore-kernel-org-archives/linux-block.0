Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8809C64E7D
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD922224A
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV5EmN13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgKUOPp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Nov 2020 09:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728238AbgKUOPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Nov 2020 09:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGrPe4o/S5aCZvKVL3hw7DCeW/9Xw/NFeCgsf4eSSA0=;
        b=MV5EmN13PP4jpMyJAuZr3dIw2MwUp+KFHEuIhsXxgdthLaxQOgQEdGGCEdk5FctP7RjhZn
        DXvXwNor2ArAC2z91T7h8Df1uGPoZlypsRCG+/3NDJVCEBqK6RoNg5JGMwL9oYHdV1XnPs
        KDsG3fTJQV+Zu9MiAO8U4JWLNlvCmWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-jHd7vtpgMDuuCO6mnqNbTQ-1; Sat, 21 Nov 2020 09:15:38 -0500
X-MC-Unique: jHd7vtpgMDuuCO6mnqNbTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D43A1005D65;
        Sat, 21 Nov 2020 14:15:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A55CA5D9D7;
        Sat, 21 Nov 2020 14:15:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/29] iov_iter: Split iov_iter_revert()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:15:34 +0000
Message-ID: <160596813488.154728.6654456287509529880.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split iov_iter_revert() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |  132 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 79 insertions(+), 53 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9859b4b8a116..b8e3da20547e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1319,71 +1319,97 @@ static void discard_advance(struct iov_iter *i, size_t size)
 	i->count -= size;
 }
 
-static void xxx_revert(struct iov_iter *i, size_t unroll)
+static void iovec_kvec_revert(struct iov_iter *i, size_t unroll)
 {
+	const struct iovec *iov = i->iov;
 	if (!unroll)
 		return;
 	if (WARN_ON(unroll > MAX_RW_COUNT))
 		return;
 	i->count += unroll;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		struct pipe_inode_info *pipe = i->pipe;
-		unsigned int p_mask = pipe->ring_size - 1;
-		unsigned int i_head = i->head;
-		size_t off = i->iov_offset;
-		while (1) {
-			struct pipe_buffer *b = &pipe->bufs[i_head & p_mask];
-			size_t n = off - b->offset;
-			if (unroll < n) {
-				off -= unroll;
-				break;
-			}
-			unroll -= n;
-			if (!unroll && i_head == i->start_head) {
-				off = 0;
-				break;
-			}
-			i_head--;
-			b = &pipe->bufs[i_head & p_mask];
-			off = b->offset + b->len;
-		}
-		i->iov_offset = off;
-		i->head = i_head;
-		pipe_truncate(i);
+	if (unroll <= i->iov_offset) {
+		i->iov_offset -= unroll;
 		return;
 	}
-	if (unlikely(iov_iter_is_discard(i)))
+	unroll -= i->iov_offset;
+	while (1) {
+		size_t n = (--iov)->iov_len;
+		i->nr_segs++;
+		if (unroll <= n) {
+			i->iov = iov;
+			i->iov_offset = n - unroll;
+			return;
+		}
+		unroll -= n;
+	}
+}
+
+static void bvec_revert(struct iov_iter *i, size_t unroll)
+{
+	const struct bio_vec *bvec = i->bvec;
+
+	if (!unroll)
 		return;
+	if (WARN_ON(unroll > MAX_RW_COUNT))
+		return;
+	i->count += unroll;
 	if (unroll <= i->iov_offset) {
 		i->iov_offset -= unroll;
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_bvec(i)) {
-		const struct bio_vec *bvec = i->bvec;
-		while (1) {
-			size_t n = (--bvec)->bv_len;
-			i->nr_segs++;
-			if (unroll <= n) {
-				i->bvec = bvec;
-				i->iov_offset = n - unroll;
-				return;
-			}
-			unroll -= n;
+	while (1) {
+		size_t n = (--bvec)->bv_len;
+		i->nr_segs++;
+		if (unroll <= n) {
+			i->bvec = bvec;
+			i->iov_offset = n - unroll;
+			return;
 		}
-	} else { /* same logics for iovec and kvec */
-		const struct iovec *iov = i->iov;
-		while (1) {
-			size_t n = (--iov)->iov_len;
-			i->nr_segs++;
-			if (unroll <= n) {
-				i->iov = iov;
-				i->iov_offset = n - unroll;
-				return;
-			}
-			unroll -= n;
+		unroll -= n;
+	}
+}
+
+static void pipe_revert(struct iov_iter *i, size_t unroll)
+{
+	struct pipe_inode_info *pipe = i->pipe;
+	unsigned int p_mask = pipe->ring_size - 1;
+	unsigned int i_head = i->head;
+	size_t off = i->iov_offset;
+
+	if (!unroll)
+		return;
+	if (WARN_ON(unroll > MAX_RW_COUNT))
+		return;
+
+	while (1) {
+		struct pipe_buffer *b = &pipe->bufs[i_head & p_mask];
+		size_t n = off - b->offset;
+		if (unroll < n) {
+			off -= unroll;
+			break;
+		}
+		unroll -= n;
+		if (!unroll && i_head == i->start_head) {
+			off = 0;
+			break;
 		}
+		i_head--;
+		b = &pipe->bufs[i_head & p_mask];
+		off = b->offset + b->len;
 	}
+	i->iov_offset = off;
+	i->head = i_head;
+	pipe_truncate(i);
+}
+
+static void discard_revert(struct iov_iter *i, size_t unroll)
+{
+	if (!unroll)
+		return;
+	if (WARN_ON(unroll > MAX_RW_COUNT))
+		return;
+	i->count += unroll;
 }
 
 /*
@@ -2082,7 +2108,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.type				= ITER_IOVEC,
 	.copy_from_user_atomic		= iovec_copy_from_user_atomic,
 	.advance			= iovec_advance,
-	.revert				= xxx_revert,
+	.revert				= iovec_kvec_revert,
 	.fault_in_readable		= iovec_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= iovec_copy_page_to_iter,
@@ -2116,7 +2142,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.type				= ITER_KVEC,
 	.copy_from_user_atomic		= kvec_copy_from_user_atomic,
 	.advance			= kvec_advance,
-	.revert				= xxx_revert,
+	.revert				= iovec_kvec_revert,
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
@@ -2150,7 +2176,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.type				= ITER_BVEC,
 	.copy_from_user_atomic		= bvec_copy_from_user_atomic,
 	.advance			= bvec_iov_advance,
-	.revert				= xxx_revert,
+	.revert				= bvec_revert,
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
@@ -2184,7 +2210,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.type				= ITER_PIPE,
 	.copy_from_user_atomic		= no_copy_from_user_atomic,
 	.advance			= pipe_advance,
-	.revert				= xxx_revert,
+	.revert				= pipe_revert,
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= pipe_copy_page_to_iter,
@@ -2218,7 +2244,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.type				= ITER_DISCARD,
 	.copy_from_user_atomic		= no_copy_from_user_atomic,
 	.advance			= discard_advance,
-	.revert				= xxx_revert,
+	.revert				= discard_revert,
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= discard_copy_page_to_iter,


