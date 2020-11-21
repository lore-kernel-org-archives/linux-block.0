Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47FC63697
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC0422264
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVsSJWar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgKUOOe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Nov 2020 09:14:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728040AbgKUOOe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MOxzf6AmZSNKfEnpa+Mn4aEC9Xg4TZA2VqmfqOCv8zg=;
        b=OVsSJWariqH1oI4a1gcaTJOGhESKpsZQianXHHISl82Yn7ToRVGhLrF5jInwATgbYRegIB
        YKXOne/mfqFzWdoBc7wuFHDSd35WHKjyN5M+UY4sCoqC3SE6cehj321wy5AwIkylH9kmNT
        iEA+dTpXQTkcWNDSY/+yMdc56MI+dkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-EkozzKeyPzuaN7Np9QIgOw-1; Sat, 21 Nov 2020 09:14:29 -0500
X-MC-Unique: EkozzKeyPzuaN7Np9QIgOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A458780ED8E;
        Sat, 21 Nov 2020 14:14:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DBE35D6BA;
        Sat, 21 Nov 2020 14:14:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/29] iov_iter: Split the iterate_all_kinds() macro
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:14:25 +0000
Message-ID: <160596806531.154728.6113611661561602930.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the iterate_all_kinds() macro into iovec, bvec and kvec variants.
It doesn't handle pipes and the discard variant is a no-op and can be built
in directly.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5b18dfe0dcc7..934193627540 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -106,6 +106,33 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n);
 	}							\
 }
 
+#define iterate_over_iovec(i, n, v, CMD) {			\
+	if (likely(n)) {					\
+		size_t skip = i->iov_offset;			\
+		const struct iovec *iov;			\
+		struct iovec v;					\
+		iterate_iovec(i, n, v, iov, skip, (CMD))	\
+	}							\
+}
+
+#define iterate_over_bvec(i, n, v, CMD) {			\
+	if (likely(n)) {					\
+		size_t skip = i->iov_offset;			\
+		struct bio_vec v;				\
+		struct bvec_iter __bi;				\
+		iterate_bvec(i, n, v, __bi, skip, (CMD))	\
+	}							\
+}
+
+#define iterate_over_kvec(i, n, v, CMD) {			\
+	if (likely(n)) {					\
+		size_t skip = i->iov_offset;			\
+		const struct kvec *kvec;			\
+		struct kvec v;					\
+		iterate_kvec(i, n, v, kvec, skip, (CMD))	\
+	}							\
+}
+
 #define iterate_and_advance(i, n, v, I, B, K) {			\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\


