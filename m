Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E84657F5
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933546; cv=none; b=AgVJzLuAdQQWfx1Wl0i6aF4Z07aOrV8gcjm8mrivx1OY5mTLogPkaSVeHx0/hoNOG6USq27vGF5UwsdD08n51csQ2TLjOdZvBlBEkQUJzorKkQ4jJS6yuwhHILmRTbwHd2Mx5XPuf98IprH1IbeCasCirUybEnIrCXprDgAZNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933546; c=relaxed/simple;
	bh=N5biFNBr62yZe8gEJEP404p720ir8MesthgLLy3nc+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj7UnJFj85OTiZVO2g9ROhME+uTFGvmQ5bXELGGVCbcsdm9qoTiwZvKdQgyIYjY9FZUdLKsAFcu0xPRZXcZ5fbgIrbIrp4lIVQu15q8gtIXifKZXCJOkQv4QxLApTNB4j6MyQEnzd+zp6EXrZ0ntPS+2puGymova8j+a49nWuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFVLj2GCyzYQvVd
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 571C84087D
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkXfLnNqRJjWBA--.10386S5;
	Wed, 05 Aug 2026 20:38:58 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@lst.de,
	yukuai@kernel.org
Cc: yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	echo.chenlin@huawei.com,
	leo.lilong@huaweicloud.com,
	wangkefeng.wang@huawei.com,
	huawei.libin@huawei.com,
	leijitang@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v8 1/8] nbd: simplify find_fallback() by removing redundant logic
Date: Wed,  5 Aug 2026 20:29:23 +0800
Message-ID: <20260805122930.57647-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260805122930.57647-1-yangerkun@huawei.com>
References: <20260805122930.57647-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkXfLnNqRJjWBA--.10386S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15ur1kWrW8uw1UKr45ZFb_yoW8tF1UpF
	WfZFyfKryUXF13ur43Za1UuF1rCws3Ga1UGFW8Ja4xuryDCryUuFZ3tF1ftayUJrZxZF9F
	vF1UGFy2kFn8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU8epB3UUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Long Li <leo.lilong@huawei.com>

The second conditional checking nsock->fallback_index validity is the
logical inverse of the first, so drop it and let execution fall through
naturally. Consolidate the two identical dev_err_ratelimited() + return
paths into a single no_fallback label to reduce duplication.

Reviewed-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 drivers/block/nbd.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8f10762e90ef..b1a5acd57426 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1061,40 +1061,31 @@ static int find_fallback(struct nbd_device *nbd, int index)
 	int new_index = -1;
 	struct nbd_sock *nsock = config->socks[index];
 	int fallback = nsock->fallback_index;
+	int i;
 
 	if (test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
 		return new_index;
 
-	if (config->num_connections <= 1) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Dead connection, failed to find a fallback\n");
-		return new_index;
-	}
+	if (config->num_connections <= 1)
+		goto no_fallback;
 
 	if (fallback >= 0 && fallback < config->num_connections &&
 	    !config->socks[fallback]->dead)
 		return fallback;
 
-	if (nsock->fallback_index < 0 ||
-	    nsock->fallback_index >= config->num_connections ||
-	    config->socks[nsock->fallback_index]->dead) {
-		int i;
-		for (i = 0; i < config->num_connections; i++) {
-			if (i == index)
-				continue;
-			if (!config->socks[i]->dead) {
-				new_index = i;
-				break;
-			}
-		}
-		nsock->fallback_index = new_index;
-		if (new_index < 0) {
-			dev_err_ratelimited(disk_to_dev(nbd->disk),
-					    "Dead connection, failed to find a fallback\n");
-			return new_index;
+	for (i = 0; i < config->num_connections; i++) {
+		if (i != index && !config->socks[i]->dead) {
+			new_index = i;
+			break;
 		}
 	}
-	new_index = nsock->fallback_index;
+	nsock->fallback_index = new_index;
+	if (new_index >= 0)
+		return new_index;
+
+no_fallback:
+	dev_err_ratelimited(disk_to_dev(nbd->disk),
+			    "Dead connection, failed to find a fallback\n");
 	return new_index;
 }
 
-- 
2.52.0

