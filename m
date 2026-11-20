Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144409;
	b=eTkRfoe8gazTcOK4Bu3EUqfNXgWVd0NsvvjgRMOf6Hgey6dbjb8LdeKa8ennBeN5MmX6
	 tb+KtfYTJIrdrOXxedjCQXz2Ri/4z7j9LVg6gXNWMSG4z8c+66OWOtBnxGmjojJevxLVl
	 DRksC/KpInkOWAqC2PnXdwKjzTCQASpnHwnruWVgg/6DPdgx78zdCaStW3wSpMqtQUj4l
	 XXW9ikZ03MxlxLluo0RLS4mKfvzl4A25QNaEpzue4wrfd7yQe2+2ePy7xWTpYVbLT1ij7
	 tCQCuN5qM8ICUexUPCOiMkroFJgxmYQUvRK1hvPGxWu/Ie0sHUxUwgtisa2LndJGNDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144409;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=jF+ZIkoYQXJhmIfCnTg+8vh5WBMHRsCxt1S1gtI5VE8=;
	b=HcohCGOmg7JUGcBvCXvq4vNGalPd6e94Rppfh5FU+c5F8uosLfYGFInu9apezHfA5Qob
	 JkoezgbNzlT6lcB724qi2btVitGmw0nQZMM/JpxzYMCZEJdDrLcaNw1RIMC7KLCIXk4Mx
	 WzSsIGo+tKaFmi7OS3bM0/yzeyJzkS7XKP7tGbypIM3kAw31GsXj/EFgTDtyNb0a0n3wA
	 dcRNAbz+D5WTSrHZG6nPagdsCI0Ehkr/WQtMJZ4/yGYzNi38nKSY999RnXgcDbp/QRurt
	 nHjBVlinMa6geEhN87bbENhCckQs14etX+qAGxKA0jrKmbAEmafnAVpPURCjgEY4DHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBC2606A32A;
	Fri, 20 Nov 2026 03:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCBC2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lg3DR9zVcBD;
	Fri, 20 Nov 2026 11:13:19 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lg1362zVcB5;
	Fri, 20 Nov 2026 11:13:19 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id BC12930CB6D7;
	Fri, 20 Nov 2026 11:12:15 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:16 +0800
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
Subject: [PATCH v3 02/11] vfs: add super_iter_inodes_locked()
Date: Fri, 20 Nov 2026 11:12:56 +0800
Message-ID: <20261120031305.3561045-3-huangsj@hygon.cn>
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

The super_iter_inodes_locked() keeps sb->s_inode_list_lock held
for the whole walk and takes no inode references at all.
Its callback therefore only has an existence guarantee:
  it must not block and must do its own inode state checks and
  its own reference handling.

The iterator is internal to the VFS, being declared in fs/internal.h.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/internal.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index 967c8556c17f..27fe7948296c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -139,6 +139,37 @@ struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
 
+/*
+ * Iteration for internal VFS use only, with sb->s_inode_list_lock held
+ * across the whole walk and no inode reference taken:
+ *   @iter_fn runs in atomic context with only
+ *   an inode existence guarantee, so it must not block
+ *   and must perform its own inode state checks.
+ *
+ * Return INO_ITER_RET_ABORT if the iteration stops early.
+ * Return INO_ITER_RET_DONE if the iteration runs to the end.
+ */
+static inline int super_iter_inodes_locked(struct super_block *sb,
+					   ino_iter_fn iter_fn, void *priv)
+{
+	struct inode *inode;
+	int ret = INO_ITER_RET_NEXT;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		ret = iter_fn(inode, priv);
+		if (ret == INO_ITER_RET_ABORT)
+			break;
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+
+	/* Mark the end here */
+	if (ret == INO_ITER_RET_NEXT)
+		ret = INO_ITER_RET_DONE;
+
+	return ret;
+}
+
 /*
  * Prepare superblock for changing its read-only state (i.e., either remount
  * read-write superblock read-only or vice versa). After this function returns
-- 
2.53.0


