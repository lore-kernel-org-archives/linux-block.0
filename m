Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07216146D7B;
	Thu,  9 May 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258849; cv=none; b=tchuUoTZ2ebTpLTBR3BxGQMe+OI1e5aMGVwITM0GUBvXcA+Z8bz7oypZjzz5LBVhC8IghD4ixgPaOPpv53UyIp/WdyaTDNvLlJAvTus+j1hmm11ml37uTKWqB21EcuNT73sOM8KPZg+ZKxLJOYgO1jGp1yo4d7zzYBgUHo0jWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258849; c=relaxed/simple;
	bh=94OTiQNVw96KBqdSWjcw8KSMyl7GYa6XYujHM5DDG3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iaRG9cSCCYxJSNzfO19DuZwNPYjui8Hts7cVTNWWUkiHbMT+lV3Yem5qXx7NN0d2+V6ptTcYipRviJeT1p1eJp95o9YlqQUWxUbFiaaTy/Z45hLE+6sp1D6hp6Ymw7V+wZZ7RRGEvkXf9N9pToQPe4xvLLTIPMUvSaqtvZDUa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VZsGq26byz4f3knp;
	Thu,  9 May 2024 20:47:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A20071A0568;
	Thu,  9 May 2024 20:47:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7ZxTxm7wHDMA--.34199S4;
	Thu, 09 May 2024 20:47:23 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	hch@infradead.org,
	mpatocka@redhat.com,
	snitzer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 for-6.10/block 0/2] block: fix user-aware inaccurate util
Date: Thu,  9 May 2024 20:37:15 +0800
Message-Id: <20240509123717.3223892-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7ZxTxm7wHDMA--.34199S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYx7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v2:
 - just replace blk_mq_in_flight() with part_in_flight() for
 diskstats_show() and part_stat_show() in patch 2;

Yu Kuai (2):
  block: support to account io_ticks precisely
  block: fix that util can be greater than 100%

 block/blk-core.c  |  9 +++++----
 block/blk-merge.c |  2 ++
 block/blk-mq.c    |  4 ++++
 block/blk.h       |  1 +
 block/genhd.c     | 14 +++-----------
 5 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.39.2

