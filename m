Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597941;
	b=CLeYnD12wzFmqs4tARxlbFLegrz1yfI1QBdof5GtXZCq4Dih93ct8SJcgCYZ1ZOJxCeH
	 TC9XaJnzBq6vsnRe/D1aUh50JB/Sehb/sC0QeQjbJ4dII1E2hNqYe0Hoz/I7fHi2cUirJ
	 dXJ+gaL6TeoJ8zS0wclZctspU6kdJtKIuFJ36bR4mEs0MjBn7lOdapqeLrpqbR13SR6Oi
	 wygD3hafSRL0TcxzQK5dpy80VPT8IFC6R3i5lc/xPC1b5beSRiGcAvkZoNjU6kLiYDIEQ
	 qZo9cj1hPBc9Cu/hKgowzMY0FMU3OJTbfnvhYkx/G9aZwzxbYRXGcAlLVLQk06/cJUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597941;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=y3AlrLrmzijoOmmLMUS871ALaIug8w67kopjsTk4pe4=;
	b=OFx5lB1V/yTIKn0sczN3RxFeMm4qm5N0raTVy47BudO3TDzwfeqyzpm/LOON+HQqg6vi
	 k7bqDsxgm+dPB7egtWd7D1rAhu13jqGV+Q0c+V8+H6FK+GODnpVCw6YrKUX40b0c9hkTk
	 exsCX4Mci/pBwCvyX5BjJeMr5AROf5uC7Kqye3BRwTA8O7aay6XEnaSHsTL5OzAL5gD3X
	 cZQ/LpqEgxyNW+07T/3iX75FKqSYU3eFWPTOyrvAObwUU+lXtMGCZqM3SCjJ3iI1GqrFb
	 BIlLv4bonMb1eXAjc1MhkBGbEdLObCZWvhGLC5SHzkfXzAS3i7AjPa/zpxICJ3ORHSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D249606A329;
	Wed, 25 Nov 2026 09:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D249606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTP28vrzVcB8;
	Wed, 25 Nov 2026 17:12:09 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTP1HGTzVhfS;
	Wed, 25 Nov 2026 17:12:09 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 84690300B6F1;
	Wed, 25 Nov 2026 17:10:56 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:06 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<hch@infradead.org>, <agruenba@redhat.com>, <mic@digikod.net>,
	<axboe@kernel.dk>
CC: <gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <legion@kernel.org>, <aleksa@amutable.com>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <djwong@kernel.org>,
	<sandeen@redhat.com>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <wujianyong@hygon.cn>, <shijie8@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, Huang Shijie <huangsj@hygon.cn>
Subject: [PATCH v4 01/11] vfs: add sb_inode_iter_next()
Date: Wed, 25 Nov 2026 17:11:47 +0800
Message-ID: <20261125091157.1822521-2-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125091157.1822521-1-huangsj@hygon.cn>
References: <20261125091157.1822521-1-huangsj@hygon.cn>
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

Walking sb->s_inodes requires taking sb->s_inode_list_lock, grabbing a
reference on the next inode, dropping the lock and then working on the
inode.  That sequence is open coded in several places, each with its own
subtleties around rescheduling and iput().

Add struct sb_inode_iter, which the caller declares and owns, plus
sb_inode_iter_next() to step through the list and sb_inode_iter_end() to
release the last reference.

As the cursor inode is referenced or pinned by other method, it cannot be
unlinked from sb->s_inodes, so the walk resumes from it after the caller
has dropped the lock.

Callers that need to filter inodes can provide iter->eligible,
which is called with inode->i_lock held, and callers that need to
stop early can set iter->status.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/super.c                     | 102 +++++++++++++++++++++++++++++++++
 include/linux/fs/super_types.h |  40 +++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index c5a0658f7aaf..077e772fa19b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -171,6 +171,108 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
+static bool sb_inode_iter_check(struct sb_inode_iter *iter, struct inode *inode)
+{
+	bool ret = false;
+
+	if ((iter->flags & INO_ITER_F_REFERENCED) && !icount_read_once(inode))
+		return false;
+
+	if ((iter->flags & INO_ITER_F_NOREF) && icount_read_once(inode))
+		return false;
+
+	spin_lock(&inode->i_lock);
+
+	if ((iter->flags & INO_ITER_F_NOREF) && icount_read(inode))
+		goto out_unlock;
+
+	if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
+		goto out_unlock;
+
+	if (iter->eligible && !iter->eligible(inode, iter->priv))
+		goto out_unlock;
+
+	if (!(iter->flags & INO_ITER_F_NOIGET))
+		__iget(inode);
+
+	ret = true;
+out_unlock:
+	spin_unlock(&inode->i_lock);
+	return ret;
+}
+
+static inline bool sb_inode_iter_flags_valid(int flags)
+{
+	switch (flags) {
+	case 0:
+	case INO_ITER_F_REFERENCED:
+	case INO_ITER_F_NOREF | INO_ITER_F_NOIGET:
+		/* only used by evict_inodes() */
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * sb_inode_iter_next - return the next inode of @iter->sb
+ * @iter: iterator state
+ *
+ * The returned inode stays on sb->s_inodes for the next round
+ * without holding sb->s_inode_list_lock:
+ *  -- By default, this inode has an increased reference count.
+ *  -- If INO_ITER_F_NOIGET is set, this inode will not change
+ *	its reference count.
+ *
+ * Return the next inode, or NULL once the walk is over or @iter->status is
+ * negative.
+ */
+struct inode *sb_inode_iter_next(struct sb_inode_iter *iter)
+{
+	struct super_block *sb = iter->sb;
+	struct inode *prev = iter->inode, *inode;
+
+	if (!sb_inode_iter_flags_valid(iter->flags)) {
+		VFS_WARN_ON_ONCE(1);
+		iter->status = -EINVAL;
+		return NULL;
+	}
+
+	if (iter->status || iter->done)
+		return NULL;
+
+	spin_lock(&sb->s_inode_list_lock);
+	VFS_WARN_ON_ONCE(prev && list_empty(&prev->i_sb_list));
+	inode = list_prepare_entry(prev, &sb->s_inodes, i_sb_list);
+	list_for_each_entry_continue(inode, &sb->s_inodes, i_sb_list) {
+		if (!sb_inode_iter_check(iter, inode))
+			continue;
+
+		spin_unlock(&sb->s_inode_list_lock);
+		iter->inode = inode;
+		if (!(iter->flags & INO_ITER_F_NOIGET))
+			iput(prev);
+		return inode;
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+
+	iter->inode = NULL;
+	iter->done = true;
+	if (!(iter->flags & INO_ITER_F_NOIGET))
+		iput(prev);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(sb_inode_iter_next);
+
+void sb_inode_iter_end(struct sb_inode_iter *iter)
+{
+	if (!(iter->flags & INO_ITER_F_NOIGET))
+		iput(iter->inode);
+	iter->inode = NULL;
+	iter->done = true;
+}
+EXPORT_SYMBOL_GPL(sb_inode_iter_end);
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 72f4288e16c5..b844e5259360 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -80,6 +80,46 @@ enum freeze_holder {
 	FREEZE_EXCL		= (1U << 3),
 };
 
+/* Caller-owned state for walking sb->s_inodes. */
+struct sb_inode_iter {
+	struct super_block	*sb;
+	struct inode		*inode;
+	bool			(*eligible)(struct inode *inode, void *priv);
+	void			*priv;
+	bool			done;
+	int			status;
+	int			flags;
+};
+
+/* Only hand out inodes that still have a reference. */
+#define INO_ITER_F_REFERENCED	BIT(0)
+/* Only hand out inodes whose reference count has reached zero. */
+#define INO_ITER_F_NOREF	BIT(1)
+/* Do not take a reference on the inodes handed out. */
+#define INO_ITER_F_NOIGET	BIT(2)
+
+struct inode *sb_inode_iter_next(struct sb_inode_iter *iter);
+void sb_inode_iter_end(struct sb_inode_iter *iter);
+
+static inline struct sb_inode_iter
+sb_inode_iter_init(struct super_block *sb,
+		   bool (*eligible)(struct inode *inode, void *priv),
+		   void *priv, int flags)
+{
+	return (struct sb_inode_iter){
+		.sb		= sb,
+		.eligible	= eligible,
+		.priv		= priv,
+		.flags		= flags,
+	};
+}
+
+DEFINE_CLASS(sb_inode_iter, struct sb_inode_iter,
+	     sb_inode_iter_end(&_T),
+	     sb_inode_iter_init(sb, eligible, priv, flags),
+	     struct super_block *sb, bool (*eligible)(struct inode *, void *),
+	     void *priv, int flags)
+
 struct super_operations {
 	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *inode);
-- 
2.53.0


