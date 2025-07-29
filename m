Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E54217648;
	Tue, 29 Jul 2025 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759564; cv=none; b=SFOwR0P4srEtJwwC6/bG6B6RgrB+PWZgvtTioDpPdsMuCXUnThXnzRsSkpmST18UF9pxApeYjVldJYqS6kizMzrL7HuEAIhlQxPLNPtn6bLtIzBmTFGIzrasAPEqD3+7bJRey4o+x7Q0f26qGHOZzdd9FJwDj1CRcJ429xYOCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759564; c=relaxed/simple;
	bh=JPwk2IQDGs/f73q/O91gWYje2P+4ByedJSMtLJK8+ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qUbyc2asFx+J5hKm9nADrNWNThAnGIo3sEb83fg8A8HRqc5+ERzblq1RxyuuUro7HKQNbn9zRiUTOBdyeGDeTs9P1hdHXT6yogCQbUdMicWFk3T1UAvRIKySUU18ki5yHRczqlbmdACz5S9guFiZaFbKT8FzMlDjV/pVw8sxFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4brgjG486zzYQtpx;
	Tue, 29 Jul 2025 11:25:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 459C41A08FC;
	Tue, 29 Jul 2025 11:25:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxA_P4hoIG9dBw--.17427S4;
	Tue, 29 Jul 2025 11:25:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	axboe@kernel.dk,
	akpm@linux-foundation.org,
	yang.yang@vivo.com,
	dlemoal@kernel.org,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 0/2] lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
Date: Tue, 29 Jul 2025 11:19:04 +0800
Message-Id: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxA_P4hoIG9dBw--.17427S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYP7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14
	v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes from v1:
 - fix some wording in patch 2
 - add review tag by Damien in patch 2

Yu Kuai (2):
  lib/sbitmap: convert shallow_depth from one word to the whole sbitmap
  lib/sbitmap: make sbitmap_get_shallow() static

 block/bfq-iosched.c     | 35 +++++++++-----------
 block/bfq-iosched.h     |  3 +-
 block/kyber-iosched.c   |  9 ++---
 block/mq-deadline.c     | 16 +--------
 include/linux/sbitmap.h | 19 +----------
 lib/sbitmap.c           | 73 +++++++++++++++++++++++++----------------
 6 files changed, 65 insertions(+), 90 deletions(-)

-- 
2.39.2

