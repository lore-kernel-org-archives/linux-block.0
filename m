Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38982C47083
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 06:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140FB613F8
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 06:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhFDG7W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 02:59:22 -0400
Received: from verein.lst.de ([213.95.11.211]:36450 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhFDG7V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Jun 2021 02:59:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 743C16736F; Fri,  4 Jun 2021 08:57:33 +0200 (CEST)
Date:   Fri, 4 Jun 2021 08:57:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] block: loop: fix deadlock between open and remove
Message-ID: <20210604065733.GA11135@lst.de>
References: <20210604000424.189928-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604000424.189928-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks good, but I think we can do simple by just adding add new
Lo_deleting state.  Completely untested as I'm at the tail end of a vacation
with a broken laptop:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..76e12f3482a9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1879,29 +1879,18 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
-	struct loop_device *lo;
+	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	/*
-	 * take loop_ctl_mutex to protect lo pointer from race with
-	 * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce contention
-	 * release it prior to updating lo->lo_refcnt.
-	 */
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		return err;
-	lo = bdev->bd_disk->private_data;
-	if (!lo) {
-		mutex_unlock(&loop_ctl_mutex);
-		return -ENXIO;
-	}
 	err = mutex_lock_killable(&lo->lo_mutex);
-	mutex_unlock(&loop_ctl_mutex);
 	if (err)
 		return err;
-	atomic_inc(&lo->lo_refcnt);
+	if (lo->lo_state == Lo_deleting)
+		err = -ENXIO;
+	else
+		atomic_inc(&lo->lo_refcnt);
 	mutex_unlock(&lo->lo_mutex);
-	return 0;
+	return err;
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
@@ -2285,7 +2274,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			mutex_unlock(&lo->lo_mutex);
 			break;
 		}
-		lo->lo_disk->private_data = NULL;
+		lo->lo_state = Lo_deleting;
 		mutex_unlock(&lo->lo_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index a3c04f310672..5beb959b94d3 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -22,6 +22,7 @@ enum {
 	Lo_unbound,
 	Lo_bound,
 	Lo_rundown,
+	Lo_deleting,
 };
 
 struct loop_func_table;
