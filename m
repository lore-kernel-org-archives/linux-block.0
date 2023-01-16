Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4669BC678D4
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 23:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjAPXKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 18:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjAPXJ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 18:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A54F1D905
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dAIPKunUAzbkWNJ87wOuiKX6GyF+tsszNSftx0o+4s=;
        b=CXX8LSevDo2ZC5ODUh6k78nGkoy+y4xVxKKv0FpzFQ+vCHGU9Hkj0vR01B//fTALFnu8if
        tWtAefKZZ7ztFuodjgwPNKCyfH6YpN5/YD1B1KbuUVlALQ8MZ04l4I/Tc6tG1VOMhNTZRy
        MQ4KCU4NXOdTTRJeFjRsMsIADVkWUEs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-CDItCd_iNCaYGYyZBePHvw-1; Mon, 16 Jan 2023 18:08:33 -0500
X-MC-Unique: CDItCd_iNCaYGYyZBePHvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECD041C0432A;
        Mon, 16 Jan 2023 23:08:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE10E2166B26;
        Mon, 16 Jan 2023 23:08:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 04/34] iov_iter: Remove iov_iter_get_pages2/pages_alloc2()
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:08:31 +0000
Message-ID: <167391051122.2311931.14824492646435673046.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are now no users of iov_iter_get_pages2() and
iov_iter_get_pages_alloc2(), so remove them.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/uio.h |    4 ----
 lib/iov_iter.c      |   14 --------------
 2 files changed, 18 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6f4dfa96324d..365e26c405f2 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -248,13 +248,9 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 		size_t maxsize, unsigned maxpages, size_t *start,
 		unsigned gup_flags);
-ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
-			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		struct page ***pages, size_t maxsize, size_t *start,
 		unsigned gup_flags);
-ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
-			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f53583836009..ca89ffa9d6e1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1511,13 +1511,6 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iov_iter_get_pages);
 
-ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
-		size_t maxsize, unsigned maxpages, size_t *start)
-{
-	return iov_iter_get_pages(i, pages, maxsize, maxpages, start, 0);
-}
-EXPORT_SYMBOL(iov_iter_get_pages2);
-
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start, unsigned gup_flags)
@@ -1536,13 +1529,6 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc);
 
-ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
-		struct page ***pages, size_t maxsize, size_t *start)
-{
-	return iov_iter_get_pages_alloc(i, pages, maxsize, start, 0);
-}
-EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
-
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {


