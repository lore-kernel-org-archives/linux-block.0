Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597948;
	b=tmegxIVGnm3xV3qsuE0obHFnmaDE75MPkDFvSpZ81g4jKaTwnukKO2rLjmob5W+VaaJl
	 SiGok6YKqLR9kZsNYOyU/gltT/0jmBDoeUX3a2lOVtu0iLpqiJNxZ/3L4RXNqAB4rONT4
	 bgB5S59Y0A3u/seY9ND0ValSnlk/XgruPgRRxhi/WItlJrpNwEptfv4q94UHGB1LnoUb+
	 mHNBBj8M+blljrUDn1bOGD81qximJJPVJOBl02FyvQz62ykVrE6DEz+g9VLfUW/UYrZqq
	 gzhwEiy7lqnPwybX6qxCOsYYQboiE53jFN5ZTH2ua1P3p0G4AX2aA9V1qhmtsC08uWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597948;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=V4HbwVEuwHie2pyqStq3WwzIcpZJDTmvqIBLuBqtFGA=;
	b=dTHHl8khdm3NfiqTnh3BBGtP6Ew+Vp2br90QBmS2ix+rFyylcYr2s7JkFAHdlB6ql/oN
	 +fg0oTdlcscbF1oTG33xfiHOSrLwSXtO92fwhixnXzOt3SZiTK1Vx7902qJFyepjpwTZj
	 yh9esm2j9ThrIkCSaeNouGEn6kJFaWDFf9j1S45mo3U/X5o7w3Y5y9LujF6ZHD1VbCi3L
	 uLLc/COQ/dyv6WfyQ39gW5WbsOg+/CbsI+8pvezAxsQHwxmmmwQZbyIdblivfdPihQxim
	 kvq5KteyYrOTfhM3N+YCKH9ln9JqVSYkMgQfh0aEnkpC7LXQ1cZmwiQR+xCfae/H8tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05AB60A260C;
	Wed, 25 Nov 2026 09:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E05AB60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTd29DHzVcB7;
	Wed, 25 Nov 2026 17:12:21 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTZ6wxDzVcB7;
	Wed, 25 Nov 2026 17:12:18 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 518F3300B6F1;
	Wed, 25 Nov 2026 17:11:06 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:16 +0800
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
Subject: [PATCH v4 05/11] fs: convert generic_shutdown_super() poison loop
Date: Wed, 25 Nov 2026 17:11:51 +0800
Message-ID: <20261125091157.1822521-6-huangsj@hygon.cn>
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

Convert generic_shutdown_super() poison loop with sb_inode_iter_locked().

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/super.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 077e772fa19b..bf7fac5ebcbb 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -780,6 +780,15 @@ void retire_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(retire_super);
 
+static int inode_poison_fn(struct inode *inode, void *priv)
+{
+	inode->i_op = VFS_PTR_POISON;
+	inode->i_sb = VFS_PTR_POISON;
+	inode->i_mapping = VFS_PTR_POISON;
+
+	return 0;
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -838,15 +847,7 @@ void generic_shutdown_super(struct super_block *sb)
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
+			sb_inode_iter_locked(sb, inode_poison_fn, NULL);
 		}
 	}
 	/*
-- 
2.53.0


