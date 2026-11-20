Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144409;
	b=JYcgJ4DjGkadenm94+KEHyuHtcka+MLqvQuRDdjOZk6p0gEYwe60/irYHbCiwnM1LlE/
	 vkYpaxpPVij9ZZnRaZhr6jI6qXkdZvhbRbySx1R/HQMepZ2wzyJym5pfNjxlzIXaFZxzd
	 PgRSfES7e78fRlgtyCpOJWkYaJAfMC8a1eQgsctcc5EmW/CzGwtJHLWZQbpoWndyOT/3s
	 Zz3Gl0uonWDmbmt1wuUxM2qcPWli9Y+cU5TVn7v2e+54Dl/guSr1+CJyxzSEO2x35+Rso
	 M4ottPskY8HI9iqcdgq1c0kiQXq1BRQCglNENWFYtM3v8Xsr/5LwgT61VDzEQAWfNhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144409;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=uIEansB0MuhQ4c3Aqig7WqzSZmGjWpCxBCheQKcMU/8=;
	b=I8gnDprkFvphk3QMWHMq5vyvZMhMgJ2/um4JvrKx3wN6EYgNWcLdE5CKvmJ+T0YJcJ6z
	 69lmKMxgI7bqvlsfM3VbVaTNvC3+QX2PA/5J6oIY4gZWwCXJK2wQG5qWqO1C+HgQoA2l4
	 yBEhPs0o5Wck1lzcbby00pZLHJ5VxRyXJkxdUBKwCDRoJA6CMA5ZHQqXabDsMG6PqT3Vu
	 kJFC3+NzdRUki9sGfuskJRXXwxyACyKzbT2MWmZt7q8ZEI1fv87c9pxQNkZCMrLMs0g7K
	 vFt4Kkq8D/g8A9nwgoBcAAOctXD74oNxHzhqZG/U7JfgsfyM83PmJFy6xeZqMh0WqwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC3606A334;
	Fri, 20 Nov 2026 03:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7EC3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0ln3Df0zVcB6;
	Fri, 20 Nov 2026 11:13:25 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lm1s1QzVcB6;
	Fri, 20 Nov 2026 11:13:24 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id D859330CB6D6;
	Fri, 20 Nov 2026 11:12:20 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:21 +0800
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
Subject: [PATCH v3 04/11] block: convert nr_blockdev_pages() to super_iter_inodes_locked()
Date: Fri, 20 Nov 2026 11:12:58 +0800
Message-ID: <20261120031305.3561045-5-huangsj@hygon.cn>
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

Convert nr_blockdev_pages() to super_iter_inodes_locked()
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..3c1d38475607 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -558,16 +558,19 @@ void bdev_drop(struct block_device *bdev)
 	iput(BD_INODE(bdev));
 }
 
+static int bdev_pages_count(struct inode *inode, void *priv)
+{
+	long *pages = priv;
+
+	*pages += inode->i_mapping->nrpages;
+	return INO_ITER_RET_NEXT;
+}
+
 long nr_blockdev_pages(void)
 {
-	struct inode *inode;
 	long ret = 0;
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
-		ret += inode->i_mapping->nrpages;
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-
+	super_iter_inodes_locked(blockdev_superblock, bdev_pages_count, &ret);
 	return ret;
 }
 
-- 
2.53.0


