Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B896C64E69
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE622226
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/XOqLCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgKUONz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Nov 2020 09:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727917AbgKUONx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Nov 2020 09:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Brwyd9luXNZHwUZnWyh55ctEF8pacMKJRPmRg6XxmTU=;
        b=d/XOqLCUovRU5YnstbeeVuKLapOys6TSgdRKdXtnjkGIQrDZw1Tr3GD9/jDj6HnE8rP59u
        QuGzJZhdR4Xl+eDBVCniM8bbT7F7BHT0SK/bSySrc3OjWGSi/V3qILDKHsmVDiV7ziuJtK
        zvLgPsNP3IhrUYkhQc0kdalbULN8zoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-taPHaKzFMImi3BiULlzl2A-1; Sat, 21 Nov 2020 09:13:50 -0500
X-MC-Unique: taPHaKzFMImi3BiULlzl2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A92D91005D67;
        Sat, 21 Nov 2020 14:13:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 160005C22B;
        Sat, 21 Nov 2020 14:13:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/29] iov_iter: Split iov_iter_fault_in_readable
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:13:46 +0000
Message-ID: <160596802633.154728.149371155811186006.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split iov_iter_fault_in_readable() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fee8e99fbb9c..280b5c9c9a9c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -439,20 +439,23 @@ static size_t pipe_copy_page_to_iter(struct page *page, size_t offset, size_t by
  * Return 0 on success, or non-zero if the memory could not be accessed (i.e.
  * because it is an invalid address).
  */
-static int xxx_fault_in_readable(struct iov_iter *i, size_t bytes)
+static int iovec_fault_in_readable(struct iov_iter *i, size_t bytes)
 {
 	size_t skip = i->iov_offset;
 	const struct iovec *iov;
 	int err;
 	struct iovec v;
 
-	if (!(iov_iter_type(i) & (ITER_BVEC|ITER_KVEC))) {
-		iterate_iovec(i, bytes, v, iov, skip, ({
-			err = fault_in_pages_readable(v.iov_base, v.iov_len);
-			if (unlikely(err))
-			return err;
-		0;}))
-	}
+	iterate_iovec(i, bytes, v, iov, skip, ({
+		err = fault_in_pages_readable(v.iov_base, v.iov_len);
+		if (unlikely(err))
+		return err;
+	0;}))
+	return 0;
+}
+
+static int no_fault_in_readable(struct iov_iter *i, size_t bytes)
+{
 	return 0;
 }
 
@@ -1846,7 +1849,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
-	.fault_in_readable		= xxx_fault_in_readable,
+	.fault_in_readable		= iovec_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= iovec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
@@ -1880,7 +1883,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
-	.fault_in_readable		= xxx_fault_in_readable,
+	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
@@ -1914,7 +1917,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
-	.fault_in_readable		= xxx_fault_in_readable,
+	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
@@ -1948,7 +1951,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
-	.fault_in_readable		= xxx_fault_in_readable,
+	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= pipe_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
@@ -1982,7 +1985,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
-	.fault_in_readable		= xxx_fault_in_readable,
+	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= discard_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,


