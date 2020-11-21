Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F41C64E7D
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256CC2245D
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MA22twdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgKUOPG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Nov 2020 09:15:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728162AbgKUOPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Nov 2020 09:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVU2Fb/xVpWFVdtrZFqElVvemnq4TZD7WPoTZ9/Kuds=;
        b=MA22twdFReJ2tR7ZMtKGRl6CWQ9s1tkorLDNG2MZJ0sbSdXWa4CrAAHfn0j89s5KjrjyNl
        pGja+ChBIpVcxibVR6Bkb9JjqiGoxGbN3M9kNrq8pxZaIk+9vI9JG9Bvn9/9VXk4XavGPQ
        VDDY/PRB6CrdkdltJdQdDKEjIVcJ8TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-4Q0AbEC-Pj2Mpja_toWsPA-1; Sat, 21 Nov 2020 09:15:00 -0500
X-MC-Unique: 4Q0AbEC-Pj2Mpja_toWsPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 889C0107AD46;
        Sat, 21 Nov 2020 14:14:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE2C51975F;
        Sat, 21 Nov 2020 14:14:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/29] iov_iter: Split copy_from_iter_full_nocache()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:14:56 +0000
Message-ID: <160596809604.154728.18003023672281785295.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split copy_from_iter_full_nocache() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6b4739d7dd9a..544e532e3e9f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1041,25 +1041,39 @@ static size_t kvec_copy_from_iter_flushcache(void *addr, size_t bytes, struct io
 }
 #endif
 
-static bool xxx_copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
+static bool iovec_copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
-		return false;
-	}
 	if (unlikely(i->count < bytes))
 		return false;
-	iterate_all_kinds(i, bytes, v, ({
+	iterate_over_iovec(i, bytes, v, ({
 		if (__copy_from_user_inatomic_nocache((to += v.iov_len) - v.iov_len,
 					     v.iov_base, v.iov_len))
 			return false;
-		0;}),
+		0;}));
+	iov_iter_advance(i, bytes);
+	return true;
+}
+
+static bool bvec_copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+	if (unlikely(i->count < bytes))
+		return false;
+	iterate_over_bvec(i, bytes, v,
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
-	)
+				 v.bv_offset, v.bv_len));
+	iov_iter_advance(i, bytes);
+	return true;
+}
 
+static bool kvec_copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+	if (unlikely(i->count < bytes))
+		return false;
+	iterate_over_kvec(i, bytes, v,
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len));
 	iov_iter_advance(i, bytes);
 	return true;
 }
@@ -2026,7 +2040,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.copy_from_iter			= iovec_copy_from_iter,
 	.copy_from_iter_full		= iovec_copy_from_iter_full,
 	.copy_from_iter_nocache		= iovec_copy_from_iter_nocache,
-	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+	.copy_from_iter_full_nocache	= iovec_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= iovec_copy_from_iter_flushcache,
 #endif
@@ -2060,7 +2074,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.copy_from_iter			= kvec_copy_from_iter,
 	.copy_from_iter_full		= kvec_copy_from_iter_full,
 	.copy_from_iter_nocache		= kvec_copy_from_iter_nocache,
-	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+	.copy_from_iter_full_nocache	= kvec_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= kvec_copy_from_iter_flushcache,
 #endif
@@ -2094,7 +2108,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.copy_from_iter			= bvec_copy_from_iter,
 	.copy_from_iter_full		= bvec_copy_from_iter_full,
 	.copy_from_iter_nocache		= bvec_copy_from_iter_nocache,
-	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+	.copy_from_iter_full_nocache	= bvec_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= bvec_copy_from_iter_flushcache,
 #endif
@@ -2128,7 +2142,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.copy_from_iter			= no_copy_from_iter,
 	.copy_from_iter_full		= no_copy_from_iter_full,
 	.copy_from_iter_nocache		= no_copy_from_iter,
-	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+	.copy_from_iter_full_nocache	= no_copy_from_iter_full,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= no_copy_from_iter,
 #endif
@@ -2162,7 +2176,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.copy_from_iter			= no_copy_from_iter,
 	.copy_from_iter_full		= no_copy_from_iter_full,
 	.copy_from_iter_nocache		= no_copy_from_iter,
-	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+	.copy_from_iter_full_nocache	= no_copy_from_iter_full,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= no_copy_from_iter,
 #endif


