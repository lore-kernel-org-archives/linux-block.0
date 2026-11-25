Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597955;
	b=MQmKRg+fWx5znjqf+CCJ5zTXET6b18Sh0Pav3p2zO2bOOaCUaJCHNeRbKuz01zCf4rS3
	 eECzqNbXbp3bqeblaK+TufMyI1frJELvG1cdOIyf+L/PvGNFZGAh2xncIezTLVCCeqAAX
	 G3mO9vg8c0ZybZJWynCldyoK/v9YyJje7PZ9JrcGZV0qGLQ+MSwYW2ydmrLecdbKqF0bA
	 VNw1X3ZHB/aNYI6N9KutwdB/JtTZDA7Yz5Ny6zzlWsaeq+TD3b2Iz2N5RR9V0uDh6gwI5
	 NLo5oup19+IVyktiwyulAuwPXuFZLH7p+1gokNSylFl4C7DgeNFoUUz/+IwvTECCcYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597955;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=W5xTPhBqbOYvt1pbc0+N0zz1+MkA79aoENSFmoHeo0U=;
	b=rbAOdj4+OOAHvaLpvPX+izpUU11p+4h1h84xlyZo83jm5M8adfONHE56ZRZed/FcCi63
	 /sJRuqXWF/v3z2biXTnsFJ0bzwSg3/mlbmQCkCpvKafl0ATyzXMDvyA80s/pzbImMzeUM
	 CN9feH9W7x3nLc9RHx/HvHm4p2Kh+Kud/TtR80KsEv8AAOmUH+bJ+I/WO+0xT2A6cgTwK
	 Z9vdGyd35KubfNqaT3h8m+4aZAUCMhGQZNUjDZfNooUB9QOFRd/RblHXLHXyc0cY9nisS
	 cTb9nS8kjaa1zgLALPWTxE2j6n/ls7ufoGBy2aZMyIC/XBloivbcoY2bMXfDTwZr82w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C590860A260F;
	Wed, 25 Nov 2026 09:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C590860A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTs29cZzVcBQ;
	Wed, 25 Nov 2026 17:12:33 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTr6kFyzVcBM;
	Wed, 25 Nov 2026 17:12:32 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 4D687300B6F1;
	Wed, 25 Nov 2026 17:11:20 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:30 +0800
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
Subject: [PATCH v4 11/11] gfs2: convert gfs2_evict_inodes() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:57 +0800
Message-ID: <20261125091157.1822521-12-huangsj@hygon.cn>
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

Convert gfs2_evict_inodes to sb_inode_iter.

The original code also handed out an inode which was already being
torn down when need_resched() was set. That is not preserved: taking a
reference on an I_FREEING inode whose count has already reached zero
lets a second iput() run on it once the reference is dropped again.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/gfs2/ops_fstype.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6ec47376aecf..130b116627a3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1739,31 +1739,17 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
  */
 static void gfs2_evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *toput_inode = NULL;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
 
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
+	/*
+	 * Nothing to do with each inode: we only want to bounce it through
+	 * iput() so that it is evicted while the list lock is dropped.
+	 */
+	CLASS(sb_inode_iter, iter)(sb, NULL, NULL, 0);
+	while (sb_inode_iter_next(&iter))
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
-- 
2.53.0


