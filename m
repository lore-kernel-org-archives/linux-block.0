Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D074C08;
	Fri, 18 Apr 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969539; cv=none; b=hZmqJNoVOzav3s23Nfzi45mc/PX/Bb16N7oN56i1FxUTB/bMZXr9lxgFuD1ltwoMempgl886075KoHgrakN8D0tQN2a9wMdxcnoRBBFDepgoLqlX2fWeLOika9bSSeWMWeKUNoYwZ3nmRT7exquPiHocfDMleyjnuZ9r30p6O+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969539; c=relaxed/simple;
	bh=UDOwa931HgYpWxZCrI2EqWZEOyEdcAEem8/0hRyzDds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kOD1c7K91Euepk8y3g24esxs2OGD41olw5bVHdp1IW1EXy9jT1JffvYGxurDMdnauw8OSQoeJjigDO3wELaaoMn6A4MKy5Ex5FsgF6qqRC/HOoadTEUuvkMW17B8wJ8k4RmNkCrlaQxB+KDbTEMo83Xc/q5MjWU3bAS4GWXgdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zf8y24J9vz4f3jtK;
	Fri, 18 Apr 2025 17:45:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0AC0E1A1B7D;
	Fri, 18 Apr 2025 17:45:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGA6HwJozQ1aJw--.29179S4;
	Fri, 18 Apr 2025 17:45:32 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	kbusch@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 0/5] brd: discard bugfix
Date: Fri, 18 Apr 2025 17:38:21 +0800
Message-Id: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGA6HwJozQ1aJw--.29179S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4rCryUXF15uryrCFyUKFg_yoWxKwc_AF
	9rKF9xW3WxGF17tas0yFy7Z390gw4UWF1kGF10gr12yw1rAw1DCryq93yqqr18XF4UAr9r
	J39FqrWFvw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The backgroud is that our customer is using brd for dm-thinpool, and
they want brd to support discard. So today I'm reviewing the commit
9ead7efc6f3f ("brd: implement discard support") and try to backport it
to downstream kernel. Those problems are found while backporting, they
are not tested yet.

Yu Kuai (5):
  brd: fix oops if write concurrent with discard
  brd: synchronize using page and free page with rcu
  brd: fix aligned_sector from brd_do_discard()
  brd: fix discard end sector
  brd: zero data for discard that is not aligned to page

 drivers/block/brd.c | 76 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 21 deletions(-)

-- 
2.39.2

