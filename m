Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144409;
	b=DNuE0Qk6VAq7Kj1TRUOzVJ+Oj+KiN6v4QggmJBKWeWxWky09LvCyzKBMz6cyKLMP/2Ue
	 g1bb36rav/T3dXOd6roUpo6yRSY+rM+OPqy5TgAKq2S2mZ7ge5lvYxI5wlbAFGSSTdahJ
	 e6rfP02zU8Qlt1OIrSjKrPRpMZgwHySg/dJO2VUR350NBs75aKWNFtoEP7WKwTF8hGw6N
	 Ok/b9VJ8UwjOc0U3xvOEXQTuEpsy/uPIciB0822M8Os1TyUT6Pf1TJKTZkZgxRegPpcUq
	 IBioOONbFzZGLeaPc5vwJ2deu+GawLasOA0Dh0qFuAw6G/WhcbGcnmptBvg62f205JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144409;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=VzitFVl3uFCd//sxJWT9xWn8rNYxjausEpqwSdmmrtY=;
	b=l6jgQe9pTw4h9Gqwfa9F+uCJ16HQQBjEyr3bfTkSibp+dCV5/n0fRs4BTyV74q3HaMqb
	 qSAeyh3TMli/AgrqT1PSTJvSz7LCLwDpImu1/A6gKoENg1bE31ILsZYK6ACIoinAbLvXF
	 yxpBiWe+1fHgbyjZxX0/JhACcNwxwkk/4AAOYDpWSzvt4ZXKKwatgiqOYx0vgpMgGqu9e
	 /edjJ17FOOtPYUUswTGEvGr9mFeX0Oobwcy6Wu9TsFlq1v1JI8V5lUb6DHSo+1AIFyKeL
	 KlBBsJzwkBMWjbke7vvmI76bzQeQ8ofhZ62g3R6q+BAfKIrF6G/u8qiCtxkl0hStDCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCABF606A326;
	Fri, 20 Nov 2026 03:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCABF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lg3DN9zVcB5;
	Fri, 20 Nov 2026 11:13:19 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lc3zZvzVcB8;
	Fri, 20 Nov 2026 11:13:16 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 4277EC087;
	Fri, 20 Nov 2026 11:13:07 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:14 +0800
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
Subject: [PATCH v3 01/11] vfs: add super_iter_inodes()
Date: Fri, 20 Nov 2026 11:12:55 +0800
Message-ID: <20261120031305.3561045-2-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120031305.3561045-1-huangsj@hygon.cn>
References: <20261120031305.3561045-1-huangsj@hygon.cn>
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

Iterating the cached inodes of a superblock is open coded in the
kernel. Add super_iter_inodes() for the callers which can work without
holding the sb->s_inode_list_lock.

For super_iter_inodes():
-- By default, it runs @iter_fn with a referenced inode and with
  sb->s_inode_list_lock dropped, so the callback is free to block and to
  do whatever it wants with the inode except drop the reference the
  iterator holds.

-- Three flags change the default behaviour.

  INO_ITER_F_REFERENCED restricts the walk to inodes which still have a
  reference.

  INO_ITER_F_NOREF does the opposite: only inodes whose reference count
  has already reached zero are handed out.

  INO_ITER_F_NOIGET tells the iterator do not call __iget for the inode.
  Used with INO_ITER_F_NOREF in evict_inodes().

  The flags are not orthogonal, so super_iter_inodes() warns if an unknown
  bit is set or if INO_ITER_F_REFERENCED is combined with either of the
  no-reference flags.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/super.c                     | 87 ++++++++++++++++++++++++++++++++++
 include/linux/fs/super_types.h | 29 ++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index c5a0658f7aaf..204c70c7f179 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -171,6 +171,93 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
+static bool super_iter_check(struct inode *inode, int flags,
+			     ino_iter_eligible_fn eligible, void *priv)
+{
+	bool ret = false;
+
+	if ((flags & INO_ITER_F_REFERENCED) && !icount_read_once(inode))
+		return false;
+	if ((flags & INO_ITER_F_NOREF) && icount_read_once(inode))
+		return false;
+
+	spin_lock(&inode->i_lock);
+
+	if ((flags & INO_ITER_F_NOREF) && icount_read(inode))
+		goto out_unlock;
+
+	if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
+		goto out_unlock;
+
+	if (eligible && !eligible(inode, priv))
+		goto out_unlock;
+
+	if (!(flags & INO_ITER_F_NOIGET))
+		__iget(inode);
+
+	ret = true;
+out_unlock:
+	spin_unlock(&inode->i_lock);
+	return ret;
+}
+
+/**
+ * super_iter_inodes - iterate all the cached inodes on a superblock
+ * @sb: superblock to iterate
+ * @iter_fn: called for each inode, with a reference held
+ * @eligible: optional filter, called before the reference is taken
+ * @priv: caller data, passed to @iter_fn and @eligible
+ * @flags: INO_ITER_F_* control flags
+ *
+ * This function iterates all cached inodes on a superblock that are not in
+ * the process of being initialised or torn down. By default it runs @iter_fn
+ * with a valid, referenced inode, so it is safe for the caller to do anything
+ * it wants with the inode except drop the reference the iterator holds.
+ *
+ * The flag INO_ITER_F_NOIGET changes that contract. It runs @iter_fn without
+ * grabbing the inode with __iget().
+ *
+ * Return INO_ITER_RET_DONE if the iteration runs to the end.
+ * Return other value if the iteration breaks.
+ */
+int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
+		      ino_iter_eligible_fn eligible, void *priv, int flags)
+{
+	struct inode *inode, *old_inode = NULL;
+	int ret;
+
+	WARN_ON_ONCE(flags & ~INO_ITER_F_ALL);
+	WARN_ON_ONCE((flags & INO_ITER_F_REFERENCED) &&
+		     (flags & (INO_ITER_F_NOREF | INO_ITER_F_NOIGET)));
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		if (!super_iter_check(inode, flags, eligible, priv))
+			continue;
+
+		spin_unlock(&sb->s_inode_list_lock);
+
+		if (!(flags & INO_ITER_F_NOIGET))
+			iput(old_inode);
+
+		ret = iter_fn(inode, priv);
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
+	if (!(flags & INO_ITER_F_NOIGET))
+		iput(old_inode);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(super_iter_inodes);
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 72f4288e16c5..974d3c087952 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -80,6 +80,35 @@ enum freeze_holder {
 	FREEZE_EXCL		= (1U << 3),
 };
 
+/* Inode iteration callback return values */
+#define INO_ITER_RET_DONE	0
+#define INO_ITER_RET_ABORT	1
+#define INO_ITER_RET_NEXT	2
+
+/* Inode iteration control flags */
+/* Only iterate inodes that still have a reference. */
+#define INO_ITER_F_REFERENCED	BIT(0)
+/* Only iterate inodes whose reference count has reached zero. */
+#define INO_ITER_F_NOREF	BIT(1)
+/* Do not take a reference on the inodes handed to the callback. */
+#define INO_ITER_F_NOIGET	BIT(2)
+
+/* REFERENCED and NOREF ask for opposite things, so only one may be set. */
+#define INO_ITER_F_ALL		(INO_ITER_F_REFERENCED | INO_ITER_F_NOREF | \
+				 INO_ITER_F_NOIGET)
+
+typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
+
+/*
+ * Optional filter, called from inside the inode's i_lock and before
+ * __iget(), so that an inode can be rejected without paying for a
+ * reference.
+ */
+typedef bool (*ino_iter_eligible_fn)(struct inode *inode, void *priv);
+
+int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
+		      ino_iter_eligible_fn eligible, void *priv, int flags);
+
 struct super_operations {
 	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *inode);
-- 
2.53.0


