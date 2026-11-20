Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144426;
	b=W5l4Px0dYsbjtA52feZrBeO8iYWXNUExrLgUGnKQUdOT1AGKuFh/BxBDee7h0EBej4wr
	 6J+2lHvZQtcOQfyFcgVrkiMIPaXNX5mhbtVugQEQW0nApjTrtkpY2vGGGOxA/M0yfd2g9
	 XF+8A86E9GvPjvFGURb9ZzY7qTWQB7o5b6iAXMYZyvRDPQ7omZmeEWcPMCZ6CNdFyuwXH
	 j24ekTNXIXYXNrHG4TU0mP53cgOCfnzK+s7AVI7n41ypeqctotjL4Cm0ZN0tsT6tuKFRC
	 8d0iw57GZ5zDjJP4/hxylEesRDh6Fsm1Z8W3j/8VaxdNlJGdH/PungKQmz2kMo02INw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144426;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=WAE71jRExM1HToAOokplb7JGRyz27FwuaBPVyfzmFKA=;
	b=DCy9lP6vwQTVB9xc63jx/QIaWh7RUNGzyFkno7Bed/eDz1mvpJT1nbcIkLy8buXmKJgm
	 JU2YI9rDH0tIVEdvRzHp6UYrf74C0Npfmbur+OJChZaS3FxNsoAbK7T3eDLLEKZm98dj7
	 2v4vFH0KFgEmv2hNWaopfBiwt9iDkkNdCOx0m3fwiLmP0YDTxucP1HK74dVJ5m/Su+UGy
	 +2cDP6E79OXAmtl0qiOvpJcPXm+Z1PPTlK/3cDyINwo/RCPv9eHkRM/SbZ8YgtyhBwG6q
	 TVQPy1vlyFMnmbqGLUwLgz9p2wtRni2PpaLBd8y6jBBKhHr14vecTOOs7JQS4FaUPZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE94260A2627;
	Fri, 20 Nov 2026 03:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE94260A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0m73F7wzVcBP;
	Fri, 20 Nov 2026 11:13:43 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0m56z3bzVcBK;
	Fri, 20 Nov 2026 11:13:41 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id AA2F7C087;
	Fri, 20 Nov 2026 11:13:32 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:39 +0800
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
Subject: [PATCH v3 11/11] gfs2: convert gfs2_evict_inodes() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:05 +0800
Message-ID: <20261120031305.3561045-12-huangsj@hygon.cn>
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

Convert gfs2_evict_inodes to super_iter_inodes().

The original code also handed out an inode which was already being
torn down when need_resched() was set. That is not preserved: taking a
reference on an I_FREEING inode whose count has already reached zero
lets a second iput() run on it once the reference is dropped again.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/gfs2/ops_fstype.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6ec47376aecf..a6f8e95a4187 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1717,6 +1717,12 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+/* Nothing to do because we just want to bounce the inode through iput() */
+static int gfs2_evict_inode_fn(struct inode *inode, void *priv)
+{
+	return INO_ITER_RET_NEXT;
+}
+
 /**
  * gfs2_evict_inodes - evict inodes cooperatively
  * @sb: the superblock
@@ -1739,31 +1745,10 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
  */
 static void gfs2_evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *toput_inode = NULL;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
-		    !need_resched()) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+	super_iter_inodes(sb, gfs2_evict_inode_fn, NULL, NULL, 0);
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
-- 
2.53.0


