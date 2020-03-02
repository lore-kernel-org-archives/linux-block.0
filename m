Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C00C3F2D1
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D20D246BB
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 09:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCBJfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:35:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:35680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbgCBJfC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 04:35:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA5E1AC7C;
        Mon,  2 Mar 2020 09:35:00 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.de, mhocko@suse.com, mkoutny@suse.com,
        Coly Li <colyli@suse.de>
Subject: [PATCH 1/2] bcache: ignore pending signals in bcache_device_init()
Date:   Mon,  2 Mar 2020 17:34:49 +0800
Message-Id: <20200302093450.48016-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200302093450.48016-1-colyli@suse.de>
References: <20200302093450.48016-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When cache device and cached device are registered simuteneously and
register_cache() firstly acquires bch_register_lock. register_bdev()
has to wait before register_cache() finished, it might be a very long
time.

If the registration is from udev rules in system boot up time, and
registration is not completed before udev timeout (default 180s), the
registration process will be killed by udevd. Then the following calls
to kthread_run() or kthread_create() will fail due to the pending
signal (they are implemented this way at this moment).

For boot time, this is not good, because it means a cache device with
huge cached data will always fail in boot time, just because it
spends too much time to check its internal meta data (btree and dirty
sectors).

The failure for cache device registration is solved by previous
patches, but failure due to timeout also exists in cached device
registration. As the above text explains, cached device registration
may also be timeout if it is blocked by a timeout cache device
registration process. Then in the following code path,
    bioset_init() <= bcache_device_init() <= cached_dev_init() <=
    register_bdev() <= register_bcache()
bioset_init() will fail because internally kthread_create() will fail
for pending signal in the following code path,
    bioset_init() => alloc_workqueue() => init_rescuer() =>
    kthread_create()

Maybe fix kthread_create() and kthread_run() is better method, but at
this moment a fast workaroudn is to flush pending signals before
calling bioset_init() in bcache_device_init().

This patch calls flush_signals() in bcache_device_init() if there is
pending signal for current process. It avoids bcache registration
failure in system boot up time due to bcache udev rule timeout.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 0c3c5419c52b..e8bbd4f171ca 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -850,6 +850,18 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 	if (idx < 0)
 		return idx;
 
+	/*
+	 * There is a timeout in udevd, if the bcache device is registering
+	 * by udev rules, and not completed in time, the udevd may kill the
+	 * registration process. In this condition, there will be pending
+	 * signal here and cause bioset_init() failed for internally creating
+	 * its kthread. Here the registration should ignore the timeout and
+	 * continue, it is safe to ignore the pending signal and avoid to
+	 * fail bcache registration in boot up time.
+	 */
+	if (signal_pending(current))
+		flush_signals(current);
+
 	if (bioset_init(&d->bio_split, 4, offsetof(struct bbio, bio),
 			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
 		goto err;
-- 
2.16.4

