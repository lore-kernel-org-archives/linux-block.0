Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571062;
	b=kjitkiNrV23f/aEpVn61yn+Ekh3WXDciN8z+PxxTCs0qFLEF9yLEATXoIYXwWA1IM6d2
	 fGvUPWryNLO3c2fA3Ugztgdy8D04I6vtkUS0Zfvske3kzXSaojvTkAhnfAVmMK1hSClpF
	 EhDFSfhXog6ucwWbD1fNZYjrgL/Go5K37T2byxnyi1DhQaBd0bRkUiuKG8p8ukskZzqds
	 wIbbC7cyJE8B4SpV5FmAzu9kolnzb2aYHBNotXPg7SnYCTuxv2IXVfa9THf/3LbZyaSJu
	 olfNc74Z9T4UyrrrQdi5qGrP/ftlE+q8LoROLNCH2HnQ7vWvdl+6KajNOrTc78cS4KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571062;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=w1sjKjKeKcFzIMFsA7+peO32XoN+kMiU2FuPkTHm74A=;
	b=W4x1npa8PcMPjZzmBOzhd95MJkUPlOcWuvPhMg13gd7jelDnNWek0W9sCURKrzYOl9LW
	 C3rkzzDA43/rHx2YY6jizxpCo/f3veL7HVUTznvvFtjHkdHkNYwv0ltqm71exdPow/KsZ
	 AXEDU+D81tX5PxbnyCj73vW4VE92y27waWp4HKwvk8bfBpSLvSDlGkYogPFUDEOvg3a8g
	 SkGoWj6/6LOOHT4n5MTJOt8nWfjA5okHNtavk0XKhoAYk9UmZ6xxcYyrgYbTIjJMJsIfY
	 blUmDOsXvb95gP90JyGyiSKhxi0BwKros22lHpBvt3Hy3KWHtnZ/BRajPwWMv/oUsvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A2606A32E;
	Fri, 13 Nov 2026 11:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 880A2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jQwjk2LXwzVcB7;
	Fri, 13 Nov 2026 19:57:30 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jQwjh4k0qzVcBF;
	Fri, 13 Nov 2026 19:57:28 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id D1B2513A5C;
	Fri, 13 Nov 2026 19:57:19 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Nov 2026 19:57:27 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<agruenba@redhat.com>, <mic@digikod.net>, <gnoack@google.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<aleksa@amutable.com>, <legion@kernel.org>, <david@kernel.org>,
	<sandeen@redhat.com>, <ebiggers@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-security-module@vger.kernel.org>,
	<sunjunchao@bytedance.com>, <shijie8@gmail.com>, Huang Shijie
	<huangsj@hygon.cn>
Subject: [PATCH v2 1/3] vfs: add inode iteration methods
Date: Fri, 13 Nov 2026 19:57:00 +0800
Message-ID: <20261113115702.586594-2-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113115702.586594-1-huangsj@hygon.cn>
References: <20261113115702.586594-1-huangsj@hygon.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Add two inode iteration methods:
     super_iter_inodes_unsafe()/super_iter_inodes()

We use them to replace the explicit sb->s_inodes iteration,
with the caller supplying an inode_iter_context which has the
metadata needed in the interation.

The two iteration methods:

-- super_iter_inodes() runs @ctx->iter_fn() with a referenced
   inode and with sb->s_inode_list_lock dropped, so the callback
   is free to block and to do whatever it wants with the inode
   except drop the reference the iterator holds. The iterator
   releases that one reference per inode itself, so the callback
   cannot leave a dangling inode behind. It is exported because
   filesystems built as modules need it.

-- super_iter_inodes_unsafe() keeps sb->s_inode_list_lock and
   rcu_read_lock() held for the whole walk and takes no inode
   references at all. Its callback therefore only has an
   existence guarantee: it must not block and must do its own
   inode state checks and its own reference handling. It is
   internal to the VFS, being declared in fs/internal.h.

Both take a struct inode_iter_context carrying the per-caller
state:

   iter_fn   the callback. Returns INO_ITER_RET_NEXT to go on
             with the next inode, or INO_ITER_RET_ABORT to stop.

   eligible  optional filter, called only by the safe iterator,
             from inside the inode's i_lock and before __iget(),
             so that an inode can be rejected without paying for
             a reference.

   prev      resume point. A caller of the unsafe iterator which
             has to drop the list lock in the middle of a walk
             stores the inode to continue from here, and the next
             call starts after that inode instead of at the head.

   flags     INO_ITER_F_REFERENCED makes the safe iterator skip
             inodes which have no reference, which is what
             hook_sb_delete() filters for today.

   priv      caller private data.

This patch only adds the methods; converting the callers over is
left to the patches which follow.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/internal.h                  | 34 ++++++++++++++++++
 fs/super.c                     | 65 ++++++++++++++++++++++++++++++++++
 include/linux/fs/super_types.h | 25 +++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index 967c8556c17f..f9b39d05bbee 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -139,6 +139,40 @@ struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
 
+/*
+ * Unsafe iteration for internal VFS use only:
+ *   @ctx->iter_fn runs in atomic context with only
+ *   an inode existence guarantee, so it must not block
+ *   and must perform its own inode state checks.
+ *
+ * Return INO_ITER_RET_ABORT if the iteration stops early.
+ * Return INO_ITER_RET_DONE if the iteration runs to the end.
+ */
+static inline int super_iter_inodes_unsafe(struct super_block *sb,
+				struct inode_iter_context *ctx)
+{
+	struct inode *inode;
+	int ret = INO_ITER_RET_NEXT;
+
+	rcu_read_lock();
+	spin_lock(&sb->s_inode_list_lock);
+	inode = list_prepare_entry(ctx->prev, &sb->s_inodes, i_sb_list);
+
+	list_for_each_entry_continue(inode, &sb->s_inodes, i_sb_list) {
+		ret = ctx->iter_fn(inode, ctx);
+		if (ret == INO_ITER_RET_ABORT)
+			break;
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	rcu_read_unlock();
+
+	/* Mark the end here */
+	if (ret == INO_ITER_RET_NEXT)
+		ret = INO_ITER_RET_DONE;
+
+	return ret;
+}
+
 /*
  * Prepare superblock for changing its read-only state (i.e., either remount
  * read-write superblock read-only or vice versa). After this function returns
diff --git a/fs/super.c b/fs/super.c
index c5a0658f7aaf..32137422df35 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -171,6 +171,71 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
+static bool super_iter_iget(struct inode *inode, struct inode_iter_context *ctx)
+{
+	bool ret = false;
+
+	if ((ctx->flags & INO_ITER_F_REFERENCED) && !icount_read_once(inode))
+		return false;
+
+	spin_lock(&inode->i_lock);
+	if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
+		goto out_unlock;
+
+	if (ctx->eligible && !ctx->eligible(inode, ctx))
+		goto out_unlock;
+
+	__iget(inode);
+	ret = true;
+out_unlock:
+	spin_unlock(&inode->i_lock);
+	return ret;
+}
+
+/**
+ * super_iter_inodes - iterate all the cached inodes on a superblock
+ * @sb: superblock to iterate
+ * @ctx: the context which has the metadata
+ *
+ * This function iterates all cached inodes on a superblock that are not in
+ * the process of being initialised or torn down. It will run @ctx->iter_fn()
+ * with a valid, referenced inode, so it is safe for the caller to do
+ * anything it wants with the inode except drop the reference the iterator
+ * holds.
+ *
+ * Return INO_ITER_RET_DONE if the iteration runs to the end.
+ * Return other value if the iteration breaks.
+ */
+int super_iter_inodes(struct super_block *sb, struct inode_iter_context *ctx)
+{
+	struct inode *inode, *old_inode = NULL;
+	int ret;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		if (!super_iter_iget(inode, ctx))
+			continue;
+
+		spin_unlock(&sb->s_inode_list_lock);
+		iput(old_inode);
+
+		ret = ctx->iter_fn(inode, ctx);
+
+		old_inode = inode;
+		if (ret != INO_ITER_RET_NEXT)
+			goto out_loop;
+
+		cond_resched();
+		spin_lock(&sb->s_inode_list_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	ret = INO_ITER_RET_DONE;
+out_loop:
+	iput(old_inode);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(super_iter_inodes);
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 72f4288e16c5..da15c360def3 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -80,6 +80,31 @@ enum freeze_holder {
 	FREEZE_EXCL		= (1U << 3),
 };
 
+/* Inode iteration callback return values */
+#define INO_ITER_RET_DONE		0
+#define INO_ITER_RET_ABORT		1
+#define INO_ITER_RET_NEXT		2
+
+/* Inode iteration control flags */
+/* Only iterate inodes that still have a reference. */
+#define INO_ITER_F_REFERENCED		(1U << 0)
+
+struct inode_iter_context {
+	/* the hook for the iteration */
+	int (*iter_fn)(struct inode *inode, struct inode_iter_context *ctx);
+
+	/* the hook for the eligibility check, called before __iget() */
+	bool (*eligible)(struct inode *inode, struct inode_iter_context *ctx);
+
+	/* Save the temporary inode in a loop break */
+	struct inode *prev;
+
+	int flags;
+	void *priv;
+};
+
+int super_iter_inodes(struct super_block *sb, struct inode_iter_context *ctx);
+
 struct super_operations {
 	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *inode);
-- 
2.53.0


