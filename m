Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942F49158F
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944507; cv=none; b=OOLpoq49OknDLzKFRIx6Jw74Q5Jd4GJSpsM7+Rh3ii+igaIq4yXUxfc8jJWaEPZ1gaUir3OlOU6CAaGxvSsXbIybmcVC4PnGq+Kl2cFW/OfBwr+f9Ui8XmXp08o4lMCe+XE4e7ja0zqQ+S9wkUWG8bPOpSVGSpvTkdbiKuEE3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944507; c=relaxed/simple;
	bh=HwU/ru9C3cqaYxeWB4WaVZIJTnLTox6zR3se4so5PpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWRNLXOuyyXsAG4wmpaTzIc0LHGWUzyYksFszK9a+YyK3aHoLlX+lt30po0U0xl2u5yl1TI3rqcoFlNnjRsRNkkjehMiX4BqbWToc8lushPIAEtUt96fOe+LeQVjCWZuHiTh0GleOMqBk3UXn08IjStu7tPnxgMQG78fWKgI270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QUioUctI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QUioUctI"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e041ea211so4609534a91.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944497; x=1789549297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnw+bbx2n8GI1P1qJxz04Evujcp+PRs2H97tReO8VaY=;
        b=QUioUctI+Amc+Qo8bxZ3Rkm5hQ2qoQWS+Sd3eMUC9YW8ujSx2qmtA0UuqW5IiZIIk6
         paEtPzUxpnykPMckhjnT2nSLmwyIheOY7Bz+nUFCkeJi9rGd9zOvpNNpOIuqsGPFzQVb
         RdBLlttJXlTIVn1eG7Ac2vtDNo5OR3t5f8eMic2VRXVeDpDFYYMIKV0U2A7OL5lzINw/
         KAlAy9voHDqRDESHB3LSOEgfQihmwH5Z+16LDRs/prbyntctGSvsfrOrGuW8uWf4uzlO
         gCn5hmNzAiVCIyeWzkzx0OuZFTRYiUxdm7sparBn/MDFM7s4vQiuWgU0XGM2muz7gsb9
         q8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944497; x=1789549297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnw+bbx2n8GI1P1qJxz04Evujcp+PRs2H97tReO8VaY=;
        b=rokf2ODaOYqDG36GjLfjlzF3zKxCS5OtYU5EjU/FyFp0/XjePmVJFSPcq9Xl4CdnYo
         njTeAzWjT4UFZEIPCk8udiMXPhU0b7SGZxXwsEOQXQzXplmLBa+8Mjk5unnAJrqthguU
         J2jEFxUr0LB+aJgd0QOJbGgnuLUyzL2/p/7h1Mh4eJYMTOnERNz+3wnHrsjiBC5gsSqg
         be1jUKJ5q2M0KaiaPTBPVCDT189GcfYUeqcyuyT74XA2dJ6rMFEreCHYE7hMi23/DHlp
         V+mraIv4VSdgo9m9sFMW3cXV6HMNV42/EQex27uQVZsNq5ZbdJ99hRMs5wkz1pTOTxEp
         17Xg==
X-Gm-Message-State: AFuF++m6SUb4rXozLJzJ9dpTJIu2h6wz+VT3cW80y7IKoh1rrIQn0lMA
	YdpmBSAAk2dJlfAMFfjiM6fj/2aGKMqA8//kGt9dC+eMdbQdu0vM03Oo5dlEhCpe73zIA0bTDvv
	d6s7xp7Y=
X-Gm-Gg: AYBFou2PXQ4cm3kwyvox59ZQjQcRU19fF2Pe+qg3U0av+8tQnxdcA1lfOC9Pv4dUN99
	QWnDLg0qVzmwp2WrNgbygvEahunyuQPTfpPgNoRW95shM3nqX4A4NZ+33hJMKX4rqfyoxYt3Jog
	rQiCEdHvfRdQiMOyHJv3LmnhFHCjeHxyGX7QNtsIyag9ZWYFTMJ3OzYfRIz7/+DW/pFklxcxCBT
	4Ib2vp1kSkZjt2XK9CGwkP6P4hDsMUWHDkVcqsp/R6KHPc1bC3wGIhJ4GDJkRqX3E9CnnAXCITH
	r45+QfkRuPIb0NBeeNdEel2XNknC9GwjhYif1x71mILW3545iFj4o6sbxtVmYNKsP4S4dEGUTLs
	AU98Y7Brh8o44rNtNpdmchQZtstMXORtvjnzpRQbaXcw3ScGjPXt6505cT53/kWpuO62I8v/zh/
	F5AhD2YvMdBgN1qMtUxN9ysWLF34bMY4m1WT1umTGcN8ICjfxflfJbotCICotsvKZIyMQqQetBw
	fAi
X-Received: by 2002:a17:90b:1343:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39b26123302mr60180972a91.3.1788944496615;
        Wed, 09 Sep 2026 02:01:36 -0700 (PDT)
Received: from localhost ([106.38.226.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bac3a2809sm4683088a91.10.2026.09.09.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:36 -0700 (PDT)
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
Subject: [PATCH 5/7] gfs2: use sb_for_each_inodes() for cooperative eviction
Date: Wed,  9 Sep 2026 17:01:10 +0800
Message-Id: <20260909090112.790006-6-sunjunchao@bytedance.com>
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

Convert gfs2_evict_inodes() to sb_for_each_inodes(). Take and drop the
inode reference within the callback, with iput() outside the list lock,
to retain cooperative eviction. The iterator preserves the walk position
and removes the need for toput_inode.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/gfs2/ops_fstype.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 718e0da7dfce..acdbf9ca44a3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -996,7 +996,7 @@ static int gfs2_lm_mount(struct gfs2_sbd *sdp, int silent)
 		switch (token) {
 		case Opt_jid:
 			ret = match_int(&tmp[0], &option);
-			if (ret || option < 0) 
+			if (ret || option < 0)
 				goto hostdata_error;
 			if (test_and_clear_bit(SDF_NOJOURNALID, &sdp->sd_flags))
 				ls->ls_jid = option;
@@ -1719,6 +1719,19 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static int gfs2_evict_inode_iter_cb(struct inode *inode, void *unused)
+{
+	struct super_block *sb = inode->i_sb;
+
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
+
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
+	return 0;
+}
+
 /**
  * gfs2_evict_inodes - evict inodes cooperatively
  * @sb: the superblock
@@ -1741,31 +1754,10 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
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
+	sb_for_each_inodes(sb, INODE_ITER_NORMAL, gfs2_evict_inode_iter_cb, NULL);
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
-- 
2.39.5

