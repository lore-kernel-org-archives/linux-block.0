Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33CBC433EF
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 02:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiCRC2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Mar 2022 22:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiCRC2A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Mar 2022 22:28:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71D2A3A72
        for <linux-block@vger.kernel.org>; Thu, 17 Mar 2022 19:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647570403; x=1679106403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7J2E0JiDQLVXFtoD6ibrcPbomKCFAYIph6L0q4gFkvU=;
  b=H49PrxpHHVDu9YUIIqXwqXkUE9AERxev0lQytj5FUUR4lYKb/myj2F9u
   rIRAfZMDy7rFzjQonwZTq5/uvkcFU1jT0+izvsNGPLnhrRd8E3gWjtIKt
   ATMtI5I8xc5yoi4l8pDYHtuLNwKwcSFNHZNSr4Hz9qyiaHgjSWpnh57qm
   gzz/el2SoMHdTwt/feAv2UnWGk+Ti5sYrMZnV+hpAvUXnGbGQwsIrgug8
   +TnzgdtkGxwTS9jyX3EIH4IHAHNLH/TnaE4o+lhlYQULW+Kiu4DhZaE4R
   WfZpCn1vWusv1YjBA2A3hlLcHRSwk+hFbefZVRJWDAaZEQcwlZgzim2jV
   g==;
X-IronPort-AV: E=Sophos;i="5.90,191,1643644800"; 
   d="scan'208";a="194573113"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2022 10:26:42 +0800
IronPort-SDR: xkeDq88RQWWllZxvAZysZTLsHVSsfNDUKGBkg58y6MYL8xAlBmu4U8LhRK+xQCWdvRcGstIcDs
 X33l3xXhEWQDPJ+Hf87w5V2KdEzzZXKtvzzQOjvErUjxCYQ7/hm+UxLOHSRrlMAAzrroDf/KuU
 r6AfDr3ljdVWpDaJs6BmtXjtv5hSzyE4UY38sOFPjqqKgvm1AQkIr/yRplbRN4o/Ovu4vSxCsA
 ZoUBBj8WjSmcWL8wkZSGW6SsnOS4LYwpVeMQzcZQ8NzWgI8Jkn6vsLZ9Fs7CLpvAxyTocuBytc
 4FG8BFWcyt/CGM3JLipxnfrc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 18:57:47 -0700
IronPort-SDR: qO/SUEhRybTWOnXcp9PXEkp0vY7fevq9CS+yN8ouO0RawRdWe7P5VLO/5i5DAwi1I7w2InEdf+
 eq08K2X2mUlGFlErKPhCF1UeRWxONqk3/nshRSqdAwYM682hzu8gk9TXhPGmiuE7OczbA3yo+c
 E+06HecISHwub9SowoXE997mB8Mf1qXC64R8L2/IEa8zunobIsNKR8L4XJMvCw1JFKXboQwieA
 fnFPIhxY3WORJDJlZinjSbiDzaa+KPafsS/SpLyE5YX5s2JCwgJTFMp4zLgjI2oK24OvRQ6r2c
 If8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Mar 2022 19:26:42 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] block: limit request dispatch loop duration
Date:   Fri, 18 Mar 2022 11:26:41 +0900
Message-Id: <20220318022641.133484-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When IO requests are made continuously and the target block device
handles requests faster than request arrival, the request dispatch loop
keeps on repeating to dispatch the arriving requests very long time,
more than a minute. Since the loop runs as a workqueue worker task, the
very long loop duration triggers workqueue watchdog timeout and BUG [1].

To avoid the very long loop duration, break the loop periodically. When
opportunity to dispatch requests still exists, check need_resched(). If
need_resched() returns true, the dispatch loop already consumed its time
slice, then reschedule the dispatch work and break the loop. With heavy
IO load, need_resched() does not return true for 20~30 seconds. To cover
such case, check time spent in the dispatch loop with jiffies. If more
than 1 second is spent, reschedule the dispatch work and break the loop.

[1]

[  609.691437] BUG: workqueue lockup - pool cpus=10 node=1 flags=0x0 nice=-20 stuck for 35s!
[  609.701820] Showing busy workqueues and worker pools:
[  609.707915] workqueue events: flags=0x0
[  609.712615]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  609.712626]     pending: drm_fb_helper_damage_work [drm_kms_helper]
[  609.712687] workqueue events_freezable: flags=0x4
[  609.732943]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  609.732952]     pending: pci_pme_list_scan
[  609.732968] workqueue events_power_efficient: flags=0x80
[  609.751947]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  609.751955]     pending: neigh_managed_work
[  609.752018] workqueue kblockd: flags=0x18
[  609.769480]   pwq 21: cpus=10 node=1 flags=0x0 nice=-20 active=3/256 refcnt=4
[  609.769488]     in-flight: 1020:blk_mq_run_work_fn
[  609.769498]     pending: blk_mq_timeout_work, blk_mq_run_work_fn
[  609.769744] pool 21: cpus=10 node=1 flags=0x0 nice=-20 hung=35s workers=2 idle: 67
[  639.899730] BUG: workqueue lockup - pool cpus=10 node=1 flags=0x0 nice=-20 stuck for 66s!
[  639.909513] Showing busy workqueues and worker pools:
[  639.915404] workqueue events: flags=0x0
[  639.920197]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  639.920215]     pending: drm_fb_helper_damage_work [drm_kms_helper]
[  639.920365] workqueue kblockd: flags=0x18
[  639.939932]   pwq 21: cpus=10 node=1 flags=0x0 nice=-20 active=3/256 refcnt=4
[  639.939942]     in-flight: 1020:blk_mq_run_work_fn
[  639.939955]     pending: blk_mq_timeout_work, blk_mq_run_work_fn
[  639.940212] pool 21: cpus=10 node=1 flags=0x0 nice=-20 hung=66s workers=2 idle: 67

Fixes: 6e6fcbc27e778 ("blk-mq: support batching dispatch in case of io")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # v5.10+
Link: https://lore.kernel.org/linux-block/20220310091649.zypaem5lkyfadymg@shindev/
---
Changes from v1:
* Inverted logic of jiffies and end time comparison
* Improved readability per comment on the list

 block/blk-mq-sched.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55488ba97823..80e0eb26b697 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -180,11 +180,18 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 
 static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
+	unsigned long end = jiffies + HZ;
 	int ret;
 
 	do {
 		ret = __blk_mq_do_dispatch_sched(hctx);
-	} while (ret == 1);
+		if (ret != 1)
+			break;
+		if (need_resched() || time_is_before_jiffies(end)) {
+			blk_mq_delay_run_hw_queue(hctx, 0);
+			break;
+		}
+	} while (1);
 
 	return ret;
 }
-- 
2.34.1

