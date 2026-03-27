Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30E3DB64B;
	Fri, 27 Mar 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603457; cv=none; b=nN0lnrXzh2huY6DRp0p2CCdRUJWFiaCIg1aANgAISTeCGanjpbmpJSkLKHa8AQP9a3D8XJbws2VgLLLGBnFfR6Jv7dAta7J3zzuu5FxWlu7UXC0wzr8bIqE8ud06vZvWOcfUWk5GRheIDdEEtjCHhUK6ygmBkT78WfyiWtOyNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603457; c=relaxed/simple;
	bh=YOLokWSdToD8kI4grwc+wFe7gCSIYg9o99s09E+DHHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naWmYtU+pAGLpU6w/13ST4OEysxV30WzhGm6IZZQfvpKTZhNICOmxMsu79o+2S5TiqqxUfTNLPRb8GFj7r3QEGANnaIK2emgpy4r+//QLrpfi34QrE+276Na7UGtaGwyamL0vsqYwMG+dHHkFsq5I9kS1SzA13xLFNhOM6jE0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhwDg4WKxzKHMkH;
	Fri, 27 Mar 2026 17:23:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3BDB040574;
	Fri, 27 Mar 2026 17:24:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgAHC9uyTMZpTlaWCQ--.27625S5;
	Fri, 27 Mar 2026 17:24:13 +0800 (CST)
From: leo.lilong@huaweicloud.com
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: leo.lilong@huawei.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lonuxli.64@gmail.com
Subject: [PATCH 1/4] nbd: simplify find_fallback() by removing redundant logic
Date: Fri, 27 Mar 2026 17:12:20 +0800
Message-Id: <20260327091223.4147956-2-leo.lilong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
References: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHC9uyTMZpTlaWCQ--.27625S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1fCF48uFW7tryUuFWkCrg_yoW8tFy7pF
	WfZFyfKryUJ3W3ur43Za1UuF15Cws3Ga1UGFW8Ja4xuryUCryUuFZ3tF1ftay5JrZxZFyq
	vF1UWFy7CFn8Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_JF0_Jw
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7zuWDUUUU
X-CM-SenderInfo: hohrhzxlor0w46kxt4xhlfz01xgou0bp/

From: Long Li <leo.lilong@huawei.com>

Remove the intermediate new_index variable and return -1 directly.
The second conditional checking nsock->fallback_index validity is the
logical inverse of the first, so drop it and let execution fall through
naturally. Consolidate the two identical dev_err_ratelimited() + return
paths into a single no_fallback label to reduce duplication.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 drivers/block/nbd.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fe63f3c55d0d..f26ad2f1f3ff 100644
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
2.39.2

