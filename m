Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597941;
	b=lkuZFxf3gBz2S6EreFH0OlJjyh/iigljRHBwzp5xZx3VgDOJa8w+js8lqNpKkrzNaClE
	 tE02/6p/BA3R22XzCMkRTz5tSOvMjzVx5FkHx1+81trBD/+s/MUof0E3AQpN13mf/y4Tc
	 Gg5h7f/kNzcDHztfflKEVUBt5NezNt/S6Zyno5B91FeZFfXEN4InOzfOGp4krfym2EZy9
	 seCwxFb8V8vvwYgVv6dNQBkimo4kRImos1eSCM7GuKTWBFqtVxA6F8CcEpCtZ9soFjRs2
	 xtPvWFo/lSKQCo4C37nyiyz8BqVvHfA6UyrUpqL0ys/eAQSc0NlV5eUa1Y2P6OaoKBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597941;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=C3CkL86lGVjEHDU0Yms3OxY9SiwvX79Vo9oMUChjX3o=;
	b=hAQ3+SpPNhT0vp41/cU7xwYOXZAZWK+7VjfhxVFlsRlt66Xn+Nl8lGZ5P6YInNc6Fn46
	 7xOGZQRZJ0B3Wu2fb0oaMpum92so37oAJjritu3nUHrxbGFEloIx2rpYCI21LB5g6VIGo
	 b2CjXvh0LyQvVI3GsUVSoP+MaYcHXnpElvnmJO1Y7DPTU2YzB8HrdY+uKFH08r31KYPpi
	 6w7wdProziCw9HdABTu3TzdaTnQmmTPcWb9S+Ta5z7rB4mRDTolO9ZWcbm2FpPCe2BlXT
	 R0WNiacff1Zj7N3WwQUO4Ua7d1iQYap+XCM6hs4ae0PEY3bUlyNnyqUtf41NoEelv0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B54606A32A;
	Wed, 25 Nov 2026 09:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B54606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTW29BwzVcB5;
	Wed, 25 Nov 2026 17:12:15 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTV0QbPzVcB5;
	Wed, 25 Nov 2026 17:12:14 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 68886300B6F1;
	Wed, 25 Nov 2026 17:11:01 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:11 +0800
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
Subject: [PATCH v4 03/11] block: convert nr_blockdev_pages() to sb_inode_iter_locked()
Date: Wed, 25 Nov 2026 17:11:49 +0800
Message-ID: <20261125091157.1822521-4-huangsj@hygon.cn>
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

Convert nr_blockdev_pages() to sb_inode_iter_locked().
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..938396c6559d 100644
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
+	return 0;
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
+	sb_inode_iter_locked(blockdev_superblock, bdev_pages_count, &ret);
 	return ret;
 }
 
-- 
2.53.0


