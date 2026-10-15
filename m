Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562A50391B;
	Thu, 15 Oct 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057254; cv=none; b=VHWk+BhOOBuI3KLdUwhrhD5bsLaxsb2ZsxE5N1U1ltDd3DkEjURYmSb0ueXpA4fj2yuyoxuPRKTMrUuM+OHvJ4L1cJjeDBwip/1UCj6kaFjCCOK3pgzHb+lKKu/1juATjsqHtT7Kx+Ki3TpVjZTlwPMEAW/jhBVHWL+5uKeRw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057254; c=relaxed/simple;
	bh=q3a+s7fWOWA/5t77A7KlLe+uSvQtF1iKr385yU2yGzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zjfm8kLgLjEj7SVjEhAQnxZopDQUf60gfAjfTUbVmUs0umjuaStBSN2iKkDb8gxt0XuajfpOuTIiEI+3vOmvkE7wwxm4dKdfsCefNl/NNg77mMPwIevj62PQR5sRRyU11DJpF42MJ8TWTaOd8Lulf+br/eHw6qgIm9ZsW1xojqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j532y6DkgzCWwYd;
	Thu, 15 Oct 2026 17:40:26 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4j532x0gd3zCWwYX;
	Thu, 15 Oct 2026 17:40:25 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id C09D716E7;
	Thu, 15 Oct 2026 17:40:17 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 15 Oct 2026 17:40:23 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <agruenba@redhat.com>, <mic@digikod.net>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<david@kernel.org>, <sandeen@redhat.com>, <ebiggers@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, <sunjunchao@bytedance.com>, Huang
 Shijie <huangsj@hygon.cn>
Subject: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
Date: Thu, 15 Oct 2026 17:38:52 +0800
Message-ID: <20261015093854.2082600-2-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015093854.2082600-1-huangsj@hygon.cn>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

This will be used to replace the explicit sb->s_inodes iteration,
with the caller supplying a callback function and a private data
pointer that is passed to the callback along with each inode that is
iterated.

A single iteration function, super_iter_inodes(), is provided, with
the iteration mode selected by the INO_ITER_F_UNSAFE flag. The
INO_ITER_F_REFERENCED flag can additionally restrict the iteration to
inodes that still have a reference.

Without INO_ITER_F_UNSAFE, the callback is called with a valid,
unlocked and referenced inode, so any inode operation, including
blocking operations, is allowed. The iterator is responsible for
inode lifecycle management, so the callback only needs to implement
the operation it wants to perform on all inodes.

With INO_ITER_F_UNSAFE set, the inodes are iterated without taking a
reference and the callback is run in an atomic context that must not
block. This mode is for internal VFS use only and runs under a RCU
read lock so that the VFS inode is not freed from under the callback.
It is needed for operations that require tight control over the state
of the inodes they operate on.

This mechanism allows the existing sb->s_inodes iteration models to
be maintained, providing a generic implementation for iterating all
cached inodes on the superblock.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/super.c                     | 111 +++++++++++++++++++++++++++++++++
 include/linux/fs/super_types.h |  14 +++++
 2 files changed, 125 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 1d5ccf540a9b..3f7df0bcb642 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -171,6 +171,117 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
+static bool super_iter_iget(struct inode *inode, int flags)
+{
+	bool ret = false;
+
+	spin_lock(&inode->i_lock);
+	if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
+		goto out_unlock;
+
+	if ((flags & INO_ITER_F_REFERENCED) && !icount_read(inode))
+		goto out_unlock;
+
+	__iget(inode);
+	ret = true;
+out_unlock:
+	spin_unlock(&inode->i_lock);
+	return ret;
+}
+
+static int generic_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
+			       void *private_data, int flags)
+{
+	struct inode *inode, *old_inode = NULL;
+	int ret = INO_ITER_RET_DONE;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		if (!super_iter_iget(inode, flags))
+			continue;
+
+		spin_unlock(&sb->s_inode_list_lock);
+		iput(old_inode);
+
+		ret = iter_fn(inode, private_data);
+
+		old_inode = inode;
+		if (ret == INO_ITER_RET_ABORT) {
+			ret = INO_ITER_RET_DONE;
+			goto out_loop;
+		}
+		if (ret < 0)
+			goto out_loop;
+
+		cond_resched();
+		spin_lock(&sb->s_inode_list_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+out_loop:
+	iput(old_inode);
+	return ret;
+}
+
+/*
+ * Unsafe iteration for internal VFS use only: @iter_fn runs in atomic
+ * context with only an inode existence guarantee, so it must not block
+ * and must perform its own inode state checks. Return INO_ITER_RET_ABORT
+ * to stop the iteration early.
+ */
+static int generic_iter_inodes_unsafe(struct super_block *sb, ino_iter_fn iter_fn,
+				      void *private_data)
+{
+	struct inode *inode;
+	int ret = INO_ITER_RET_DONE;
+
+	rcu_read_lock();
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		ret = iter_fn(inode, private_data);
+		if (ret == INO_ITER_RET_ABORT)
+			break;
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/**
+ * super_iter_inodes - iterate all the cached inodes on a superblock
+ * @sb: superblock to iterate
+ * @iter_fn: callback to run on every inode found
+ * @private_data: private data to pass to @iter_fn
+ * @flags: inode iteration control flags
+ *
+ * This function iterates all cached inodes on a superblock that are not in
+ * the process of being initialised or torn down. It will run @iter_fn() with
+ * a valid, referenced inode, so it is safe for the caller to do anything it
+ * wants with the inode except drop the reference the iterator holds.
+ *
+ * If @flags has %INO_ITER_F_REFERENCED set, inodes with a zero refcount are
+ * skipped as well, so that they are not needlessly bounced through
+ * __iget()/iput() (which would evict them from the inode cache).
+ *
+ * If @flags has %INO_ITER_F_UNSAFE set, the inodes are iterated without
+ * taking a reference and @iter_fn is run in an atomic context that must not
+ * block; %INO_ITER_F_REFERENCED is ignored in this mode. This is for internal
+ * VFS operations only and almost certainly not what the caller wants.
+ *
+ * Return: %INO_ITER_RET_DONE on completion, a negative errno if @iter_fn()
+ * returned an error (safe iteration only), or %INO_ITER_RET_ABORT if the
+ * unsafe iteration was aborted early.
+ */
+int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
+		      void *private_data, int flags)
+{
+	if (flags & INO_ITER_F_UNSAFE)
+		return generic_iter_inodes_unsafe(sb, iter_fn, private_data);
+
+	return generic_iter_inodes(sb, iter_fn, private_data, flags);
+}
+EXPORT_SYMBOL_GPL(super_iter_inodes);
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ecd96aeb1cee..2fd8cd9bec5f 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -81,6 +81,20 @@ enum freeze_holder {
 	FREEZE_EXCL		= (1U << 3),
 };
 
+/* Inode iteration callback return values */
+#define INO_ITER_RET_DONE		0
+#define INO_ITER_RET_ABORT		1
+
+/* Inode iteration control flags */
+/* Iterate without taking a reference; @iter_fn must not block. */
+#define INO_ITER_F_UNSAFE		(1U << 1)
+/* Only iterate inodes that still have a reference. */
+#define INO_ITER_F_REFERENCED		(1U << 2)
+
+typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
+int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
+		      void *private_data, int flags);
+
 struct super_operations {
 	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *inode);
-- 
2.34.1


