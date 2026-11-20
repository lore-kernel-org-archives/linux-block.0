Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144409;
	b=OPt9RJcegBQK8PQhApgmNgHEfp9jscPpvapaN6lfJb6cwtadAc6ZCdPSViK+m3TXRVAq
	 vBVyyIYKK4gtZGLScfA6umYzo2ziunRynyWzo8u2y96NveroINTEwMFiTdLDIAt2RT94h
	 ys5CUXWeB10Ck22xRCPer/oiY0/jYseLR9DztpjZjbaNIqyLLwRwYF/8ZWfUGMU7FmrvE
	 6hmq2qECQc3PL2LJ0R7JHK4Z4AV2bKFID5BprdzUjgTPIf6DOneHxEnWH2BNRilgQaFC4
	 nDlT+2EBvXm/2o/qGt8r2pyePJWLNx4eiaLO1RM28g7cZ47SlBPNHzjSF4n1trOdAYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144409;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Js6rt0O1NPfO/eZ3eJEf2HOYL7oxLujLdUYutg/+J1c=;
	b=e779qwrvI8+uOgeJXOucrltFpnldNxV6DhE1Mip4WVtE1H4QKAOHWCuY6aMPq/JIp3us
	 R2aT0p2/FBFb8cs3pltxHAcUKkQM0MxRf+CuR5t7e7inKaVV/QIABjTJD+96O7IBDCa13
	 fscIuBsCG4mrQttJX1tZ+RjToCSxoy44AACRrMjjDBaDMAvffIrug5PXTGG8tSITIvcsO
	 +WxcRHAr72cAo3fNPeF9Eb/uiodleh6i/8llOHFRzjwNXeJBiCLaeQ32mDP/d+zjo9o8m
	 9qksftOB+lpKmJeJTJ7tZATL3pQUROhmWj2KVoD3r8zjWglpH69+6wwUH/cWYsu76iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD443606A332;
	Fri, 20 Nov 2026 03:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD443606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lk3DVXzVcB8;
	Fri, 20 Nov 2026 11:13:22 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lj4PJhzVcB8;
	Fri, 20 Nov 2026 11:13:21 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 505DFC087;
	Fri, 20 Nov 2026 11:13:12 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:19 +0800
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
Subject: [PATCH v3 03/11] fs/quota: convert remove_dquot_ref() to super_iter_inodes_locked()
Date: Fri, 20 Nov 2026 11:12:57 +0800
Message-ID: <20261120031305.3561045-4-huangsj@hygon.cn>
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

Convert remove_dquot_ref() to super_iter_inodes_locked().
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/quota/dquot.c | 68 ++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a3d503591871..9aaf2cfa9e1b 100644
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
@@ -1117,41 +1124,46 @@ static int add_dquot_ref(struct super_block *sb, int type)
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
+	return INO_ITER_RET_NEXT;
+}
+
+static void remove_dquot_ref(struct super_block *sb, int type)
+{
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+
+	/*
+	 * We have to scan I_NEW inodes because they can already
+	 * have quota pointer initialized. Luckily, we need to touch
+	 * only quota pointers and these have separate locking
+	 * (dq_data_lock) so the existence guarantee that
+	 * super_iter_inodes_locked() provides inodes passed to
+	 * remove_dquot_ref_fn() is sufficient for this operation.
+	 */
+	super_iter_inodes_locked(sb, remove_dquot_ref_fn, &ref);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		printk(KERN_WARNING "VFS (%s): Writes happened after quota"
 			" was disabled thus quota information is probably "
 			"inconsistent. Please run quotacheck(8).\n", sb->s_id);
-- 
2.53.0


