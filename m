Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9715278E
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846588; cv=none; b=C4NRD6F7qoOw0Yv9TFzyRNHiSb4OSwhjqfwArGrN/2G9Q5XUVW3vYDbgoUo1JjcLjDPJzuZkKO3Xsafix2h//axRvo3WrpSgV2kN7UoIwSR+5teZHYhBCXjcn7AcwQMRj4ReBh20vOxQIJkDgLvElwDPdhTLBse7ni81xuCxS7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846588; c=relaxed/simple;
	bh=douu/OH3JOBJbcNCPjglBlefsScRwWQQRJejY8Y8034=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnLWb8iQnw7eAPVyryMTwvAD5YdRsdciFM7jSDMgBNXXguCgJM00v+18lzp2+I2qbqWPZMZpyWwrr81V+gQxY0GtYEdxVWsLDF9ZpIVH7o7vwDIkcadkiUa70Qxq1vIfCTm0/SuOHiX/3Kv+WOvX7qCk1UTbVPy+zrnnTEYWRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGx+iQR+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGx+iQR+"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f898fso18531265ad.3
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846587; x=1759451387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mZBfvjKH+a+qnWQMQA8rEgrcPJHuMhz3ff1QpWHtCw=;
        b=nGx+iQR+qyqgjlVxNjOWNBRQBARpkHQDu8nvzKY8sI4/iGRIysq+WxDBaiUtcCRVZQ
         sn/jmfQK3uI3YTQNhlEi1C6qxr6rIeQBi6HZcldgaGdDp95lKGda90OXEUEtKsy9u9sw
         jg2FoVq4NIM4qt4JsV7zE7hdEC59+KQWnoZdKunCOHLnwaeDB1xzVAuFjVeNruq/3Woc
         zBzEtY50E5UCd3GgxxOnlyhduMwhrZJI5Bx9HrhWkz/sLecZg0hGQ9dGryc8w32QRLqo
         e4dpF89L6vwq3Qdafy1FyNFRCIC5QtK/EuGNkYeSs3A5YhEJFefmSwE1wJlGS5/iBvLY
         MivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846587; x=1759451387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mZBfvjKH+a+qnWQMQA8rEgrcPJHuMhz3ff1QpWHtCw=;
        b=d9sAKM3NHz5yKnGDJPxtzQissidpFZfiRjqbDUTPZhs4PDWXur4GW9N6X74D4u+lkr
         5PGsPzM0TVniHeunBx2WFOLAcItIAYV01tgf5dChvHmCXqOmVSyjggJspsVsfsBKgGOU
         fFVL8UnY3g+/wHopeJNece9LMGUs6OFosX82Ty3bnq8574pTw3z+QLlWIkerbNRU5BPF
         ZXbHi8QfmBeE5fPBvSZmvwUkCK8dlve4yHur90XNMMZKHfRHDK79Xmg//FPU8iZd8sZg
         ywxqzDcksg5Dn+egoaZbYEpZcsKjWDXBx4rw8PNsJBvTf3oVjMobzpY/umoQoT9TSmvG
         YLGw==
X-Forwarded-Encrypted: i=1; AJvYcCUUEtbHilQMSnYH2AWV6l2NfgSvFfUGSnH+NJElt8Q/QwpAQsgtL89sOhhSZuzvdgGKCxYv6BH8wm8HcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YznhbJmw+QeFrePjhhQmqPh2WmTvW0WD7yFCUuZAdNDFttyB2od
	OIU/AK71dejAFAxjzkL8l/kVIRf9b0cv+R7gtlyJkcnCwE+NTkiYTMWN
X-Gm-Gg: ASbGncsTrX5Y2+H2s6NxFd8pdPCqp5uSICceQNm5Ur0oSFOcQFnOt14iLKxYPTSk8Vv
	ik6BFLTCaZXPKNlNG7v8YBy1fvBTN0RrkXjX1kN9W5V8zBjKX/2fDNaThOeHDtchs9b/s0njkDh
	RhB8KNaQx5z6RnGLKkXbWMxGqZi7Qlzc8uSe9QwyNS2TPpx7mz0eJ1FbSuaNtzx8dHOJLh9cejh
	Yets0MgmVhu4mZ/C+FLhoVn9+qZhQ7YWaXn3n8ijvwh8WOZOpoqA020FARLk7NLa9VMeLtzj+BF
	+jj3dyM9iIGmV5x4Bndi3VqoO6TclFgnu4JSDhv65ETUe3Hw/xBziP/AfwxW3srk8C8uSdEuSel
	/AzUInHU4Qe4KeiF+ArwqjWkKnxWGa7exKbAZFk7czZ4ZQZP8JFaU5cWgZdI=
X-Google-Smtp-Source: AGHT+IEMH5lJf7DHsnuKCyqZaYo7vRM2tcWdcLIid+23yMPPfujKM5L9NhzST+ddt/eFTEXbRRQDiA==
X-Received: by 2002:a17:903:32c2:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-27ed49dd7d2mr60037595ad.16.1758846586702;
        Thu, 25 Sep 2025 17:29:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6716081sm36552055ad.53.2025.09.25.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 14/14] fuse: remove fc->blkbits workaround for partial writes
Date: Thu, 25 Sep 2025 17:26:09 -0700
Message-ID: <20250926002609.1302233-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fuse is integrated with iomap for read/readahead, we can remove
the workaround that was added in commit bd24d2108e9c ("fuse: fix fuseblk
i_blkbits for iomap partial writes"), which was previously needed to
avoid a race condition where an iomap partial write may be overwritten
by a read if blocksize < PAGE_SIZE. Now that fuse does iomap
read/readahead, this is protected against since there is granular
uptodate tracking of blocks, which means this workaround can be removed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/fuse_i.h |  8 --------
 fs/fuse/inode.c  | 13 +------------
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f..ebee7e0b1cd3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (attr->blksize != 0)
 		blkbits = ilog2(attr->blksize);
 	else
-		blkbits = fc->blkbits;
+		blkbits = inode->i_sb->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cc428d04be3e..1647eb7ca6fa 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -975,14 +975,6 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
-
-	/*
-	 * This is a workaround until fuse uses iomap for reads.
-	 * For fuseblk servers, this represents the blocksize passed in at
-	 * mount time and for regular fuse servers, this is equivalent to
-	 * inode->i_blkbits.
-	 */
-	u8 blkbits;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7485a41af892..a1b9e8587155 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	if (attr->blksize)
 		fi->cached_i_blkbits = ilog2(attr->blksize);
 	else
-		fi->cached_i_blkbits = fc->blkbits;
+		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
 
 	/*
 	 * Don't set the sticky bit in i_mode, unless we want the VFS
@@ -1810,21 +1810,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		err = -EINVAL;
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
-		/*
-		 * This is a workaround until fuse hooks into iomap for reads.
-		 * Use PAGE_SIZE for the blocksize else if the writeback cache
-		 * is enabled, buffered writes go through iomap and a read may
-		 * overwrite partially written data if blocksize < PAGE_SIZE
-		 */
-		fc->blkbits = sb->s_blocksize_bits;
-		if (ctx->blksize != PAGE_SIZE &&
-		    !sb_set_blocksize(sb, PAGE_SIZE))
-			goto err;
 #endif
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
-		fc->blkbits = sb->s_blocksize_bits;
 	}
 
 	sb->s_subtype = ctx->subtype;
-- 
2.47.3

