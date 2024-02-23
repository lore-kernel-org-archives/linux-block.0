Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F610A09
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660571; cv=none; b=LqDuIFETitnTH2uF9ut/AxZOBr9TP5b7NrB7oWaX7FUQGhhxfntb7796tO7atTbVx9Vg15fpNMSyUmXPY2O69zzol4d+kBC2SZXNtP0lpwD9m+E7lePK4Y5ouQZXpBJLR1Ck/WpWctcTZ8JdFmWmSs4qcDVsul928aagosiOg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660571; c=relaxed/simple;
	bh=t6I7agqo7A3TTgQjkP8Wd3mMKgNKfghTfx+u9omcUE0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pjuiLmSlUbO99H5fRkuDhthEMPdrE8PkahgbBvzDP+qrJyFLfr3ww5/BPJzh3leTgRFw/eyQl1YRakPi0+lysuopciOS9uZOAjI1YwQkoIwFk/UiDqXDE5NlNhrqd4/4Fa0cPerX668NMfB0WljDdhekUDjwYUcxA9vXIQ6JReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tgx2f6rlfzXhG2;
	Fri, 23 Feb 2024 11:54:02 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 006391400CA;
	Fri, 23 Feb 2024 11:56:00 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 11:55:59 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Huacai Chen
	<chenhuacai@kernel.org>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, <linux-mm@kvack.org>,
	<linux-block@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/5] mm: unify default compressor algorithm for zram/zswap
Date: Fri, 23 Feb 2024 11:55:43 +0800
Message-ID: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Both zram and zswap are used to reduce memory usage by compressing cold
page, a default compressor algorithm is selected from kinds of compressor
algorithm as the default one from very similar Kconfig, also both of
them could change the algorithm by sysfs interfaces, so unify the
default compressor algorithm to cleanup the default algorithm chosen.

Kefeng Wang (5):
  zram: zcomp: remove zcomp_set_max_streams() declaration
  zram: make zram depends on SWAP
  zram: support deflate compressor
  mm: zswap: default to lzo-rle instead of lzo
  mm: unify default compressor algorithm for zswap and zram

 Documentation/admin-guide/mm/zswap.rst     |   2 +-
 arch/loongarch/configs/loongson3_defconfig |   2 +-
 drivers/block/zram/Kconfig                 |  44 +------
 drivers/block/zram/zcomp.c                 |   3 +
 drivers/block/zram/zcomp.h                 |   1 -
 drivers/block/zram/zram_drv.c              |   2 +-
 mm/Kconfig                                 | 134 +++++++++++----------
 mm/zswap.c                                 |   8 +-
 8 files changed, 83 insertions(+), 113 deletions(-)

-- 
2.27.0

