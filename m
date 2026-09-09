Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7CF485CCD
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944512; cv=none; b=FokE51aCGC0M6SROdvI1CswXQ5oRJC/ZBm6gPvatUp3olFs7jDzHP1jv8HqXk5Zl5Vi+0DxSdtyuaaxnAQy9d4Rk4Z1Ld0K6jK4V8i2U5abkf1V2xwKxTRvOEPO4rG98GJYJnHBz8bV0ZeS3Z1FCAb3HcMAIaOXk9jUdF0OvKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944512; c=relaxed/simple;
	bh=8FHBC5gbFeIC4E/lA238Bv5TaDRS4lUM54i1wq/3L1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BsSRYYgff228Pw8Q57+F12ZYVCh5MgmDW7jD9kWI6QDfYGPrL/x1pwew4cLNQ/eaTHsi+wKXj0Drad3TbMMJoi3UPijwGliu6h+dTbor7K3lc96PYPSePayLzVUM/lTohgcFB22kt2aD/AShVfum8Tn6+8EVvcTK5pY9LA2cNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=acCzvl5C; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="acCzvl5C"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84eb992a881so4106044b3a.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944509; x=1789549309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zE9gpwYGcyFTdwIyA0S+65+Mdt3hWydj4aldKyaFgJI=;
        b=acCzvl5C487VQlld4jjCNmPa66fdxX7t2wrEUMtLFvl7HgR+pFOGDORAgwnKzkNLgo
         kUX5k14LXJCCnIadmXW0ZdgpkJ/S4KCQz3VXhaegtgDLL2yr0tKB6K66+pyoCfza6ZP8
         c/0/g1XDt+WFI0KJXX9UzKg9AEZDaCN3no/HfchPtAA2MN9sDAIkrSNd/s6jKDxBtZGD
         sh5G4rbtSVV3HR/YWdBz86an+iVK9lVrBZ1RzP7VfwXE1jGOHy1hHa1pJEturGmsCpME
         wGH/EiHj3bt7li3klOheTd0gwSYyL0ASPbIztU00f71NVCiugaOpawfPK77XkAK8nv56
         so7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944509; x=1789549309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zE9gpwYGcyFTdwIyA0S+65+Mdt3hWydj4aldKyaFgJI=;
        b=XzrwbtS1Oy3Uf1dO2keJ23VIXbnc2nuhHTxrcscj0Kj3NR0dXG6UAki5YAWLZISjz9
         MehsmkComRtYCKnYAeDBYhAlqjExvsLuO8kjgsZ2LSZywlQVc5v40bqVn/F+8t2yvaLP
         TEBaAWwfxF6XqShQoAz2TJyofnPZeAJhGnwu8jGWBHMLkxVw8WAnoFspsliz2Y2f4mA5
         8whISKMOsPvygcywKzjb7U/x1hAtk08kh6nAtvHiFDrkP6HfGuIzOYH4yq7xIuyU8+k9
         mN6++Oab0SILVHhsrMpp/qkDIo0ujwgkC1Cz6hO9OGvghh+vev4ko7PXY2R9u1RstYSi
         0UZg==
X-Gm-Message-State: AFuF++nJ7Gvf3k6hp8vTppLDIGeCNcN3YU6JbQDiUNZaIbxDE9/zFeba
	1WsztgTKWRI1YORt1QCeUwbdTfhrENewo6wVcnixe2P+ckA71BiwDZinDpdBrVFK/z5wPYN0dfW
	gjSi+Svk=
X-Gm-Gg: AYBFou3Xbr6tpnqHhOO5NZX/ZxUHC9QVuCB5nUv9eD9Jv6PtUVlLtrl9WWgZ6Px9FYW
	FVRM0uTeurvQOSZ50SP1fRVTUpcLGmWUGUjf8272xFRU+jvQ+VCulOdycVtwl658iOIeha4Rk80
	i2U1N+YZQZVZH7aBqeQ7ASYSMz8/dE7zCMU0DUVaEVCIj8UNKFJwbIpLAjdfHfPAyo52Rl2/8GP
	HkbHOTMubKVxbwJ0cRQjbOvgQIDW75GSUeL5XUC1tzpJSG97Wy+Z/11ofCH/3i1s/i44nCXu4PJ
	0XTuRrnRsyZuQ02Xz55RqEKlKt08kYuMOm0onbquN1knC8aGy813bLiUacATiW55yhKcmmnOxW0
	8ts8xVzmBW55KrjlE+rXWjatWESxgLp57seFF3pysxv9zYxCTTQqYN/h9/MhS+zVbetDJlMwlhV
	LgRTA6ED8IXfhr2Yytw97NLuI0RC0fd1v88DuV7VTs3SgGfzphpEcxdirVnyao7uTrkUf8fUd2x
	us=
X-Received: by 2002:a05:6a00:909a:b0:857:7317:cff1 with SMTP id d2e1a72fcca58-8616a168525mr51310976b3a.18.1788944504640;
        Wed, 09 Sep 2026 02:01:44 -0700 (PDT)
Received: from localhost ([106.38.226.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-868d1e4ff97sm483493b3a.17.2026.09.09.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:44 -0700 (PDT)
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
Subject: [PATCH 7/7] landlock: use sb_for_each_inodes() when detaching a superblock
Date: Wed,  9 Sep 2026 17:01:12 +0800
Message-Id: <20260909090112.790006-8-sunjunchao@bytedance.com>
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

Convert hook_sb_delete() to sb_for_each_inodes() and release each
callback's inode reference outside s_inode_list_lock. This removes the
prev_inode reference used to preserve the walk position while retaining
the synchronization with release_inode() and the final wait for pending
inode releases.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 security/landlock/fs.c | 150 +++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 90 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 30aa6ce13590..3dcde8cbfb6a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1369,110 +1369,80 @@ static void hook_inode_free_security_rcu(void *inode_security)
 
 /* Super-block hooks */
 
-/*
- * Release the inodes used in a security policy.
- *
- * Cf. fsnotify_unmount_inodes() and evict_inodes()
- */
-static void hook_sb_delete(struct super_block *const sb)
+static int hook_sb_delete_inode_iter_cb(struct inode *inode, void *data)
 {
-	struct inode *inode, *prev_inode = NULL;
+	struct landlock_object *object;
+	struct super_block *sb = inode->i_sb;
 
-	if (!landlock_initialized)
-		return;
+	if (!atomic_read(&inode->i_count)) {
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		struct landlock_object *object;
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	if (!object) {
+		rcu_read_unlock();
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
+	/* Keeps a reference to this inode until the next loop walk. */
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
 
-		/* Only handles referenced inodes. */
-		if (!icount_read_once(inode))
-			continue;
+	/*
+	 * If there is no concurrent release_inode() ongoing, then we
+	 * are in charge of calling iput() on this inode, otherwise we
+	 * will just wait for it to finish.
+	 */
+	spin_lock(&object->lock);
+	if (object->underobj == inode) {
+		object->underobj = NULL;
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
 
 		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
+		 * Because object->underobj was not NULL,
+		 * release_inode() and get_inode_object() guarantee
+		 * that it is safe to reset
+		 * landlock_inode(inode)->object while it is not NULL.
+		 * It is therefore not necessary to lock inode->i_lock.
 		 */
-		spin_lock(&inode->i_lock);
+		rcu_assign_pointer(landlock_inode(inode)->object, NULL);
 		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
+		 * At this point, we own the ihold() reference that was
+		 * originally set up by get_inode_object() and the
+		 * __iget() reference that we just set in this loop
+		 * walk.  Therefore there are at least two references
+		 * on the inode.
 		 */
-		if (inode_state_read(inode) &
-		    (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
+		iput_not_last(inode);
+	} else {
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
+	}
 
-		rcu_read_lock();
-		object = rcu_dereference(landlock_inode(inode)->object);
-		if (!object) {
-			rcu_read_unlock();
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
 
-		/*
-		 * If there is no concurrent release_inode() ongoing, then we
-		 * are in charge of calling iput() on this inode, otherwise we
-		 * will just wait for it to finish.
-		 */
-		spin_lock(&object->lock);
-		if (object->underobj == inode) {
-			object->underobj = NULL;
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
+	return 0;
+}
 
-			/*
-			 * Because object->underobj was not NULL,
-			 * release_inode() and get_inode_object() guarantee
-			 * that it is safe to reset
-			 * landlock_inode(inode)->object while it is not NULL.
-			 * It is therefore not necessary to lock inode->i_lock.
-			 */
-			rcu_assign_pointer(landlock_inode(inode)->object, NULL);
-			/*
-			 * At this point, we own the ihold() reference that was
-			 * originally set up by get_inode_object() and the
-			 * __iget() reference that we just set in this loop
-			 * walk.  Therefore there are at least two references
-			 * on the inode.
-			 */
-			iput_not_last(inode);
-		} else {
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
-		}
+/*
+ * Release the inodes used in a security policy.
+ *
+ * Cf. fsnotify_unmount_inodes() and evict_inodes()
+ */
+static void hook_sb_delete(struct super_block *const sb)
+{
+	unsigned int flags = INODE_ITER_NORMAL;
 
-		if (prev_inode) {
-			/*
-			 * At this point, we still own the __iget() reference
-			 * that we just set in this loop walk.  Therefore we
-			 * can drop the list lock and know that the inode won't
-			 * disappear from under us until the next loop walk.
-			 */
-			spin_unlock(&sb->s_inode_list_lock);
-			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
-			 */
-			iput(prev_inode);
-			cond_resched();
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		prev_inode = inode;
-	}
-	spin_unlock(&sb->s_inode_list_lock);
+	if (!landlock_initialized)
+		return;
+
+	sb_for_each_inodes(sb, flags, hook_sb_delete_inode_iter_cb, NULL);
 
-	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
-- 
2.39.5

