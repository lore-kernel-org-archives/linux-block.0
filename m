Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C082C027D;
	Tue, 30 Sep 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216918; cv=none; b=CvujhoSljMqtXHagwhP3UIsMtS4lpFlTHLcUB330VxwzO/7A25TjA3BLfczvxGkvh8xMJ/fokCujIsG2bGEuNjzUABkE6AenHdPpxpdosyXTJSRs1/MLZB6HOS622j4H+9RTuhvFzMifjBarKPw6z9tpPzM63lsWqDZWEFaC79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216918; c=relaxed/simple;
	bh=xnPYgdSTZcvH2V/KsDQCUBMVx8+oZQ4daHbrCqvMGgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Calhrl8edrcR9XGaK0wC3Z9rEX2ZqcBHypZMDwAck5Yb6p6nhIyMASpDud7yndgI/QaMc1PyeSUYA8Gyyi2HCxJknjmqDbdYFR33ymW7mEmE3mu7J4mkFbmbSU+sQBxfbyKlhGGxYKBgpmIoHk3Ejg+N42IrBRWiM+ZX3YjWnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbTy80VWLzYQtnm;
	Tue, 30 Sep 2025 15:21:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4E6B81A1B09;
	Tue, 30 Sep 2025 15:21:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjGQLhdtoC9s4BQ--.44849S11;
	Tue, 30 Sep 2025 15:21:53 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 7/7] blk-mq: add documentation for new queue attribute async_dpeth
Date: Tue, 30 Sep 2025 15:11:11 +0800
Message-Id: <20250930071111.1218494-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjGQLhdtoC9s4BQ--.44849S11
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1UAFykJr15uF13ur4Durg_yoWDuFXEgF
	WDGF1vg3ykAF15ZFW2yF4kAF12g3y5Kry8G3WkAr15Zry3t3WSka98XrZ8CFZrXF4I9rn3
	Zws5XrWUKrnxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Explain the attribute and the default value in different case.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 Documentation/ABI/stable/sysfs-block | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0ed10aeff86b..09b9b3db9a1f 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -609,6 +609,16 @@ Description:
 		enabled, and whether tags are shared.
 
 
+What:		/sys/block/<disk>/queue/async_depth
+Date:		August 2025
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This controls how many async requests may be allocated in the
+		block layer. If elevator is none, then this value is nr_requests.
+		By default, this value is 75% of nr_requests for bfq and kyber,
+		abd nr_requests for mq-deadline.
+
+
 What:		/sys/block/<disk>/queue/nr_zones
 Date:		November 2018
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
-- 
2.39.2

