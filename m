Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D05274B58;
	Fri,  6 Mar 2026 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784071; cv=none; b=EKxR96OVp7SUod7vEaDvptQqKrR3MqYGZW+TZJATbuVQGv3rs3QHdDV2GgZbfdMUesKjxexQoeCbFpAmaSIIVZusx7CNkIavRr4jg5aEPhSSpqovEahsFrF3H9tYBxcR19r08mtP4STe21bh837hgoZ4aE+2+4luqVL11Tl/5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784071; c=relaxed/simple;
	bh=4xRmiCghoaumjlLjoTcpUj2bHImb/nKVfXIo3hgsY1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aeBJNjc2D5d5u57M+Q6ptreJnOl41rGAKE0eDErOk5+ecSUn80gUNCHk+t+FlWRmeEEMzgwDplvXy7jVFur5Jgmolq/NXe33C5+VMesw6UHeagFjDwHvmeraNykugLX5sL9s5gZ8gDYhiWoTIabM/f+OUWerL29iYdwS3nEeg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lMZrVnju; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lMZrVnju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=c8
	poVyZ3dw/tWL2WhpOonhjWBenScgcZCXUDf3lSl9E=; b=lMZrVnju6R/o7yv16r
	SLNnt7MMhgB/nyHCoF3foJp1icn5iyQuUVsjKI3qu7wQeUiauuC9RWY2Zz2FYU8l
	MYt3OE0LcygRm3TGm9KmcQE4071CtEz6KgBWzzaTYHICOP1WwbHCmAVqy/PP5MnO
	5QbDyuxRp4x+cAMwDAK5+v3v8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnlZe4iappqaFpPA--.7072S2;
	Fri, 06 Mar 2026 16:00:58 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] block: Use struct_size() helper in kmalloc()
Date: Fri,  6 Mar 2026 16:00:56 +0800
Message-Id: <20260306080056.1262324-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnlZe4iappqaFpPA--.7072S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw18tw4DZFyUXw43XF4DCFg_yoW3uwc_Aw
	1qvrn7Cr1kAF4fZrnFkFW8Jryv9w4DJr4Fgr9xtr9xWFyUJ3Z3Ca4UXr1fXF95CryfGrZx
	Z3yDZr9IqFnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRD73tUUUUU==
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+RqV2Wmqibp0CQAA3i

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

