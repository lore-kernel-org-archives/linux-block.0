Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFCFCD13CF
	for <linux-block@archiver.kernel.org>; Wed, 20 Sep 2023 22:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjITWYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Sep 2023 18:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjITWYY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2023 18:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D1118
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2023 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695248579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfSLwCbdFMwywMZPFTO5hx480mND9O9O9B3C6PwfVhs=;
        b=QGfkJ7xv29ruO9Hi5/YkzhOMhxw6GcpcRvZweAceREdKss0eEtqNMrpnukKHkoMm+m/wss
        0eg/t2OvX3OwE6mGWLnTNfup8rt+3cduOdoc0e4VgEdsHePFEr1ZYEppGfdRVi1GM4RfB6
        TY8FJlawN4EuTINBIQQO1bM5EOTgw6o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-jGqCcrvuM6694XgMINqOzQ-1; Wed, 20 Sep 2023 18:22:54 -0400
X-MC-Unique: jGqCcrvuM6694XgMINqOzQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A146428EC111;
        Wed, 20 Sep 2023 22:22:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07578492C37;
        Wed, 20 Sep 2023 22:22:51 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/11] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
Date:   Wed, 20 Sep 2023 23:22:26 +0100
Message-ID: <20230920222231.686275-7-dhowells@redhat.com>
In-Reply-To: <20230920222231.686275-1-dhowells@redhat.com>
References: <20230920222231.686275-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

iter->copy_mc is only used with a bvec iterator and only by
dump_emit_page() in fs/coredump.c so rather than handle this in
memcpy_from_iter_mc() where it is checked repeatedly by _copy_from_iter()
and copy_page_from_iter_atomic(),
---
 lib/iov_iter.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65374ee91ecd..943aa3cfd7b3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -253,14 +253,33 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
-static size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
-				  size_t len, void *to, void *priv2)
+static __always_inline
+size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
+			   size_t len, void *to, void *priv2)
+{
+	return copy_mc_to_kernel(to + progress, iter_from, len);
+}
+
+static size_t __copy_from_iter_mc(void *addr, size_t bytes, struct iov_iter *i)
 {
-	struct iov_iter *iter = priv2;
+	size_t progress;
 
-	if (iov_iter_is_copy_mc(iter))
-		return copy_mc_to_kernel(to + progress, iter_from, len);
-	return memcpy_from_iter(iter_from, progress, len, to, priv2);
+	if (unlikely(i->count < bytes))
+		bytes = i->count;
+	if (unlikely(!bytes))
+		return 0;
+	progress = iterate_bvec(i, bytes, addr, NULL, memcpy_from_iter_mc);
+	i->count -= progress;
+	return progress;
+}
+
+static __always_inline
+size_t __copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (unlikely(iov_iter_is_copy_mc(i)))
+		return __copy_from_iter_mc(addr, bytes, i);
+	return iterate_and_advance(i, bytes, addr,
+				   copy_from_user_iter, memcpy_from_iter);
 }
 
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
@@ -270,9 +289,7 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 
 	if (user_backed_iter(i))
 		might_fault();
-	return iterate_and_advance2(i, bytes, addr, i,
-				    copy_from_user_iter,
-				    memcpy_from_iter_mc);
+	return __copy_from_iter(addr, bytes, i);
 }
 EXPORT_SYMBOL(_copy_from_iter);
 
@@ -493,9 +510,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		}
 
 		p = kmap_atomic(page) + offset;
-		n = iterate_and_advance2(i, n, p, i,
-					 copy_from_user_iter,
-					 memcpy_from_iter_mc);
+		__copy_from_iter(p, n, i);
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;

