Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BE7C636D4
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 16:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBOQcV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjBOQcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 11:32:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B9B3B0E4
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 08:32:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r2so19754555wrv.7
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfuueqXo6KJuWiRPOt3VVKLrd7ni9o9ZWdxoAzKHmB8=;
        b=I7FdSZktpCfMsHvyrAcsUZA31ZVE0ukxsrMHIWqQlSYfCR6snWSyzljTLVLN3k8Hj4
         9qbQW+RR9ROr93PyYgwJVTefWCHjWFU87vohjYb5dCGWl3SN2cq/P5OWHL7gng58vfiu
         utbNz5VB/9aXgGqykJ2ORgP/oW+/eHSQmcvEr4yaPowg7N2FHN6QiA0Rkue8JDCj5qcm
         NVAff0/FDdf6l5+6amxy6vmirFx3kjRO0Hgf+yLiOr+lwICYAnc8KprcXt5CQgdSJ8Z+
         lKS9cHJplKDzhmQ6zbiMLlhjPWTpCYgLBpZwWCKlxyGfQzNntEO9z/+Xaneq+bFsDSmw
         Dl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfuueqXo6KJuWiRPOt3VVKLrd7ni9o9ZWdxoAzKHmB8=;
        b=bqjsArgxIy2VQVbCZp0RAzaMdxS8HhOzvbGznC60iivdf/OsHZpAIzhEP+lVNmpV4U
         U56KzxpcKMYDqTrs16m7PKgwD/h3h83zBXeaTFqVCwP3+LOb9Z4cRKDlD8RFMoA3lkjq
         oIiJH1EGaHNC0DJ34a1ffff1XCi+HhJjRdZnBkGBb+u0vS4HW4ygzQ3RuqVAzV5K2VKN
         i92r/qANJEo8yifq1XdymAoO6v+fcb5+N21Ou06HWmAC2ReWuBAelgIqOFYvlRRMpS3t
         W7qIxhyOVM5wr1pracg4FeBL3D9QuSRn0QQOgcAvUqAswQOMlK47hKjqIQlDaTar87Ff
         8gCA==
X-Gm-Message-State: AO0yUKUi37oHU40ad63/CrWZTCFVZNqWPKOw8CBrOb/u13PA0Nc8gA2s
        ldGRMHuZKhxZKOXdsMlGhBn9Lg==
X-Google-Smtp-Source: AK7set+vA/ojSvJlZkdnLh/rvLe+XnnfOFf2xCBVlkRhCuxNj+j0FheIwfvsrPeR14v305Tctbk22A==
X-Received: by 2002:a5d:58c7:0:b0:2bf:ae11:c40c with SMTP id o7-20020a5d58c7000000b002bfae11c40cmr2089175wrf.32.1676478731196;
        Wed, 15 Feb 2023 08:32:11 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b002c56287bd2csm4865055wrw.114.2023.02.15.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:32:10 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 5/7] drbd: pass a peer_device to more bitmap functions
Date:   Wed, 15 Feb 2023 17:32:02 +0100
Message-Id: <20230215163204.2856631-6-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
References: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_bitmap.c   |  6 ++++--
 drivers/block/drbd/drbd_int.h      | 15 ++++++++++-----
 drivers/block/drbd/drbd_main.c     |  4 ++--
 drivers/block/drbd/drbd_nl.c       |  5 +++--
 drivers/block/drbd/drbd_receiver.c |  2 +-
 drivers/block/drbd/drbd_state.c    | 12 +++++++-----
 drivers/block/drbd/drbd_worker.c   |  3 ++-
 7 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 7d8e3b02a1da..6ac8c54b44c7 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1241,7 +1241,8 @@ int drbd_bm_write(struct drbd_device *device,
  *
  * Will write all pages.
  */
-int drbd_bm_write_all(struct drbd_device *device) __must_hold(local)
+int drbd_bm_write_all(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	return bm_rw(device, BM_AIO_WRITE_ALL_PAGES, 0);
 }
@@ -1267,7 +1268,8 @@ int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_ho
  * verify is aborted due to a failed peer disk, while local IO continues, or
  * pending resync acks are still being processed.
  */
-int drbd_bm_write_copy_pages(struct drbd_device *device) __must_hold(local)
+int drbd_bm_write_copy_pages(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
 }
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 8b4d06e10365..345e96ceb47c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -66,6 +66,7 @@ extern int drbd_proc_details;
 
 struct drbd_device;
 struct drbd_connection;
+struct drbd_peer_device;
 
 /* Defines to control fault insertion */
 enum {
@@ -1068,13 +1069,15 @@ extern void drbd_md_mark_dirty(struct drbd_device *device);
 extern void drbd_queue_bitmap_io(struct drbd_device *device,
 				 int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 				 void (*done)(struct drbd_device *, int),
-				 char *why, enum bm_flag flags);
+				 char *why, enum bm_flag flags,
+				 struct drbd_peer_device *peer_device);
 extern int drbd_bitmap_io(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
-		char *why, enum bm_flag flags);
+		char *why, enum bm_flag flags, struct drbd_peer_device *);
 extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
-		char *why, enum bm_flag flags);
+		char *why, enum bm_flag flags,
+		struct drbd_peer_device *peer_device);
 extern int drbd_bmio_set_n_write(struct drbd_device *device,
 		struct drbd_peer_device *peer_device) __must_hold(local);
 extern int drbd_bmio_clear_n_write(struct drbd_device *device,
@@ -1295,8 +1298,10 @@ extern int  drbd_bm_write(struct drbd_device *device,
 extern void drbd_bm_reset_al_hints(struct drbd_device *device) __must_hold(local);
 extern int  drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local);
 extern int  drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_hold(local);
-extern int drbd_bm_write_all(struct drbd_device *device) __must_hold(local);
-extern int  drbd_bm_write_copy_pages(struct drbd_device *device) __must_hold(local);
+extern int drbd_bm_write_all(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
+extern int  drbd_bm_write_copy_pages(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local);
 extern size_t	     drbd_bm_words(struct drbd_device *device);
 extern unsigned long drbd_bm_bits(struct drbd_device *device);
 extern sector_t      drbd_bm_capacity(struct drbd_device *device);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6f2955f2dcc9..6647f84f3879 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1198,7 +1198,7 @@ static int fill_bitmap_rle_bits(struct drbd_device *device,
  * code upon failure.
  */
 static int
-send_bitmap_rle_or_plain(struct drbd_peer_device *device, struct bm_xfer_ctx *c)
+send_bitmap_rle_or_plain(struct drbd_peer_device *peer_device, struct bm_xfer_ctx *c)
 {
 	struct drbd_device *device = peer_device->device;
 	struct drbd_socket *sock = &peer_device->connection->data;
@@ -1269,7 +1269,7 @@ static int _drbd_send_bitmap(struct drbd_device *device,
 		if (drbd_md_test_flag(device->ldev, MDF_FULL_SYNC)) {
 			drbd_info(device, "Writing the whole bitmap, MDF_FullSync was set.\n");
 			drbd_bm_set_all(device);
-			if (drbd_bm_write(device)) {
+			if (drbd_bm_write(device, peer_device)) {
 				/* write_bm did fail! Leave full sync flag set in Meta P_DATA
 				 * but otherwise process as per normal - need to tell other
 				 * side that a full resync is required! */
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 07a52c5a2989..8967298968f3 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3007,11 +3007,12 @@ static int drbd_adm_simple_request_state(struct sk_buff *skb, struct genl_info *
 	return 0;
 }
 
-static int drbd_bmio_set_susp_al(struct drbd_device *device) __must_hold(local)
+static int drbd_bmio_set_susp_al(struct drbd_device *device,
+		struct drbd_peer_device *peer_device) __must_hold(local)
 {
 	int rv;
 
-	rv = drbd_bmio_set_n_write(device);
+	rv = drbd_bmio_set_n_write(device, peer_device);
 	drbd_suspend_al(device);
 	return rv;
 }
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 8605b5154a7e..e352880c70b5 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4878,7 +4878,7 @@ static int receive_bitmap(struct drbd_connection *connection, struct packet_info
 	if (device->state.conn == C_WF_BITMAP_T) {
 		enum drbd_state_rv rv;
 
-		err = drbd_send_bitmap(device);
+		err = drbd_send_bitmap(device, peer_device);
 		if (err)
 			goto out;
 		/* Omit CS_ORDERED with this state transition to avoid deadlocks. */
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 0b335ddd6d12..c92dc6093b0a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1810,7 +1810,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	    device->state.conn == C_WF_BITMAP_S)
 		drbd_queue_bitmap_io(device, &drbd_send_bitmap, NULL,
 				"send_bitmap (WFBitMapS)",
-				BM_LOCKED_TEST_ALLOWED);
+				BM_LOCKED_TEST_ALLOWED, peer_device);
 
 	/* Lost contact to peer's copy of the data */
 	if (lost_contact_to_peer_data(os.pdsk, ns.pdsk)) {
@@ -1840,7 +1840,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			 * No harm done if the bitmap still changes,
 			 * redirtied pages will follow later. */
 			drbd_bitmap_io_from_worker(device, &drbd_bm_write,
-				"demote diskless peer", BM_LOCKED_SET_ALLOWED);
+				"demote diskless peer", BM_LOCKED_SET_ALLOWED, peer_device);
 		put_ldev(device);
 	}
 
@@ -1852,7 +1852,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		/* No changes to the bitmap expected this time, so assert that,
 		 * even though no harm was done if it did change. */
 		drbd_bitmap_io_from_worker(device, &drbd_bm_write,
-				"demote", BM_LOCKED_TEST_ALLOWED);
+				"demote", BM_LOCKED_TEST_ALLOWED, peer_device);
 		put_ldev(device);
 	}
 
@@ -1889,7 +1889,8 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		/* no other bitmap changes expected during this phase */
 		drbd_queue_bitmap_io(device,
 			&drbd_bmio_set_n_write, &abw_start_sync,
-			"set_n_write from StartingSync", BM_LOCKED_TEST_ALLOWED);
+			"set_n_write from StartingSync", BM_LOCKED_TEST_ALLOWED,
+			peer_device);
 
 	/* first half of local IO error, failure to attach,
 	 * or administrative detach */
@@ -2012,7 +2013,8 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 	if ((os.conn > C_CONNECTED && os.conn < C_AHEAD) &&
 	    (ns.conn == C_CONNECTED || ns.conn >= C_AHEAD) && get_ldev(device)) {
 		drbd_queue_bitmap_io(device, &drbd_bm_write_copy_pages, NULL,
-			"write from resync_finished", BM_LOCKED_CHANGE_ALLOWED);
+			"write from resync_finished", BM_LOCKED_CHANGE_ALLOWED,
+			peer_device);
 		put_ldev(device);
 	}
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index f46738040d6b..68d5ba4af17d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1945,6 +1945,7 @@ static void drbd_ldev_destroy(struct drbd_device *device)
 
 static void go_diskless(struct drbd_device *device)
 {
+	struct drbd_peer_device *peer_device = first_peer_device(device);
 	D_ASSERT(device, device->state.disk == D_FAILED);
 	/* we cannot assert local_cnt == 0 here, as get_ldev_if_state will
 	 * inc/dec it frequently. Once we are D_DISKLESS, no one will touch
@@ -1970,7 +1971,7 @@ static void go_diskless(struct drbd_device *device)
 		 * Any modifications would not be expected anymore, though.
 		 */
 		if (drbd_bitmap_io_from_worker(device, drbd_bm_write,
-					"detach", BM_LOCKED_TEST_ALLOWED)) {
+					"detach", BM_LOCKED_TEST_ALLOWED, peer_device)) {
 			if (test_bit(WAS_READ_ERROR, &device->flags)) {
 				drbd_md_set_flag(device, MDF_FULL_SYNC);
 				drbd_md_sync(device);
-- 
2.39.1

