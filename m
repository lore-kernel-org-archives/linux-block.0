Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144410;
	b=OGoW79SSD/tISYJTjkjXfX1bLpl8JpRYCC6sNd5R99VbKy3jR59Y25Fz51ZBLUkJjXQq
	 iWOFRD/gkFLOi8mxrrqAaQv5R/iR1EaAhUJM6X/t8szojQ0rjSCcjOZrpyZ1v66Jy8OZY
	 BlDzoi+NcS/lzBQtrWiag2DpaQ8nedOJ+j66ZfVXI1GemDJ3Smc9Bc9+ientIQ9i2qSAX
	 dWpVsKxefHLuuUD6sMmSBl+kMN4Z9XxKdwB8olud7R7fono8Fb8gBSKKTBOkV/Y339jcs
	 FHnweCCb5p5YtKYaFnDA6zkdj+nel7CGLrX5IBrw43tvYYe6weTQ0+wr9cgFi5JKaWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144410;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=StkWp6J3ELExZ9UvSDl/wHBlNOQrUt2kpZHMo7UNctA=;
	b=eU1+E9DMsLosRLW6ojgaxy89c06OplGb0fJvLeamdfm48vlRXgZqMA3holEohm3G+uhw
	 X0eP708QhGJAv1eV65yWaNQqIWLXmHLybOn0eT3p0KEkodNjETQE7w3huzRsrMrzmaChu
	 JIRKuOqA3nK7fs5EZOJKt16DuKOPfR9eN9QqGvNy+1enpbjOx8Z6Sf5u3SR/krTmAoS26
	 pAxJrQABED/abguRKVq2Vh+4ldxHWoZ5ZeES8RNwtAK7K/l9eYfMvkg5MZzQ+2IvWUfyH
	 PTw7Jbdc6Dat2pIeDxLawjNWbP2pcS5k7mfjVTietFxCFHqxzw3KIGLqCU9ZCguTmow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D6E60A3828;
	Fri, 20 Nov 2026 03:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D6E60A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lr3JvQzVcB7;
	Fri, 20 Nov 2026 11:13:28 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lp64KxzVcB9;
	Fri, 20 Nov 2026 11:13:26 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 8BB47C087;
	Fri, 20 Nov 2026 11:13:17 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:24 +0800
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
Subject: [PATCH v3 05/11] fs: convert generic_shutdown_super() poison loop
Date: Fri, 20 Nov 2026 11:12:59 +0800
Message-ID: <20261120031305.3561045-6-huangsj@hygon.cn>
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

Convert generic_shutdown_super() poison loop with
super_iter_inodes_locked().

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/super.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 204c70c7f179..dad7689fd3de 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -765,6 +765,15 @@ void retire_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(retire_super);
 
+static int inode_poison_fn(struct inode *inode, void *priv)
+{
+	inode->i_op = VFS_PTR_POISON;
+	inode->i_sb = VFS_PTR_POISON;
+	inode->i_mapping = VFS_PTR_POISON;
+
+	return INO_ITER_RET_NEXT;
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -823,15 +832,7 @@ void generic_shutdown_super(struct super_block *sb)
 			 * we can at least make it more likely that a later
 			 * iput_final() or such crashes cleanly.
 			 */
-			struct inode *inode;
-
-			spin_lock(&sb->s_inode_list_lock);
-			list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-				inode->i_op = VFS_PTR_POISON;
-				inode->i_sb = VFS_PTR_POISON;
-				inode->i_mapping = VFS_PTR_POISON;
-			}
-			spin_unlock(&sb->s_inode_list_lock);
+			super_iter_inodes_locked(sb, inode_poison_fn, NULL);
 		}
 	}
 	/*
-- 
2.53.0


