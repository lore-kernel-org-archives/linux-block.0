Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CC20468E
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667401; cv=none; b=kin2a3l3IhvzB3CvdeQRnTw/Cjocgcby0QskJbbga1sub1Kp4g5BMJmsOOp8aP2/PHpuNzpDodynS38S2fafG+C36ET0G3/jeg5XFsh7RE7lS6LzcsbdRWF0AawUyzx7L2PbdIUCIhLgw0tQy9YCl3eWlQ2nO6t2UKLu5uP0UqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667401; c=relaxed/simple;
	bh=WngXNw5TLT9ESIezQBibG29lop1zmpfZuZPivaAG8mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cGMBjM88mFyv49isnMen3odqsroIDOCVoKpL+gwLxyFbYK+Chty8P57tDb8sN/+PbF2GiIGzvlCAvS/TLchnjGjLDMAausacrfQ01Fb/qn781HrpCyrdl4BuAQmEozg+FT/61uG7LAMDqQAmCnn++fHhqFd58l1Zx0W3C5mwlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K2EYBjWL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K2EYBjWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9z
	0wbNwD0eUQevy49eIwK9wlGS/cBOv+mCc/PwjdXBw=; b=K2EYBjWLUiOjZxk+ii
	HxCTD1T5DJ65I+orPQCaO+NSUTeJzlIHbqusaYgakrIwOxgkii6ibUSulA/4RoeM
	53qZXhLk8rSVLJMxdFJ1Br5YxF7wei9BYKxJven5+r9LImU1rlW1laov6fYZo+OT
	+VjjQ3oJxwIjZ4boVQw9rY1hU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnuOC0dlxpESiPKQ--.87S2;
	Tue, 06 Jan 2026 10:43:03 +0800 (CST)
From: Yang Xiuwei <yangxiuwei2025@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] block: remove redundant kill_bdev() call in set_blocksize()
Date: Tue,  6 Jan 2026 10:42:57 +0800
Message-Id: <20260106024257.144974-1-yangxiuwei2025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnuOC0dlxpESiPKQ--.87S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1fKrWUur4DWryxGw4kWFg_yoWxKrc_WF
	W09F48AF43Zrs8Cr43CF13Z3sYyw4q9r1S9rZ3ArWxX3W3tF4kZ3y8Ww1jyrn8GFZ7Was0
	kw4UWrs8Xr1rKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR9Yw5UUUUU==
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6hc8zGlcdrdcWgAA3-

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

The second kill_bdev() call in set_blocksize() is redundant as the first
call already clears all buffers and pagecache, and locks prevent new
pagecache creation between the calls.

Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

diff --git a/block/bdev.c b/block/bdev.c
index b8fbb9576110..ed022f8c48c7 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -208,7 +208,6 @@ int set_blocksize(struct file *file, int size)
 
 		inode->i_blkbits = blksize_bits(size);
 		mapping_set_folio_min_order(inode->i_mapping, get_order(size));
-		kill_bdev(bdev);
 		filemap_invalidate_unlock(inode->i_mapping);
 		inode_unlock(inode);
 	}
-- 
2.25.1

