Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB1C05027
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 17:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjBNRPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 12:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjBNRPH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 12:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7B4FF33
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676394855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4i4bwQTS34x6oFo2ZgYGZTE2NYetAQq5iydlM1fsxY=;
        b=Q9hXojbfhJKfXs5NR00t72IVU9Arkwmmn2aJs793NqFq53okfJrXdZPNnD4EQch9LrT0Yd
        cM3XPC8LcvPtyXaMPtz4pdZ/vxcBZb102KnKRPg1abgMiknanCceEM0RZnadcDUF46SfSM
        aapST+s/bD2wZ2NPL85MLT+V7WrRxyg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-ZogOeZ8jO0-C97KX6CrYIA-1; Tue, 14 Feb 2023 12:14:10 -0500
X-MC-Unique: ZogOeZ8jO0-C97KX6CrYIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4219F100F907;
        Tue, 14 Feb 2023 17:14:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4767E1415108;
        Tue, 14 Feb 2023 17:14:06 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v14 08/17] splice: Do splice read from a file without using ITER_PIPE
Date:   Tue, 14 Feb 2023 17:13:21 +0000
Message-Id: <20230214171330.2722188-9-dhowells@redhat.com>
In-Reply-To: <20230214171330.2722188-1-dhowells@redhat.com>
References: <20230214171330.2722188-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make generic_file_splice_read() use filemap_splice_read() and
direct_splice_read() rather than using an ITER_PIPE and call_read_iter().

With this, ITER_PIPE is no longer used.

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

Notes:
    ver #14)
    - Split out filemap_splice_read() into a separate patch.

 fs/splice.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 4c6332854b63..a93478338cec 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -391,29 +391,13 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags)
 {
-	struct iov_iter to;
-	struct kiocb kiocb;
-	int ret;
-
-	iov_iter_pipe(&to, ITER_DEST, pipe, len);
-	init_sync_kiocb(&kiocb, in);
-	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
-	if (ret > 0) {
-		*ppos = kiocb.ki_pos;
-		file_accessed(in);
-	} else if (ret < 0) {
-		/* free what was emitted */
-		pipe_discard_from(pipe, to.start_head);
-		/*
-		 * callers of ->splice_read() expect -EAGAIN on
-		 * "can't put anything in there", rather than -EFAULT.
-		 */
-		if (ret == -EFAULT)
-			ret = -EAGAIN;
-	}
-
-	return ret;
+	if (unlikely(*ppos >= file_inode(in)->i_sb->s_maxbytes))
+		return 0;
+	if (unlikely(!len))
+		return 0;
+	if (in->f_flags & O_DIRECT)
+		return direct_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 EXPORT_SYMBOL(generic_file_splice_read);
 

