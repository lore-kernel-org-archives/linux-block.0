Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23CED2FB
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855239; cv=none; b=asF1mtv/Oqv7gmg/FxrdXqTgfH2iTAOG2HoId4Zc+e8FL4bp+FwFl94FcRcgDk2N+FzXfYbMEQfWamfb2o5smz1N0fBQOhy72lfNNr+WTaVJ8vrHKvss8WHK34G3fLS50IK7AT4HyQeE1tLrigm7Guu8O10fsgPB1e3vPiGpfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855239; c=relaxed/simple;
	bh=+ad2sVNv36nqgxbCXr6VchIfUBgU3+Mx4w65UVwbnYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWM6LeMyebVjm2dN9t/TrvPYG2EDwvzNSctsLfY27ohW650WhhySR7qXbsNKZ6R8IBxJf+fI2ZBs3wMhzBglYv4HJ0Tex3oh4iORxsUBDN+gsdXe7KEk5OYDUyPByPOkkpUiPh9gGd1/Ybdszn2y6jv1fCtP05d1scALSRRYOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZdLbr1D4qz69cP;
	Thu, 17 Apr 2025 09:56:40 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id AB47E1402E9;
	Thu, 17 Apr 2025 10:00:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 10:00:27 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 0/3] blk-throttle: Some bugfixes and modifications
Date: Thu, 17 Apr 2025 09:50:30 +0800
Message-ID: <20250417015033.512940-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

The patchset mainly address the update logic of tg->[bytes/io]_disp and add
related overflow checks. The last patch also simplified the process.

Zizhi Wo (3):
  blk-throttle: Fix wrong tg->[bytes/io]_disp update in
    __tg_update_carryover()
  blk-throttle: Delete unnecessary carryover-related fields from
    throtl_grp
  blk-throttle: Add an additional overflow check to the call
    calculate_bytes/io_allowed

 block/blk-throttle.c | 131 +++++++++++++++++++++++++++++++++----------
 block/blk-throttle.h |  19 +++----
 2 files changed, 108 insertions(+), 42 deletions(-)

-- 
2.46.1

