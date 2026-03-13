Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F61F1518
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391069; cv=none; b=qu+e3v7NWsC3CWdm/+nZcsAOfiUsOZUiRvzaRxRM3cohNEvNhWTcw6vPYlf67bNersIcPeWeT8PPyp6u3D8Fan2iHltisLOh5LFSPST1qeMHNkgSeIBGeya2XbrJbXiCh0s2belkGrdpkZeylb07LsHSzwMUTSmgkQTHmNjBY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391069; c=relaxed/simple;
	bh=5C2N+yqVonPkUsA7emt/0lQdoL+YvGyCHE9EN7cyLf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u+Zr5WSAthwRaF8GGZl4ljAMrGAUVNRXoe5ZUHkqh5qbX0rN0W7g6ZtdFqLBoNyw/huamNxEBwTwlw0lFDd4dlbup6QnATc239ihaityhgjIcFW67I9ETbrlwLfgCzjlwxD/gl24cXEXHCbnFGQ0+SeE+XpmSlW9NDqaFbJ5MdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fXHsK0qvFzYQv7h
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 16:36:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A67414056B
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 16:37:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgD3+NjXzLNpNUXyAg--.25488S4;
	Fri, 13 Mar 2026 16:37:43 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	yukuai@fnnas.com,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	houtao1@huawei.com,
	zhengqixing@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH] blk-wbt: Cleanup in __wbt_enable_default
Date: Fri, 13 Mar 2026 16:27:27 +0800
Message-Id: <20260313082727.3585288-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3+NjXzLNpNUXyAg--.25488S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5Xw1DKF1kJw45uryUZFb_yoW8Wr4Dpw
	4rK3yxK3409r4xWr47Jr18XrW3Cw40gr4kJ3s3K3WfX3W8Zrsa9a1vkFy5WF48Zr97XF47
	ta12qFs8Za1UJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VU1eWlP
	UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

In __wbt_enable_default(), if "enable" is false, function can directly
return false without executing subsequent processes. Based on this,
remove the "enable" variable and simplify the related processes.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-wbt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 33006edfccd4..b614c76dd4f2 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -740,29 +740,29 @@ static bool __wbt_enable_default(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
-	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
+
+	if (!IS_ENABLED(CONFIG_BLK_WBT_MQ))
+		return false;
 
 	mutex_lock(&disk->rqos_state_mutex);
 
 	if (blk_queue_disable_wbt(q))
-		enable = false;
+		goto out_false;
 
 	/* Throttling already enabled? */
 	rqos = wbt_rq_qos(q);
 	if (rqos) {
-		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
+		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
 			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
-		mutex_unlock(&disk->rqos_state_mutex);
-		return false;
+		goto out_false;
 	}
 	mutex_unlock(&disk->rqos_state_mutex);
 
 	/* Queue not registered? Maybe shutting down... */
-	if (!blk_queue_registered(q))
-		return false;
+	return blk_queue_registered(q) && queue_is_mq(q);
 
-	if (queue_is_mq(q) && enable)
-		return true;
+out_false:
+	mutex_unlock(&disk->rqos_state_mutex);
 	return false;
 }
 
-- 
2.39.2

