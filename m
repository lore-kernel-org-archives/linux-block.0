Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BE3E763E
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055539; cv=none; b=oJhf+ADcWmesKHI12zyXuYl8OP6pTnq7nzNZuD/HtGMCJXimraKzFff9XH6UnqL+OdCOy/wV1d2iqMaaLi0M+eXXUjzUOuRARAXkJ6tNoFslz9MbfeAZzk3rQd82GRoXonPxuG40vCUYQZA+5Vxe2nDqD9XvNBcr8tqCeYZd7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055539; c=relaxed/simple;
	bh=uR6m+uWNfN2Yc6j/LIN6oH7sG1PGsCRjRis7NlxhRcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0vL4oRhm6QxhRImSBjqY1+HnI8aYZUoXeFH0gEXCCmUQjyvFU0nMvpexvCYOxo3pmGxgaBnAJYOXP7QN4fOh5uzD22HklMB/ureqU1/R0Ztj3DZfDB/AxLETt6UPkuEpwgvgWHMAAwJor8spmwYNSG8QI5fkLuCucsGdhfqes8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TZqRswby; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TZqRswby"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a8adb68d8bso3640902a91.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792055538; x=1792660338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUtQyvHt2ryB24p7DORNQLnVbQrgtD+YNOuJHRPPYD0=;
        b=TZqRswbyf3jRtEOV2cKOYJZ+cdgjW+P3kuIe9/h47Sl69s4aN3ZpeHP4ge6WmE0tri
         HtZGid+gtsbEk0cA3ha+PKeKmfDhjyFGdLnAM/cBo/ajMhgUpfKDNJPDacX3rklofHWq
         wcNtDhgrIzc1NZYh/Pwbdh9ZO2BSycbvETXh32w8bU3dXyZKrRI4mSYL4BildUhoK325
         0kIojAYvmNqoQNE5vxV8u+yxaYKZ4wLY2P/HliaYA8iCJxYlAj5QmqDacA9bu8JelvJP
         cf7Rn7sgfTqRxLxq+Bi2iPEMpkBgLYWFAK3FUxT4T+Cr0SFyGBmgLr7yneVyYVrnLS99
         4cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055538; x=1792660338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mUtQyvHt2ryB24p7DORNQLnVbQrgtD+YNOuJHRPPYD0=;
        b=Mrh3d49jK0ARkJvPFXTkXTCVmnWzxdxz00gamdNXycsHrcblJYzqhPvPyEtd6xIsHu
         rdJndee191JRL6JdeI2a3ETi3ec7PvAl1emtddHp94Xph3dL3/LirViD4NTxNu1XfkUx
         IxWEW4nXA61+gTIjlTZsBOObC3cJ+bL5gsbkuSJ2B0ntbDVjtEp7UG0x6eUP80oKsVjj
         scC8T7gqgqVJyUcc9mu2UzK47iOM4LT5K48kzhgWzG/G6jdSr/Tzi3vLTOP8YOMhYVDw
         QJ16NVHlz7gqIKT5dO0SE1AVWF4mCXRjqM3MvVJ9UZdinzXJrOfAVlOH7LoUQHKdlF0G
         koyQ==
X-Gm-Message-State: AFq9FYKjlYwXqwnHPfExaSKUNktXozyRLWHZPHXJo1Tzg4RiJjMIjgQe
	Tm5lReiQnQ9bsRtIdJgw/m3IZk0N2pTJPiiBNXCB2y5phu7arDb6eAu8iTYTzAyVNYgGZJAwTeV
	TYEkj
X-Gm-Gg: AYBFou2yY0Lbq5+mp7H17uZqNtJUXadDRd498Sfu32BFKcTz8pV5chmbv5UJXefs4Hi
	sZoSigBf2WFyupl7qxaXEe9SKz7oOnssX/ba/WyqZIcdZNJ9Iu1t2OMdB72T9J3bdlfR+nqBhkb
	ALrjjTRCURxMrH1QgPOTjI2jeJEp9u3pX0tXeKTNiKw6FBzHE/bwQlsAs7DwrmwcyiJDBoDR2tc
	rxAAvvIA+vdiKsmBXrlir5VdKKzRPjU/y1luvMjPfh7oXfDzr68OuRfxkD9zoN/lfRl4XV516oc
	X9hwRqCjwQZpmX+LX0vEES9izrECFTYUoEPDOyD1rY8QkmPgMThXfY7vturBR+iLNKS/5eR8r7N
	jhyPZy9IK80pfboXALoEothR1i2OA3mdVW3NkSXw++NpREgIvRTAazNo8e0Cw5EyUa1Raz1nSoJ
	2vM4AhxBbXZ0GyVoC6hBt9SjljXgEodsFZEGHWnXixeytcDgyZGoUTWEJWF1XYBrkw1amLkHlw
X-Received: by 2002:a17:90b:390d:b0:3ac:85be:cd52 with SMTP id 98e67ed59e1d1-3ac85bed101mr3079120a91.59.1792055536305;
        Thu, 15 Oct 2026 02:12:16 -0700 (PDT)
Received: from localhost ([106.38.226.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e821csm3386419a91.8.2026.10.15.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:12:15 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org
Cc: jack@suse.cz,
	axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	djwong@kernel.org
Subject: [PATCH 2/2] block: take the inode lock for buffered write fallback
Date: Thu, 15 Oct 2026 17:11:05 +0800
Message-Id: <20261015091105.1315605-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261015091105.1315605-1-sunjunchao@bytedance.com>
References: <20261015091105.1315605-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c0e473a0d226 ("block: fix race between set_blocksize and read
paths") added shared inode locking around ordinary buffered writes,
but missed the direct-I/O fallback path.

Move the lock into blkdev_buffered_write() so both paths serialize
with set_blocksize().

Also correct the comment claiming that this path takes invalidate_lock;
it only takes i_rwsem.

Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/fops.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 982a713b4c27..74e7a0713d1a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -709,12 +709,22 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct inode *inode = bdev_file_inode(iocb->ki_filp);
+	ssize_t ret;
+
 	/* Buffered fallback waits for writeback, which NOWAIT cannot allow. */
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EAGAIN;
 
-	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
-			NULL);
+	/*
+	 * Take i_rwsem to avoid racing with set_blocksize() changing
+	 * i_blkbits/folio order and truncating the page cache.
+	 */
+	inode_lock_shared(inode);
+	ret = iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
+					NULL);
+	inode_unlock_shared(inode);
+	return ret;
 }
 
 /*
@@ -773,14 +783,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
-		/*
-		 * Take i_rwsem and invalidate_lock to avoid racing with
-		 * set_blocksize changing i_blkbits/folio order and punching
-		 * out the pagecache.
-		 */
-		inode_lock_shared(bd_inode);
 		ret = blkdev_buffered_write(iocb, from);
-		inode_unlock_shared(bd_inode);
 	}
 
 	if (ret > 0)
-- 
2.39.5

