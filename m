Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2A20968D
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908938; cv=none; b=jRcMYJiKRUCcHkn1pDNdXSqtgoxGBjom7rTHh+6xuE5TWwCmZDSEOQnMNB1THppjCzpntg62evZb3NO2m3AO2WkKBoejqXvcW3TQBr6YMnUZ0HAQAtTTLATmeJIxtJeAbi8JpHLYu+EZs3mY+MMiWVhAL7pM3BGUUFk+8fxHhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908938; c=relaxed/simple;
	bh=8qJA1t/oP1wKnFSji3XC0BItsvE3qCEUW/Gd2fboNIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iD9GggYo07Fnn7PUMjyflUfq/mC642LoSb+mMN2h2LExli22sCuX0myFWpSHqfnIBRQSyUbbQFbPXP7rSJ1YQM4DyI8nYU3qV6TdH+WSVpW0WYKLDPVFwORCkVIht4lXaXOJWj1oEydl0Jy0/C2KUF+ATWT+4jWfnxt5gyAmAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rk9Mdg0R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rk9Mdg0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGcz01WnWG0q81+QmgZlmMhhOegvNur4a75Sm9xwI30=;
	b=Rk9Mdg0RinRlbpLc5w1m0DwlfGndf/TKtTSr6ldAKPzH/4gYNlWYW96FP5cmcMhXk/3fpS
	eSGTh19WfnRoPe4Jqv2qyaqcb/tltjNvugxUHJ6aCPjzqjAga6lphZBJKBf5uSadB27em8
	IotMfjj4/5lPLItVh432AwXQ2uqsZuY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-ME2h5ZTGOhyxIk538zxFgA-1; Thu,
 13 Mar 2025 19:35:31 -0400
X-MC-Unique: ME2h5ZTGOhyxIk538zxFgA-1
X-Mimecast-MFC-AGG-ID: ME2h5ZTGOhyxIk538zxFgA_1741908930
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 821511801A07;
	Thu, 13 Mar 2025 23:35:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA2551955F2D;
	Thu, 13 Mar 2025 23:35:27 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>
Subject: [RFC PATCH 27/35] netfs: Pass extra write context to write functions
Date: Thu, 13 Mar 2025 23:33:19 +0000
Message-ID: <20250313233341.1675324-28-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allow the filesystem to pass in an extra bit of context to certain write
functions so that netfs_page_mkwrite() and netfs_perform_write() can pass
it back to the filesystem's ->post_modify() function.

This can be used by ceph to pass in a preallocated ceph_cap_flush record.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_file.c          |  2 +-
 fs/afs/write.c            |  2 +-
 fs/netfs/buffered_write.c | 21 ++++++++++++---------
 fs/smb/client/file.c      |  4 ++--
 include/linux/netfs.h     |  9 +++++----
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 348cc90bf9c5..838332d5372c 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -477,7 +477,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 static vm_fault_t
 v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
-	return netfs_page_mkwrite(vmf, NULL);
+	return netfs_page_mkwrite(vmf, NULL, NULL);
 }
 
 static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 18b0a9f1615e..054f3a07d2a5 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -276,7 +276,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 
 	if (afs_validate(AFS_FS_I(file_inode(file)), afs_file_key(file)) < 0)
 		return VM_FAULT_SIGBUS;
-	return netfs_page_mkwrite(vmf, NULL);
+	return netfs_page_mkwrite(vmf, NULL, NULL);
 }
 
 /*
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index f3370846ba18..0245449b93e3 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -86,7 +86,8 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
  * netfs_perform_write - Copy data into the pagecache.
  * @iocb: The operation parameters
  * @iter: The source buffer
- * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps)
+ * @fs_priv: Private data to be passed to ->post_modify()
  *
  * Copy data into pagecache folios attached to the inode specified by @iocb.
  * The caller must hold appropriate inode locks.
@@ -97,7 +98,7 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
  * a new one is started.
  */
 ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
-			    struct netfs_group *netfs_group)
+			    struct netfs_group *netfs_group, void *fs_priv)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -382,7 +383,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 */
 		set_bit(NETFS_ICTX_MODIFIED_ATTR, &ctx->flags);
 		if (unlikely(ctx->ops->post_modify))
-			ctx->ops->post_modify(inode);
+			ctx->ops->post_modify(inode, fs_priv);
 	}
 
 	if (unlikely(wreq)) {
@@ -411,7 +412,8 @@ EXPORT_SYMBOL(netfs_perform_write);
  * netfs_buffered_write_iter_locked - write data to a file
  * @iocb:	IO state structure (file, offset, etc.)
  * @from:	iov_iter with data to write
- * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps)
+ * @fs_priv: Private data to be passed to ->post_modify()
  *
  * This function does all the work needed for actually writing data to a
  * file. It does all basic checks, removes SUID from the file, updates
@@ -431,7 +433,7 @@ EXPORT_SYMBOL(netfs_perform_write);
  * * negative error code if no data has been written at all
  */
 ssize_t netfs_buffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *from,
-					 struct netfs_group *netfs_group)
+					 struct netfs_group *netfs_group, void *fs_priv)
 {
 	struct file *file = iocb->ki_filp;
 	ssize_t ret;
@@ -446,7 +448,7 @@ ssize_t netfs_buffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *fr
 	if (ret)
 		return ret;
 
-	return netfs_perform_write(iocb, from, netfs_group);
+	return netfs_perform_write(iocb, from, netfs_group, fs_priv);
 }
 EXPORT_SYMBOL(netfs_buffered_write_iter_locked);
 
@@ -485,7 +487,7 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0)
-		ret = netfs_buffered_write_iter_locked(iocb, from, NULL);
+		ret = netfs_buffered_write_iter_locked(iocb, from, NULL, NULL);
 	netfs_end_io_write(inode);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
@@ -499,7 +501,8 @@ EXPORT_SYMBOL(netfs_file_write_iter);
  * we only track group on a per-folio basis, so we block more often than
  * we might otherwise.
  */
-vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
+vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group,
+			      void *fs_priv)
 {
 	struct netfs_group *group;
 	struct folio *folio = page_folio(vmf->page);
@@ -554,7 +557,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	file_update_time(file);
 	set_bit(NETFS_ICTX_MODIFIED_ATTR, &ictx->flags);
 	if (ictx->ops->post_modify)
-		ictx->ops->post_modify(inode);
+		ictx->ops->post_modify(inode, fs_priv);
 	ret = VM_FAULT_LOCKED;
 out:
 	sb_end_pagefault(inode->i_sb);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 8582cf61242c..4329c2bbf74f 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2779,7 +2779,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	rc = netfs_buffered_write_iter_locked(iocb, from, NULL);
+	rc = netfs_buffered_write_iter_locked(iocb, from, NULL, NULL);
 
 out:
 	up_read(&cinode->lock_sem);
@@ -2955,7 +2955,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 
 static vm_fault_t cifs_page_mkwrite(struct vm_fault *vmf)
 {
-	return netfs_page_mkwrite(vmf, NULL);
+	return netfs_page_mkwrite(vmf, NULL, NULL);
 }
 
 static const struct vm_operations_struct cifs_file_vm_ops = {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ec1c51697c04..a67297de8a20 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -335,7 +335,7 @@ struct netfs_request_ops {
 
 	/* Modification handling */
 	void (*update_i_size)(struct inode *inode, loff_t i_size);
-	void (*post_modify)(struct inode *inode);
+	void (*post_modify)(struct inode *inode, void *fs_priv);
 
 	/* Write request handling */
 	void (*begin_writeback)(struct netfs_io_request *wreq);
@@ -435,9 +435,9 @@ ssize_t netfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 
 /* High-level write API */
 ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
-			    struct netfs_group *netfs_group);
+			    struct netfs_group *netfs_group, void *fs_priv);
 ssize_t netfs_buffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *from,
-					 struct netfs_group *netfs_group);
+					 struct netfs_group *netfs_group, void *fs_priv);
 ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from);
 ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *iter,
 					   struct netfs_group *netfs_group);
@@ -466,7 +466,8 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 
 /* VMA operations API. */
-vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
+vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group,
+			      void *fs_priv);
 
 /* (Sub)request management API. */
 void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq);

