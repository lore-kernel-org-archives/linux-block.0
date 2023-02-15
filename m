Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AF4C636D4
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 13:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBONsW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 08:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBONsV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 08:48:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB8513E
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 05:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676468857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99QOKMb+AOrpDYfFG2DfoxFW2c4EvPytRBO6/OA6ny4=;
        b=SyjKa1rgF2oLWydAhkiRbQWMKfdhQvZeqtyeDK8Og186bBmmqggTvfRP8IhV5+wVnGYSHZ
        E04WxlfKtcUuzsbOcVTtPlSdDiuO3oLWUyvvR/bzpaTnApw80hBR9gMNj0gflE7lt8wn6h
        lInaWmehP3WhPZoe9xdVAnL/xXq2Qxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-9aaqLuwxPfmRX3fDSqVpVw-1; Wed, 15 Feb 2023 08:47:36 -0500
X-MC-Unique: 9aaqLuwxPfmRX3fDSqVpVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4E8118A64E0;
        Wed, 15 Feb 2023 13:47:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A22040B40E4;
        Wed, 15 Feb 2023 13:47:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3113838.1676468540@warthog.procyon.org.uk>
References: <3113838.1676468540@warthog.procyon.org.uk> <Y+nzO2H8AizX4lAQ@infradead.org> <Y+UJAdnllBw+uxK+@casper.infradead.org> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-2-dhowells@redhat.com> <909202.1675959337@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] splice: Clean up direct_splice_read() a bit
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3114483.1676468851.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Feb 2023 13:47:31 +0000
Message-ID: <3114484.1676468851@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I forgot to commit the cast change too.  Try the attached instead.

David
---
splice: Clean up direct_splice_read() a bit

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

diff --git a/fs/splice.c b/fs/splice.c
index 9e798c901087..e97f9aa30717 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -295,7 +295,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *pp=
os,
 	struct kiocb kiocb;
 	struct page **pages;
 	ssize_t ret;
-	size_t used, npages, chunk, remain, reclaim;
+	size_t used, npages, chunk, remain, keep =3D 0;
 	int i;
 =

 	/* Work out how much data we can actually add into the pipe */
@@ -309,7 +309,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *pp=
os,
 	if (!bv)
 		return -ENOMEM;
 =

-	pages =3D (void *)(bv + npages);
+	pages =3D (struct page **)(bv + npages);
 	npages =3D alloc_pages_bulk_array(GFP_USER, npages, pages);
 	if (!npages) {
 		kfree(bv);
@@ -332,11 +332,8 @@ ssize_t direct_splice_read(struct file *in, loff_t *p=
pos,
 	kiocb.ki_pos =3D *ppos;
 	ret =3D call_read_iter(in, &kiocb, &to);
 =

-	reclaim =3D npages * PAGE_SIZE;
-	remain =3D 0;
 	if (ret > 0) {
-		reclaim -=3D ret;
-		remain =3D ret;
+		keep =3D DIV_ROUND_UP(ret, PAGE_SIZE);
 		*ppos =3D kiocb.ki_pos;
 		file_accessed(in);
 	} else if (ret < 0) {
@@ -349,14 +346,12 @@ ssize_t direct_splice_read(struct file *in, loff_t *=
ppos,
 	}
 =

 	/* Free any pages that didn't get touched at all. */
-	reclaim /=3D PAGE_SIZE;
-	if (reclaim) {
-		npages -=3D reclaim;
-		release_pages(pages + npages, reclaim);
-	}
+	if (keep < npages)
+		release_pages(pages + keep, npages - keep);
 =

 	/* Push the remaining pages into the pipe. */
-	for (i =3D 0; i < npages; i++) {
+	remain =3D ret;
+	for (i =3D 0; i < keep; i++) {
 		struct pipe_buffer *buf =3D pipe_head_buf(pipe);
 =

 		chunk =3D min_t(size_t, remain, PAGE_SIZE);

