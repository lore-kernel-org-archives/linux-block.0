Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF5309EFC
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592854; cv=none; b=e5QPKvDuRvhduxITIp1rt/z0R4F2YszZEbBx7JC0DnIretGT/lho3uPfrEUv159wcnZtDKrDwpFKUx9V7CTgzrQaQupUi/2MKJdPQ2w9qUaQ9w+FlJYQXTavVrrPdiKn29+W9gTBW8SZ5bA5FvrlsRxKqYyeQLNN1Ls1QjqLB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592854; c=relaxed/simple;
	bh=T9ZEPeTOwOg7DDlabqfPRzzHhZv1uNCtoeRqcmjUpvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ABPY9SAaAE+1dC6+T/UnMmvwS6u0gKQir0hN/bOpcBZDSyLL1v5MzVjh2oyFQb5eMGwj5JERKtelHWMGaZlGKrBjkOglz768li3e5HVB7t8lbF9fvRjO7uePH+DSSzs5qrq6AU/MMILHqW2xETE2uxt9lc32TLQLzEwUEZoP6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mf9oIj+j; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mf9oIj+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vF
	ZWE+jPeRStF+sfBHlhEeHRmWeQ2ti12ZT5U1tWIxQ=; b=mf9oIj+j58PmyvziD5
	0wKjkc5jiYcGeID8kNKDT5OfF5Ls6fvfWQ7mlH1FdKHtCZvGK6LGqExsqy5bf4+X
	VZE4dhkVWMXXLej2AvNJ9HYPT6O5RfC2hUMF7eq6tDpExgpy42hD/U/+yFg4BrSL
	XpBcgrQ2fcnGMKhZ237uIfhkc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wA3MbiznqdpLxvgNw--.27626S2;
	Wed, 04 Mar 2026 10:53:40 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	linux-block@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] block: use __bio_add_page in bio_copy_kern
Date: Wed,  4 Mar 2026 10:53:35 +0800
Message-Id: <20260304025335.225965-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3MbiznqdpLxvgNw--.27626S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XryfAF4ruFW8Wr4fWF1UGFg_yoW3twb_WF
	y8t3WkG3Z5GF1Y9F4Yka13JFy8t3ZruFy8KayqqrZ3Jas5JFsruF1rArnFvFW7JFZ29a47
	KwsrJFnrC34jvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjJ5rDUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwRQZqWmnnrRlowAA3H

Since the bio is allocated with the exact number of pages needed via
blk_rq_map_bio_alloc(), and the loop iterates exactly that many times,
bio_add_page() cannot fail due to insufficient space.  Switch to
__bio_add_page() and remove the dead error handling code.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

diff --git a/block/blk-map.c b/block/blk-map.c
index 53bdd100aa4b..768549f19f97 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -398,8 +398,7 @@ static struct bio *bio_copy_kern(struct request *rq, void *data, unsigned int le
 		if (op_is_write(op))
 			memcpy(page_address(page), p, bytes);
 
-		if (bio_add_page(bio, page, bytes, 0) < bytes)
-			break;
+		__bio_add_page(bio, page, bytes, 0);
 
 		len -= bytes;
 		p += bytes;
-- 
2.25.1

