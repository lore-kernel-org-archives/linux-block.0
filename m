Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144413;
	b=4ad25PgKuWGqqLOMTN6VI6dxra1Bx7u6wsyF8A2HvqdGdtiakBzx3E99Hz6VN2yrmTaO
	 e3xg9NE+RHgpIhW4HUXY+nMJ4/L1BpMRcE5B+y89FSrcoKlXT5A5O/An7BmNTL7JJIGUn
	 8swQIHKA8/JRE5FCOel94dY11tytWd3Vhf8YG96DhLcxGAdPMPGE0zz/p+839GE5YF60H
	 H4jGckR6wDNOVYeo0HJXNLZCL9jHrt1jcpw7KyVKlIH7GH8AbMnmsY35AJWxCYoKpoJlN
	 9rFBPD0zdftk7meO9DuQvco2INAgCy46JEVLzxQivtrTocAd2XT9IZbowRt6tirkvbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144413;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=t7e1N9j3FtfUfXYB6xNEtndSV5CwfLVjVvURR0QAmGs=;
	b=A6pOJzKz2N60HNzU11A+yCeemGGJ17w+LA9nmMD5AhS/iw3tDfG3zcJE63YGEwaEJjqE
	 X/GtjiLlq3Vr/I07RALL66EttyzuR9ER5DxPWRyNILMyeO2NonEpgfgPUTf27VGim+uYg
	 8rsAGoM0PvY7qPLMAX1YfGijVUaDdsn9v3tNpPpEHPpXxpyqzWINE8VKKKdOnpBNQZQEu
	 VhP136csSfekIiQODfxyefyePG25LPad1fhUpQDXG+CA5PtBg7JCCmWNuUbzH/zJZqewg
	 6+l4BklJ1ZMnhjY+w3v6I31N1AIwghL2fijzlhILzTz7AUvkY3a+f3DdRvn9AKoKPwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D4860A2606;
	Fri, 20 Nov 2026 03:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D4860A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lv3DgRzVcBB;
	Fri, 20 Nov 2026 11:13:31 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0ls24TczVcBB;
	Fri, 20 Nov 2026 11:13:29 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id DFE6B30CB6D6;
	Fri, 20 Nov 2026 11:12:25 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:26 +0800
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
Subject: [PATCH v3 06/11] fs/inode: convert evict_inodes() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:00 +0800
Message-ID: <20261120031305.3561045-7-huangsj@hygon.cn>
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

Use super_iter_inodes() with INO_ITER_F_NOREF | INO_ITER_F_NOIGET,
which hands out only zero-count inodes and takes no reference on them.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/inode.c | 61 +++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f63535ee3629..be21d1f10007 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -865,6 +865,30 @@ static void dispose_list(struct list_head *head)
 	}
 }
 
+static int evict_inode_fn(struct inode *inode, void *data)
+{
+	struct list_head *list = data;
+
+	/*
+	 * Only drain what previous rounds collected: @inode is the inode the
+	 * walk is using as its cursor, and evict() would unlink it from
+	 * s_inodes underneath the walk.
+	 */
+	if (need_resched()) {
+		cond_resched();
+		dispose_list(list);
+	}
+	list_add(&inode->i_lru, list);
+	return INO_ITER_RET_NEXT;
+}
+
+static bool evict_inode_eligible(struct inode *inode, void *data)
+{
+	inode_state_set(inode, I_FREEING);
+	inode_lru_list_del(inode);
+	return true;
+}
+
 /**
  * evict_inodes	- evict all evictable inodes for a superblock
  * @sb:		superblock to operate on
@@ -876,43 +900,10 @@ static void dispose_list(struct list_head *head)
  */
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode;
 	LIST_HEAD(dispose);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read_once(inode))
-			continue;
-
-		spin_lock(&inode->i_lock);
-		if (icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		inode_state_set(inode, I_FREEING);
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
-
-		/*
-		 * Keep this inode out of dispose so it stays on s_inodes while
-		 * the list lock is dropped. I_FREEING prevents new references
-		 * and leaves eviction to us, so we can resume the walk from it.
-		 */
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		list_add(&inode->i_lru, &dispose);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
+	super_iter_inodes(sb, evict_inode_fn, evict_inode_eligible, &dispose,
+			  INO_ITER_F_NOREF | INO_ITER_F_NOIGET);
 	dispose_list(&dispose);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
-- 
2.53.0


