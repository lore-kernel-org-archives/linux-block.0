Received: from out198-14.us.a.mail.aliyun.com (out198-14.us.a.mail.aliyun.com [47.90.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706CC30ACF2;
	Fri, 11 Sep 2026 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789101629; cv=none; b=O+D7RJkbmw8z1PUJ4p4cUluExUjE3Uw/nBcy5M7Q9VeQAzOYxTgbXNNzvnU1hz1f9AV5NaB28AwRV1Pc/NBaCKCp1DgTdUiodVcwcRI265+yIJtgbgCFgljsb3KhqXPzq4c1vIXwJQQ6IjPOJvgmaf9EMSxK4Z8bIbZy2/mYNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789101629; c=relaxed/simple;
	bh=BZbB/VZN9Yi/s1+aehuGKKl4t3/hYRDUQ1herdf8QD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+jnBzMLFkXv+9rBuLNdxMY+E47vt+FOmLOWZfV1D0GlF7vnPM9FhHkaGpforCJQfA6/+5gxtGYBeBxtEZ2+PKE3nNTm/JD/4Z5+sXE/epVKLYoxiVgv0NF8YKYXZ51NAFcloX0HHdx1Ta3S0f3cT6qB96OK4O3nFK+V4zC8B9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=AzYPr2+t; arc=none smtp.client-ip=47.90.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="AzYPr2+t"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789101607; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BugIdu0+dQDQdK5XdwssyCF7bk78JFbALqZ6yxi0/Ds=;
	b=AzYPr2+tVE9SeP0xCMItk4sj47A4xU3/R/HIWh7UriUtLXmj+u8u3dl2x1N4PzUMTAr9H9A01WNRdgmC+9D2jFWRnoRFLyvqq+htZcdMacURe8ShJ909Y7lipL0SlGk1SybYxiXxzHXSG6jLjT9KnJveUYSSDUB7CDC2SGExjh0=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07792894|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00467262-0.00021972-0.995108;FP=3267047091946991308|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jAvL4VN_1789101607;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jAvL4VN_1789101607 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Sep 2026 12:40:07 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH] partitions: atari: fix overflow in the partition sanity check
Date: Fri, 11 Sep 2026 12:40:06 +0800
Message-ID: <20260911044006.1436211-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VALID_PARTITION() adds the 32-bit start and size fields before
comparing the sum against the disk size, so a table entry whose
st + siz wraps to a small value passes the check.  An entry with
st = 0x1000 and siz = 0xfffff000, for example, is accepted on a
32 MiB disk even though the partition ends far beyond it.

Widening the addition to sector_t rejects such entries, so the
table is no longer mistaken for a valid Atari table based on an
overflowing entry.

No Fixes tag: the check dates back to the initial git import and
predates any in-tree stable branch that would still carry it.

Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Verified in a QEMU guest with a crafted Atari root sector holding
that single entry: the unpatched kernel accepts the table and
reports

  vda: p1 size 4294963200 extends beyond EOD, truncated

with this change the entry fails the check, the table is rejected
as non-Atari, and no partition device is created.
---
 block/partitions/atari.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/atari.c b/block/partitions/atari.c
index 2438d1448f..de6d9b1b68 100644
--- a/block/partitions/atari.c
+++ b/block/partitions/atari.c
@@ -22,7 +22,7 @@
     (((pi)->flg & 1) &&							     \
      isalnum((pi)->id[0]) && isalnum((pi)->id[1]) && isalnum((pi)->id[2]) && \
      be32_to_cpu((pi)->st) <= (hdsiz) &&				     \
-     be32_to_cpu((pi)->st) + be32_to_cpu((pi)->siz) <= (hdsiz))
+     (sector_t)be32_to_cpu((pi)->st) + be32_to_cpu((pi)->siz) <= (hdsiz))
 
 static inline int OK_id(char *s)
 {
-- 
2.43.0

