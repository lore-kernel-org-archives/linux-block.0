Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597948;
	b=3pUm6cv7AsMyz5yJsneSNhZ9tdtkLKgm+0KVsbgjC2h0Y4mn/CmIs5QExd53a9fSkZYK
	 RZ9+2dG99KQnr5VdJmo56SYrohEgYj501ui+XQMMbnaaeqMn28uIFWv6mEPbk7ZDcSUgk
	 LGyLRsJPvj0TLa9wXHHEns2jvy+QXLtueJ00W1lriDdybQ9RMy5hSdg8U5nBoFElKz7qe
	 G72srMCiAOFmXMdhW2O3cXMflslo4X3w8MwUSOphKTuhHJ1F3rdMIHDCBaecb3SmCOP2r
	 c+OnL1Yh2j3diArwpYn4zCbsnbb1QRN5G0fUyfu1yB916xOzp6QIAf+Ac14+M9EDZcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597948;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=89APBZOIzdphO0qaHIcKOP/6wX8oBfdQncS3a6Ks6/g=;
	b=d3NqdAqmn+JmbLsJRFBxhudqcdD0pTtcVlyFjD9e1hg5rc2Bdcq0J/HYtn2RsJLtjnK3
	 1Pvki4zyztcKfg7pJJen9hAfHmv0FxTw0tejQWoIiyAUWhib9kJ5mS1A33jfQKDHEMct3
	 KDHJzsV4K9ig9ZvzabmuD4+k483nyBcMnC+hOl2qonPKdNanUxRqrV1cCcslyiIkPhl0S
	 ysc1YckkW1K1mo+G9N9T+AY67Mal0bnWGPbhyXAFUOtVwt+wnjqrLj5IqA9gNa+irO3wT
	 Av06XDoI1a6qOr8C2BZV8Fve52pr3kxZ3D6JQb0gE8Wxim/fIg8+MzFToR2trrpCyXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AFB606A32C;
	Wed, 25 Nov 2026 09:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1AFB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTh29DZzVcBH;
	Wed, 25 Nov 2026 17:12:24 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTg4qPzzVcBB;
	Wed, 25 Nov 2026 17:12:23 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 0BF7E300B6F1;
	Wed, 25 Nov 2026 17:11:11 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:21 +0800
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
Subject: [PATCH v4 07/11] block: convert sync_bdevs() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:53 +0800
Message-ID: <20261125091157.1822521-8-huangsj@hygon.cn>
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

Convert sync_bdevs() to sb_inode_iter.
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 938396c6559d..5b399fb7cd63 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1339,44 +1339,27 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
  */
 EXPORT_SYMBOL_GPL(bdev_mark_dead);
 
+static bool sync_bdev_eligible(struct inode *inode, void *priv)
+{
+	return inode->i_mapping->nrpages != 0;
+}
+
 void sync_bdevs(bool wait)
 {
-	struct inode *inode, *old_inode = NULL;
+	struct inode *inode;
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
-		struct address_space *mapping = inode->i_mapping;
-		struct block_device *bdev;
+	CLASS(sb_inode_iter, iter)(blockdev_superblock, sync_bdev_eligible,
+				   NULL, 0);
 
-		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW) ||
-		    mapping->nrpages == 0) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock  We cannot iput the inode now as we can
-		 * be holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		iput(old_inode);
-		old_inode = inode;
-		bdev = I_BDEV(inode);
+	while ((inode = sb_inode_iter_next(&iter))) {
+		struct block_device *bdev = I_BDEV(inode);
 
 		/*
 		 * The inode does not keep the gendisk of a partition alive, the
 		 * device does.
 		 */
-		if (!kobject_get_unless_zero(&bdev->bd_device.kobj)) {
-			spin_lock(&blockdev_superblock->s_inode_list_lock);
+		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
 			continue;
-		}
 
 		mutex_lock(&bdev->bd_disk->open_mutex);
 		if (!atomic_read(&bdev->bd_openers)) {
@@ -1394,11 +1377,7 @@ void sync_bdevs(bool wait)
 		}
 		mutex_unlock(&bdev->bd_disk->open_mutex);
 		put_device(&bdev->bd_device);
-
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
 	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-	iput(old_inode);
 }
 
 /*
-- 
2.53.0


