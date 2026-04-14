Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C8392C28
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154701; cv=none; b=V7oMq1xbzR4DEDyzTO8XUKQWt1o09sV1iSfpQHa5JsyfWKCoXNeq1tWX2h61vsN7rI6YNuqG2vZT2KFjU/sYBcCfQimck9cfggCM/wCsh+vyq8lWMsh//RmP6kM/kRwz7HWUpoEIjVDRirJIHk3i2wu0EJkCvUZ8cjsSSrPw4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154701; c=relaxed/simple;
	bh=B52p1NzR21B7Lyk8URKYUNBIEKIrk8nipnX1hlCGfY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOy9MftLsDNU4+HVTqsepCFe8sLnNZ58pBGhTMBLfHbzqEgICmfs3/Lt0xxmBH7LQfFR4ZfJc5bac16j4sud+BMzPpg/DMYxXI3yomUgvea281rLq7dkrTjYb6DIb+F4VbKKK11eL6SCl9pO4XF0qhHSYLU+Gqx+HV4l/HsVmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pLg9BBtA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLg9BBtA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Jf4UI0q4DtxicLVwWANgBjBU479NXMZUvPihf55Znsk=; b=pLg9BBtALYey8b5D5V8r+eiF/+
	9tcKeZlU6ZCG/XvCg4ksBueqRaxiAFBRHVnL41ZW64gQ3Knm4KRss04I05ByS23aYOWR9xjZyDJMe
	QqIx/ub/B2MRn1Q9RuDD875AIWZNFsdsM+YGg4212zNYVSRi4h1uQ/WMCUYQruCcQ8V55DxLgPQUc
	ylpWTnYN1uEYlqvs5he0LPByvLKUKPFKldFK8M6K5wud0V9LOUuqS2aqUED9JzlE0rLe2lo+NHOBQ
	buJMNb9X683g1zLdF6rumkb1YrkciK6rS9FVXeOhg1eEnC8iL7qwffb9zWbYKVbtePocmfoJAR7Tp
	OtqghI0w==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYyR-0000000Gxiw-35l3;
	Tue, 14 Apr 2026 08:18:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/6] zloop: use vfs_truncate
Date: Tue, 14 Apr 2026 10:17:47 +0200
Message-ID: <20260414081811.549755-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414081811.549755-1-hch@lst.de>
References: <20260414081811.549755-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

While vfs_truncate does various extra checks that we don't really need,
it is always better to use a VFS helper rather than open coding the
logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 672948d3653e..fc54480ed62d 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1363,20 +1363,6 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	return ret;
 }
 
-static void zloop_truncate(struct file *file, loff_t pos)
-{
-	struct mnt_idmap *idmap = file_mnt_idmap(file);
-	struct dentry *dentry = file_dentry(file);
-	struct iattr newattrs;
-
-	newattrs.ia_size = pos;
-	newattrs.ia_valid = ATTR_SIZE;
-
-	inode_lock(dentry->d_inode);
-	notify_change(idmap, dentry, &newattrs, NULL);
-	inode_unlock(dentry->d_inode);
-}
-
 static void zloop_forget_cache(struct zloop_device *zlo)
 {
 	unsigned int i;
@@ -1411,7 +1397,8 @@ static void zloop_forget_cache(struct zloop_device *zlo)
 		if (WARN_ON_ONCE(old_wp == ULLONG_MAX))
 			continue;
 
-		zloop_truncate(file, (old_wp - zone->start) << SECTOR_SHIFT);
+		vfs_truncate(&file->f_path,
+			(old_wp - zone->start) << SECTOR_SHIFT);
 	}
 }
 
-- 
2.53.0

