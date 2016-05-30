Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34233 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161537AbcE3Ngq (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 30 May 2016 09:36:46 -0400
From: Ming Lei <ming.lei@canonical.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@canonical.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linbit.com (open list:DRBD DRIVER)
Subject: [PATCH v6 7/8] block: drbd: avoid to use BIO_MAX_SIZE
Date: Mon, 30 May 2016 21:34:35 +0800
Message-Id: <1464615294-9946-8-git-send-email-ming.lei@canonical.com>
In-Reply-To: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use BIO_MAX_PAGES instead and we will remove BIO_MAX_SIZE.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/block/drbd/drbd_int.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 7a1cf7e..e6e4b08 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1327,14 +1327,14 @@ struct bm_extent {
 #endif
 #endif
 
-/* BIO_MAX_SIZE is 256 * PAGE_SIZE,
+/* Estimate max bio size as 256 * PAGE_SIZE,
  * so for typical PAGE_SIZE of 4k, that is (1<<20) Byte.
  * Since we may live in a mixed-platform cluster,
  * we limit us to a platform agnostic constant here for now.
  * A followup commit may allow even bigger BIO sizes,
  * once we thought that through. */
 #define DRBD_MAX_BIO_SIZE (1U << 20)
-#if DRBD_MAX_BIO_SIZE > BIO_MAX_SIZE
+#if DRBD_MAX_BIO_SIZE > (BIO_MAX_PAGES << PAGE_SHIFT)
 #error Architecture not supported: DRBD_MAX_BIO_SIZE > BIO_MAX_SIZE
 #endif
 #define DRBD_MAX_BIO_SIZE_SAFE (1U << 12)       /* Works always = 4k */
-- 
1.9.1

