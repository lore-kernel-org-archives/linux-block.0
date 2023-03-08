Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C424C678D5
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 14:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjCHOjW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 09:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjCHOjB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 09:39:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5B2384E
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 06:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678286288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dL8s47Tp1nK8GIg8PijNkCrDLEgPha2fkCIMRUXm1zk=;
        b=B+8OO+g/cht+JMOglyul2YtlUKvsYYM08KhcQOFeBu+kx0aI/QMROOPGk9BtBw8iImg/4q
        jPRbz9zrHEQoItjCvgeQV3+zWaVGHeyKzpp5d7UxHK7zW9Aarkbq8gxWvyb/Ti6u/KjIug
        /jGop5a/JV0Mec8xMhjrS9yxOrTGXek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-WwOWsJk3MvajoYgGpEO4_w-1; Wed, 08 Mar 2023 09:38:02 -0500
X-MC-Unique: WwOWsJk3MvajoYgGpEO4_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1438857A84;
        Wed,  8 Mar 2023 14:38:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACA4114171B6;
        Wed,  8 Mar 2023 14:37:59 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v16 01/13] splice: Clean up direct_splice_read() a bit
Date:   Wed,  8 Mar 2023 14:37:42 +0000
Message-Id: <20230308143754.1976726-2-dhowells@redhat.com>
In-Reply-To: <20230308143754.1976726-1-dhowells@redhat.com>
References: <20230308143754.1976726-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Do a couple of cleanups to direct_splice_read():

 (1) Cast to struct page **, not void *.

 (2) Simplify the calculation of the number of pages to keep/reclaim in
     direct_splice_read().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/splice.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2e76dbb81a8f..abd21a455a2b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -295,7 +295,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	struct kiocb kiocb;
 	struct page **pages;
 	ssize_t ret;
-	size_t used, npages, chunk, remain, reclaim;
+	size_t used, npages, chunk, remain, keep = 0;
 	int i;
 
 	/* Work out how much data we can actually add into the pipe */
@@ -309,7 +309,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	if (!bv)
 		return -ENOMEM;
 
-	pages = (void *)(bv + npages);
+	pages = (struct page **)(bv + npages);
 	npages = alloc_pages_bulk_array(GFP_USER, npages, pages);
 	if (!npages) {
 		kfree(bv);
@@ -332,11 +332,8 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	kiocb.ki_pos = *ppos;
 	ret = call_read_iter(in, &kiocb, &to);
 
-	reclaim = npages * PAGE_SIZE;
-	remain = 0;
 	if (ret > 0) {
-		reclaim -= ret;
-		remain = ret;
+		keep = DIV_ROUND_UP(ret, PAGE_SIZE);
 		*ppos = kiocb.ki_pos;
 		file_accessed(in);
 	} else if (ret < 0) {
@@ -349,14 +346,12 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	}
 
 	/* Free any pages that didn't get touched at all. */
-	reclaim /= PAGE_SIZE;
-	if (reclaim) {
-		npages -= reclaim;
-		release_pages(pages + npages, reclaim);
-	}
+	if (keep < npages)
+		release_pages(pages + keep, npages - keep);
 
 	/* Push the remaining pages into the pipe. */
-	for (i = 0; i < npages; i++) {
+	remain = ret;
+	for (i = 0; i < keep; i++) {
 		struct pipe_buffer *buf = pipe_head_buf(pipe);
 
 		chunk = min_t(size_t, remain, PAGE_SIZE);

