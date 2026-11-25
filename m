Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597948;
	b=MvpDK7c9ssx9YzYYY/4EbtWxuG7h/UDzeMj4rqfD8zYirnjPhVO3eJY/ImdXEgMmqLJ0
	 eJQ225tTGaXxJ2iCPciTe42eqVoJHZfc0VMyTl/trutQYFYFV/+qB36wrmGO9Jw+FBEjb
	 bq8BP0UY8sVYA51iHD5jDizBXSPoIlA6QiB7Ibhcfg8YUnpGSjtWGmPJ3ztTufpgggrZc
	 ZT0tkd/5N/Jcm/pxJ3f5GHbz8JahU52HKqWU9wzzxqONgJKaCGbHg3c2WMc2PpCySId5E
	 A8Ci+EPSy4BlgSPzjSHd8JUIUpekwisJ88StWKEBYUFi5BenpyH9CGSsNk2iaB0F3kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597948;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=/6O+blZWFeGtJIpYuxgB4qiZ+0l3PmKkDlPDd+QWUBU=;
	b=NpVNQ9s6Imh+lmzhwFZLAPxjJaKmJEcEzBwKy5/NbhyWrStckIrZ08DO+3Av/XMMP/TS
	 xT/HB6XKL5dGMV6seVXFgPe1ZkDI9JI0jRsH37IoZLaLFMgH6bjk0RYzmED0qe89MvOkN
	 tm/DMxZxSDCWnGxgUR8ceRAd1GXrk+zy29ytS63AzFaDHVV1kga//8ZlWMSQNTvxBS3ha
	 oxUVXG/S6LKfhDUveNLhmuExK+q99pKQCKQIcjhUAL0uJq+Q89YgjaBjBflLO6adM3P8B
	 LVq3rPUKBHO56sVook/tBxPAFPXXe7rUtmZSaC5F7E54EIRn8vZkeDA/B8PwBAF6/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BEE606A326;
	Wed, 25 Nov 2026 09:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78BEE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTh29FjzVcBJ;
	Wed, 25 Nov 2026 17:12:24 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTd2x4vzVcBC;
	Wed, 25 Nov 2026 17:12:21 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id B62751548;
	Wed, 25 Nov 2026 17:12:14 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:19 +0800
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
Subject: [PATCH v4 06/11] fs/inode: convert evict_inodes() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:52 +0800
Message-ID: <20261125091157.1822521-7-huangsj@hygon.cn>
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

Use sb_inode_iter with %INO_ITER_F_NOREF | %INO_ITER_F_NOIGET, which
hands out only zero-count inodes and takes no reference on them.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/inode.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f63535ee3629..0830a11a37e9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -865,6 +865,13 @@ static void dispose_list(struct list_head *head)
 	}
 }
 
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
@@ -879,40 +886,20 @@ void evict_inodes(struct super_block *sb)
 	struct inode *inode;
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
+	CLASS(sb_inode_iter, iter)(sb, evict_inode_eligible, &dispose,
+				   INO_ITER_F_NOREF | INO_ITER_F_NOIGET);
+	while ((inode = sb_inode_iter_next(&iter))) {
 		/*
 		 * Keep this inode out of dispose so it stays on s_inodes while
 		 * the list lock is dropped. I_FREEING prevents new references
 		 * and leaves eviction to us, so we can resume the walk from it.
 		 */
 		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
 			dispose_list(&dispose);
-			spin_lock(&sb->s_inode_list_lock);
 		}
 		list_add(&inode->i_lru, &dispose);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
-
 	dispose_list(&dispose);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
-- 
2.53.0


