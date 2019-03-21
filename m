Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2ECC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 11:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C215218FD
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 11:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfCULuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:50:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCULuv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 07:50:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B908C2026E;
        Thu, 21 Mar 2019 11:50:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26E7F19C57;
        Thu, 21 Mar 2019 11:50:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 3/6] cramfs: Convert to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Nicolas Pitre <nico@linaro.org>, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Thu, 21 Mar 2019 11:50:48 +0000
Message-ID: <155316904836.29884.4272832456354077956.stgit@warthog.procyon.org.uk>
In-Reply-To: <155316902426.29884.2476392753144421312.stgit@warthog.procyon.org.uk>
References: <155316902426.29884.2476392753144421312.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 21 Mar 2019 11:50:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Nicolas Pitre <nico@linaro.org>
cc: linux-mtd@lists.infradead.org
cc: linux-block@vger.kernel.org
---

 fs/cramfs/inode.c |   69 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 9352487bd0fc..2ee89a353d64 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -24,6 +24,7 @@
 #include <linux/blkdev.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/super.h>
+#include <linux/fs_context.h>
 #include <linux/slab.h>
 #include <linux/vfs.h>
 #include <linux/mutex.h>
@@ -506,18 +507,19 @@ static void cramfs_kill_sb(struct super_block *sb)
 	kfree(sbi);
 }
 
-static int cramfs_remount(struct super_block *sb, int *flags, char *data)
+static int cramfs_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_RDONLY;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_RDONLY;
 	return 0;
 }
 
-static int cramfs_read_super(struct super_block *sb,
-			     struct cramfs_super *super, int silent)
+static int cramfs_read_super(struct super_block *sb, struct fs_context *fc,
+			     struct cramfs_super *super)
 {
 	struct cramfs_sb_info *sbi = CRAMFS_SB(sb);
 	unsigned long root_offset;
+	bool silent = fc->sb_flags & SB_SILENT;
 
 	/* We don't know the real size yet */
 	sbi->size = PAGE_SIZE;
@@ -532,7 +534,7 @@ static int cramfs_read_super(struct super_block *sb,
 		/* check for wrong endianness */
 		if (super->magic == CRAMFS_MAGIC_WEND) {
 			if (!silent)
-				pr_err("wrong endianness\n");
+				errorf(fc, "cramfs: wrong endianness");
 			return -EINVAL;
 		}
 
@@ -544,22 +546,22 @@ static int cramfs_read_super(struct super_block *sb,
 		mutex_unlock(&read_mutex);
 		if (super->magic != CRAMFS_MAGIC) {
 			if (super->magic == CRAMFS_MAGIC_WEND && !silent)
-				pr_err("wrong endianness\n");
+				errorf(fc, "cramfs: wrong endianness");
 			else if (!silent)
-				pr_err("wrong magic\n");
+				errorf(fc, "cramfs: wrong magic");
 			return -EINVAL;
 		}
 	}
 
 	/* get feature flags first */
 	if (super->flags & ~CRAMFS_SUPPORTED_FLAGS) {
-		pr_err("unsupported filesystem features\n");
+		errorf(fc, "cramfs: unsupported filesystem features");
 		return -EINVAL;
 	}
 
 	/* Check that the root inode is in a sane state */
 	if (!S_ISDIR(super->root.mode)) {
-		pr_err("root is not a directory\n");
+		errorf(fc, "cramfs: root is not a directory");
 		return -EINVAL;
 	}
 	/* correct strange, hard-coded permissions of mkcramfs */
@@ -578,12 +580,12 @@ static int cramfs_read_super(struct super_block *sb,
 	sbi->magic = super->magic;
 	sbi->flags = super->flags;
 	if (root_offset == 0)
-		pr_info("empty filesystem");
+		infof(fc, "cramfs: empty filesystem");
 	else if (!(super->flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&
 		 ((root_offset != sizeof(struct cramfs_super)) &&
 		  (root_offset != 512 + sizeof(struct cramfs_super))))
 	{
-		pr_err("bad root offset %lu\n", root_offset);
+		errorf(fc, "cramfs: bad root offset %lu", root_offset);
 		return -EINVAL;
 	}
 
@@ -607,8 +609,7 @@ static int cramfs_finalize_super(struct super_block *sb,
 	return 0;
 }
 
-static int cramfs_blkdev_fill_super(struct super_block *sb, void *data,
-				    int silent)
+static int cramfs_blkdev_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct cramfs_sb_info *sbi;
 	struct cramfs_super super;
@@ -623,14 +624,13 @@ static int cramfs_blkdev_fill_super(struct super_block *sb, void *data,
 	for (i = 0; i < READ_BUFFERS; i++)
 		buffer_blocknr[i] = -1;
 
-	err = cramfs_read_super(sb, &super, silent);
+	err = cramfs_read_super(sb, fc, &super);
 	if (err)
 		return err;
 	return cramfs_finalize_super(sb, &super.root);
 }
 
-static int cramfs_mtd_fill_super(struct super_block *sb, void *data,
-				 int silent)
+static int cramfs_mtd_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct cramfs_sb_info *sbi;
 	struct cramfs_super super;
@@ -652,7 +652,7 @@ static int cramfs_mtd_fill_super(struct super_block *sb, void *data,
 
 	pr_info("checking physical address %pap for linear cramfs image\n",
 		&sbi->linear_phys_addr);
-	err = cramfs_read_super(sb, &super, silent);
+	err = cramfs_read_super(sb, fc, &super);
 	if (err)
 		return err;
 
@@ -947,32 +947,41 @@ static const struct inode_operations cramfs_dir_inode_operations = {
 };
 
 static const struct super_operations cramfs_ops = {
-	.remount_fs	= cramfs_remount,
 	.statfs		= cramfs_statfs,
 };
 
-static struct dentry *cramfs_mount(struct file_system_type *fs_type, int flags,
-				   const char *dev_name, void *data)
+static int cramfs_get_tree(struct fs_context *fc)
 {
-	struct dentry *ret = ERR_PTR(-ENOPROTOOPT);
+	int ret = -ENOPROTOOPT;
 
 	if (IS_ENABLED(CONFIG_CRAMFS_MTD)) {
-		ret = mount_mtd(fs_type, flags, dev_name, data,
-				cramfs_mtd_fill_super);
-		if (!IS_ERR(ret))
+		ret = vfs_get_mtd_super(fc, cramfs_mtd_fill_super);
+		if (ret < 0)
 			return ret;
 	}
-	if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV)) {
-		ret = mount_bdev(fs_type, flags, dev_name, data,
-				 cramfs_blkdev_fill_super);
-	}
+	if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV))
+		ret = vfs_get_block_super(fc, cramfs_blkdev_fill_super);
 	return ret;
 }
 
+static const struct fs_context_operations cramfs_context_ops = {
+	.get_tree	= cramfs_get_tree,
+	.reconfigure	= cramfs_reconfigure,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int cramfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &cramfs_context_ops;
+	return 0;
+}
+
 static struct file_system_type cramfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "cramfs",
-	.mount		= cramfs_mount,
+	.init_fs_context = cramfs_init_fs_context,
 	.kill_sb	= cramfs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };

