Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597955;
	b=MPZBKmeQHDEuQ1VlV7fW/WWLgM6E7cVHQjp12jGCrVMuCGjh9NLhFO1iXgCtwGberWqz
	 4nY4xg/CymPmYuLC1FpgmzuU4ibCQZ4afbPEL344KbpZS/l0223PuEvd/9heY0mNxdlCE
	 eDWLcjl0jgT2T8G/vNxd2jGn4nepj/E1ftD6QOy56y/SGRGN13I5jn8YY9KrMn8+hSzhV
	 tFSwI9XvqIxThgh1zG0MpRjurUkxdwfKy6mEt1WaP/dGADXWeiyY9qEzb68ZJeZLkZbbK
	 mx2m5sDLzUqgdxDy+U7sktOKYk0TIeD0dbV23kyqLpnWJMyG2lA5mGiLXw2pCCepT5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597955;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=fm6gr307MsdGQsF6kVhe4Pd7zQc9SvxpRFmgnheb0qE=;
	b=3A6B4WtsqK/2QLmWrLdu/wUCTj4uRrC43OWG9XEt2h+ZLBO3OBGZ8k51mtVGWHHVMSeW
	 LXAR8Yo3JvaN44x3O8WVSU2HGEDjZcRi6rbNItZnyGDP+/wGe0KIYuLv5pWAiMCj8obNe
	 fXkm3yoWvU1f8ZJ0kyxivwDHvtwa8vMRnjWIs85mzo15j4BAIbsdEQqe4OeMiTlw3DXPB
	 eWtdwN99zg73cPja9EXoUVwHprI5V7MmJi/sqp7WZGEv9vNdXQrxUHAEKR0Iya8HAOvvg
	 RKUJ2Jhk+x7XxzThQQeT9NoNC0D373ALK1lGx0IBJVZ5yr+QaTMnP02YLSI9vvpU/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592160A2612;
	Wed, 25 Nov 2026 09:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C592160A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTs2KbTzVcBV;
	Wed, 25 Nov 2026 17:12:33 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTp4vJgzVcBD;
	Wed, 25 Nov 2026 17:12:30 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 095A61548;
	Wed, 25 Nov 2026 17:12:24 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:28 +0800
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
Subject: [PATCH v4 10/11] landlock: convert hook_sb_delete() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:56 +0800
Message-ID: <20261125091157.1822521-11-huangsj@hygon.cn>
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

Convert hook_sb_delete() to sb_inode_iter.
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 security/landlock/fs.c | 67 ++++++++++--------------------------------
 1 file changed, 16 insertions(+), 51 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 2ab67bcad198..36e22be99acc 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1380,49 +1380,35 @@ static void hook_inode_free_security_rcu(void *inode_security)
  *
  * Cf. fsnotify_unmount_inodes() and evict_inodes()
  */
+static bool release_inode_eligible(struct inode *inode, void *priv)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = !!rcu_dereference(landlock_inode(inode)->object);
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static void hook_sb_delete(struct super_block *const sb)
 {
-	struct inode *inode, *prev_inode = NULL;
+	struct inode *inode;
 
 	if (!landlock_initialized)
 		return;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	CLASS(sb_inode_iter, iter)(sb, release_inode_eligible, NULL,
+				   INO_ITER_F_REFERENCED);
+	while ((inode = sb_inode_iter_next(&iter))) {
 		struct landlock_object *object;
 
-		/* Only handles referenced inodes. */
-		if (!icount_read_once(inode))
-			continue;
-
-		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
-		 */
-		spin_lock(&inode->i_lock);
-		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
-		 */
-		if (inode_state_read(inode) &
-		    (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
 		rcu_read_lock();
 		object = rcu_dereference(landlock_inode(inode)->object);
 		if (!object) {
 			rcu_read_unlock();
-			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
 
 		/*
 		 * If there is no concurrent release_inode() ongoing, then we
@@ -1455,30 +1441,9 @@ static void hook_sb_delete(struct super_block *const sb)
 			spin_unlock(&object->lock);
 			rcu_read_unlock();
 		}
-
-		if (prev_inode) {
-			/*
-			 * At this point, we still own the __iget() reference
-			 * that we just set in this loop walk.  Therefore we
-			 * can drop the list lock and know that the inode won't
-			 * disappear from under us until the next loop walk.
-			 */
-			spin_unlock(&sb->s_inode_list_lock);
-			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
-			 */
-			iput(prev_inode);
-			cond_resched();
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		prev_inode = inode;
+		cond_resched();
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
-	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
-- 
2.53.0


