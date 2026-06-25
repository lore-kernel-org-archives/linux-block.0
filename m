Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525338550E
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377539; cv=none; b=ONUvK7CBob4cYrybQ9xbM39XRya3jUbeTgFRsxYR8kJkVr5z4W/WmTdzzfUF4TEiy4BKCHcSTXZm0+v0crkhtqKk6Ga27B9yshqyEBLSyGRKDzZEv1YR7+4GchTvq9ozrqdYNK2XqllA7u/QC+JWOXQvIUbVnjk8GQ6j/o3FekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377539; c=relaxed/simple;
	bh=LPaF4f9aTyKFE2EF+9SMsok2O54ApF9xd9hfQg8JeoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+0r7NAt+Y/poNvRdQNBqM7QH5b4PlM83n1rLZH1qHE3+Im9jA/eS7GGgc6ZowN5XLkBWm4Spow5G9i3g33fQ+evZx+pmN5fOoikXfG5Km5eDn3AEIQZ/w9A52iR5XvPjXZ3gU4NvXI89L0wwZm5wT1I5wc+VS9l1BZP5+iY1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gmCG22VKCzYQthR
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 16:51:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 495734056B
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 16:52:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3rYIw7DxqlmUxDA--.39891S5;
	Thu, 25 Jun 2026 16:52:06 +0800 (CST)
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
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v2 1/5] nbd: simplify find_fallback() by removing redundant logic
Date: Thu, 25 Jun 2026 16:44:54 +0800
Message-ID: <20260625084458.4171890-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260625084458.4171890-1-yangerkun@huawei.com>
References: <20260625084458.4171890-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3rYIw7DxqlmUxDA--.39891S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15ur1kWrW8uw1UKr45ZFb_yoW8tr13pF
	WrZFyfKryUJ3W3ur4ava1UuF15Cws3Ga1UGFW8Ja4xuryUCryUuFZ3tF1ftayUJrZrZFyq
	vF1UWFy2kFn8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Long Li <leo.lilong@huawei.com>

The second conditional checking nsock->fallback_index validity is the
logical inverse of the first, so drop it and let execution fall through
naturally. Consolidate the two identical dev_err_ratelimited() + return
paths into a single no_fallback label to reduce duplication.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 drivers/block/nbd.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3a585a0c882a..dcba3042862a 100644
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

