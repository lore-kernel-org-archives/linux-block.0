Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144420;
	b=h/lIKIhRNJBiXr+rPSLlb+5oKvO/RlCVFQ2Ow+omjwJNlIraQ8qvYY5M5NHbONYMhS7y
	 DJzd+pz3o0fF2n8tIoSnfoeppew0AtaUfeJUDG/oG4QOLST5CcS1+HvbQqK/EYPa23hnF
	 u3qZLBCsOGzlWT1fbt7IxMiOtB1HwRMyZ1sYEigzJ//8WJCQ5T2OQi3ZvCm/9Qj1+0lvB
	 YvJWABzEIgohjz5ADtyBI8PqscOdCpO7RU/9ZYEcF6FnjZi3hU93Bk9zCuUAE7qiXGyfK
	 xZ6X2/3aD6Si2YsoSSoLPNwFev6HMtVfAUnJueY+H2/UKi2YcA23UrLKp9cCebqqxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144420;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=MXn/vipY2N1l4qLdGnwApO+16GsInZpYm0yxQZl82ao=;
	b=aHhBPiLICr3tOnysBDD/pmUdGjf53Fb5PInrZ1hmapvYKbqYO0aDCLyt3mVoUeqsStvK
	 HrI9VJuOgkcQYqCoFqIWWfP7GIrIJxm8pu88rd5lRotWBlsM62yGChNg6rmZp43JFbn1s
	 ACGfOQ7gz4fuWH2t2SEFY/KwSgG37HHwKqd93f4jTJ9/Q5XMk4svzUEh0UxEa1JBodw2s
	 +W71atqvM55i1pCAcpprAMTMQj4U9SOd7PQm7rpiz0k1NfY6LmjBLwT6SwLZyPtvWY0rT
	 8Yk3/U9JvSw/Sgeh/HfxnBM8NWoFobyOvhnO8zFc6KKSEidKXM50lh8Opd3Xr49weNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262060A2621;
	Fri, 20 Nov 2026 03:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B262060A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0m13Dy9zVcBC;
	Fri, 20 Nov 2026 11:13:37 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0m05NyKzVcBC;
	Fri, 20 Nov 2026 11:13:36 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 73A1FC087;
	Fri, 20 Nov 2026 11:13:27 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:34 +0800
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
Subject: [PATCH v3 09/11] fs/quota: convert add_dquot_ref() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:03 +0800
Message-ID: <20261120031305.3561045-10-huangsj@hygon.cn>
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

Convert add_dquot_ref() to super_iter_inodes()

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/quota/dquot.c | 71 +++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9aaf2cfa9e1b..6453949c8af6 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1066,56 +1066,41 @@ static int dqinit_needed(struct inode *inode, int type)
 	return 0;
 }
 
-/* This routine is guarded by s_umount semaphore */
-static int add_dquot_ref(struct super_block *sb, int type)
+static bool add_dquot_ref_eligible(struct inode *inode, void *priv)
 {
-	struct inode *inode, *old_inode = NULL;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
-	int err = 0;
+	struct dquot_ref_data *ref = priv;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
-		    !atomic_read(&inode->i_writecount) ||
-		    !dqinit_needed(inode, type)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+	return atomic_read(&inode->i_writecount) &&
+	       dqinit_needed(inode, ref->type);
+}
+
+static int add_dquot_ref_fn(struct inode *inode, void *priv)
+{
+	struct dquot_ref_data *ref = priv;
+	int ret;
 
 #ifdef CONFIG_QUOTA_DEBUG
-		if (unlikely(inode_get_rsv_space(inode) > 0))
-			reserved = 1;
+	if (unlikely(inode_get_rsv_space(inode) > 0))
+		ref->reserved++;
 #endif
-		iput(old_inode);
-		err = __dquot_initialize(inode, type);
-		if (err) {
-			iput(inode);
-			goto out;
-		}
+	ret = __dquot_initialize(inode, ref->type);
+	if (ret)
+		return ret;
+	return INO_ITER_RET_NEXT;
+}
 
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock. We cannot iput the inode now as we can be
-		 * holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		old_inode = inode;
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(old_inode);
-out:
+/* This routine is guarded by s_umount semaphore */
+static int add_dquot_ref(struct super_block *sb, int type)
+{
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+	int err;
+
+	err = super_iter_inodes(sb, add_dquot_ref_fn,
+				add_dquot_ref_eligible, &ref, 0);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		quota_error(sb, "Writes happened before quota was turned on "
 			"thus quota information is probably inconsistent. "
 			"Please run quotacheck(8)");
-- 
2.53.0


