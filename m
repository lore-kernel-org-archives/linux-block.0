Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED73B9D8D
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400203; cv=none; b=YsQyVLJf4EOpKvmIu+l1fVYbkl2mxk9fQBoEPf/JRZ6jPVXiXj7Jy6xarqiJgvjUUeT4y73FaOriGaR/0CiMOA3CzdrAiP3h5/i34lkoldtAqrF75mFMhdLskHjIrjmK4TTCRgl00qfT+ylHECVG6enkBzmxEZ1B7s5o+YjLvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400203; c=relaxed/simple;
	bh=kv6a6LxiTWXL5U2GgJxzrIpyqlsIMoi3BKGbxX/asTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Md3D22fbVYK3EbSYER4tj1kPKDd6iSfRKRqBagmtackmDpwwqkYEPmwcwi/+ybwgcDIvz0zHokhpKiz0QVHvOgRu6pVIrzctkJIdoNU0krs2gZmXE9T4CgSOCiZCBYOmWE4TfCQYjg9TdvoqlBjoxo9zl9+Lyqu6c6kG+ReAjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h9j620xJYzKHMgL
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:28:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 88D5B40575
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:29:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgCnlkV9C2tqwObjAQ--.20420S5;
	Thu, 30 Jul 2026 16:29:54 +0800 (CST)
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
Subject: [PATCH v5 1/8] nbd: simplify find_fallback() by removing redundant logic
Date: Thu, 30 Jul 2026 16:20:39 +0800
Message-ID: <20260730082046.3459239-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260730082046.3459239-1-yangerkun@huawei.com>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnlkV9C2tqwObjAQ--.20420S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15ur1kWrW8uw1UKr45ZFb_yoW8tF1UpF
	WfZFyfKryUXF13uF43Za1UuF1rCan3Ga1UGFW8Ja4xuryDCryUuFZ3tF1ftayUJrZxZF9F
	vF1UGFy2kFn8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07jnWrAUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Long Li <leo.lilong@huawei.com>

The second conditional checking nsock->fallback_index validity is the
logical inverse of the first, so drop it and let execution fall through
naturally. Consolidate the two identical dev_err_ratelimited() + return
paths into a single no_fallback label to reduce duplication.

Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Yu Kuai <yukuai@fygo.io>
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

