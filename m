Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144416;
	b=N86b6gY83fQl6jEYUXZ0otUvKWFQ1ztH9v5QBTiuSaonm8SExrQ4wcVeBadKWo5ySO5h
	 FQxVDXhYY/aXqdt+liOeCrUgl3MWfPosi5YL7jG0d0DbfVPhrJyKZAbwHdEL3qHsGgz5p
	 7d7HypRwKVUm6eWxKb5dBjPzNYvIofjaVeGN1KXJLPqIpPwrlEWGq7dl63l/WcRfmAYSL
	 uvCRQuFqz9FtopKd7cXo8LUtgVdk+hVkS/v4EPQSrMC9S6qk1xNK79MV11AatdS5zvdk7
	 rSjgRqg4w2ix/yd+TrHyNXMRRQtQGZi0NCGb9FBfnDKMYKCHzlOTI1IK75cJb7niFJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144416;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=++vwF3/aYnq3i5kVxaq8VS+fg3m4S+G64LZ6YaI01gY=;
	b=jOjbZEKM81QvNQfgRC5f49at38Yd6lZqFN9NLL5DBrSKCr1iwkdF1KsRraG5DA/nusgK
	 AUOLSjQzDC9i1bBHQZtREWgkYSV0TLRp+fIyXkXDhw8uoGHGh5v6VP5/2/HwLYPtA5SOg
	 xsDElAmNPrjztvi+ntB6SgQyItdy2xA6zi3VHVpLuWO/B3mNKOPqS0HP0P29tlNManMMW
	 0go2QxCXsI90TdWiTSYELc1DVqqbQBNmM6AQUt2e1MXLfpAVDcFHf8jXd4c+BPdAhpy5I
	 YmLLRBYCLvcDJCuN1BusV2huKfsZFE+r04SuYRGwezdBTRIUpI9yQaB3eQzNaVJ3rqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D360A2627;
	Fri, 20 Nov 2026 03:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF5D360A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0ly3DvgzVcBF;
	Fri, 20 Nov 2026 11:13:34 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lv5RMvzVcBJ;
	Fri, 20 Nov 2026 11:13:31 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 75322C087;
	Fri, 20 Nov 2026 11:13:22 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:29 +0800
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
Subject: [PATCH v3 07/11] block: convert sync_bdevs() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:01 +0800
Message-ID: <20261120031305.3561045-8-huangsj@hygon.cn>
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

Convert sync_bdevs() to super_iter_inodes().
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c | 86 +++++++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 52 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3c1d38475607..37fa47fb15ac 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1339,66 +1339,48 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
  */
 EXPORT_SYMBOL_GPL(bdev_mark_dead);
 
-void sync_bdevs(bool wait)
+static bool sync_bdev_eligible(struct inode *inode, void *priv)
 {
-	struct inode *inode, *old_inode = NULL;
+	return inode->i_mapping->nrpages != 0;
+}
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
-		struct address_space *mapping = inode->i_mapping;
-		struct block_device *bdev;
+static int sync_bdev_fn(struct inode *inode, void *priv)
+{
+	bool wait = *(bool *)priv;
+	struct block_device *bdev;
 
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
+	bdev = I_BDEV(inode);
+	/*
+	 * The inode does not keep the gendisk of a partition alive, the
+	 * device does.
+	 */
+	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
+		return INO_ITER_RET_NEXT;
 
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!atomic_read(&bdev->bd_openers)) {
+		; /* skip */
+	} else if (wait) {
 		/*
-		 * The inode does not keep the gendisk of a partition alive, the
-		 * device does.
+		 * We keep the error status of individual mapping so
+		 * that applications can catch the writeback error using
+		 * fsync(2). See filemap_fdatawait_keep_errors() for
+		 * details.
 		 */
-		if (!kobject_get_unless_zero(&bdev->bd_device.kobj)) {
-			spin_lock(&blockdev_superblock->s_inode_list_lock);
-			continue;
-		}
+		filemap_fdatawait_keep_errors(inode->i_mapping);
+	} else {
+		filemap_fdatawrite(inode->i_mapping);
+	}
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	put_device(&bdev->bd_device);
 
-		mutex_lock(&bdev->bd_disk->open_mutex);
-		if (!atomic_read(&bdev->bd_openers)) {
-			; /* skip */
-		} else if (wait) {
-			/*
-			 * We keep the error status of individual mapping so
-			 * that applications can catch the writeback error using
-			 * fsync(2). See filemap_fdatawait_keep_errors() for
-			 * details.
-			 */
-			filemap_fdatawait_keep_errors(inode->i_mapping);
-		} else {
-			filemap_fdatawrite(inode->i_mapping);
-		}
-		mutex_unlock(&bdev->bd_disk->open_mutex);
-		put_device(&bdev->bd_device);
+	return INO_ITER_RET_NEXT;
+}
 
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
-	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-	iput(old_inode);
+void sync_bdevs(bool wait)
+{
+	super_iter_inodes(blockdev_superblock, sync_bdev_fn,
+			  sync_bdev_eligible, &wait, 0);
 }
 
 /*
-- 
2.53.0


