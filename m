Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F955CA64
	for <linux-block@vger.kernel.org>; Sun, 24 Dec 2023 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GIbM3uEb"
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id HSP5rZNROiIuMHSP5rdHda; Sun, 24 Dec 2023 18:36:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1703439404;
	bh=/Xrwq4JtY3OSAfkwHWxb6r0DI+lLpVMm6KFhZBMoZ8E=;
	h=From:To:Cc:Subject:Date;
	b=GIbM3uEbJVEDTx/e7Zk17if2KvnT7AeMB2P/kINEt6QqFXlSYmYC2J/JAZC7EveMM
	 RdZRDRoMHEow7p8vHv2GSt7Ir/nWhO7zWbK3yMQQoZ6rvzgGzySKswT/qg9HNTqatT
	 YvTZBFKRTKIJ81OYLnBHKxE+7yE+1ms0AFGQUW5HrNfMlMzUpcZL4ecZnroamcJ+2v
	 jIAgpeEo5ofIqLEIlZ5GVMmloHU5thouD81Bfd4kvDjMmibiJ7Ep3QHiOUuas/2DMs
	 f+JPvv0KYD3Owvv+ukH7K0wlEcmOb12wksNrpqpytRguXZ/YxMfgTXeSpSdB5jeW8S
	 E/J6lMWO+ZqFQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Dec 2023 18:36:44 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: Fix a memory leak in bdev_open_by_dev()
Date: Sun, 24 Dec 2023 18:36:42 +0100
Message-Id: <8eaec334781e695810aaa383b55de00ca4ab1352.1703439383.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we early exit here, 'handle' needs to be freed, or some memory leaks.

Fixes: ed5cc702d311 ("block: Add config option to not allow writing to mounted devices")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The code could also be re-arranged to delay the memory allocation.
This would be cleaner IMHO.
---
 block/bdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 6f73b02d549c..e9f1b12bd75c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -830,8 +830,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		goto free_handle;
 
 	/* Blocking writes requires exclusive opener */
-	if (mode & BLK_OPEN_RESTRICT_WRITES && !holder)
-		return ERR_PTR(-EINVAL);
+	if (mode & BLK_OPEN_RESTRICT_WRITES && !holder) {
+		ret = -EINVAL;
+		goto free_handle;
+	}
 
 	bdev = blkdev_get_no_open(dev);
 	if (!bdev) {
-- 
2.34.1

