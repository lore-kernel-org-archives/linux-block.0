Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597953;
	b=u3T4PA9AdoWVE6qe5zt/xufunJPekLkXsWs2ZeT+a5BRaSqmfZZJvfJ5ACSOlye9r3XN
	 GMxWjdD55uXM/tPZFMbr82o0mdFHKmhhi1u66vkhHHDs1fBI4Tf8BXl1/NE1oEuHka7nY
	 Z9Ikx89Xf1ApRquSy8Gd2WtfnlWAlkchNdGI7HhoS/QvuvpSOONtwO9dOgqnqo2Oyw2Vp
	 VcOQdy/ElY+fj11wR+P6h3mloOIGBIG0EaQ87VYDRpkP85rdaboaZoEkdl6joldcN8ubH
	 UAMxwv7X86Cp2G+RK+A0UKfEOSYevvFq9k8R2J5HiR0L2RqdWSLs0pakJab1K7OBLsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597953;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=PZApHeOyVFfHJcYU8jllKoaZGZcNH5itsU2DEbproM8=;
	b=QtyRaVCs2hTDG3G7GZbfrxUiIp9wo2wXxo+gebzaUW7b7ECLVjLJW2wSGdDPjLGN33sk
	 l0pXfo+mIrnOLqigUn7vlyo2/urkY5Khn27u33tZ8aSiDnT5eZDyjsxYFqpdDR8wP5WMf
	 i0XUt7jaMQDHozAxjA0i6yYw/mbtik6K2tGOCP2YpkWh8N+q666anUqLb3/8aOL0YWm/q
	 la223yVroOsDHdyIXSRGOHUX3Xg4Zrh2PJ/ymuN7HuzXYirj8PJjtj34bfkLm0dKn8sF3
	 JB4PlvWx9bmayNhVN1/GNJhX9gKiJbw2iJbg40AuWipZ1WpQWwWxDV7NNhFETKxTlAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C21606A68F;
	Wed, 25 Nov 2026 09:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C21606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTp29NpzVcBF;
	Wed, 25 Nov 2026 17:12:30 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTm28LNzVcBC;
	Wed, 25 Nov 2026 17:12:28 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id A4193300B6F1;
	Wed, 25 Nov 2026 17:11:15 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:26 +0800
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
Subject: [PATCH v4 09/11] fs/quota: convert add_dquot_ref() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:55 +0800
Message-ID: <20261125091157.1822521-10-huangsj@hygon.cn>
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

Convert add_dquot_ref() to sb_inode_iter.

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/quota/dquot.c | 54 ++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 538578c79b5c..d047a3353b79 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1066,56 +1066,38 @@ static int dqinit_needed(struct inode *inode, int type)
 	return 0;
 }
 
+static bool add_dquot_ref_eligible(struct inode *inode, void *priv)
+{
+	struct dquot_ref_data *ref = priv;
+
+	return atomic_read(&inode->i_writecount) &&
+	       dqinit_needed(inode, ref->type);
+}
+
 /* This routine is guarded by s_umount semaphore */
 static int add_dquot_ref(struct super_block *sb, int type)
 {
-	struct inode *inode, *old_inode = NULL;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+	struct inode *inode;
 	int err = 0;
 
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
-
+	CLASS(sb_inode_iter, iter)(sb, add_dquot_ref_eligible, &ref, 0);
+	while ((inode = sb_inode_iter_next(&iter))) {
 #ifdef CONFIG_QUOTA_DEBUG
 		if (unlikely(inode_get_rsv_space(inode) > 0))
-			reserved = 1;
+			ref.reserved++;
 #endif
-		iput(old_inode);
 		err = __dquot_initialize(inode, type);
 		if (err) {
-			iput(inode);
-			goto out;
+			iter.status = err;
+			break;
 		}
-
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock. We cannot iput the inode now as we can be
-		 * holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		old_inode = inode;
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(old_inode);
-out:
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		quota_error(sb, "Writes happened before quota was turned on "
 			"thus quota information is probably inconsistent. "
 			"Please run quotacheck(8)");
-- 
2.53.0


