Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF018C388F9
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76552224A
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hL7rMXDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgKUOOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Nov 2020 09:14:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbgKUOOB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SrNEeqWVEcvXCl0seBrseTcT0IMzwDCjOyOwZ0vCNA=;
        b=hL7rMXDAqX/L6HsNtW9UU+MqoHY183/Vadkhr57YtbaZgUWoqbc1c+A8yLvB5LIX9MUPL3
        gcXe+M7zoo9v+rOMugLJwlZVOIyO1LEe2StlZsKZpmQB9E3d0mptL3UdaJHeiLFTQuUcQh
        hzfw1SxVJ8Pd3VGwzth4ohenTDkdqXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-bgXRmFisNpCoZrNH8mhsRQ-1; Sat, 21 Nov 2020 09:13:57 -0500
X-MC-Unique: bgXRmFisNpCoZrNH8mhsRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60D23804741;
        Sat, 21 Nov 2020 14:13:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B39F710016DB;
        Sat, 21 Nov 2020 14:13:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/29] iov_iter: Split the iterate_and_advance() macro
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:13:53 +0000
Message-ID: <160596803388.154728.17090770115276211012.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the iterate_and_advance() macro into iovec, bvec, kvec and discard
variants.  It doesn't handle pipes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 280b5c9c9a9c..a221e7771201 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -147,6 +147,68 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n);
 	}							\
 }
 
+#define iterate_and_advance_iovec(i, n, v, CMD) {		\
+	if (unlikely(i->count < n))				\
+		n = i->count;					\
+	if (i->count) {						\
+		size_t skip = i->iov_offset;			\
+		const struct iovec *iov;			\
+		struct iovec v;					\
+		iterate_iovec(i, n, v, iov, skip, (CMD))	\
+			if (skip == iov->iov_len) {		\
+				iov++;				\
+				skip = 0;			\
+			}					\
+		i->nr_segs -= iov - i->iov;			\
+		i->iov = iov;					\
+		i->count -= n;					\
+		i->iov_offset = skip;				\
+	}							\
+}
+
+#define iterate_and_advance_bvec(i, n, v, CMD) {		\
+	if (unlikely(i->count < n))				\
+		n = i->count;					\
+	if (i->count) {						\
+		size_t skip = i->iov_offset;				\
+		const struct bio_vec *bvec = i->bvec;			\
+		struct bio_vec v;					\
+		struct bvec_iter __bi;					\
+		iterate_bvec(i, n, v, __bi, skip, (CMD))		\
+			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
+		i->nr_segs -= i->bvec - bvec;				\
+		skip = __bi.bi_bvec_done;				\
+		i->count -= n;						\
+		i->iov_offset = skip;					\
+	}								\
+}
+
+#define iterate_and_advance_kvec(i, n, v, CMD) {		\
+	if (unlikely(i->count < n))				\
+		n = i->count;					\
+	if (i->count) {						\
+		size_t skip = i->iov_offset;			\
+		const struct kvec *kvec;			\
+		struct kvec v;					\
+		iterate_kvec(i, n, v, kvec, skip, (CMD))	\
+			if (skip == kvec->iov_len) {		\
+				kvec++;				\
+				skip = 0;			\
+			}					\
+		i->nr_segs -= kvec - i->kvec;			\
+		i->kvec = kvec;					\
+		i->count -= n;					\
+		i->iov_offset = skip;				\
+	}							\
+}
+
+#define iterate_and_advance_discard(i, n) {			\
+	if (unlikely(i->count < n))				\
+		n = i->count;					\
+	i->count -= n;						\
+	i->iov_offset += n;					\
+}
+
 static int copyout(void __user *to, const void *from, size_t n)
 {
 	if (should_fail_usercopy())


