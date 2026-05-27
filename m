Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1683B52F5
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864798; cv=none; b=sulInVDZ9fYkmc5wqrs6dPDoApFMF+27YCTgmv/vEO6hqbBeYYW/+HQaMgGlyZaBc30hmOEXBbUeztgYaBoC8nEf7+Q4ueTVlQvUoGWinEu3AX1iIidXe1ITNs3e/aUhVAY0bqH247rqggYkMS8c4qifwEWU9oiAx6SD+0fhtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864798; c=relaxed/simple;
	bh=ZelXbZEksrmDa+2txnRIGeY60tEe9gstCZ8Ax9zHN1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jAg4SMDpxNWITcZ9Eww50em3eygxaj/w5DkmlEBnpN+MKTeuXZl7zeoVgbCgLNU+DtNp+jNo9oE/zim3Ta8jaueLNcJR+ngOvATBY+1CtM1xwHpEqqoXQa8BABGaHP2+PzZPUrytc78JEORMjgnQmeaFzy4U5YHftY0Xf0HLqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CNr8nYbw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CNr8nYbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1G
	gIUbrMJ1tVOMpa2s234Qg7BwSjKzEB+nbE4YExmJc=; b=CNr8nYbwYU6WBlV7Ey
	d+0VGZBzSO6iQToXIOCWEdw7Eh4IbQhTdVTyM3XleCewmGkvlhQ+EHkC/tTCLrMk
	36gBx2gAFqYECksE5/BVjHF2CcUrLhmgcRzXibWea9s+jydNbTdjmYQPieAEzjdM
	NmJNXCv+pxwhDMdW2I9t/msXY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wC3gdSilBZqlMukDg--.62791S2;
	Wed, 27 May 2026 14:52:20 +0800 (CST)
From: dayou5941@163.com
To: ldm@flatcap.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	liyouhong@kylinos.cn
Subject: [PATCH] block/partitions/ldm: fix TOCBLOCK bitmap mismatch message argument order
Date: Wed, 27 May 2026 14:52:16 +0800
Message-Id: <20260527065216.777028-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3gdSilBZqlMukDg--.62791S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry7ZFW5Zr4DtryDAw15CFg_yoW8AryDpr
	Wjg3s8Ca1fAr4jva1UZayruryrZan3JanrtF4I9w45Cr93Xwnakr48Ka4Yyw1rJ343Za9F
	qr43tFWUuan8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbCztUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gRuHWoWlKR8xAAA35

From: liyouhong <liyouhong@kylinos.cn>

The ldm_crit() calls in ldm_parse_tocblock() have the format string
arguments in the wrong order. The format string reads:

  "TOCBLOCK's first bitmap is '%s', should be '%s'."

The intent is to print the actual (on-disk) name first and the expected
name second. However, the constant TOC_BITMAP1/TOC_BITMAP2 (expected) is
passed as the first argument and toc->bitmapX_name (actual) as the
second, producing misleading diagnostic output on corrupt disks.

Swap the two arguments so the printed message matches its intended
semantics.

Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
 block/partitions/ldm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index c0bdcae58a3e..fca55f9a583e 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -138,7 +138,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 	if (strncmp (toc->bitmap1_name, TOC_BITMAP1,
 			sizeof (toc->bitmap1_name)) != 0) {
 		ldm_crit ("TOCBLOCK's first bitmap is '%s', should be '%s'.",
-				TOC_BITMAP1, toc->bitmap1_name);
+				toc->bitmap1_name, TOC_BITMAP1);
 		return false;
 	}
 	strscpy_pad(toc->bitmap2_name, data + 0x46, sizeof(toc->bitmap2_name));
@@ -147,7 +147,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 	if (strncmp (toc->bitmap2_name, TOC_BITMAP2,
 			sizeof (toc->bitmap2_name)) != 0) {
 		ldm_crit ("TOCBLOCK's second bitmap is '%s', should be '%s'.",
-				TOC_BITMAP2, toc->bitmap2_name);
+				toc->bitmap2_name, TOC_BITMAP2);
 		return false;
 	}
 	ldm_debug ("Parsed TOCBLOCK successfully.");
-- 
2.25.1

