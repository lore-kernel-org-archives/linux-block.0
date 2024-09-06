Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D961C9EA4;
	Fri,  6 Sep 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618222; cv=none; b=WDo5OYrDuy1oVMlJQAL22UyvJ59dD5m//MouUIukd7nP69JsDWEfqQ/Ug1t5CXlOQLw90YVIkQJQIMNVNCtOOq8IdGobkBUJxS6dIbftfg2u97j+jV9pGmKUAn7HedUKxT6rAV0bvQxoC+pYEwivwf/GUNaGjYrb+m3oB9o0cNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618222; c=relaxed/simple;
	bh=0cPUYRjKz+cEQA/HyuVxBI6hyIfBSPTS2C3lIVvEyt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVXyfCWtL4MEneIhs1Vc7I7RJjqFTFfCzkXKvT/Y7JICwC7cEk0Hy8Vit3u1WNi1HYotsAWuRJf7tKoLU/kaNF/4Z60DmTKRftOALw2nNo/w76wqbIIKTQPSIFJ1ReOzS1khPEvtPWSYKCbMxeWtsBMoLfxQQmndA0LP52Ly2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X0XPM063Tz4f3jXP;
	Fri,  6 Sep 2024 18:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 23B8C1A06D7;
	Fri,  6 Sep 2024 18:23:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8ck2NpmtyU1Ag--.55896S4;
	Fri, 06 Sep 2024 18:23:33 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: jack@suse.cz,
	ming.lei@redhat.com,
	bvanassche@acm.org,
	paolo.valente@unimore.it,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
Date: Fri,  6 Sep 2024 18:21:53 +0800
Message-Id: <20240906102153.612997-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8ck2NpmtyU1Ag--.55896S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw13uF48Jw13tr4ftw1kXwb_yoW8Xry8pa
	n8Cw4akr93tF15CwnrGF17ZFyktas5ZF47GrZxtw15ZFn8tryFkrnIqay3uan7urWfZa90
	vr9Iyr1jyrWUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

BFQ has been lacking active maintenance for approximately two years, and it
was recently transitioned to the Orphan state. However, there are still
many users, I have decided to step forward and assume the role of
maintainer to ensure continued support and development.

While I may not be the one with the most extensive knowledge of BFQ's
internals, I have been actively involved in its development since 2021.
Moreover, our team continues to rigorously test BFQ in downstream kernels,
ensuring it's stability and performance. Despite my confidence to maintain
BFQ, I believe it is prudent to classify its state as "Odd Fixes" to
accurately reflect my relatively new position as the maintainer.

By assuming this responsibility, I am committed to providing the necessary
support and addressing any issues that may arise with BFQ. As time
progresses, we will reassess the situation and determine the appropriate
state.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a857a125d6e..6da36e26ee8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3781,8 +3781,9 @@ F:	Documentation/filesystems/befs.rst
 F:	fs/befs/
 
 BFQ I/O SCHEDULER
+M:	Yu Kuai <yukuai3@huawei.com>
 L:	linux-block@vger.kernel.org
-S:	Orphan
+S:	Odd Fixes
 F:	Documentation/block/bfq-iosched.rst
 F:	block/bfq-*
 
-- 
2.39.2

