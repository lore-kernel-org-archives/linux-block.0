Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E629D29E;
	Fri, 27 Mar 2026 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603458; cv=none; b=hDlZMBJ1ipWcaE4Q8lXp/9EXoVVI5dKDNWhtt1Md5DXKetfPrgfAU6Mn+11RXkuTVc1UJ3tK+aaYXlSOb2hjkD/CVkHDKKSi7smGqgHts56GLW+MuHWgujn7aMhP4+0ni+Q0C9McByUr/UeCacS1ErbLy6dI/jrvIJB/PaZaoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603458; c=relaxed/simple;
	bh=Wpgs7Jw4AKDqCnA6eG8+j0JWhZ8t4B4Ze7no1TgzV9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjAxds6C7W9eAEWoryy7po+qOOowbGujAsewcY0/D09f7sHAu0TVTvi61F7S8V8uQjwwEseWnMkWR54k04aleNSAfe0hZUnJxGgcYfEwyHA3ymo4gznuFET+6G+wQPy29tKT+Npn3Ri06Lh0qPCQ3lk1+nLxZAR1wWGtAFlYQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fhwFC63HqzYQvDS;
	Fri, 27 Mar 2026 17:23:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5C31D4058D;
	Fri, 27 Mar 2026 17:24:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgAHC9uyTMZpTlaWCQ--.27625S7;
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
Subject: [PATCH 3/4] nbd: remove redundant num_connections boundary checks
Date: Fri, 27 Mar 2026 17:12:22 +0800
Message-Id: <20260327091223.4147956-4-leo.lilong@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAHC9uyTMZpTlaWCQ--.27625S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1rArWkGw1furW7tFyrWFg_yoW8AF4UpF
	45uay0krWUJF1fZF4FyaykWryUAanxGa97W3W8Aa1IyFy5ury0kFZ8KFyIgFyUJrZ5ZrZF
	vFs8GF1rAF17GrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_JF0_Jw
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFMKZDUUUU
X-CM-SenderInfo: hohrhzxlor0w46kxt4xhlfz01xgou0bp/

From: Long Li <leo.lilong@huawei.com>

Now that config->socks uses xarray instead of a plain array, explicit
bounds checking against num_connections is no longer necessary.
xa_load() returns NULL for any out-of-range or missing index, and
xa_for_each() is a no-op on an empty xarray, making these guards
redundant.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 drivers/block/nbd.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 728db2e832f8..1606cdaa868d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1094,7 +1094,7 @@ static int find_fallback(struct nbd_device *nbd, int index)
 		goto no_fallback;
 
 	fallback = nsock->fallback_index;
-	if (fallback >= 0 && fallback < config->num_connections) {
+	if (fallback >= 0) {
 		fallback_nsock = xa_load(&config->socks, fallback);
 		if (fallback_nsock && !fallback_nsock->dead)
 			return fallback;
@@ -1149,12 +1149,6 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		return BLK_STS_IOERR;
 	}
 
-	if (index >= config->num_connections) {
-		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Attempted send on invalid socket\n");
-		nbd_config_put(nbd);
-		return BLK_STS_IOERR;
-	}
 	cmd->status = BLK_STS_OK;
 again:
 	nsock = xa_load(&config->socks, index);
@@ -1475,11 +1469,9 @@ static void nbd_config_put(struct nbd_device *nbd)
 		}
 		nbd_clear_sock(nbd);
 
-		if (config->num_connections) {
-			xa_for_each(&config->socks, i, nsock) {
-				sockfd_put(nsock->sock);
-				kfree(nsock);
-			}
+		xa_for_each(&config->socks, i, nsock) {
+			sockfd_put(nsock->sock);
+			kfree(nsock);
 		}
 		xa_destroy(&config->socks);
 
-- 
2.39.2

