Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFA1494D9;
	Thu,  9 May 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247226; cv=none; b=AHx1E1UiO15sIt8hbq+Fwy6audNCilfuqZPqcP9dRW0GDj3pJLmzANs6lTlHPvSVGJ2YkhHNBQtchnkyUeh6R3Ch3TiAycntlL03bAu1Bk9lx8PiTpEEup92lczrukMjX+R1Bjh2a8h3X78Mz7P1+JV8m7iGHUgid3O6e7muiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247226; c=relaxed/simple;
	bh=aHW5/vIQ8c227jwhESnXTgt/7c8ZoU4PkjaXxYwerYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JRMLEkIX31k2hgxoyrSJt7OD2C63JBnqT/x9ioFa00PFjfjG5zTLXwdRuJKPKEtUGo6AlTUt1cr/rSgiaSc3JCaBzrF0yT11DmOEs2S4u37rUUmJLEvPKYDBya1+vdXkbaVLNvOU9TZVrT1hXkPvvJJcKJnIIrFtmAZSlEiQm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VZmvf4ljyz2CfJY;
	Thu,  9 May 2024 17:30:22 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 13F701A016C;
	Thu,  9 May 2024 17:33:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 9 May
 2024 17:33:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <axboe@kernel.dk>, <dlemoal@kernel.org>, <hare@suse.de>,
	<johannes.thumshirn@wdc.com>, <ming.lei@redhat.com>,
	<zhouchengming@bytedance.com>, <nj.shetty@samsung.com>,
	<justinstitt@google.com>, <john.g.garry@oracle.com>,
	<shinichiro.kawasaki@wdc.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] null_blk: Add __must_hold macro for null_flush_cache_page()
Date: Thu, 9 May 2024 17:33:04 +0800
Message-ID: <20240509093304.1618775-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)

It seems that call null_flush_cache_page() must hold nullb->lock and it
returns with nullb->lock held. However, this is not clearly described, and
the caller may forget to hold the lock. Therefore, add __must_hold() macro
to the function entry to show that the lock is held on function entry and
exit, which allows sparse to do lock checking.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index ed33cf7192d2..adca31e55deb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1013,7 +1013,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	return 0;
 }
 
-static int null_make_cache_space(struct nullb *nullb, unsigned long n)
+static int null_make_cache_space(struct nullb *nullb, unsigned long n) __must_hold(&nullb->lock)
 {
 	int i, err, nr_pages;
 	struct nullb_page *c_pages[FREE_BATCH];
-- 
2.34.1

