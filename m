Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69752F88;
	Thu, 28 Nov 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784508; cv=none; b=MVdpJGic4dTRsxulB+X/C109r+cqL2UFxVOcdRX34CTl0HhcexM/Onh6Xvkm0wgl2ToR3hWmT7AvT778wv9/DYHFzY/87QYHusjfyH1hzqi63HcRBpKU8eDF5LZHm8zzkZSgomdTQzzBqyKcpbBrIa+rasGic5Hvt9kVIifjkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784508; c=relaxed/simple;
	bh=IGXqSlNqiun6cEqMkjMBSvJi38Zbrx5l/r/SygIqWR0=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=eVGn/PrPsN5kosRmp/ZfuYBvgvj0fO9Q/9Rc7wFZAM8z4wLrawXrrH5A0TvLBNhU06d75J5X3AUBsuBF5h5wpgGTTll9sE8rJKWZROQSRMdkRKBxsfEOfid1mftyDZXG7o7pmHrPkUKN5TkskIi/TaPJ5yEu40uLfv3Ej1AzIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4XzVfl51jRz1Dwn;
	Thu, 28 Nov 2024 17:01:35 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4XzVff00SYzBRHKN;
	Thu, 28 Nov 2024 17:01:29 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4XzVfN5PzWz8R040;
	Thu, 28 Nov 2024 17:01:16 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4XzVfD2LnCz501bV;
	Thu, 28 Nov 2024 17:01:08 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl1.zte.com.cn with SMTP id 4AS905Pq012421;
	Thu, 28 Nov 2024 17:00:53 +0800 (+08)
	(envelope-from long.yunjian@zte.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid201;
	Thu, 28 Nov 2024 17:00:56 +0800 (CST)
Date: Thu, 28 Nov 2024 17:00:56 +0800 (CST)
X-Zmail-TransId: 2aff67483148ffffffffaa9-50f72
X-Mailer: Zmail v1.0
Message-ID: <20241128170056565nPKSz2vsP8K8X2uk2iaDG@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <long.yunjian@zte.com.cn>
To: <axboe@kernel.dk>
Cc: <kbusch@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mou.yi@zte.com.cn>,
        <zhang.xianwei8@zte.com.cn>, <cai.qu@zte.com.cn>,
        <xu.lifeng1@zte.com.cn>, <jiang.xuexin@zte.com.cn>,
        <jiang.yong5@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBicmQ6IGRlY3JlYXNlIHRoZSBudW1iZXIgb2YgYWxsb2NhdGVkIHBhZ2VzIHdoaWNoIGRpc2NhcmRlZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4AS905Pq012421
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6748316E.000/4XzVfl51jRz1Dwn

From: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
The number of allocated pages which discarded will not decrease.
Fix it.

Fixes: 9ead7efc6f3f ("brd: implement discard support")

Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
---
 drivers/block/brd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 5a95671d8151..292f127cae0a 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -231,8 +231,10 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 	xa_lock(&brd->brd_pages);
 	while (size >= PAGE_SIZE && aligned_sector < rd_size * 2) {
 		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
-		if (page)
+		if (page) {
 			__free_page(page);
+			brd->brd_nr_pages--;
+		}
 		aligned_sector += PAGE_SECTORS;
 		size -= PAGE_SIZE;
 	}
-- 
2.27.0
