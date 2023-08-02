Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF3C001E0
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjHBOjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjHBOjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 10:39:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E68E0
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 07:39:05 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGF1S07z7zVjm6;
        Wed,  2 Aug 2023 22:37:16 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 22:39:00 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
        <christoph.boehmwalder@linbit.com>, <axboe@kernel.dk>
CC:     <drbd-dev@lists.linbit.com>, <linux-block@vger.kernel.org>,
        <yuehaibing@huawei.com>
Subject: [PATCH -next] drbd: Remove unused function declarations
Date:   Wed, 2 Aug 2023 22:38:57 +0800
Message-ID: <20230802143857.33900-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
index a30a5ed811be..6e68e8bbad9c 100644
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
@@ -1388,9 +1384,6 @@ extern void conn_free_crypto(struct drbd_connection *connection);
 extern void do_submit(struct work_struct *ws);
 extern void __drbd_make_request(struct drbd_device *, struct bio *);
 void drbd_submit_bio(struct bio *bio);
-extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
-extern int is_valid_ar_handle(struct drbd_request *, sector_t);
-
 
 /* drbd_nl.c */
 
@@ -1472,7 +1465,6 @@ extern int w_resync_timer(struct drbd_work *, int);
 extern int w_send_write_hint(struct drbd_work *, int);
 extern int w_send_dblock(struct drbd_work *, int);
 extern int w_send_read_req(struct drbd_work *, int);
-extern int w_e_reissue(struct drbd_work *, int);
 extern int w_restart_disk_io(struct drbd_work *, int);
 extern int w_send_out_of_sync(struct drbd_work *, int);
 
@@ -1486,7 +1478,6 @@ extern int drbd_issue_discard_or_zero_out(struct drbd_device *device,
 		sector_t start, unsigned int nr_sectors, int flags);
 extern int drbd_receiver(struct drbd_thread *thi);
 extern int drbd_ack_receiver(struct drbd_thread *thi);
-extern void drbd_send_ping_wf(struct work_struct *ws);
 extern void drbd_send_acks_wf(struct work_struct *ws);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_device, sector_t sector,
@@ -1502,7 +1493,6 @@ extern void __drbd_free_peer_req(struct drbd_device *, struct drbd_peer_request
 #define drbd_free_peer_req(m,e) __drbd_free_peer_req(m, e, 0)
 #define drbd_free_net_peer_req(m,e) __drbd_free_peer_req(m, e, 1)
 extern struct page *drbd_alloc_pages(struct drbd_peer_device *, unsigned int, bool);
-extern void drbd_set_recv_tcq(struct drbd_device *device, int tcq_enabled);
 extern void _drbd_clear_done_ee(struct drbd_device *device, struct list_head *to_be_freed);
 extern int drbd_connected(struct drbd_peer_device *);
 
-- 
2.34.1

