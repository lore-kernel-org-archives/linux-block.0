Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Sage Weil <sage@redhat.com>,
	Alex Elder <elder@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rbd: fix spelling mistake: "reregisteration" -> "re-registration"
Date: Mon, 19 Mar 2018 13:33:10 +0000
Message-Id: <20180319133310.4251-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in rdb_warn message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1e03b04819c8..7b97240ff15e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3887,7 +3887,7 @@ static void rbd_reregister_watch(struct work_struct *work)
 
 	ret = rbd_dev_refresh(rbd_dev);
 	if (ret)
-		rbd_warn(rbd_dev, "reregisteration refresh failed: %d", ret);
+		rbd_warn(rbd_dev, "re-registration refresh failed: %d", ret);
 }
 
 /*
-- 
2.15.1
