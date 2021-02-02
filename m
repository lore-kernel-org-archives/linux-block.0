Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB3C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B245D64EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhBBFiF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:38:05 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60410 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhBBFiC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244281; x=1643780281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/sbuZDoO/tuTi4agpwhNzOmQchNsnt7PWfWjd/zx47k=;
  b=W8XXCBIjCzx8GXrARbvC/itSlXs8EOdnkEpRdrrZsuzDMBSe5To4PB0j
   fEqpJlJ77rHEGMlFYnCYMtNu2dDmmrKG5U0yvrPiG5419bmJv+pm5iFOP
   +6A1VmGNHDfz8TQjXLU0/dQuA791yf20kbaxjQdlY+WGKOODrVFnUQ26Y
   PY+1kSGpt7X1TzGHfXYjH7Q0OjK/W6EMfrq9XdvAL1OuWdTZevhN7BAH+
   1MJGxFb3HXG0qI6MSV75a38FXhjMU8ZiovtfxA0HET+0u6bfMm/K6LnZ0
   +T9+VpNZ4BlYqnH5o65a8nKeXi7pHOG78LOC0rR8Ady/3bmGCy9JhCylQ
   g==;
IronPort-SDR: QJqvRF5uzVJAwsiY2wz/RO2HNIT+0JD+Jas0RNXwJANapdWXtFnRtha7iRxknRGflwHyL517kJ
 7jh949NLod7ODSyYZEw1UufKK+HEWGLrlcv5sMe5FY2FL9xsQKZ4WCmgI16gMNTmfCFhuauSkX
 UUlglB65urpsRUFqdjFlNxoX2mKU/PSQsD/JbQJlv3w4yk1hUGMHXF9jJmfZ/3cXxe9LPhPVut
 5N/fMdKCPhwON0FFd8LQ/52Ng/cXKnRJhz+jDqMwtA9bawt9cZpI6ireH87yb6dCmxlflQJNPr
 mAg=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="269301781"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:36:55 +0800
IronPort-SDR: cPD+KEjeJKpSggkrF2sbVQ30fDxAdvbrldONkh8gpTyCOYYsV7qMR+gfcJs8GsvVSE/VBqWDqM
 ezvL7brM5s1qB0x8REPTuGEIYDlGKWhdmCAKlPAlYazwwXeJVyp/PLjS7RXUjVrzgx9v4rE2Jv
 2xSQdv+Wy9zxKTp+VVXVa0ZUFjujVO5D2AkEB+bO3DrqdUKOobDUJT57IRmf1cN34flNEvGGfh
 lIUqCZxh+GDzHpE7lOsoq0rmeWNTb9VP/nraxKm+0LXpQM++VKYEhkSXRnMuM/k8Q7MYm6x4CK
 9gnN6F7Sgq59/vOjt+4BFP6p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:21:05 -0800
IronPort-SDR: sDKPYjxpVz5VeXWvNW7FXoN/DGgx4jxfWwKDH4RGOD82jRua5eq4QzPFx9tvxWy7wWxXU6fVn6
 YVV+XCuXe1x5npLwOnwFkacKiZ7QuB4vjm6G2jBpwWD6QAykL7VYd4cxyyM0M8IowoJw/sy6Vy
 inVlhZYgNIFzN/CJJ4FifglfmurTY4nBZyaq/7FRt4KQPYSwF6f2FBv1TLuRi3LoAcoRGyilnA
 REsrVeE/yvorU/M0rY9mJ4Olzfw32OMcwQxJAsD4/BWa2Xji8cVXT2hWCFWIS0qPrtAdwrfnWz
 q6E=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:36:56 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 08/20] loop: use uniform function header style
Date:   Mon,  1 Feb 2021 21:35:40 -0800
Message-Id: <20210202053552.4844-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are two different styles present in the code right now, that
creates a confusion for a new developer on which style to follow. Since
this is a block driver follow common coding style for the function
header than having return type on the separate line and align the
function parameters to the end of the function name.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 85 +++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c4458b3f1dab..b0a8d5b0641f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -232,8 +232,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
  * loop_validate_block_size() - validates the passed in block size
  * @bsize: size to validate
  */
-static int
-loop_validate_block_size(unsigned short bsize)
+static int loop_validate_block_size(unsigned short bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
@@ -255,11 +254,10 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
-static inline int
-lo_do_transfer(struct loop_device *lo, int cmd,
-	       struct page *rpage, unsigned roffs,
-	       struct page *lpage, unsigned loffs,
-	       int size, sector_t rblock)
+static inline int lo_do_transfer(struct loop_device *lo, int cmd,
+				 struct page *rpage, unsigned roffs,
+				 struct page *lpage, unsigned loffs,
+				 int size, sector_t rblock)
 {
 	int ret;
 
@@ -296,7 +294,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 }
 
 static int lo_write_simple(struct loop_device *lo, struct request *rq,
-		loff_t pos)
+			   loff_t pos)
 {
 	struct bio_vec bvec;
 	struct req_iterator iter;
@@ -318,7 +316,7 @@ static int lo_write_simple(struct loop_device *lo, struct request *rq,
  * access to the destination pages of the backing file.
  */
 static int lo_write_transfer(struct loop_device *lo, struct request *rq,
-		loff_t pos)
+			     loff_t pos)
 {
 	struct bio_vec bvec, b;
 	struct req_iterator iter;
@@ -348,7 +346,7 @@ static int lo_write_transfer(struct loop_device *lo, struct request *rq,
 }
 
 static int lo_read_simple(struct loop_device *lo, struct request *rq,
-		loff_t pos)
+			  loff_t pos)
 {
 	struct bio_vec bvec;
 	struct req_iterator iter;
@@ -377,7 +375,7 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 }
 
 static int lo_read_transfer(struct loop_device *lo, struct request *rq,
-		loff_t pos)
+			    loff_t pos)
 {
 	struct bio_vec bvec, b;
 	struct req_iterator iter;
@@ -964,8 +962,7 @@ static void loop_update_rotational(struct loop_device *lo)
 		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
 }
 
-static int
-loop_release_xfer(struct loop_device *lo)
+static int loop_release_xfer(struct loop_device *lo)
 {
 	int err = 0;
 	struct loop_func_table *xfer = lo->lo_encryption;
@@ -980,9 +977,8 @@ loop_release_xfer(struct loop_device *lo)
 	return err;
 }
 
-static int
-loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
-	       const struct loop_info64 *i)
+static int loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
+			  const struct loop_info64 *i)
 {
 	int err = 0;
 
@@ -1009,9 +1005,8 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
  * Configures the loop device parameters according to the passed
  * in loop_info64 configuration.
  */
-static int
-loop_set_status_from_info(struct loop_device *lo,
-			  const struct loop_info64 *info)
+static int loop_set_status_from_info(struct loop_device *lo,
+				     const struct loop_info64 *info)
 {
 	int err;
 	struct loop_func_table *xfer;
@@ -1336,8 +1331,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
-static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+static int loop_set_status(struct loop_device *lo,
+			   const struct loop_info64 *info)
 {
 	int err;
 	struct block_device *bdev;
@@ -1420,8 +1415,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	return err;
 }
 
-static int
-loop_get_status(struct loop_device *lo, struct loop_info64 *info)
+static int loop_get_status(struct loop_device *lo,
+			   struct loop_info64 *info)
 {
 	struct path path;
 	struct kstat stat;
@@ -1464,8 +1459,8 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	return ret;
 }
 
-static void
-loop_info64_from_old(const struct loop_info *info, struct loop_info64 *info64)
+static void loop_info64_from_old(const struct loop_info *info,
+				 struct loop_info64 *info64)
 {
 	memset(info64, 0, sizeof(*info64));
 	info64->lo_number = info->lo_number;
@@ -1486,8 +1481,8 @@ loop_info64_from_old(const struct loop_info *info, struct loop_info64 *info64)
 	memcpy(info64->lo_encrypt_key, info->lo_encrypt_key, LO_KEY_SIZE);
 }
 
-static int
-loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
+static int loop_info64_to_old(const struct loop_info64 *info64,
+			      struct loop_info *info)
 {
 	memset(info, 0, sizeof(*info));
 	info->lo_number = info64->lo_number;
@@ -1516,8 +1511,8 @@ loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
 	return 0;
 }
 
-static int
-loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
+static int loop_set_status_old(struct loop_device *lo,
+			       const struct loop_info __user *arg)
 {
 	struct loop_info info;
 	struct loop_info64 info64;
@@ -1528,8 +1523,8 @@ loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
 	return loop_set_status(lo, &info64);
 }
 
-static int
-loop_set_status64(struct loop_device *lo, const struct loop_info64 __user *arg)
+static int loop_set_status64(struct loop_device *lo,
+			     const struct loop_info64 __user *arg)
 {
 	struct loop_info64 info64;
 
@@ -1538,8 +1533,9 @@ loop_set_status64(struct loop_device *lo, const struct loop_info64 __user *arg)
 	return loop_set_status(lo, &info64);
 }
 
-static int
-loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
+static int loop_get_status_old(struct loop_device *lo,
+			       struct loop_info __user *arg)
+{
 	struct loop_info info;
 	struct loop_info64 info64;
 	int err;
@@ -1555,8 +1551,9 @@ loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
 	return err;
 }
 
-static int
-loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
+static int loop_get_status64(struct loop_device *lo,
+			     struct loop_info64 __user *arg)
+{
 	struct loop_info64 info64;
 	int err;
 
@@ -1660,8 +1657,8 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 	return err;
 }
 
-static int lo_ioctl(struct block_device *bdev, fmode_t mode,
-	unsigned int cmd, unsigned long arg)
+static int lo_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
+		    unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *) arg;
@@ -1813,9 +1810,8 @@ loop_info64_to_compat(const struct loop_info64 *info64,
 	return 0;
 }
 
-static int
-loop_set_status_compat(struct loop_device *lo,
-		       const struct compat_loop_info __user *arg)
+static int loop_set_status_compat(struct loop_device *lo,
+				 const struct compat_loop_info __user *arg)
 {
 	struct loop_info64 info64;
 	int ret;
@@ -1826,9 +1822,8 @@ loop_set_status_compat(struct loop_device *lo,
 	return loop_set_status(lo, &info64);
 }
 
-static int
-loop_get_status_compat(struct loop_device *lo,
-		       struct compat_loop_info __user *arg)
+static int loop_get_status_compat(struct loop_device *lo,
+				  struct compat_loop_info __user *arg)
 {
 	struct loop_info64 info64;
 	int err;
@@ -1999,7 +1994,7 @@ EXPORT_SYMBOL(loop_register_transfer);
 EXPORT_SYMBOL(loop_unregister_transfer);
 
 static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
-		const struct blk_mq_queue_data *bd)
+				  const struct blk_mq_queue_data *bd)
 {
 	struct request *rq = bd->rq;
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
@@ -2068,7 +2063,7 @@ static void loop_queue_work(struct kthread_work *work)
 }
 
 static int loop_init_request(struct blk_mq_tag_set *set, struct request *rq,
-		unsigned int hctx_idx, unsigned int numa_node)
+			     unsigned int hctx_idx, unsigned int numa_node)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
-- 
2.22.1

