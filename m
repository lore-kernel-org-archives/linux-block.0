Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C01C433EF
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 05:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiC3Fb7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbiC3Fb6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 01:31:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238B1D12C3
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 22:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hWEhA1iHAl3Ur4hgCgNhUygoGzwcnfqgtb6HKOMXfV4=; b=cJjB3x5SJXg945IEf3FbF+RswY
        pw88yJBv9Y6x6joVTwQbmWHDtS6G0RfL3ZEp3v4CI+gSEO3Dujd3A9LgCY8dL9Y1Rnt4wkQf7FVAH
        lSdsN6V1dp8YwcsFy7N0ZD/dGRLLQQ8X8FotNx4f4jq7el4s89aKSHSpE/HNflzehr7dzTtHv7HPo
        BMxzGYsgYrQX/RtJT8uyc4Le5g9tOl4dL7xXudpZETJ9G/BkPE0MelFf1e0UtMRtDa8pSmrL6QAih
        FT/+RKRVojh/KzM5C2LdEv+uT57tz2RHqA9rDM4eZDckkkaTzMJzD180ro3ESM1zq46yh6OUgnhIs
        JF8tx4WA==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQuE-00ELSK-Gg; Wed, 30 Mar 2022 05:30:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH 12/15] loop: suppress uevents while reconfiguring the device
Date:   Wed, 30 Mar 2022 07:29:14 +0200
Message-Id: <20220330052917.2566582-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330052917.2566582-1-hch@lst.de>
References: <20220330052917.2566582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, udev change event is generated for a loop device before the
device is ready for IO. Due to serialization on lo->lo_mutex in
lo_open() this does not matter because anybody is able to open the
device and do IO only after the configuration is finished. However this
synchronization in lo_open() is going away so make sure userspace
reacting to the change event will see the new device state by generating
the event only when the device is setup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b3170e8cdbe95..bfd21af7aa38b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -572,6 +572,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	if (!file)
 		return -EBADF;
+
+	/* suppress uevents while reconfiguring the device */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
+
 	is_loop = is_loop_device(file);
 	error = loop_global_lock_killable(lo, is_loop);
 	if (error)
@@ -626,13 +630,18 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	fput(old_file);
 	if (partscan)
 		loop_reread_partitions(lo);
-	return 0;
+
+	error = 0;
+done:
+	/* enable and uncork uevent now that we are done */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	return error;
 
 out_err:
 	loop_global_unlock(lo, is_loop);
 out_putf:
 	fput(file);
-	return error;
+	goto done;
 }
 
 /* loop sysfs attributes */
@@ -999,6 +1008,9 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
+	/* suppress uevents while reconfiguring the device */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
+
 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * here to avoid changing device under exclusive owner.
@@ -1101,7 +1113,12 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		loop_reread_partitions(lo);
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
-	return 0;
+
+	error = 0;
+done:
+	/* enable and uncork uevent now that we are done */
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	return error;
 
 out_unlock:
 	loop_global_unlock(lo, is_loop);
@@ -1112,7 +1129,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	fput(file);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
-	return error;
+	goto done;
 }
 
 static void __loop_clr_fd(struct loop_device *lo, bool release)
-- 
2.30.2

