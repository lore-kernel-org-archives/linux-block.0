Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F621766B
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742475; cv=none; b=RhAdI9WVxyq0vM8V7bTBZlpipRv5ermfAU7mVnxJPxwfLhwemh2DR6i7EjQkG97o0JH75wKTTOd9jX5aMenku9caVpWMBWH0SiNrEwpdxg9UmTddctRVOctIs7Ynh8Cbz8TYQKWoEBhgG0gC5TuL/FK3/ydYwc/w9R5TmcSPyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742475; c=relaxed/simple;
	bh=IE9ANbj+FiPbNxYD5IB+H26tgDUxjfWgYiJhhK4uRSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O8Yo2U7tvd2GQaLotzvY8LNoZuZTgTVqCsynYlYbMiPtnmh9MxoKwJqofMiSeIYO7hjQ36sIERDmUFbd2H1bV8K0f5GJItuFECViUInMtwx6Rg8g8zZZGxdITmx0OmeQB6Emk4NGJdiw3GpRIxbpCRpQddSs3uAQ8nNT2vkeQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y6Jwv3TfNz4f3l1s
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 19:07:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AA8661A14C4
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 19:07:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4d9z1Zn7YdqEA--.17831S4;
	Mon, 09 Dec 2024 19:07:47 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: axboe@kernel.dk,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v2] block: retry call probe after request_module in blk_request_module
Date: Mon,  9 Dec 2024 19:04:35 +0800
Message-Id: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4d9z1Zn7YdqEA--.17831S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17Aw1xAF4rur4fJF4Utwb_yoW8tFy8pr
	47Ja98KrZF9rsrWa1fXFy7W3W5Ka48KFWrtwnxta4fJr95Kr4avr47tw1Y9a45Ar93Zan3
	Xa1UWF98Cay0yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

Set kernel config:

 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_LOOP_MIN_COUNT=0

Do latter:

 mknod loop0 b 7 0
 exec 4<> loop0

Before commit e418de3abcda ("block: switch gendisk lookup to a simple
xarray"), lookup_gendisk will first use base_probe to load module loop,
and then the retry will call loop_probe to prepare the loop disk. Finally
open for this disk will success. However, after this commit, we lose the
retry logic, and open will fail with ENXIO. Block device autoloading is
deprecated and will be removed soon, but maybe we should keep open success
until we really remove it. So, give a retry to fix it.

Fixes: e418de3abcda ("block: switch gendisk lookup to a simple xarray")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 block/genhd.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

v1->v2:
Rewrite this patch by adding helper blk_probe_dev to make code looks
more clear.

diff --git a/block/genhd.c b/block/genhd.c
index 79230c109fca..8a63be374220 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -798,7 +798,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
 }
 
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
-void blk_request_module(dev_t devt)
+static bool blk_probe_dev(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
@@ -808,14 +808,26 @@ void blk_request_module(dev_t devt)
 		if ((*n)->major == major && (*n)->probe) {
 			(*n)->probe(devt);
 			mutex_unlock(&major_names_lock);
-			return;
+			return true;
 		}
 	}
 	mutex_unlock(&major_names_lock);
+	return false;
+}
+
+void blk_request_module(dev_t devt)
+{
+	int error;
+
+	if (blk_probe_dev(devt))
+		return;
 
-	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("block-major-%d", MAJOR(devt));
+	error = request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt));
+	/* Make old-style 2.4 aliases work */
+	if (error > 0)
+		error = request_module("block-major-%d", MAJOR(devt));
+	if (!error)
+		blk_probe_dev(devt);
 }
 #endif /* CONFIG_BLOCK_LEGACY_AUTOLOAD */
 
-- 
2.39.2

