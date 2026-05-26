Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712C3FF1B8;
	Tue, 26 May 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805154; cv=none; b=TonA/WVd2ZiUGIVLWhp3gi1q5xBXfRPR8l+ZZTOhhUXyGTb1aDh8Ab9gdO5CEGo/eLrWSbAT96ki1lBV40dA2PGZ5v8uSVALdoG5nbBKGjFJnJ03wk5fWQphG2/2dPZ+/gTwTcmO9m7A3wuBCM9bwzacWpc0Mx6pLpWJCMA2qps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805154; c=relaxed/simple;
	bh=LgrCO9oMw/z3/g27hCLEyNUrRjPB18SvS9w/FJ+lUXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCvCqJCHpHogIjG3Hf6EnBnc9PgAGhPRvySzay6XgfkF5yLvK88EeTY7yaMsw68R00L7ycxcMYI+BFk8laIWy94PweRc0pXljJs3Mp0SB045YL57Lfb7N+GcPipXQ4jOG11Oh1xtmJ2fteUNy2S2A45hXib/r0SeNI02YQLjuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADHNenQqxVq+O56EQ--.396S2;
	Tue, 26 May 2026 22:18:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] block: blk-zoned: fix zwplug refcount leak on write error path
Date: Tue, 26 May 2026 14:18:24 +0000
Message-Id: <20260526141824.2293025-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHNenQqxVq+O56EQ--.396S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryxCw4fKry7XF13Gw4fuFg_yoW8JFy7pr
	WF934YkF9Yqr10qay0kF1UXF109wsrGrZ7KrWSywnxZw1rX34jqF1UZrs0gr1Fkr97uFWY
	vFZxtFyDArs8CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjO6pDUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwTA2oVcMiv1AAAsm

blk_zone_wplug_handle_write() increments zwplug->ref via kref_get()
when preparing to handle a zone write. On the error path where
blk_zone_wplug_handle_write_noalloc() fails, the function returns
without calling kref_put() on zwplug->ref, leaking the reference.

Add kref_put(&zwplug->ref, ...) on the error path to properly release
the reference.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 block/blk-zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 42ef830054dc..24b899663a48 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1503,6 +1503,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
+		disk_put_zone_wplug(zwplug);
 		bio_io_error(bio);
 		return true;
 	}
@@ -1511,6 +1512,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
 
 	spin_unlock_irqrestore(&zwplug->lock, flags);
+	disk_put_zone_wplug(zwplug);
 
 	return false;
 
-- 
2.34.1

