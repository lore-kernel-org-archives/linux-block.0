Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A7384CFB
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377539; cv=none; b=UO+JOPRebHsZF7dDsg5IdKbvgigzJ+2shbm0fjLzTw5T8b9yz413hLQTdaZbFK8SO22HkerQoTjOdjSDhXrUiBc37bcBs6EIhuJ/TXwHWIo0rj2bxsQ7cUU1zEVtfQ1MGQzLT4S3rj4S9hcIGxjSG3gXzxyOoZrpP84qy4XzdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377539; c=relaxed/simple;
	bh=XZhMNNw5ajjnEOLVcQgZbri5CZTxDEd28PRR1w0X+ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNFkDI5SR2dOg6c4m7Rk7Pq1s9PxACMhActhMrAxk1Uy8pH9TL0UteWqq7ORC+wIYsf4X6/0IkWOzY0hnFglIERdLuV+ZHEQlCY1sS/kBpqdf5ZNjl4wE2nwjIQ6Ge2TDO4sKEXUueSO/0HxrvRsIi8Zf0NXto2/LN7VFNZCNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gmCG23RDjzYQtj9
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 16:51:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 69D5F4058C
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 16:52:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3rYIw7DxqlmUxDA--.39891S7;
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
Subject: [PATCH v2 3/5] nbd: remove redundant num_connections boundary checks
Date: Thu, 25 Jun 2026 16:44:56 +0800
Message-ID: <20260625084458.4171890-4-yangerkun@huawei.com>
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
X-CM-TRANSID:Syh0CgA3rYIw7DxqlmUxDA--.39891S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1rArWkGw1furW7tFyrWFg_yoW8AF4UpF
	45uay0krW8JF1fZF4FyaykWryYyanxGa97W3W8Ja1xAFy5Cry0kF98KFyIgFyUJrZ5Z39F
	vFs8GF1fAF1UGrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
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
	daVFxhVjvjDU0xZFpf9x07UHwZ7UUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

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
index d88bdc97f4d1..409a655c40f0 100644
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
@@ -1512,11 +1506,9 @@ static void nbd_config_put(struct nbd_device *nbd)
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
2.52.0

