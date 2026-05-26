Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F2355F4E;
	Tue, 26 May 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785830; cv=none; b=hrmPxQm9U2ku4Hhu+Q+fTCl/h4nlGvOs//TbW/dtU2p3RiTga5HdHPDzp4Zb3FHc06+ly+F7+cxUDsDxzYMhlfhvUm6oDj0wvpDNVHaE3lcJlxvPzZem9l8OIIxKCN8WTlULgM0DrVUoqqs8bjifE612QtOznCeku6Nbrf/F7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785830; c=relaxed/simple;
	bh=4xRmiCghoaumjlLjoTcpUj2bHImb/nKVfXIo3hgsY1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0+BsYlG2Afr+mAvYtgGRXe+Xzd6qpgWN4AOZQj6qpTFe6wM6BEvb74n5AoyJDHSiGNewdGbjdiSX8Hh9UsbG1lnmLmE9LKH4zE8gEIC2kfJSCMP0F8O1a9WRraQ2ovxhcU6dwDEgRoagpcTPQmiAHW1RCVRneR+biu1Rfae1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y6R0riIJ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y6R0riIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=c8
	poVyZ3dw/tWL2WhpOonhjWBenScgcZCXUDf3lSl9E=; b=Y6R0riIJ9fucK87rDc
	fJXO2opgSY8kMA+uRaPbl49GGeb+bySspnge/8inB2bDr5B2RYZ7cj4z/7eP4cS5
	dSRpQI6uIM62GtAiKc7LHoLhqOT53lNHbw6rQWQqxRN+KFpgl8vua0DidCIfL0uN
	JdDHzn5X3NmFQVXqI3jVGR/+M=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAH9vBQYBVqOZNlGQ--.57606S2;
	Tue, 26 May 2026 16:56:50 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	l1138897701@163.com
Subject: [PATCH 1/2] block: Use struct_size() helper in kmalloc()
Date: Tue, 26 May 2026 16:56:48 +0800
Message-Id: <20260526085648.1784798-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAH9vBQYBVqOZNlGQ--.57606S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw18tw4DZFyUXw43XF4DCFg_yoW3uwc_Aw
	1qvrn7Cr1kAF4fZrnFkFW8Jryv9w4DJr4Fgr9xtr9xWFyUJ3Z3Ca4UXr1fXF95CryfGrZx
	Z3yDZr9IqFnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUSfOUUUUUU==
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+RIMUGoVYFLchAAA3i

From: luoqing <luoqing@kylinos.cn>

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Signed-off-by: luoqing <luoqing@kylinos.cn>
---
 block/bio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d80d5d26804e..397fc3bc0ede 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -657,8 +657,7 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 
 	if (nr_vecs > BIO_MAX_INLINE_VECS)
 		return NULL;
-	return kmalloc(sizeof(*bio) + nr_vecs * sizeof(struct bio_vec),
-			gfp_mask);
+	return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
 }
 EXPORT_SYMBOL(bio_kmalloc);
 
-- 
2.25.1

