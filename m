Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5471EC4E2;
	Sat, 21 Dec 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734774066; cv=none; b=NSixQgrlkBydRSrOTIT/BqCwuV3EPRAszGBundyMfDyqckbk1tkQCuwIf8uQWPO9bNIW3SNE0a5g5Nhp2crITNN2FGJUMwafrps6KiVlgqzMHl3V5jCQS5uiQ5ZAmC9XLeA4Yp9wXku7BkbT5K9rmTZQ20nogwnmYsca51PBIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734774066; c=relaxed/simple;
	bh=mRGM0IDy0EEZEiXUQeTFlO2/CfNlwLO340Ga2BMAVyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=srchnGe/sTSIAY2p0XAGNFOmc46HzbLMg34xp9si8Z2PaOTbmIRSNamCeyxMVDcJa8n6sXFWhNKFvL7i3K9ZRP9HT+hdTHANC1cXurJG4nTHID1KJSE6vh7QYw07zcPY+9Fs8HOK86+ieWkkI00zGEFWSN9GJ4u8vjV2Om1ZMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YFfRD6Th2z4f3jcn;
	Sat, 21 Dec 2024 17:40:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CB6E1A06DA;
	Sat, 21 Dec 2024 17:41:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoYqjWZnocfeFA--.21383S4;
	Sat, 21 Dec 2024 17:41:00 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org,
	ming.lei@redhat.com,
	yang.yang@vivo.com,
	yukuai3@huawei.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v3 0/7] lib/sbitmap: fix shallow_depth tag allocation
Date: Sat, 21 Dec 2024 17:37:03 +0800
Message-Id: <20241221093710.926309-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoYqjWZnocfeFA--.21383S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XryDCr4UWryrJr4rGw43trb_yoWkuFb_JF
	WkAa4kGrs3GFn3ZFy5tr15JrWUtr48Jr1UAF4DtrWxXr17Ga1UJrZ8ArWUXF13ZFWUG3Wr
	Ar1UurykAr1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in RFC v3:
 - only patch 1,2 is from v1/v2, others are new patches, in order to change
 async_depth to request queue attribute.

Changes in RFC v2:
 - update commit message for patch 1;
 - also handle min_shallow_depth in patch 2;
 - add patch 3 to choose none elevator by default;
 - add patch 4 to fix default wake_batch;

Yu Kuai (7):
  lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
  lib/sbitmap: make sbitmap_get_shallow() internal
  block/elevator: add new ops async_depth_updated()
  block: change the filed nr_requests to unsgined int in request_queue
  block: add new queue sysfs api async_depth
  block/mq-deadline: switch to use queue async_depth
  block/kyber-iosched: switch to use queue async_depth

 block/blk-sysfs.c       | 35 ++++++++++++++++++++
 block/elevator.h        |  1 +
 block/kyber-iosched.c   | 31 +++--------------
 block/mq-deadline.c     | 57 ++++++--------------------------
 include/linux/blkdev.h  |  8 ++++-
 include/linux/sbitmap.h | 19 +----------
 lib/sbitmap.c           | 73 +++++++++++++++++++++++++----------------
 7 files changed, 103 insertions(+), 121 deletions(-)

-- 
2.39.2

