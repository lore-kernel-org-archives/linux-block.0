Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9F6A71FDA61;
	Wed, 30 Sep 2026 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729974; cv=none; b=jMxYbkI/KMWLyCZmoaK1INeJkH8WAHRprgtN9Hm/0YlR5nXx38WK9Fj48HcHX9OfHkA738iEq/g3ZWG3L35rExofxw564HJrQHdDUVD/FCZodnS2Fn1Re3yghNAZsDfAbVI9tLDHEiNMymJSF07sstfTOchJ7QJ14NZZj8Vjje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729974; c=relaxed/simple;
	bh=OuZ6EjBIIKH7ZQ2utIoQ1iUeQVNILDkfliRbqnLmyrE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d6yVilBJUtikFVzwWeihQ3zsIH0/03nfzS9CMZIFc3rsNQeUt6uSIRM8Ar9QzD/yxnqUTvCco8DXONMF3jLw1/DlRv0dRlJ0zXkmc4lZjSXgQq0ilxU8EHUaXKrtRkc2mi1SrGRA6D0T4IThSPuboB8hHu7HnGPpPU/kL3a+ZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=G6CGtdSa; arc=none smtp.client-ip=111.202.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="G6CGtdSa"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andreas
 Hindborg <a.hindborg@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2] ublk: use global index for reported zones
Date: Wed, 30 Sep 2026 08:59:14 +0800
Message-ID: <20260930005914.2133-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790729964;
	bh=bEkkdNMIu2tI1nsr4es61ds0oGFTkZBoeIgpOddJhoI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=G6CGtdSayRLizLMWWWS57gGdckDHd8vhPaUHOLlQ3UKx2IlH2+1tnxDMeBrI+vlQK
	 bLVriO2W3SqAtu/14WSkYZraq/OEs4lzQyKHqJ8LPTPtVbvnJhl/0/RZg38HdxKzjb
	 mNZfsPOHpCieVd65M5KCNnwsTatBHo1Yb5FQFvqpFjRkhUIzGjytBB2j+auwpZNzMk
	 GPK7ZlIJuEqLLd40ZmZu0hemwNOSLmD9CpyFBcBo6Y3dK5WRfKbrTwrxP7mEpaBgva
	 OnkhExSW8AmY3sK7RGAkWMxuhAr7eRMLDw4BVT9EpxuXKvJ+Cr3HkA7jT+sBp/N0IS
	 6QEavjhKf9cfA==

From: Li RongQing <lirongqing@baidu.com>

ublk_report_zones() may split a zone report into multiple requests when
the number of zones exceeds the temporary buffer capacity. The index
passed to disk_report_zone() must refer to the zone position in the
whole report, rather than the position within the current request.

Currently, the per-request loop index is used as the callback index,
causing each chunk after the first one to restart from zero. This can
make userspace callbacks receive duplicate zone indices and may result
in blk_revalidate_disk_zones() updating incorrect entries in its zone
state array.

Use the number of zones already reported as the base index for each
request so that zone indices remain continuous across all chunks.

Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
---
Diff with v1: pass done_zones directly

 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e..ebd01af 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -687,7 +687,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			if (!zone->len)
 				break;
 
-			ret = disk_report_zone(disk, zone, i, args);
+			ret = disk_report_zone(disk, zone, done_zones, args);
 			if (ret)
 				goto out;
 
-- 
2.9.4

