Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D9C77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjEVNxS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjEVNwc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 09:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E22E7F
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3P+FOs1njQUxSqylXnXlO9wiVhuujp6lAryk+mz03wc=;
        b=EIWF4CWxOmQxWNFWSfXNtPUd98BDnE1TVtJoaXf/EGUN5OEZ+fgjNrPKjMoIrV5mJLJFvy
        J4nP94KR56gOc6pIxFNJebIq/h9aEtGYFec4BhGDAgvEPqYmN5lyqlvy21zMSR3k4Q5rRK
        MIvEufYxqvqErUp3QEVzkPHxGYMl0Mk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-t6IcFv94Ov-E8ijVu7uUwg-1; Mon, 22 May 2023 09:51:22 -0400
X-MC-Unique: t6IcFv94Ov-E8ijVu7uUwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A23F0185A78B;
        Mon, 22 May 2023 13:51:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42CD0C1ED99;
        Mon, 22 May 2023 13:51:17 +0000 (UTC)
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
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev
Subject: [PATCH v22 14/31] 9p:  Add splice_read wrapper
Date:   Mon, 22 May 2023 14:50:01 +0100
Message-Id: <20230522135018.2742245-15-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a splice_read wrapper for 9p.  We should use copy_splice_read() if
9PL_DIRECT is set and filemap_splice_read() otherwise.  Note that this
doesn't seem to be particularly related to O_DIRECT.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/9p/vfs_file.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 6c31b8c8112d..2996fb00387f 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -374,6 +374,28 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+/*
+ * v9fs_file_splice_read - splice-read from a file
+ * @in: The 9p file to read from
+ * @ppos: Where to find/update the file position
+ * @pipe: The pipe to splice into
+ * @len: The maximum amount of data to splice
+ * @flags: SPLICE_F_* flags
+ */
+static ssize_t v9fs_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags)
+{
+	struct p9_fid *fid = in->private_data;
+
+	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
+		 fid->fid, len, *ppos);
+
+	if (fid->mode & P9L_DIRECT)
+		return copy_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
 /**
  * v9fs_file_write_iter - write to a file
  * @iocb: The operation parameters
@@ -569,7 +591,7 @@ const struct file_operations v9fs_file_operations = {
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock,
 	.mmap = generic_file_readonly_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
 };
@@ -583,7 +605,7 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.lock = v9fs_file_lock_dotl,
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_file_mmap,
-	.splice_read = generic_file_splice_read,
+	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
 };

