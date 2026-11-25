Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597941;
	b=sT19xKgNCRpbTmDBhTh6FFRrlqfHNWtfBUL5VWKXgrW3TQ0Mpc1L/vxXWdFimukwFozI
	 fo4Lmk/Q7heV9FVAmRv8zTnSohjA+Dkdx2A1fhZpokdGGZKp0RKTneOcBXFLpQSJo3DAH
	 fAOqsZkGOAU60HUPi0kZ2nXmMIpkzxYrjD1nX6fwDO7/lsGGC4L4uMqwO9VKApD8s6AmQ
	 TnOUH7IZSYe+tzEpybGlG54O8Tj9rM+HLrySA1Omo+iqebNbW4L29kRyjBiU1XrhMwb4i
	 aJmP9cc4Nvlkbcc5en0JQU6JSX/4ymb/hlNbUXBHcaNUU6lJpktnx1j/c4F00092/OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597941;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=rY5KIVlAKbKab/tzgXdLnTdiBHJ81jLW95dmUPBtS/E=;
	b=vCszVUoEaanmsh0OwUybjarbpt8WYqID25ntnv8cqNsaiQ0gHDQdnoNUz7aA6UNEH0pu
	 nwMCvR9NCAG+YeGd+dA+1mQrHsc15VKof92458v3wO+KJfT0DKEX+tdJjFik9F2R1VsyB
	 La6KgdZzgD1nLmhEtZ9OlkwQ/VXVNpm4w+xeWwK8pqAc5Hsd2rffMrNoA0RNvBk0ttghG
	 igmMDlgOaGGKjigUymP3uKj2M0yQUzIhpKGz1Y3j1LmNIqpnGdhl5iWpupkvVSxxn0zpj
	 5RF41PHD+UwNMz2Zx6U2C3PnuJlhdmlLIlL+NZXT9RG2fRZRy5gzpb6GlGwJ1dN+AHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AB2606A32E;
	Wed, 25 Nov 2026 09:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3AB2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTZ2984zVcB6;
	Wed, 25 Nov 2026 17:12:18 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTX3hm4zVcB6;
	Wed, 25 Nov 2026 17:12:16 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id D43771548;
	Wed, 25 Nov 2026 17:12:09 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:14 +0800
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
Subject: [PATCH v4 04/11] fs/quota: convert remove_dquot_ref() to sb_inode_iter_locked()
Date: Wed, 25 Nov 2026 17:11:50 +0800
Message-ID: <20261125091157.1822521-5-huangsj@hygon.cn>
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

Convert remove_dquot_ref() to sb_inode_iter_locked().
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/quota/dquot.c | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a3d503591871..538578c79b5c 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -83,6 +83,8 @@
 
 #include <linux/uaccess.h>
 
+#include "../internal.h"
+
 /*
  * There are five quota SMP locks:
  * * dq_list_lock protects all lists with quotas and quota formats.
@@ -165,6 +167,11 @@ static struct kmem_cache *dquot_cachep;
 /* workqueue for work quota_release_work*/
 static struct workqueue_struct *quota_unbound_wq;
 
+struct dquot_ref_data {
+	int type;
+	int reserved;
+};
+
 void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -1117,41 +1124,44 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	return err;
 }
 
-static void remove_dquot_ref(struct super_block *sb, int type)
+static int remove_dquot_ref_fn(struct inode *inode, void *priv)
 {
-	struct inode *inode;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
+	struct dquot_ref_data *ref = priv;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 *  We have to scan also I_NEW inodes because they can already
-		 *  have quota pointer initialized. Luckily, we need to touch
-		 *  only quota pointers and these have separate locking
-		 *  (dq_data_lock).
-		 */
-		spin_lock(&dq_data_lock);
-		if (!IS_NOQUOTA(inode)) {
-			struct dquot __rcu **dquots = i_dquot(inode);
-			struct dquot *dquot = srcu_dereference_check(
-				dquots[type], &dquot_srcu,
-				lockdep_is_held(&dq_data_lock));
+	spin_lock(&dq_data_lock);
+	if (!IS_NOQUOTA(inode)) {
+		struct dquot __rcu **dquots = i_dquot(inode);
+		struct dquot *dquot = srcu_dereference_check(
+			dquots[ref->type], &dquot_srcu,
+			lockdep_is_held(&dq_data_lock));
 
 #ifdef CONFIG_QUOTA_DEBUG
-			if (unlikely(inode_get_rsv_space(inode) > 0))
-				reserved = 1;
+		if (unlikely(inode_get_rsv_space(inode) > 0))
+			ref->reserved++;
 #endif
-			rcu_assign_pointer(dquots[type], NULL);
-			if (dquot)
-				dqput(dquot);
-		}
-		spin_unlock(&dq_data_lock);
+		rcu_assign_pointer(dquots[ref->type], NULL);
+		if (dquot)
+			dqput(dquot);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
+	spin_unlock(&dq_data_lock);
+	return 0;
+}
+
+static void remove_dquot_ref(struct super_block *sb, int type)
+{
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+
+	/*
+	 *  We have to scan also I_NEW inodes because they can already
+	 *  have quota pointer initialized. Luckily, we need to touch
+	 *  only quota pointers and these have separate locking
+	 *  (dq_data_lock).
+	 */
+	sb_inode_iter_locked(sb, remove_dquot_ref_fn, &ref);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		printk(KERN_WARNING "VFS (%s): Writes happened after quota"
 			" was disabled thus quota information is probably "
 			"inconsistent. Please run quotacheck(8).\n", sb->s_id);
-- 
2.53.0


