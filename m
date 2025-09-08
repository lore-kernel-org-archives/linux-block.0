Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14765224AF0;
	Mon,  8 Sep 2025 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312697; cv=none; b=Pz5OThfzGfAIx0LK6P3uQukSWHX+CCHOTCGDJFiLSFDy05hblmst/YXzbAdZN/nWUWCVlCm7Fr4g7YSLNDfJLW3z3XqLnTkbnlbJkSkY/7h5AY6n34VL3gaXxVncy40tJ8K5tQLF2wejRJEA4UpVxOVa/ScX6SqGx4F/KBSNt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312697; c=relaxed/simple;
	bh=WUoCSRNyXygxBg40G1rimhKm2q8h8PwfgC+2wqmpPqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X1S1I+CzfPj2OqDvxCW2zSM/hs13UjDtPcNI/4DmNgYXLdFXAJWRQt/POxBC1JYb2dRYZxLv3j3ZsEIf1bS0hetsgmYPiaJnMF68gItJ4Ya2YVq4WGpAIfbnWflEjs9pKnBuN2wlwYXJQ6p++OSZR2oQHC+aYDluvQ1vaweGvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cKxks2F4JzYQv07;
	Mon,  8 Sep 2025 14:24:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C5BF11A0B82;
	Mon,  8 Sep 2025 14:24:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY6xdr5oCGEjBw--.62066S4;
	Mon, 08 Sep 2025 14:24:51 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: nilay@linux.ibm.com,
	ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH for-6.18/block 00/10] cleanup and fixes for updating nr_requests
Date: Mon,  8 Sep 2025 14:15:23 +0800
Message-Id: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY6xdr5oCGEjBw--.62066S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZr17Xr48GF1DCr43Ww15urg_yoWkJwbEkF
	yUCFyftFZ0qF45AFZFkF1UJ34DKan3CF1UKa4DArW8Jws7ta15Cr45KrWrZFsxua12k3Wk
	tw1UXr1rJan5ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Yu Kuai (10):
  blk-mq: remove useless checking in queue_requests_store()
  blk-mq: remove useless checkings in blk_mq_update_nr_requests()
  blk-mq: check invalid nr_requests in queue_requests_store()
  blk-mq: convert to serialize updating nr_requests with
    update_nr_hwq_lock
  blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
  blk-mq: split bitmap grow and resize case in
    blk_mq_update_nr_requests()
  blk-mq-sched: add new parameter nr_requests in
    blk_mq_alloc_sched_tags()
  blk-mq: fix potential deadlock while nr_requests grown
  blk-mq: remove blk_mq_tag_update_depth()
  blk-mq: fix stale nr_requests documentation

 Documentation/ABI/stable/sysfs-block | 14 ++----
 block/blk-mq-sched.c                 | 14 +++---
 block/blk-mq-sched.h                 |  2 +-
 block/blk-mq-tag.c                   | 53 ----------------------
 block/blk-mq.c                       | 66 ++++++++++++----------------
 block/blk-mq.h                       | 18 ++++++--
 block/blk-sysfs.c                    | 47 +++++++++++++++-----
 block/elevator.c                     |  3 +-
 8 files changed, 92 insertions(+), 125 deletions(-)

-- 
2.39.2

