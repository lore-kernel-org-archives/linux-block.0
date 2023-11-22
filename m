Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC41A2;
	Tue, 21 Nov 2023 18:37:13 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SZlkr1NJdz4f3jMX;
	Wed, 22 Nov 2023 10:37:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CC8E71A01D0;
	Wed, 22 Nov 2023 10:37:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhBSaV1lNClcBg--.32716S7;
	Wed, 22 Nov 2023 10:37:09 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 3/3] block: warn once for each partition in bio_check_ro()
Date: Wed, 22 Nov 2023 18:31:03 +0800
Message-Id: <20231122103103.1104589-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhBSaV1lNClcBg--.32716S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1kXr15WF4xJF47ZrWDJwb_yoW8Ww1fpF
	nxKFyrGryjgrWxuan7GF13Aa4rGa1kWrW5ArWfZw1Yyay3K34Iq3Z2qr13Jr48uFWSkrW3
	Xr1jkrWrCFyDWrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiyCJDUUUUU=
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Commit 1b0a151c10a6 ("blk-core: use pr_warn_ratelimited() in
bio_check_ro()") fix message storm by limit the rate, however, there
will still be lots of message in the long term. Fix it better by warn
once for each partition.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c          | 14 +++++++++++---
 include/linux/blk_types.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f9f8b12ba626..6575f684d41e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -502,9 +502,17 @@ static inline void bio_check_ro(struct bio *bio)
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return;
-		pr_warn_ratelimited("Trying to write to read-only block-device %pg\n",
-				    bio->bi_bdev);
-		/* Older lvm-tools actually trigger this */
+
+		if (bdev_flagged(bio->bi_bdev, BD_FLAG_RO_WARNED))
+			return;
+
+		bdev_set_flag(bio->bi_bdev, BD_FLAG_RO_WARNED);
+		/*
+		 * Use ioctl to set underlying disk of raid/dm to read-only
+		 * will trigger this.
+		 */
+		pr_warn("Trying to write to read-only block-device %pg\n",
+			bio->bi_bdev);
 	}
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index de652045111b..a2185d2f02d9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -41,6 +41,7 @@ struct bio_crypt_ctx;
 #define BD_FLAG_WRITE_HOLDER	1
 #define BD_FLAG_HAS_SUBMIT_BIO	2
 #define BD_FLAG_MAKE_IT_FAIL	3
+#define BD_FLAG_RO_WARNED	4
 
 struct block_device {
 	sector_t		bd_start_sect;
-- 
2.39.2

