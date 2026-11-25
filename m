Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597949;
	b=MKDALV7D+JSZAQk0HMk3iymY7QiE7LpKW55CvlDgQW1btBuXvkGAZxwt2VTozruljnAm
	 Qb7RUsNzXjd+qqwjkLfM5t/W5ddYMVTa02y6bdomTfDA0gH1YE9Mdada2uZuv6bUtBvY/
	 hGkFFU6Z0tbyv4bV3i9hOzYKIiFCuKDZ5+B5EJq15KTt3Ukx8doSKxOfhZULI2BPh4tHL
	 6IfXv3HFbRzOUj+rXV2acSj8d/P/RDb2YqatfMvHtf15xgMgk0Cd+Zs+FgI5Hciau4J/w
	 Fjw5qdXTiSXBnvV0evSJl2RGu5Z1AZIbadK44IpIFUFafgNtvwxQAexgyBfnffoLvQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597949;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=XOPSQ2NrjBZFeAm9d8OQld6nLV4J+utsGW23PSfWRsE=;
	b=YUB4RIJUCpoZ524TP2i/hIMMLvSJsTihxuTXUvEKNN6hP4tOU91USfHMqJu8jTlCSRH6
	 w+P3TFAr5+nz0IiC5F2ROO1xgPUxvq07ERGOjvLXHgLsWbpMiO9rs2zdwWuukt5Cq+4z9
	 JRFXBHhKGg3lmHfr9pBA9Bt+Nn+G/7ReAIX+6xkydCm94g6TkFfv1iPQHZJRFAlrd8GHp
	 Mk3cL+RNuGFDRqWsqeiw7N67FFyukREDu6rj6Z2F3P4ZxRdOnhB/59FybX/KnzUYZtpqC
	 hIuL5zXeAyzKnde3KoNNY9I/XszrEAIlXYdgVGbE+Vsd5ikh4Lg9ObE/PenWxYfvN0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE3606A32A;
	Wed, 25 Nov 2026 09:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68AE3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTl29P6zVcBB;
	Wed, 25 Nov 2026 17:12:27 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTj75JFzVcBB;
	Wed, 25 Nov 2026 17:12:25 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 511FC1548;
	Wed, 25 Nov 2026 17:12:19 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:23 +0800
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
Subject: [PATCH v4 08/11] fs/drop_caches: convert drop_pagecache_sb() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:54 +0800
Message-ID: <20261125091157.1822521-9-huangsj@hygon.cn>
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

Convert drop_pagecache_sb() to sb_inode_iter.

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/drop_caches.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 28c5fb9c7357..bfe9b8cbb45c 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -17,39 +17,27 @@
 /* A global variable is a bit ugly, but it keeps the code simple */
 static int sysctl_drop_caches;
 
+static bool invalidate_inode_eligible(struct inode *inode, void *priv)
+{
+	/*
+	 * Skip inodes without pages, unless we need to reschedule: then take
+	 * one anyway so that a long scan of empty inodes cannot stall.
+	 */
+	return !mapping_empty(inode->i_mapping) || need_resched();
+}
+
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
-	struct inode *inode, *toput_inode = NULL;
+	struct inode *inode;
 
 	if (sb->s_bdi == &noop_backing_dev_info)
 		return;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
-		    (mapping_empty(inode->i_mapping) && !need_resched())) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
+	CLASS(sb_inode_iter, iter)(sb, invalidate_inode_eligible, NULL, 0);
+	while ((inode = sb_inode_iter_next(&iter))) {
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-		iput(toput_inode);
-		toput_inode = inode;
-
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
 }
 
 static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
-- 
2.53.0


