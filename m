Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132FD1C2BD;
	Fri,  2 Aug 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592478; cv=none; b=NgXQsdbl04TFqvqMvEXOya4QUGuCBlh81rdTt6efHR4EnoVF3uvCUwSpypiXXmBUXWCyxfDAIinbSKAz+z0WglHLwfIUlkbLJNGtXwElsznNdduoKvpCflsWgZYVvdAs1yEo3yd7mhUKvLwc76TSUXMyszNbE4RzIkhJqvp+c+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592478; c=relaxed/simple;
	bh=pG7QYf5atpiLxIdlu12CXatOzGN8tq3O56ZKUROVJlI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SPmyQX75Yj0Ta1ZPBHMT2OPXkTh16QN0NskWzHlUGY5xPLI7up0VI/dNhRWUt7JrpVExDQSFPYGFxXYsX5mrHgpm/4yw7tmXHIZ2Zk/WiaA1/cwgMEWr2bCtLGsnbNtWdwnXaHCohqs9RFyCvrCIabV9hdvGwZUvevgdLd3ssWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wb1KB0j6vz20l2V;
	Fri,  2 Aug 2024 17:50:06 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id CAFB91402CF;
	Fri,  2 Aug 2024 17:54:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 2 Aug
 2024 17:54:26 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
	<christoph.boehmwalder@linbit.com>, <axboe@kernel.dk>, <brauner@kernel.org>,
	<yuehaibing@huawei.com>
CC: <drbd-dev@lists.linbit.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drbd: Remove unused extern declarations
Date: Fri, 2 Aug 2024 17:51:47 +0800
Message-ID: <20240802095147.2788218-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

From: YueHaibing <yuehaibing@huawei.com>

Commit b411b3637fa7 ("The DRBD driver") declared but never implemented
drbd_read_remote(), is_valid_ar_handle() and drbd_set_recv_tcq().
And commit 668700b40a7c ("drbd: Create a dedicated workqueue for sending acks on the control connection")
never implemented drbd_send_ping_wf().

Commit 2451fc3b2bd3 ("drbd: Removed the BIO_RW_BARRIER support form the receiver/epoch code")
leave w_e_reissue() declaration unused.

Commit 8fe605513ab4 ("drbd: Rename drbdd_init() -> drbd_receiver()")
rename drbdd_init() and leave unsued declaration. Also drbd_asender() is removed in
commit 1c03e52083c8 ("drbd: Rename asender to ack_receiver").

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/block/drbd/drbd_int.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 94dc0a235919..d2937bca1fe4 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -297,10 +297,6 @@ struct drbd_epoch {
 	unsigned long flags;
 };
 
-/* Prototype declaration of function defined in drbd_receiver.c */
-int drbdd_init(struct drbd_thread *);
-int drbd_asender(struct drbd_thread *);
-
 /* drbd_epoch flag bits */
 enum {
 	DE_HAVE_BARRIER_NUMBER,
@@ -1390,9 +1386,6 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 extern void do_submit(struct work_struct *ws);
 extern void __drbd_make_request(struct drbd_device *, struct bio *);
 void drbd_submit_bio(struct bio *bio);
-extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
-extern int is_valid_ar_handle(struct drbd_request *, sector_t);
-
 
 /* drbd_nl.c */
 
@@ -1474,7 +1467,6 @@ extern int w_resync_timer(struct drbd_work *, int);
 extern int w_send_write_hint(struct drbd_work *, int);
 extern int w_send_dblock(struct drbd_work *, int);
 extern int w_send_read_req(struct drbd_work *, int);
-extern int w_e_reissue(struct drbd_work *, int);
 extern int w_restart_disk_io(struct drbd_work *, int);
 extern int w_send_out_of_sync(struct drbd_work *, int);
 
@@ -1488,7 +1480,6 @@ extern int drbd_issue_discard_or_zero_out(struct drbd_device *device,
 		sector_t start, unsigned int nr_sectors, int flags);
 extern int drbd_receiver(struct drbd_thread *thi);
 extern int drbd_ack_receiver(struct drbd_thread *thi);
-extern void drbd_send_ping_wf(struct work_struct *ws);
 extern void drbd_send_acks_wf(struct work_struct *ws);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_device, sector_t sector,
@@ -1504,7 +1495,6 @@ extern void __drbd_free_peer_req(struct drbd_device *, struct drbd_peer_request
 #define drbd_free_peer_req(m,e) __drbd_free_peer_req(m, e, 0)
 #define drbd_free_net_peer_req(m,e) __drbd_free_peer_req(m, e, 1)
 extern struct page *drbd_alloc_pages(struct drbd_peer_device *, unsigned int, bool);
-extern void drbd_set_recv_tcq(struct drbd_device *device, int tcq_enabled);
 extern void _drbd_clear_done_ee(struct drbd_device *device, struct list_head *to_be_freed);
 extern int drbd_connected(struct drbd_peer_device *);
 
-- 
2.34.1

