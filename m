Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E1237163
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059203; cv=none; b=qMRDvHbTpaXJIQrA43UwWsTb622BdJ6ufflsSU59b+P5x+555rx8VAPGDnCXhIWGcVdrE5c6867wwAiK0P/X6zoVm3aquMz6KGGKX7+9gVvzyIglKUY9vCBHRLo9/1xH/Nyg80Ib7nBG1jc+wp+NPLkxiV0UuuHA9CPa3yyeZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059203; c=relaxed/simple;
	bh=qqMh5neXihNma1bqqODHksMYAs2CpreAk4attEWQEuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c50JfGB2H+tOZWOJmyGQIOT9gCP5s1C6jlh9TZKouHcVfXLudTqItL9miHBveNsQwD2MpLR4qX/9S+V195cMK0ISN1wplQ3ziiCIMq/8cQKjeZzXug44t0noZzG4ywk8IBna/NSyQpaarqew3fbFdjyh5BXEfQprRwEbYgMitYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCujioF7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCujioF7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so3823571a91.2
        for <linux-block@vger.kernel.org>; Thu, 09 Oct 2025 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059200; x=1760664000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5NnfUqcWLVy127Caashokc+Ty+gAwqDLPiFwXfeq7Q=;
        b=JCujioF7S9U5iO7gpOnPbRaxbTP2IE8DwG4AX+rOh/96UgsT7HrsceM/YFotKvUi+q
         PnpzIVmruDz2xzD3PycsfrLeXf0z+765Uqtk4qkoDtWViGRbQKv3g5W6ZyAVpT26s9SA
         HhP1Y03x8CIPkxchqDaV7/GFVq4J/seQV6KgUuurfp04iI1+PS2A9cZr9gKIz0QKneRY
         sA2JbuENEPA/4ZrNMzS1wOeUMfdF/xvYW+zPbnWM0PZWnTtRmlfWdxfOa9jTMrsenpF0
         lXIlyNPPd78JBtOQl3tYPYYVB/Ney+aBbsx7zGxfMPqcS7LLrql8It6mGRAKCiknS2h4
         /XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059200; x=1760664000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5NnfUqcWLVy127Caashokc+Ty+gAwqDLPiFwXfeq7Q=;
        b=N+TjFwSgLxuEAt9lGQdYFrGGB5ilNRaDr8YMRXNL4BScPo3bQLOBkNudHcUwDVOa+J
         E0VIJcFSQBkMUB7CqD56JJaFYCFBiDUSTsIVbGccSM6OOv/TBhCNeMsLHGnMp3CzPl/j
         wv48G5ZWZEarlqO4nr9/oY3x2fLv1+FFAdbQNGQhGUIjCk/xfhXQcEw/kjKu3nBVcRf1
         UgE22xOv/XNKdCdw0tifYR6VDfeJHJpvN++gawgtIPFz98obIxPBTiiFllak9WmiT/FY
         /9kFi114hfL3oRM9s9n1JrUp6FW5W1FJ9yywLhfd3C7KCtdKBf4Ft71dTXtX6VxxNFOv
         qgzw==
X-Forwarded-Encrypted: i=1; AJvYcCXhK7zy+dUxG3sIkQP/DWNvC+JQ8l4/XS/MZh0alavv+q+7CYSci9gM4v2CrN/vuLqQ+QbjWb5j6Pye6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZcSptt30+aYY00I8EtObL/YaVD9T6M7JJKb+ZZlKyzhPqQPx
	rEfEje2R+jV5vuU6/5nhO2VJbPmXVQEFWp2fpVQjlhlygO3EwCOBRUxJNDmJSYBf4JLFK/FkdXI
	hT+y64Q==
X-Google-Smtp-Source: AGHT+IGUtqiuXgYovxJ9pqzet+oIg30O6HUu5Ov7PiPDZ2bQlxmJF3pLfeJkqhVr7qj3OayvX9LqFKSZH5I=
X-Received: from pjbpb8.prod.google.com ([2002:a17:90b:3c08:b0:33b:51fe:1a95])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3908:b0:335:21bf:3b99
 with SMTP id 98e67ed59e1d1-33b5139a3c6mr12252369a91.32.1760059200475; Thu, 09
 Oct 2025 18:20:00 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:45 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-3-surenb@google.com>
Subject: [PATCH 2/8] mm/cleancache: add cleancache LRU for folio aging
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

Once all folios in the cleancache are used to store data from previously
evicted folios, no more data can be stored there. To avoid that situation
we can drop older data and make space for new one.
Add an LRU for cleancache folios to reclaim the oldest folio when
cleancache is full and we need to store a new folio.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 mm/cleancache.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/mm/cleancache.c b/mm/cleancache.c
index 0023962de024..73a8b2655def 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -19,6 +19,13 @@
  *
  *	ccinode->folios.xa_lock
  *		pool->lock
+ *
+ *	ccinode->folios.xa_lock
+ *		lru_lock
+ *
+ *	ccinode->folios.xa_lock
+ *		lru_lock
+ *			pool->lock
  */
 
 #define INODE_HASH_BITS		6
@@ -60,6 +67,8 @@ static struct kmem_cache *slab_inode; /* cleancache_inode slab */
 static struct cleancache_pool pools[CLEANCACHE_MAX_POOLS];
 static atomic_t nr_pools = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(pools_lock); /* protects pools */
+static LIST_HEAD(cleancache_lru);
+static DEFINE_SPINLOCK(lru_lock); /* protects cleancache_lru */
 
 /*
  * Folio attributes:
@@ -130,6 +139,7 @@ static inline bool is_folio_attached(struct folio *folio)
 /*
  * Folio pool helpers.
  *	Only detached folios are stored in the pool->folio_list.
+ *	Once a folio gets attached, it's placed on the cleancache LRU list.
  *
  * Locking:
  *	pool->folio_list is accessed under pool->lock.
@@ -181,6 +191,32 @@ static struct folio *pick_folio_from_any_pool(void)
 	return folio;
 }
 
+/* Folio LRU helpers. Only attached folios are stored in the cleancache_lru. */
+static void add_folio_to_lru(struct folio *folio)
+{
+	VM_BUG_ON(!list_empty(&folio->lru));
+
+	spin_lock(&lru_lock);
+	list_add(&folio->lru, &cleancache_lru);
+	spin_unlock(&lru_lock);
+}
+
+static void rotate_lru_folio(struct folio *folio)
+{
+	spin_lock(&lru_lock);
+	if (!list_empty(&folio->lru))
+		list_move(&folio->lru, &cleancache_lru);
+	spin_unlock(&lru_lock);
+}
+
+static void delete_folio_from_lru(struct folio *folio)
+{
+	spin_lock(&lru_lock);
+	if (!list_empty(&folio->lru))
+		list_del_init(&folio->lru);
+	spin_unlock(&lru_lock);
+}
+
 /* FS helpers */
 static struct cleancache_fs *get_fs(int fs_id)
 {
@@ -316,6 +352,7 @@ static void erase_folio_from_inode(struct cleancache_inode *ccinode,
 
 	removed = __xa_erase(&ccinode->folios, offset);
 	VM_BUG_ON(!removed);
+	delete_folio_from_lru(folio);
 	remove_inode_if_empty(ccinode);
 }
 
@@ -413,6 +450,48 @@ static struct cleancache_inode *add_and_get_inode(struct cleancache_fs *fs,
 	return ccinode;
 }
 
+static struct folio *reclaim_folio_from_lru(void)
+{
+	struct cleancache_inode *ccinode;
+	unsigned long offset;
+	struct folio *folio;
+
+again:
+	spin_lock(&lru_lock);
+	if (list_empty(&cleancache_lru)) {
+		spin_unlock(&lru_lock);
+		return NULL;
+	}
+	ccinode = NULL;
+	/* Get the ccinode of the folio at the LRU tail */
+	list_for_each_entry_reverse(folio, &cleancache_lru, lru) {
+		struct cleancache_pool *pool = folio_pool(folio);
+
+		/* Find and get ccinode */
+		spin_lock(&pool->lock);
+		folio_attachment(folio, &ccinode, &offset);
+		if (ccinode && !get_inode(ccinode))
+			ccinode = NULL;
+		spin_unlock(&pool->lock);
+		if (ccinode)
+			break;
+	}
+	spin_unlock(&lru_lock);
+
+	if (!ccinode)
+		return NULL; /* No ccinode to reclaim */
+
+	if (!isolate_folio_from_inode(ccinode, offset, folio)) {
+		/* Retry if the folio got erased from the ccinode */
+		put_inode(ccinode);
+		goto again;
+	}
+
+	put_inode(ccinode);
+
+	return folio;
+}
+
 static void copy_folio_content(struct folio *from, struct folio *to)
 {
 	void *src = kmap_local_folio(from, 0);
@@ -468,14 +547,19 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			move_folio_from_inode_to_pool(ccinode, offset, stored_folio);
 			goto out_unlock;
 		}
+		rotate_lru_folio(stored_folio);
 	} else {
 		if (!workingset)
 			goto out_unlock;
 
 		stored_folio = pick_folio_from_any_pool();
 		if (!stored_folio) {
-			/* No free folios, TODO: try reclaiming */
-			goto out_unlock;
+			/* No free folios, try reclaiming */
+			xa_unlock(&ccinode->folios);
+			stored_folio = reclaim_folio_from_lru();
+			xa_lock(&ccinode->folios);
+			if (!stored_folio)
+				goto out_unlock;
 		}
 
 		if (!store_folio_in_inode(ccinode, offset, stored_folio)) {
@@ -487,6 +571,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			spin_unlock(&pool->lock);
 			goto out_unlock;
 		}
+		add_folio_to_lru(stored_folio);
 	}
 	copy_folio_content(folio, stored_folio);
 
@@ -516,6 +601,7 @@ static bool load_from_inode(struct cleancache_fs *fs,
 	xa_lock(&ccinode->folios);
 	stored_folio = xa_load(&ccinode->folios, offset);
 	if (stored_folio) {
+		rotate_lru_folio(stored_folio);
 		copy_folio_content(stored_folio, folio);
 		ret = true;
 	}
-- 
2.51.0.740.g6adb054d12-goog

