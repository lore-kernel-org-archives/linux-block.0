Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9134915B7
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944505; cv=none; b=mW4v+vYbDr5h/Bgg0Kx0oncq4j/8gaBXtoIZdaGSNJb6KAoECwWnPeSTWH+oXc89kAK+gf8/aBMVp3K3/PMu2IGNiEeNbAJ2rpdvibnxzMxmMTAAU4oJyAF7blJhQFNLCw+q1owWeuDAaiXaM/nJ1dzAk5tdpk6Us3OXBcR5p64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944505; c=relaxed/simple;
	bh=RC1BNmkCuQU1DakRzhjF5JezadS0qgQe8SFPOXejDL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=astD/io/KQsltgG3Cd96NIXsIAyzjkW5eghH/4Rc5oq23YXyM69Y7RDjh5Wdo5BorOXGMu0mCZFWqB+33pBChhwkoosuk2Z+xpVDCMjPbwU128s68jEXYtBT40oub6gll3NvvWZmAlG9++yyRMYKktKnOvQu8UsZxuzp5QP8FF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gOJ6F8ar; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gOJ6F8ar"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e58034d05so4591322a91.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944493; x=1789549293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/izFqZ/muM6zoo5C7zoGnLseqg/LKzmuBhX1YVp8oU=;
        b=gOJ6F8arppcKqtODSq6pTQPHYC11kjfOFk6a3G5oG1Jhz4v0yWI2qz3gH1PmVjlgL8
         xmb0/PzsRtXpOHzhPi7GcSlBsYGTx/CH+mGCvIsHrY+IIsdv+J7y5cocKuUCSxqG+cYi
         xl6GqSOMSxQ26e1slcvdZNyJNWrMyZHyAmXr/1WWj0jZFX7bSTXXvsyeDjwLcbpicaTY
         jwfkNS2AuhowPJ/8KAt7lmc3H6PAStaRBdOwvBnpKgRe1iUt8kLTWe7hzLXNsHjP4Mwy
         drlaXlke/jcUG2GBhbjRL0wK3H8dDGFl5tFN0Z+c6LlfpCQJ4xg5SOI9tjpv+Bpbqw3D
         RuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944493; x=1789549293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E/izFqZ/muM6zoo5C7zoGnLseqg/LKzmuBhX1YVp8oU=;
        b=b69tHP1n6xyoaXO/UR9ixzskZ00myo2lW0aspA4UIuqPTo1895he3FCGvsolKdw2/V
         j81KFv9QHUdHFfoFVfqOdyXJ0ey4SnJPpUP838ZSavyQxAeuxaEXdktJxltwKmuJFihH
         clCcILxB8VPY/leWikiQae/tTS6vQGDniCtstKwurtO5osmEkg2U2J0cnA/o4HVcxFQf
         fKmoMmTQlHcaLSoZUh13PjlhFzoxD3AYR/nm/MOZ+Jz6SAp48woTqvlA25NwFoah7XfL
         sz0XZVbI3zIEOmEznY4f2wnZL+Ui5shMVz1+NZEibMjO7V1xzyO9DqkcPyd4jnqWSNQm
         3UOg==
X-Gm-Message-State: AFuF++nPW2QLmieTNrByQLpKJqLXHsiH2nt/OfLfLeEL/RCdRX7lN0T7
	rEQKQOPvHAN43jQNvr73U2LE2u9P4f0OlTlv298nJP2CyYKZDUos8d6j/HQVnwmm3LDq/QS8j1W
	BLC1P8ec=
X-Gm-Gg: AYBFou2oDSGtzoGmPFK7ojF3DZZf5CsC8Srtov0a3/kDhLBg+TjytLyO9F9ilcN0epL
	QEY8s/9hbz4rRljEGUf0qnXv0QOEEUTDcQgwbE7KaZIVSRpedJzkej7O7lzI737/1lVjAH8sQB6
	2BRM3OycrGhjCXzjKOhDGlhTpvtfc3EBj/Z2W2h52Va6vbrhXkyCIlUDdTXJ7d2IzzDLTCdZ82D
	qmXv3lgH2+SCYML7J6hVTZkcQ6+IsyVlDZjMYkt7yTJf/VFa/31UA0L3L0CUkHWPI5avzgRvLC/
	l5kaHHikTnwcf3MLDaHpr9l2c9qE6AFr0Fdw66CW0QPnLKChkrIrMuMW2Ucku2x2yr16kLL7Fsl
	oar4LtaR52mAWNIUIkrovm9NeXjkxIRcjAKiBryMRYhgWy8lAbR7OKFyPX2I79znECr67HrE6/7
	xo42YI8n0OQxK2Eq98JA1EUwdbJP9owMOkeHis3XkiyBmSA9njHT8eIsKWGZqBxaYg3XeleS7He
	g==
X-Received: by 2002:a17:90b:2784:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39b26272bdcmr57133385a91.16.1788944492663;
        Wed, 09 Sep 2026 02:01:32 -0700 (PDT)
Received: from localhost ([106.38.226.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc090sm36856959a91.4.2026.09.09.02.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:32 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 4/7] fs: use sb_for_each_inodes() API.
Date: Wed,  9 Sep 2026 17:01:09 +0800
Message-Id: <20260909090112.790006-5-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sb_for_each_inodes() in evict_inodes() to avoid rescanning referenced
inodes after each reschedule. Collect eligible inodes during the walk and
dispose of them after it completes.

Convert drop_pagecache_sb() as well, replacing its deferred toput_inode
reference with the iterator's position tracking.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/drop_caches.c | 44 +++++++++++++++++++------------------------
 fs/inode.c       | 49 +++++++++++++-----------------------------------
 2 files changed, 32 insertions(+), 61 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..0d475a5ff8cf 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -16,36 +16,30 @@
 /* A global variable is a bit ugly, but it keeps the code simple */
 static int sysctl_drop_caches;
 
-static void drop_pagecache_sb(struct super_block *sb, void *unused)
+static int drop_pagecache_inode_iter_cb(struct inode *inode, void *unused)
 {
-	struct inode *inode, *toput_inode = NULL;
+	struct super_block *sb = inode->i_sb;
 
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
+	if (mapping_empty(inode->i_mapping)) {
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
+		return 0;
 	}
+
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
 	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+
+	invalidate_mapping_pages(inode->i_mapping, 0, -1);
+	iput(inode);
+
+	spin_lock(&sb->s_inode_list_lock);
+
+	return 0;
+}
+
+static void drop_pagecache_sb(struct super_block *sb, void *unused)
+{
+	sb_for_each_inodes(sb, INODE_ITER_NORMAL, drop_pagecache_inode_iter_cb, NULL);
 }
 
 static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
diff --git a/fs/inode.c b/fs/inode.c
index b4279063a5dd..07a5f48641af 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -959,6 +959,17 @@ static void dispose_list(struct list_head *head)
 	}
 }
 
+static int evict_inodes_inode_iter_cb(struct inode *inode, void *data)
+{
+	struct list_head *dispose = (struct list_head *)data;
+
+	inode_state_set(inode, I_FREEING);
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+	list_add(&inode->i_lru, dispose);
+	return 0;
+}
+
 /**
  * evict_inodes	- evict all evictable inodes for a superblock
  * @sb:		superblock to operate on
@@ -970,44 +981,10 @@ static void dispose_list(struct list_head *head)
  */
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode;
 	LIST_HEAD(dispose);
+	unsigned int flags = INODE_ITER_NORMAL | INODE_ITER_UNUSED;
 
-again:
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read_once(inode))
-			continue;
-
-		spin_lock(&inode->i_lock);
-		if (icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		inode_state_set(inode, I_FREEING);
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
-		list_add(&inode->i_lru, &dispose);
-
-		/*
-		 * We can have a ton of inodes to evict at unmount time given
-		 * enough memory, check to see if we need to go to sleep for a
-		 * bit so we don't livelock.
-		 */
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			goto again;
-		}
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
+	sb_for_each_inodes(sb, flags, evict_inodes_inode_iter_cb, &dispose);
 	dispose_list(&dispose);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
-- 
2.39.5

