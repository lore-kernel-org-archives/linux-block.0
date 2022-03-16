Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A6C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 06:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbiCPGNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353834AbiCPGMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 02:12:51 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE8D60CE9
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647411097; x=1678947097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wnt0uMjOKE6LQaGH5eXYFgbE7zMOBgPVQ5qzxRBR+3M=;
  b=WZiVieiaYZZKHivc+XXLfIvWtkw++T3XvVyHZinYm1Iyreh7YpG0tPsd
   d/w3LjKhsJ5muLOFIIKbkLMWN8XgRnHxG1dNRRbNlSFx81dHuKSijIrja
   29dCkUE0HhLLZaznl8pMfk5LoO9AdN3L6dyD7Qd5yB3vwkEAgf6Gr4FwB
   gWsYtgi3SAeni7cjHLzpKe6FNaKwA2Ejz5bCRRiJntZ4QfA23zRbHfDMr
   saW/IqWs4VVDMp2s/mRuV7zpnbMSagrFhlqiDPwrECrzhWM3Qq4vQ72Zs
   729UFDdjz50RdZXBeOz1KUESCPlxMnSzUk5RM8Dg5oVvRB7bkFuAZzvoB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="299622344"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 14:11:36 +0800
IronPort-SDR: dqGq2nAd9J/3dXvZYMXwZbSTTOOvXw4oAyYJZDHPiqeIn5YXR2hv1ufQOLEkeW14wBhkwLik0g
 GM8ZZSak0dO3SR7zaLyWc/NhuFFDlf4OK/1L/l/u2nT0mCJfJ5o7SS7H7J0T4g8UbyPeWgUr2J
 jSIWnehqNyuYvoDsaUHOA33MUYfGkKuwwpzNP6LTMyFnKKxWfUwVquSRMqcQ0YIno+ImySCIzG
 9NGjxsoXXBPiBhiEc8ieZoeOehrkzoLEHKL5viSyP0vMQQVdrK8Uef113YYa7kcyEDZNx+Q0r9
 /TES3AqFCUxpgWl8u87wezpI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 22:43:40 -0700
IronPort-SDR: m1sMeA/7Eb9PCIqORL9dG2/DZlqmFURu2U8eUiGs9Ck9cY6zaOKF4xV6NJ5fgt39/zefblyUlg
 CxshfIeInLj9wbfFVlJAtGDnk3gVet4sfJ76cNfYz3i7XtagrlJ3zuJsrvaKbvsOpSzDwC97CF
 Gce+CIQXMG017Fh5K64fZwnS/PwZ4hLPgWHrpRqb6Ebw7jmjgXsCtL62D64W9x3mwD3XfwEj+l
 QyIqKrLVUD9FpoRCRkDr91UdIthTmWO5QpRCyMmYGdWLYsXuReU3EOIsy2Jr3rUsdsTgvMGSiQ
 RXY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Mar 2022 23:11:35 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: limit request dispatch loop duration
Date:   Wed, 16 Mar 2022 15:11:34 +0900
Message-Id: <20220316061134.3812309-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55488ba97823..64941615befc 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -181,9 +181,15 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	int ret;
+	unsigned long end = jiffies + HZ;
 
 	do {
 		ret = __blk_mq_do_dispatch_sched(hctx);
+		if (ret == 1 &&
+		    (need_resched() || time_is_after_jiffies(end))) {
+			blk_mq_delay_run_hw_queue(hctx, 0);
+			break;
+		}
 	} while (ret == 1);
 
 	return ret;
-- 
2.34.1

